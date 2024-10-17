package com.ruoyi.xflow.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.xflow.domain.ProcessInstanceTask;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 流程任务表Mapper接口
 *
 * @author hongcq
 * @date 2024-06-26
 */
@Mapper
public interface ProcessInstanceTaskMapper  extends BaseMapper<ProcessInstanceTask>
{

    default List<ProcessInstanceTask> selectByProcessInstanceNodeId(String insNodeId){
        return selectList(new QueryWrapper<ProcessInstanceTask>()
                .eq("process_instance_node_id", insNodeId)
        );
    }

    default ProcessInstanceTask selectOneByTaskId(String taskId){
        return selectOne(new QueryWrapper<ProcessInstanceTask>().eq("task_id",taskId));
    }
}
