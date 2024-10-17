package com.ruoyi.xflow.domain;

import lombok.Data;

/**
 * 在流程中使用的用户信息
 * @Author hongcq
 * @Date 2024/6/25
 */
@Data
public class XflowDO {

    /**
     * 用户id
     */
    private String userId;

    /**
     * 用户名
     */
    private String userName;

    /**
     * 用户工号
     */
    private String account;

    /**
     * 部门id
     */
    private String deptId;

    /**
     * 部门名称
     */
    private String deptName;

    /**
     * 业务id
     */
    private String businessId;

    /**
     * 业务类型
     */
    private String businessType;
}
