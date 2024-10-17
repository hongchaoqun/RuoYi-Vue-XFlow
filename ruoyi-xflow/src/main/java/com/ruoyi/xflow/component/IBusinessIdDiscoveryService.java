package com.ruoyi.xflow.component;

import java.util.List;

/**
 * 业务方要用到的各种业务id，由业务方提交上来，也是业务方自己使用。数据会保存在流程实例节点的 BusinessId 里
 */
public interface IBusinessIdDiscoveryService {


    /**
     * 根据当前节点读取当前节点的配置，再从当前流程里获取数据
     *
     * 这里的功能是从前一个节点提交的表单中获取 多个统筹部门（归口部门）id
     * @param processInstanceId 流程实例id
     * @param processNodeId 节点id (当前节点，并行处理器的节点)
     * @return 部门id (也可是其他标准，根据业务需求决定，传一个标志到流程里记录起来，业务要用到就可以直接拿来用；
     * 比如： 如果是多个部门审核，就传多个部门id，如果是多个用户审核，就传多个用户id。 流程实例节点中用 BusinessId 来存这个标志，业务层根据这个标志来查询数据。)
     */
    List<String> deptListInForm(String processInstanceId, String processNodeId);
}
