package com.ruoyi.xflow.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.xflow.common.core.BaseDomain;
import lombok.Data;

/**
 * 子流程节点记录对象 xflow_process_instance_sub_node
 *
 * @author hongcq
 * @date 2024-06-28
 */
@TableName("xflow_process_instance_sub_node")
@Data
public class ProcessInstanceSubNode extends BaseDomain {
private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    @TableId(type = IdType.ASSIGN_ID)
    private String id;

    /** $column.columnComment */
    @TableField("process_instance_id")
    private String processInstanceId;

    /** $column.columnComment */
    @TableField("process_instance_node_sub_id")
    private String processInstanceNodeSubId;

    /** $column.columnComment */
    @TableField("node_id")
    private String nodeId;

    /** 节点排序 */
    @TableField("node_rank")
    private Integer nodeRank;

    /** 流程实例节点id */
    @TableField("parent_process_instance_node_id")
    private String parentProcessInstanceNodeId;

    /** $column.columnComment */
    @TableField("node_name")
    private String nodeName;

    /** $column.columnComment */
    @TableField("node_status")
    private String nodeStatus;

    @TableField("stage")
    private String stage;

    /**
     * 节点可见性
     */
    @TableField("visibility")
    private String visibility;

    /**
     * 节点的类型
     */
    @TableField("node_type")
    private String nodeType;

    /**
     * 预留字段，业务系统自行取用
     */
    @TableField("business_id")
    private String businessId;
}
