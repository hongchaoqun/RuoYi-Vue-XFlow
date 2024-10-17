package com.ruoyi.xflow.process.instance;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.xflow.domain.ProcessInstance;
import com.ruoyi.xflow.domain.XflowDO;
import com.ruoyi.xflow.vo.ProcessInstanceNodeVO;
import com.ruoyi.xflow.vo.ProcessNodeInfoVO;


import java.util.List;
import java.util.Map;

/**
 * 流程实例管理Service接口
 *
 * @author hongcq
 * @date 2024-06-26
 */
public interface IFlowProcessInstanceService extends IService<ProcessInstance> {

    /**
     * 开启一个新流程
     * @param processDefId 流程定义id
     * @param owner 流程实例的所有者
     * @return 流程实例id
     */
    String startProcessInstance(String processDefId, XflowDO owner);

    /**
     * 获取流程实例详情
     * @param processInstanceId 流程实例id
     * @return 流程实例
     */
    List<ProcessInstanceNodeVO> getProcessInstanceDetail(String processInstanceId);


    ProcessInstance getByInstanceId(String processInstanceId);

    boolean haveComplete(String processInstanceId);

    /**
     * 获取流程实例节点信息
     * @param processInstanceId 流程实例id
     * @param account 用户账号
     * @return 节点信息
     */
    Map<String, ProcessNodeInfoVO>  getProcessNodeInfoMapByUserAccount(List<String> processInstanceId, String account);

    /**
     * 获取流程实例节点信息
     * @param processInstanceId 流程实例id
     * @param userId 用户id
     * @return 节点信息
     */
    Map<String, ProcessNodeInfoVO> getProcessNodeInfoMapByUserId(List<String> processInstanceId, String userId);

    /**
     * 超期自动退回
     * @return 是否成功
     */
    boolean autoReturn(String processInstanceId);
}
