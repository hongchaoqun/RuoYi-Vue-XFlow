package com.ruoyi.xflow.process.instance;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.xflow.domain.ProcessInstance;
import com.ruoyi.xflow.domain.ProcessInstanceNode;
import com.ruoyi.xflow.domain.ProcessInstanceTask;
import com.ruoyi.xflow.domain.ProcessNode;
import com.ruoyi.xflow.vo.ProcessInstanceNodeVO;


import java.util.List;

/**
 * 流程实例节点Service接口
 *
 * @author hongcq
 * @date 2024-06-26
 */
public interface IProcessInstanceNodeService extends IService<ProcessInstanceNode>
{
    /**
     * 设置流程实例的第一个节点
     * @param instance
     * @return
     */
    ProcessInstanceTask setFirstNode(ProcessInstance instance);

    /**
     * 完成用户任务
     * @param taskId 任务id
     * @param code 审批码
     * @param auditComments 审批意见
     * @return 成功或失败
     */
    Boolean complete(String taskId, String code, String auditComments);

    List<ProcessInstanceNodeVO> listProcessInstanceNodeVo(String processInstanceId);

    ProcessInstanceNode getByInstanceNodeId(String instanceNode);

    List<ProcessInstanceNode> listInstanceNodeByDefNode(String processNodeId);

    /**
     * 根据流程节点id和流程实例id获取流程节点
     * @param processNodeId
     * @param processInstanceId
     * @return
     */
    ProcessInstanceNode getByProcessNodeIdAndInstanceId(String processNodeId, String processInstanceId);

    /**
     * 自动处理一个节点的用户任务，并且结束节点
     * @param instanceId
     * @param processNode
     */
    void autoFinishInsNode(String instanceId, ProcessNode processNode);

    List<ProcessInstanceNode> getUnCompeleteNodeByInsIdAndNodeId(String processInstanceId, String processNodeId);
}
