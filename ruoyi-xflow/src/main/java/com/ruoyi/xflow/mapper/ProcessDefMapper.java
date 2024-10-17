package com.ruoyi.xflow.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.xflow.domain.ProcessDef;
import org.apache.ibatis.annotations.Mapper;

/**
 * 流程定义Mapper接口
 *
 * @author hongcq
 * @date 2024-06-26
 */
@Mapper
public interface ProcessDefMapper  extends BaseMapper<ProcessDef>
{
    default ProcessDef getByProcessDefId(String processDefId){
        return selectOne(new LambdaQueryWrapper<ProcessDef>().eq(ProcessDef::getProcessDefId, processDefId));
    }

}
