package com.ruoyi.xflow.component;


import com.ruoyi.xflow.domain.ProcessNode;

/**
 * 节点生成后的后置处理 （任务监听器）
 */
public interface InstanceNodePostProcessor {

    /**
     * 后置处理
     */
    void postProcessAfterInitialization(String instanceId, ProcessNode processNode);

    /**
     * 是否满足产品设计的跳过条件， true=满足（跳过当前节点），false=不满足
     * @param instanceId 流程实例id
     * @param processNode 流程节点定义
     * @return
     */
    boolean isMatch(String instanceId, ProcessNode processNode);
}
