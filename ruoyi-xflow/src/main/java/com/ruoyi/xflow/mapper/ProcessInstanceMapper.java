package com.ruoyi.xflow.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.xflow.domain.ProcessInstance;
import org.apache.ibatis.annotations.Mapper;

/**
 * 流程实例管理Mapper接口
 *
 * @author hongcq
 * @date 2024-06-26
 */
@Mapper
public interface ProcessInstanceMapper extends BaseMapper<ProcessInstance>
{

    /**
     * 根据流程实例id获取流程实例
     * @param processInstanceId 流程实例id
     * @return 流程实例
     */
    default ProcessInstance selectByInstanceId(String processInstanceId){
        return selectOne(new QueryWrapper<ProcessInstance>().eq("process_instance_id",processInstanceId));
    }
}
