package com.ruoyi.xflow.common.enums;

public enum AutoCommentEnum {

    COMPLETED("COMPLETED","自动执行节点任务");

    private String code;
    private String description;

    AutoCommentEnum(String code, String description) {
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
