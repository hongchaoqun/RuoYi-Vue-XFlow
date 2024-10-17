package com.ruoyi.xflow.common.enums;

public enum ProcessNodeStageEnum {

    BEGIN("0","开始"),
    RUNNING("1","进行中"),
    END("2","结束"),
    SUB_OVER("3", "子流程技术")
    ;

    private String code;
    private String description;

    ProcessNodeStageEnum(String code,String description) {
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
