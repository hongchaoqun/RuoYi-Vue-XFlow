package com.ruoyi.xflow.process.task;


import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.xflow.domain.ProcessInstance;
import com.ruoyi.xflow.domain.ProcessInstanceNode;
import com.ruoyi.xflow.domain.ProcessInstanceTask;
import com.ruoyi.xflow.vo.ProcessInstanceTaskVO;


import java.util.List;

/**
 * 流程任务表Service接口
 *
 * @author hongcq
 * @date 2024-06-26
 */
public interface IProcessInstanceTaskService extends IService<ProcessInstanceTask>
{

    ProcessInstanceTask setFirstTask(ProcessInstance instance, ProcessInstanceNode firstNode);

    ProcessInstanceTask getByTaskId(String taskId);

    Boolean setNextTask(String nextInstanceNodeId);

    Boolean dealOrSign(ProcessInstanceTask task);

    Boolean dealAndSign(ProcessInstanceTask task);

    List<ProcessInstanceTaskVO> listByInstanceNodeId(String processInstanceNodeId);

}

