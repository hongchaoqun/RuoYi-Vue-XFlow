package com.ruoyi.xflow.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.xflow.common.enums.ProcessInstanceNodeEnum;
import com.ruoyi.xflow.domain.ProcessInstanceNode;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 流程实例节点Mapper接口
 *
 * @author hongcq
 * @date 2024-06-26
 */
@Mapper
public interface ProcessInstanceNodeMapper  extends BaseMapper<ProcessInstanceNode>
{

    /**
     * 根据流程实例节点id 获取流程实例节点
     * @param processInstanceNodeId 流程实例节点id
     * @return 流程实例节点
     */
    default ProcessInstanceNode selectByInstanceNodeId(String processInstanceNodeId){
        return selectOne(new com.baomidou.mybatisplus.core.conditions.query.QueryWrapper<ProcessInstanceNode>().eq("process_instance_node_id",processInstanceNodeId));
    }

    default ProcessInstanceNode selectByNodeIdAndInsId(String parentNodeId, String processInstanceId){
        return selectOne(new com.baomidou.mybatisplus.core.conditions.query.QueryWrapper<ProcessInstanceNode>().eq("process_instance_id",processInstanceId).eq("node_id",parentNodeId));
    }

    default ProcessInstanceNode selectByNodeIdAndInsIdAndStatus(String nodeId, String processInstanceId){
        List<ProcessInstanceNode> processInstanceNodes = selectList(new com.baomidou.mybatisplus.core.conditions.query.QueryWrapper<ProcessInstanceNode>()
                .eq("process_instance_id",processInstanceId)
                .eq("node_id",nodeId)
                .eq("node_status", ProcessInstanceNodeEnum.IN_PROGRESS.getCode())
                .orderByDesc("create_time")
        );
        return processInstanceNodes.isEmpty() ? null : processInstanceNodes.get(0);
    }

}
