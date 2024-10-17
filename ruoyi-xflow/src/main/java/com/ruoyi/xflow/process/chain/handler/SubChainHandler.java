package com.ruoyi.xflow.process.chain.handler;



import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.xflow.common.FlowException;
import com.ruoyi.xflow.common.enums.ProcessInstanceNodeEnum;
import com.ruoyi.xflow.common.enums.ProcessNodeStageEnum;
import com.ruoyi.xflow.common.enums.ProcessNodeTypeEnum;
import com.ruoyi.xflow.common.enums.ProcessNodeVisibilityEnum;
import com.ruoyi.xflow.component.IBusinessIdDiscoveryService;
import com.ruoyi.xflow.domain.ProcessInstanceNode;
import com.ruoyi.xflow.domain.ProcessInstanceSubNode;
import com.ruoyi.xflow.domain.ProcessNode;
import com.ruoyi.xflow.mapper.ProcessInstanceNodeMapper;
import com.ruoyi.xflow.mapper.ProcessInstanceSubNodeMapper;
import com.ruoyi.xflow.mapper.ProcessNodeMapper;
import com.ruoyi.xflow.process.instance.IProcessInstanceSubNodeService;

import java.util.ArrayList;
import java.util.List;

/**
 * 子链处理器，批量产生子链的数据 存在 xflow_process_instance_sub_node 表中
 * @Author hongcq
 * @Date 2024/6/28
 */
public class SubChainHandler {

    private ProcessInstanceNodeMapper processInstanceNodeMapper;

    private ProcessNodeMapper processNodeMapper;

    private ProcessInstanceSubNodeMapper processInstanceSubNodeMapper;

    private IProcessInstanceSubNodeService processInstanceSubNodeService;

    public SubChainHandler(ProcessInstanceNodeMapper processInstanceNodeMapper, ProcessNodeMapper processNodeMapper,ProcessInstanceSubNodeMapper processInstanceSubNodeMapper,IProcessInstanceSubNodeService processInstanceSubNodeService){
        this.processInstanceNodeMapper = processInstanceNodeMapper;
        this.processNodeMapper = processNodeMapper;
        this.processInstanceSubNodeMapper = processInstanceSubNodeMapper;
        this.processInstanceSubNodeService = processInstanceSubNodeService;
    }

    /**
     * 产生父节点
     * @param node 流程定义节点
     * @param instanceId 流程实例
     * @return 流程实例节点
     */
    public ProcessInstanceNode saveParentNode(ProcessNode node, String instanceId){
        ProcessInstanceNode processInstanceNode = ProcessInstanceNode.builder()
                .processInstanceId(instanceId)
                .processInstanceNodeId(IdUtils.fastUUID())
                .nodeId(node.getNodeId())
                .nodeName(node.getNodeName())
                .nodeStatus(ProcessInstanceNodeEnum.IN_PROGRESS.getCode())
                .visibility(ProcessNodeVisibilityEnum.UNABLE.getCode())
                .nodeType(ProcessNodeTypeEnum.PARALLEL.getCode())
                .build();
        processInstanceNodeMapper.insert(processInstanceNode);
        return processInstanceNode;
    }

    /**
     * 1. 先产生并行处理器节点保存
     * 2. 产生并行处理器节点的子节点
     * @param node 并行处理器的定义节点
     * @param instanceId 当前流程实例id
     * @return 最终产生的第一个子节点
     */
    public ProcessInstanceNode setParallelCardAndGetFirstNode(ProcessNode node, String instanceId) {
        if(!ProcessNodeTypeEnum.PARALLEL.getCode().equals(node.getNodeType())){
            throw new FlowException("当前节点不是并行节点");
        }
        // 创建出父节点
        ProcessInstanceNode parent = saveParentNode(node, instanceId);

        // 从调用方写的逻辑中获取并行节点的数量，具体由调用放实现
        IBusinessIdDiscoveryService discoveryService = SpringUtils.getBean(node.getBeanName());
        List<String> businessIdList = discoveryService.deptListInForm(instanceId, node.getNodeId());
        if(businessIdList == null || businessIdList.isEmpty()){
            throw new FlowException("没有获取到并行的业务id，请检查流程配置");
        }
        // 获取流程定义的子节点
        List<ProcessNode> sonNodes = processNodeMapper.selectSonNodeByNodeIds(node.getNodeId());
        // 记录到数据库中去，作为数据备份
        List<ProcessInstanceSubNode> sonInstanceNodes = new ArrayList<>();
        // 创建多个子流程，并且把他们串起来, 按顺序排列
        //int rank = 0;
        //for (int i = 0; i < businessIdList.size(); i++) {
        //    setSonInstanceNode(sonNodes, sonInstanceNodes, parent, businessIdList.get(i), rank);
        //}
        setSonInstanceNodeV2(sonNodes, sonInstanceNodes, parent, businessIdList);
        // 从备份数据中新增一个真实的流程子节点 并返回
        return setNextNode(sonInstanceNodes.get(0));
    }

