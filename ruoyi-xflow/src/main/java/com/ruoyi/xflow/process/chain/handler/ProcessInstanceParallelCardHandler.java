package com.ruoyi.xflow.process.chain.handler;


import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.xflow.common.enums.ProcessInstanceEnum;
import com.ruoyi.xflow.common.enums.ProcessInstanceNodeEnum;
import com.ruoyi.xflow.common.enums.ProcessNodeStageEnum;
import com.ruoyi.xflow.domain.ProcessInstance;
import com.ruoyi.xflow.domain.ProcessInstanceNode;
import com.ruoyi.xflow.domain.ProcessInstanceSubNode;
import com.ruoyi.xflow.domain.ProcessNode;
import com.ruoyi.xflow.mapper.ProcessInstanceMapper;
import com.ruoyi.xflow.mapper.ProcessInstanceNodeMapper;
import com.ruoyi.xflow.mapper.ProcessInstanceSubNodeMapper;
import com.ruoyi.xflow.mapper.ProcessNodeMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * 支持并行流程的节点处理器
 * @Author hongcq
 * @Date 2024/6/28
 */
public class ProcessInstanceParallelCardHandler extends AbstractParallelCardHandler{

    private static final Logger log = LoggerFactory.getLogger(ProcessInstanceParallelCardHandler.class);
    private ProcessInstanceNodeMapper processInstanceNodeMapper;

    private ProcessNodeMapper processNodeMapper;

    private ProcessInstanceMapper processInstanceMapper;

    private ProcessInstanceSubNodeMapper processInstanceSubNodeMapper;


    public ProcessInstanceParallelCardHandler(ProcessInstanceSubNode processInstanceSubNode, ProcessInstanceNodeMapper processInstanceNodeMapper, ProcessNodeMapper processNodeMapper, ProcessInstanceMapper processInstanceMapper, ProcessInstanceSubNodeMapper processInstanceSubNodeMapper){
        super(processInstanceSubNode);
        this.processInstanceNodeMapper = processInstanceNodeMapper;
        this.processNodeMapper = processNodeMapper;
        this.processInstanceMapper = processInstanceMapper;
        this.processInstanceSubNodeMapper = processInstanceSubNodeMapper;
    }


    /**
     * 处理并行流程。 如果是父节点 生成子流程， 如果是子节点处理自己的任务，然后调用父节点的方法生成兄弟节点
     *
     * @param processInstanceNodeId 流程实例节点id
     * @return
     */
    @Override
    String processCurrentTask(String processInstanceNodeId) {
        ProcessInstanceNode processInstanceNode = processInstanceNodeMapper.selectByInstanceNodeId(processInstanceNodeId);
        assert processInstanceNode != null;
        processInstanceNode.setNodeStatus(ProcessInstanceNodeEnum.COMPLETED.getCode());
        processInstanceNodeMapper.updateById(processInstanceNode);
        ProcessInstance processInstance = processInstanceMapper.selectByInstanceId(processInstanceNode.getProcessInstanceId());
        // 更新流程的当前节点
        assert processInstance != null;


        return processNextTask(processInstanceNodeId, processInstance);
    }

