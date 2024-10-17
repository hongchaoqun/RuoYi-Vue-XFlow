package com.ruoyi.xflow.process.def;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.xflow.domain.ProcessNode;
import com.ruoyi.xflow.vo.ProcessInstanceNodeVO;


import java.util.List;

/**
 * 流程定义节点Service接口
 *
 * @author hongcq
 * @date 2024-06-26
 */
public interface IProcessNodeService extends IService<ProcessNode>
{

    List<ProcessInstanceNodeVO> listProcessInstanceNodeVo(String processInstanceId);

    ProcessNode getByProcessNodeId(String processNodeId);
}
