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
 * 流程实例节点对象 xflow_process_instance_node
 *
 * @author hongcq
 * @date 2024-06-26
 */
@EqualsAndHashCode(callSuper = true)
@TableName("xflow_process_instance_node")
@Data
@Builder
public class ProcessInstanceNode extends BaseDomain {
private static final long serialVersionUID = 1L;

    /** 唯一标识 */
    @TableId(type = IdType.ASSIGN_ID)
    private String id;

    /** 流程实例ID */
    @TableField("process_instance_id")
    private String processInstanceId;

    /** 流程实例节点ID */
    @TableField("process_instance_node_id")
    private String processInstanceNodeId;

    /** 定义节点ID */
    @TableField("node_id")
    private String nodeId;

    /** 节点名称 */
    @TableField("node_name")
    private String nodeName;

    /** 节点状态 */
    @TableField("node_status")
    private String nodeStatus;

    /**
     * 在子节点中的id记录
     */
    @TableField("sub_id")
    private String subId;

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


    /**
     * 原数据id，特殊流程使用
     */
    @TableField("process_instance_node_sub_id")
    private String processInstanceNodeSubId;

}
