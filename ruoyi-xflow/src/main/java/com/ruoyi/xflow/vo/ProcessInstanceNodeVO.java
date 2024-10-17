package com.ruoyi.xflow.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;
import java.util.List;

/**
* @Author hongcq
* @Date 2024/6/27
*/
@Data
public class ProcessInstanceNodeVO {

    /** 流程实例ID */
    private String processInstanceId;

    /** 流程实例节点ID */
    private String processInstanceNodeId;

    /** 定义节点ID */
    private String nodeId;

    /** 节点名称 */
    private String nodeName;

    /** 节点状态 */
    private String nodeStatus;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    private List<ProcessInstanceTaskVO> tasks;

}