    /**
     * 生成下一个节点
     * 子流程提前生成放在xflow_process_instance_sub_node 表中
     *
     * 检查当前节点是不是子节点的最后一个节点
     *    是： 返回到父节点，生成父节点的下一个节点
     *    否： 生成兄弟节点，从flow_process_instance_sub_node 复制信息，新增节点返回
     * @param processInstanceNodeId 流程实例节点id
     * @param processInstance
     * @return
     */
    @Override
    String processNextTask(String processInstanceNodeId, ProcessInstance processInstance) {
        ProcessInstanceNode processInstanceNode = processInstanceNodeMapper.selectByInstanceNodeId(processInstanceNodeId);
        assert processInstanceNode != null && processInstanceNode.getProcessInstanceNodeSubId() != null;

        // 子流程结束, 生成父节点的下一个节点
        if(ProcessNodeStageEnum.SUB_OVER.getCode().equals(processInstanceSubNode.getStage())){
            //// 源数据的所有数据都生成了正式数据才行
            //List<ProcessInstanceSubNode> nodes = processInstanceSubNodeMapper.selectList(new QueryWrapper<ProcessInstanceSubNode>().eq("process_instance_id", processInstance.getProcessInstanceId()));
            //List<String> subId = nodes.stream().map(ProcessInstanceSubNode::getProcessInstanceNodeSubId).collect(Collectors.toList());
            //Long count = processInstanceSubNodeMapper.selectCount(new QueryWrapper<ProcessInstanceSubNode>().eq("process_instance_id", processInstance.getProcessInstanceId()).in("process_instance_node_sub_id", subId));
            //if(count.equals((long) nodes.size())){
            //   return processUncleTask(processInstanceSubNode, processInstance);
            //}

            String uncleNodeId = processUncleTask(processInstanceSubNode, processInstance);
            processInstance.setCurrentProcessInstanceNodeId(uncleNodeId);
            processInstanceMapper.updateById(processInstance);
            return uncleNodeId;
        }

        String broNodeId = processBrotherTask(processInstanceSubNode);
        processInstance.setCurrentProcessInstanceNodeId(broNodeId);
        processInstanceMapper.updateById(processInstance);
        return broNodeId;
    }

    /**
     * 生成兄弟节点
     */
    String processBrotherTask(ProcessInstanceSubNode subNode){
        // 查找出当前节点的下一个节点
        ProcessInstanceSubNode sonInstanceNodes = processInstanceSubNodeMapper.selectBrotherNodeByParentIdAndRank(subNode.getParentProcessInstanceNodeId(), subNode.getNodeRank()+1);
        if(sonInstanceNodes != null){
            ProcessInstanceNode sonInstanceNode =  ProcessInstanceNode.builder()
                    .nodeStatus(ProcessInstanceNodeEnum.IN_PROGRESS.getCode())
                    .nodeId(sonInstanceNodes.getNodeId())
                    .nodeName(sonInstanceNodes.getNodeName())
                    .processInstanceNodeId(IdUtils.fastUUID())
                    .processInstanceId(sonInstanceNodes.getProcessInstanceId())
                    .subId(sonInstanceNodes.getProcessInstanceNodeSubId())
                    .businessId(sonInstanceNodes.getBusinessId())
                    .processInstanceNodeSubId(sonInstanceNodes.getProcessInstanceNodeSubId())
                    .build();
            processInstanceNodeMapper.insert(sonInstanceNode);
            return sonInstanceNode.getProcessInstanceNodeId();
        }else {
            log.warn("子流程没有生成兄弟节点，当前subId:{}", subNode.getProcessInstanceNodeSubId());
        }
        return null;
    }

    /**
     * 生成叔叔节点
     */
    String processUncleTask(ProcessInstanceSubNode subNode, ProcessInstance processInstance){
        // 获取到父节点
        ProcessInstanceNode parentInstanceNode = processInstanceNodeMapper.selectByInstanceNodeId(subNode.getParentProcessInstanceNodeId());
        assert parentInstanceNode != null;
        ProcessNode processNode = processNodeMapper.selectNodeByNodeId(parentInstanceNode.getNodeId());
        // 更新父节点的状态
        parentInstanceNode.setNodeStatus(ProcessInstanceEnum.COMPLETED.getCode());
        processInstanceNodeMapper.updateById(parentInstanceNode);

        // 检查是不是最后一个节点。如果是，则直接完成流程
        if(ProcessNodeStageEnum.END.getCode().equals(processNode.getStage())){

            processInstance.setStatus(ProcessInstanceNodeEnum.COMPLETED.getCode());
            processInstanceMapper.updateById(processInstance);
            return null;
        }else {
            return nextMainTask(processNode, processInstance, parentInstanceNode);
        }
    }

    /**
     * 新增下一个流程节点 (主流程)
     * @return 下一个流程节点id
     */
    public String nextMainTask(ProcessNode processNode,ProcessInstance processInstance, ProcessInstanceNode parentInstanceNode) {

        ProcessNode nextNode = processNodeMapper.selectNodeByNodeId(processNode.getNextNodeId());
        assert nextNode != null;

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
