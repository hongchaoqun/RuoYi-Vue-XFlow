package com.ruoyi.xflow.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.xflow.domain.ProcessNode;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 流程定义节点Mapper接口
 *
 * @author hongcq
 * @date 2024-06-26
 */
@Mapper
public interface ProcessNodeMapper  extends BaseMapper<ProcessNode> {

    /**
     * 根据流程定义id查询节点
     * @param defId 流程定义id
     * @return 节点定义
     */
    default List<ProcessNode> listByDefId(String defId){
        return selectList(new QueryWrapper<ProcessNode>().eq("process_def_id",defId).orderByAsc("node_rank"));
    }

    /**
     * 根据流程定义id查询第一个节点
     * @param processDefId 流程定义id
     * @return 节点定义
     */
    default ProcessNode selectFirstNodeByDefId(String processDefId){
        return selectOne(new QueryWrapper<ProcessNode>().eq("process_def_id",processDefId).eq("node_rank",1));
    }

    /**
     * 根据节点id查询节点
     * @param nodeId 节点id
     * @return 节点定义
     */
    default ProcessNode selectNodeByNodeId(String nodeId){
        return selectOne(new QueryWrapper<ProcessNode>().eq("node_id",nodeId));
    }

    /**
     * 根据节点id查询子节点
     * @param nodeId
     * @return 子节点
     */
    default List<ProcessNode> selectSonNodeByNodeIds(String nodeId){
        return selectList(new QueryWrapper<ProcessNode>().eq("parent_node_id",nodeId).orderByAsc("node_rank"));
    }

    default Long selectCountById(String id){
        return selectCount(new QueryWrapper<ProcessNode>().eq("id",id));
    }
}
