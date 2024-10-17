package com.ruoyi.xflow.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.xflow.domain.ProcessInstanceSubNode;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 子流程节点记录Mapper接口
 *
 * @author hongcq
 * @date 2024-06-28
 */
@Mapper
public interface ProcessInstanceSubNodeMapper  extends BaseMapper<ProcessInstanceSubNode>
{


    default List<ProcessInstanceSubNode> selectSonNodeByParentId(String parentId){
        return this.selectList(new com.baomidou.mybatisplus.core.conditions.query.QueryWrapper<ProcessInstanceSubNode>().eq("parent_process_instance_node_id",parentId));
    }

    default ProcessInstanceSubNode selectSubNodeBySubNodeId(String subId){
        return this.selectOne(new com.baomidou.mybatisplus.core.conditions.query.QueryWrapper<ProcessInstanceSubNode>().eq("process_instance_node_sub_id",subId));
    }

    default ProcessInstanceSubNode selectBrotherNodeByParentIdAndRank(String parentProcessInstanceNodeId, int l){
        return this.selectOne(new com.baomidou.mybatisplus.core.conditions.query.QueryWrapper<ProcessInstanceSubNode>()
                .eq("parent_process_instance_node_id",parentProcessInstanceNodeId)
                .eq("node_rank",l));
    }
}
