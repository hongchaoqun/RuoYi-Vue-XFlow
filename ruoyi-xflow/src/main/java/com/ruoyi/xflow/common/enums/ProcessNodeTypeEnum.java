package com.ruoyi.xflow.common.enums;

public enum ProcessNodeTypeEnum {

    PROCESS("0","流程节点"),
    PARALLEL("1","并行处理器"),
    PARALLEL_PROCESS("2","并行处理_流程节点");

    private String code;
    private String description;

    ProcessNodeTypeEnum(String code,String description) {
        this.code = code;
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public String getCode() {
        return code;
    }
}
