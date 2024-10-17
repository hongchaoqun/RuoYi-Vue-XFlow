package com.ruoyi.xflow.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.xflow.common.core.BaseDomain;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

/**
 * 流程任务表对象 xflow_process_instance_task
 *
 * @author hongcq
 * @date 2024-06-26
 */
@EqualsAndHashCode(callSuper = true)
@TableName("xflow_process_instance_task")
@Data
@Builder
public class ProcessInstanceTask extends BaseDomain {
private static final long serialVersionUID = 1L;

    /** 唯一标识 */
    @TableId(type = IdType.ASSIGN_ID)
    private String id;

    @TableField("task_id")
    private String taskId;

    /** 流程实例ID */
    @TableField("process_instance_id")
    private String processInstanceId;

    /** 流程实例节点ID */
    @TableField("process_instance_node_id")
    private String processInstanceNodeId;

    /** 任务名 */
    @TableField("task_name")
    private String taskName;

    /** 用户ID */
    @TableField("user_id")
    private String userId;

    /** 用户名 */
    @TableField("user_name")
    private String userName;

    /** 用户工号 */
    @TableField("account")
    private String account;

    /** 部门ID */
    @TableField("dept_id")
    private String deptId;

    /** 部门名 */
    @TableField("dept_name")
    private String deptName;

    /**
     * 任务状态
     */
    @TableField("task_status")
    private String taskStatus;

    /**
     * 审核时间
     */
    @TableField("audit_time")
    private Date auditTime;

    /**
     * 审核意见
     */
    @TableField("audit_comments")
    private String auditComments;

}
