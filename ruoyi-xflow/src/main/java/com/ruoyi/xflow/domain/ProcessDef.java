package com.ruoyi.xflow.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.xflow.common.core.BaseDomain;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 流程定义对象 xflow_process_def
 *
 * @author hongcq
 * @date 2024-06-26
 */
@EqualsAndHashCode(callSuper = true)
@TableName("xflow_process_def")
@Data
public class ProcessDef extends BaseDomain {
private static final long serialVersionUID = 1L;

/** 唯一标识 */
    @TableId(type = IdType.ASSIGN_ID)
    private String id;

/** 定义ID */
    @TableField("process_def_id")
    private String processDefId;

/** 流程名 */
    @TableField("process_name")
    private String processName;

/** 说明 */
    @TableField("description")
    private String description;

/** 是否删除 */
    @TableField("deleted")
    private String deleted;


}
