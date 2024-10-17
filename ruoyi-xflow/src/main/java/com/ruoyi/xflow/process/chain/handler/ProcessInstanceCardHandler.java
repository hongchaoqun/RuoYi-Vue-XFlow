package com.ruoyi.xflow.process.chain.handler;


import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.xflow.common.FlowException;
import com.ruoyi.xflow.common.enums.ProcessInstanceNodeEnum;
import com.ruoyi.xflow.common.enums.ProcessNodeStageEnum;
import com.ruoyi.xflow.common.enums.ProcessNodeTypeEnum;
import com.ruoyi.xflow.domain.ProcessInstance;
import com.ruoyi.xflow.domain.ProcessInstanceNode;
import com.ruoyi.xflow.domain.ProcessNode;
import com.ruoyi.xflow.mapper.ProcessInstanceMapper;
import com.ruoyi.xflow.mapper.ProcessInstanceNodeMapper;
import com.ruoyi.xflow.mapper.ProcessInstanceSubNodeMapper;
import com.ruoyi.xflow.mapper.ProcessNodeMapper;
import com.ruoyi.xflow.process.instance.IProcessInstanceSubNodeService;

/**
 * 处理节点，这个需要多实例，一个
 * @Author hongcq
 * @Date 2024/6/26
 */
public class ProcessInstanceCardHandler extends AbstractProcessInstanceCard {

    private ProcessInstanceNodeMapper processInstanceNodeMapper;

    private ProcessNodeMapper processNodeMapper;

    private ProcessInstanceMapper processInstanceMapper;

    private ProcessInstanceSubNodeMapper processInstanceSubNodeMapper;

    private IProcessInstanceSubNodeService processInstanceSubNodeService;

    public ProcessInstanceCardHandler(ProcessNode node, ProcessInstanceNodeMapper processInstanceNodeMapper, ProcessNodeMapper processNodeMapper, ProcessInstanceMapper processInstanceMapper, ProcessInstanceSubNodeMapper processInstanceSubNodeMapper, IProcessInstanceSubNodeService processInstanceSubNodeService){
        super(node);
        this.processInstanceNodeMapper = processInstanceNodeMapper;
        this.processNodeMapper = processNodeMapper;
        this.processInstanceMapper = processInstanceMapper;
        this.processInstanceSubNodeMapper = processInstanceSubNodeMapper;
        this.processInstanceSubNodeService = processInstanceSubNodeService;
    }

    @Override
    public String processCurrentTask(String processInstanceNodeId) {
        ProcessInstanceNode processInstanceNode = processInstanceNodeMapper.selectByInstanceNodeId(processInstanceNodeId);
        assert processInstanceNode != null;
        processInstanceNode.setNodeStatus(ProcessInstanceNodeEnum.COMPLETED.getCode());
        processInstanceNodeMapper.updateById(processInstanceNode);
        ProcessInstance processInstance = processInstanceMapper.selectByInstanceId(processInstanceNode.getProcessInstanceId());
        assert processInstance != null;
        // 检查是不是最后一个节点。如果是，则直接完成流程
        if(ProcessNodeStageEnum.END.getCode().equals(node.getStage())){
            processInstance.setStatus(ProcessInstanceNodeEnum.COMPLETED.getCode());
            processInstanceMapper.updateById(processInstance);
            return null;
        }else {
            return processNextTask(processInstanceNodeId, processInstance);
        }
    }

    /**
     * 新增下一个流程节点
     * @param processInstanceNodeId 流程实例节点id
     * @return 下一个流程节点id
     */
    @Override
    public String processNextTask(String processInstanceNodeId,ProcessInstance processInstance) {

        ProcessNode nextNode = processNodeMapper.selectNodeByNodeId(node.getNextNodeId());
        if(nextNode == null){
            throw new FlowException("下一个节点不存在,请检查配置");
        }

        // 如果下一个节点是并行处理器，调用并行处理方法
        if(ProcessNodeTypeEnum.PARALLEL.getCode().equals(nextNode.getNodeType())){
            SubChainHandler subChainHandler = new SubChainHandler(processInstanceNodeMapper,processNodeMapper,processInstanceSubNodeMapper,processInstanceSubNodeService);
            ProcessInstanceNode processInstanceNode = subChainHandler.setParallelCardAndGetFirstNode(nextNode, processInstance.getProcessInstanceId());
            // 找不到修改的地方临时修改, 并行处理器执行后，设置第一个子节点为流程的当前节点
            try{
                processInstance.setCurrentProcessInstanceNodeId(processInstanceNode.getProcessInstanceNodeId());
                processInstanceMapper.updateById(processInstance);
            }catch (Exception e){
                e.printStackTrace();
            }
            return processInstanceNode.getProcessInstanceNodeId();
        }

        // 主流程节点
        ProcessInstanceNode nextInstanceNode = ProcessInstanceNode.builder()
                .nodeId(nextNode.getNodeId())
                .nodeName(nextNode.getNodeName())
                .nodeStatus(ProcessInstanceNodeEnum.IN_PROGRESS.getCode())
                .processInstanceId(processInstance.getProcessInstanceId())
                .processInstanceNodeId(IdUtils.fastUUID())
                .build();

        processInstanceNodeMapper.insert(nextInstanceNode);

        // 主流程上记录一下新节点
        processInstance.setCurrentProcessInstanceNodeId(nextInstanceNode.getProcessInstanceNodeId());
        processInstanceMapper.updateById(processInstance);

        return nextInstanceNode.getProcessInstanceNodeId();
    }
}
