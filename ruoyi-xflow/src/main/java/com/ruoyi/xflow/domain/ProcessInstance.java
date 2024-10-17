package com.ruoyi.xflow.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.xflow.common.core.BaseDomain;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 流程实例管理对象 xflow_process_instance
 *
 * @author hongcq
 * @date 2024-06-26
 */
@EqualsAndHashCode(callSuper = true)
@TableName("xflow_process_instance")
@Data
@Builder
public class ProcessInstance extends BaseDomain {
private static final long serialVersionUID = 1L;

    /** 唯一标识 */
    @TableId(type = IdType.ASSIGN_ID)
    private String id;

    /** 流程实例ID */
    @TableField("process_instance_id")
    private String processInstanceId;

    /** 流程定义ID */
    @TableField("process_def_id")
    private String processDefId;

    /** $column.columnComment */
    @TableField("owner_name")
    private String ownerName;

    /** $column.columnComment */
    @TableField("owner_id")
    private String ownerId;

    /** $column.columnComment */
    @TableField("owner_account")
    private String ownerAccount;

    /** $column.columnComment */
    @TableField("dept_id")
    private String deptId;

    /** $column.columnComment */
    @TableField("dept_name")
    private String deptName;

    @TableField("status")
    private String status;

    @TableField("current_process_instance_node_id")
    private String currentProcessInstanceNodeId;

    @TableField("business_id")
    private String businessId;

    @TableField("business_type")
    private String businessType;



}
