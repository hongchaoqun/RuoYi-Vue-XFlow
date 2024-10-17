package com.ruoyi.xflow.component;


import com.ruoyi.xflow.domain.XflowDO;

import java.util.List;

/**
 * 发现下一个节点的用户， 由调用方自己实现
 */
public interface IUserDiscoveryService {

    /**
     * 查找用户列表
     * @return 用户列表
     */
    List<XflowDO> findUserList(String processInstanceNodeId);
}
