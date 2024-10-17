package com.ruoyi.xflow.vo;

import lombok.Data;

import java.util.Map;

/**
 * @Author hongcq
 * @Date 2024/7/11
 */
@Data
public class ProcessNodeInfoMapVO {

    /**
     * 流程节点信息map
     */
    private Map<String, ProcessNodeInfoVO> nodeInfoVOMap;
}
