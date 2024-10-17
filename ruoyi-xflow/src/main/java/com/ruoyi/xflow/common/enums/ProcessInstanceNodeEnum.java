package com.ruoyi.xflow.common.enums;

public enum ProcessInstanceNodeEnum {

    IN_PROGRESS("IN_PROGRESS","进行中"),
    COMPLETED("COMPLETED","已完成");

    private String code;
    private String description;

    ProcessInstanceNodeEnum(String code,String description) {
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
