package com.ruoyi.xflow.common.enums;

public enum ProcessNodeVisibilityEnum {

    UNABLE("0","不可见"),
    ENABLE("1","可见");

    private String code;
    private String description;

    ProcessNodeVisibilityEnum(String code,String description) {
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
