package com.ruoyi.xflow.process.instance.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.ruoyi.xflow.domain.ProcessInstanceSubNode;
import com.ruoyi.xflow.mapper.ProcessInstanceSubNodeMapper;
import com.ruoyi.xflow.process.instance.IProcessInstanceSubNodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * 子流程节点记录Service业务层处理
 *
 * @author hongcq
 * @date 2024-06-28
 */
@Service
public class ProcessInstanceSubNodeServiceImpl extends ServiceImpl<ProcessInstanceSubNodeMapper, ProcessInstanceSubNode> implements IProcessInstanceSubNodeService
{
    @Autowired
    private ProcessInstanceSubNodeMapper processInstanceSubNodeMapper;


}
