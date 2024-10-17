package com.ruoyi.xflow.process.def.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.xflow.domain.ProcessDef;
import com.ruoyi.xflow.mapper.ProcessDefMapper;
import com.ruoyi.xflow.process.def.IProcessDefService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 流程定义Service业务层处理
 *
 * @author hongcq
 * @date 2024-06-26
 */
@Service
public class ProcessDefServiceImpl extends ServiceImpl<ProcessDefMapper, ProcessDef> implements IProcessDefService
{
    @Autowired
    private ProcessDefMapper processDefMapper;


    @Override
    public ProcessDef getByProcessDefId(String processDefId) {
        return processDefMapper.selectOne(new QueryWrapper<ProcessDef>().eq("process_def_id", processDefId));
    }
}
