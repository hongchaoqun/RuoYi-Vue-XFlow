package com.ruoyi.xflow.process.def.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.ruoyi.xflow.common.enums.ProcessInstanceNodeEnum;
import com.ruoyi.xflow.common.enums.ProcessNodeVisibilityEnum;
import com.ruoyi.xflow.domain.ProcessInstance;
import com.ruoyi.xflow.domain.ProcessInstanceNode;
import com.ruoyi.xflow.domain.ProcessNode;
import com.ruoyi.xflow.mapper.ProcessInstanceMapper;
import com.ruoyi.xflow.mapper.ProcessInstanceNodeMapper;
import com.ruoyi.xflow.mapper.ProcessNodeMapper;
import com.ruoyi.xflow.process.def.IProcessNodeService;
import com.ruoyi.xflow.vo.ProcessInstanceNodeVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;


/**
 * 流程定义节点Service业务层处理
 *
 * @author hongcq
 * @date 2024-06-26
 */
@Service
public class ProcessNodeServiceImpl extends ServiceImpl<ProcessNodeMapper, ProcessNode> implements IProcessNodeService {

    @Resource
    private ProcessInstanceMapper processInstanceMapper;
    @Resource
    private ProcessInstanceNodeMapper processInstanceNodeMapper;

    /**
     * 根据流程实例id查询流程实例节点, 实际上没有产生的节点，从流程定义中获取
     * @param processInstanceId
     * @return
     */
    @Override
    public List<ProcessInstanceNodeVO> listProcessInstanceNodeVo(String processInstanceId) {
        ProcessInstance processInstance = processInstanceMapper.selectByInstanceId(processInstanceId);
        assert processInstance != null;
        // 或取实际流程上的节点
        String currentProcessInstanceNodeId = processInstance.getCurrentProcessInstanceNodeId();
        ProcessInstanceNode processInstanceNode = processInstanceNodeMapper.selectByInstanceNodeId(currentProcessInstanceNodeId);
        assert processInstanceNode != null;

        List<ProcessNode> processNodes = baseMapper.listByDefId(processInstance.getProcessDefId());

        ProcessNode currentNode = baseMapper.selectNodeByNodeId(processInstanceNode.getNodeId());
        assert currentNode != null;
        // 获取当前节点后的节点
        List<ProcessNode> nodes = processNodes.stream().filter(node -> (node.getNodeRank() > currentNode.getNodeRank()) && (node.getVisibility().equals(ProcessNodeVisibilityEnum.ENABLE.getCode())))
                .sorted(Comparator.comparing(ProcessNode::getNodeRank))
                .collect(Collectors.toList());

        return nodes.stream().map(node -> {
            ProcessInstanceNodeVO processInstanceNodeVO = new ProcessInstanceNodeVO();
            processInstanceNodeVO.setNodeId(node.getNodeId());
            processInstanceNodeVO.setNodeName(node.getNodeName());
            processInstanceNodeVO.setNodeStatus(ProcessInstanceNodeEnum.IN_PROGRESS.getCode());
            processInstanceNodeVO.setTasks(new ArrayList<>());
            return processInstanceNodeVO;
        }).collect(Collectors.toList());
    }

    @Override
    public ProcessNode getByProcessNodeId(String processNodeId) {
        return baseMapper.selectNodeByNodeId(processNodeId);
    }
}