    /**
     * 1. 产生并行处理器节点的子节点
     * @param nodes 子流程的定义
     * @param sonInstanceNodes 存储临时数据的列表
     * @param parent 父节点
     */
    public void setSonInstanceNode(List<ProcessNode> nodes, List<ProcessInstanceSubNode> sonInstanceNodes, ProcessInstanceNode parent, String businessId, int rank) {
        for (int i = 0; i < nodes.size(); i++) {
            rank += 1;
            ProcessNode processNode = nodes.get(i);
            ProcessInstanceSubNode sonInstanceNode =  new ProcessInstanceSubNode();
            sonInstanceNode.setParentProcessInstanceNodeId(parent.getProcessInstanceNodeId());
            sonInstanceNode.setNodeName(processNode.getNodeName());
            sonInstanceNode.setNodeId(processNode.getNodeId());
            sonInstanceNode.setNodeStatus(ProcessInstanceNodeEnum.IN_PROGRESS.getCode());
            // 子节点排序，因为是多个部门并行，按顺序排序
            sonInstanceNode.setNodeRank(rank);
            sonInstanceNode.setProcessInstanceId(parent.getProcessInstanceId());
            sonInstanceNode.setProcessInstanceNodeSubId(IdUtils.fastUUID());
            sonInstanceNode.setVisibility(ProcessNodeVisibilityEnum.ENABLE.getCode());
            sonInstanceNode.setNodeType(ProcessNodeTypeEnum.PARALLEL_PROCESS.getCode());
            // 设置业务id
            sonInstanceNode.setBusinessId(businessId);
            // 最后一个节点设置特殊阶段
            if(i == nodes.size() - 1){
                sonInstanceNode.setStage(ProcessNodeStageEnum.SUB_OVER.getCode());
            }else {
                sonInstanceNode.setStage(ProcessNodeStageEnum.RUNNING.getCode());
            }
            processInstanceSubNodeMapper.insert(sonInstanceNode);
            sonInstanceNodes.add(sonInstanceNode);
        }
    }

    /**
     * 产生并行处理器节点的子节点V2
     * 假设子节点有3个，有3个部门需要并行审核，那么一个就会产生9个流程实例节点
     * @param nodes
     * @param sonInstanceNodes
     * @param parent
     * @param businessIdList
     */
    public void setSonInstanceNodeV2(List<ProcessNode> nodes, List<ProcessInstanceSubNode> sonInstanceNodes, ProcessInstanceNode parent, List<String> businessIdList){
        int rank = 0;
        for (String businessId : businessIdList) {
            for (int i = 0; i < nodes.size(); i++) {
                rank += 1;
                ProcessNode processNode = nodes.get(i);
                ProcessInstanceSubNode sonInstanceNode =  new ProcessInstanceSubNode();
                sonInstanceNode.setParentProcessInstanceNodeId(parent.getProcessInstanceNodeId());
                sonInstanceNode.setNodeName(processNode.getNodeName());
                sonInstanceNode.setNodeId(processNode.getNodeId());
                sonInstanceNode.setNodeStatus(ProcessInstanceNodeEnum.IN_PROGRESS.getCode());
                // 子节点排序，因为是多个部门并行，按顺序排序
                sonInstanceNode.setNodeRank(rank);
                sonInstanceNode.setProcessInstanceId(parent.getProcessInstanceId());
                sonInstanceNode.setProcessInstanceNodeSubId(IdUtils.fastUUID());
                sonInstanceNode.setVisibility(ProcessNodeVisibilityEnum.ENABLE.getCode());
                sonInstanceNode.setNodeType(ProcessNodeTypeEnum.PARALLEL_PROCESS.getCode());
                // 设置业务id
                sonInstanceNode.setBusinessId(businessId);

                sonInstanceNodes.add(sonInstanceNode);
            }
        }
        // 最后一个节点设置特殊阶段
        sonInstanceNodes.forEach(node -> {
            if(sonInstanceNodes.indexOf(node) == sonInstanceNodes.size() - 1){
                node.setStage(ProcessNodeStageEnum.SUB_OVER.getCode());
            }else {
                node.setStage(ProcessNodeStageEnum.RUNNING.getCode());
            }
        });
        processInstanceSubNodeService.saveBatch(sonInstanceNodes);
    }

    public ProcessInstanceNode setNextNode(ProcessInstanceSubNode sonInstanceNode) {
        ProcessInstanceNode processInstanceNode = ProcessInstanceNode.builder()
                .processInstanceId(sonInstanceNode.getProcessInstanceId())
                .processInstanceNodeId(IdUtils.fastUUID())
                .nodeId(sonInstanceNode.getNodeId())
                .nodeName(sonInstanceNode.getNodeName())
                .nodeStatus(ProcessInstanceNodeEnum.IN_PROGRESS.getCode())
                .visibility(ProcessNodeVisibilityEnum.ENABLE.getCode())
                .nodeType(ProcessNodeTypeEnum.PARALLEL_PROCESS.getCode())
                .businessId(sonInstanceNode.getBusinessId())
                .processInstanceNodeSubId(sonInstanceNode.getProcessInstanceNodeSubId())
                .build();
        processInstanceNodeMapper.insert(processInstanceNode);
        return processInstanceNode;
    }



}
