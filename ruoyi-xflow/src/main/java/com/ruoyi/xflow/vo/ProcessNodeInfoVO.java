package com.ruoyi.xflow.vo;

import lombok.Data;

/**
 * @Author hongcq
 * @Date 2024/7/11
 */
@Data
public class ProcessNodeInfoVO {

    /**
     * 流程实例id
     */
    private String processInstanceId;

    /**
     * 流程节点
     */
    private String processNode;

    /**
     * 当前登录用户在这条记录上是否有任务
     */
    private Boolean haveTask;

    /**
     *  流程阶段 0-发起阶段 1-进行中 2-已完成
     */
    private String processStage;
}
