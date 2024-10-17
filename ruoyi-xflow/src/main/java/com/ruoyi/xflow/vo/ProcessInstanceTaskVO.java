package com.ruoyi.xflow.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * @Author hongcq
 * @Date 2024/6/27
 */
@Data
public class ProcessInstanceTaskVO {

    /**
     * 任务ID
     */
    private String taskId;

    /** 用户ID */
    private String userId;

    /** 用户名 */
    private String userName;

    /** 用户工号 */
    private String account;

    /** 部门ID */
    private String deptId;

    /** 部门名 */
    private String deptName;

    /**
     * 任务状态
     */
    private String taskStatus;

    /**
     * 审核时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date auditTime;

    /**
     * 审核意见
     */
    private String auditComments;
}
