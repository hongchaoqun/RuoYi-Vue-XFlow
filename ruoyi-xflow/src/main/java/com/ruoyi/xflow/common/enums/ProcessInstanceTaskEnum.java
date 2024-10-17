package com.ruoyi.xflow.common.enums;

public enum ProcessInstanceTaskEnum {

    IN_PROGRESS("0","未审核"),
    PASS("1","通过"),
    REJECT("2","驳回"),
    WAIVER("3","弃权")
    ;

    private String code;
    private String description;

    ProcessInstanceTaskEnum(String code,String description) {
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
