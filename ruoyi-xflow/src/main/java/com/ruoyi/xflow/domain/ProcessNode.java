package com.ruoyi.xflow.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.xflow.common.core.BaseDomain;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 流程定义节点对象 xflow_process_node
 *
 * @author hongcq
 * @date 2024-06-26
 */
@EqualsAndHashCode(callSuper = true)
@TableName("xflow_process_node")
@Data
public class ProcessNode extends BaseDomain {
private static final long serialVersionUID = 1L;


    /** 唯一标识 */
    @TableId(type = IdType.ASSIGN_ID)
    private String id;

    /** 流程定义id */
    @TableField("process_def_id")
    private String processDefId;

    /** 节点ID */
    @TableField("node_id")
    private String nodeId;

    /** 节点名称 */
    @TableField("node_name")
    private String nodeName;

    /** 等级 */
    @TableField("level")
    private Long level;

    /** 父节点id */
    @TableField("parent_node_id")
    private String parentNodeId;

    /** 下一个节点id */
    @TableField("next_node_id")
    private String nextNodeId;

    /** 可见性 */
    @TableField("visibility")
    private String visibility;

    /** 节点类型 */
    @TableField("node_type")
    private String nodeType;

    /** 表单id */
    @TableField("form_id")
    private String formId;

    /** 具体实现类在 spring里的beanName */
    @TableField("bean_name")
    private String beanName;

    /**
     * 节点排序
     */
    @TableField("node_rank")
    private Integer nodeRank;

    /**
     * 节点阶段
     */
    @TableField("stage")
    private String stage;

    /**
     * 签 方式
     */
    @TableField("sign_type")
    private String signType;

    /**
     * 退回的节点
     */
    @TableField("return_node")
    private String returnNode;

}
