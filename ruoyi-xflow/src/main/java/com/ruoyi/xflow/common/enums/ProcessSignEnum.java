package com.ruoyi.xflow.common.enums;

public enum ProcessSignEnum {

    OR_SIGN("0","或签"),
    AND_SIGN("1","会签");

    private String code;
    private String description;

    ProcessSignEnum(String code,String description) {
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
