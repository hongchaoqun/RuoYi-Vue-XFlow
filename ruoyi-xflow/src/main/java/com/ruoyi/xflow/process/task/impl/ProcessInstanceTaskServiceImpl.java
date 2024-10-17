package com.ruoyi.xflow.process.task.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.xflow.common.FlowException;
import com.ruoyi.xflow.common.enums.ProcessInstanceTaskEnum;
import com.ruoyi.xflow.component.IDispatchMessageService;
import com.ruoyi.xflow.component.IUserDiscoveryService;
import com.ruoyi.xflow.domain.*;
import com.ruoyi.xflow.mapper.ProcessInstanceMapper;
import com.ruoyi.xflow.mapper.ProcessInstanceNodeMapper;
import com.ruoyi.xflow.mapper.ProcessInstanceTaskMapper;
import com.ruoyi.xflow.mapper.ProcessNodeMapper;
import com.ruoyi.xflow.process.task.IProcessInstanceTaskService;
import com.ruoyi.xflow.vo.ProcessInstanceTaskVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;


/**
 * 流程任务表Service业务层处理
 *
 * @author hongcq
 * @date 2024-06-26
 */
@Service
public class ProcessInstanceTaskServiceImpl extends ServiceImpl<ProcessInstanceTaskMapper, ProcessInstanceTask> implements IProcessInstanceTaskService
{
    @Resource
    private ProcessInstanceMapper processInstanceMapper;
    @Resource
    private ProcessInstanceNodeMapper processInstanceNodeMapper;
    @Resource
    private ProcessNodeMapper processNodeMapper;
    @Autowired
    private List<IDispatchMessageService> messageServices;

    /**
     * 添加发起人的用户任务
     * @param firstNode 第一个节点
     * @return 发起人的用户任务
     */
    @Override
    public ProcessInstanceTask setFirstTask(ProcessInstance instance, ProcessInstanceNode firstNode) {


        ProcessInstanceTask task = ProcessInstanceTask.builder().
                taskId(IdUtils.fastUUID()).
                processInstanceId(firstNode.getProcessInstanceId()).
                processInstanceNodeId(firstNode.getProcessInstanceNodeId()).
                taskName(firstNode.getNodeName()).
                taskStatus(ProcessInstanceTaskEnum.IN_PROGRESS.getCode()).
                userId(instance.getOwnerId()).
                userName(instance.getOwnerName()).
                account(instance.getOwnerAccount()).
                deptId(instance.getDeptId()).
                deptName(instance.getDeptName()).
                build();

        save(task);
        return task;
    }

    @Override
    public ProcessInstanceTask getByTaskId(String taskId) {
        return getOne(new QueryWrapper<ProcessInstanceTask>().eq("task_id",taskId));
    }

    /**
     * 跟据当前节点，设置用户任务
     * @param nextInstanceNodeId 新生成的节点
     * @return 用户任务是否创建成功
     */
    @Override
    public Boolean setNextTask(String nextInstanceNodeId) {
        ProcessInstanceNode instanceNode = processInstanceNodeMapper.selectByInstanceNodeId(nextInstanceNodeId);
        assert instanceNode != null;

        ProcessNode processNode = processNodeMapper.selectNodeByNodeId(instanceNode.getNodeId());
        assert processNode != null;

        // 根据配置获取用户，给他们设置任务。获取用户的步骤交给业务方自定义，定义完在配置数据里写上beanName
        IUserDiscoveryService discoveryService = (IUserDiscoveryService) SpringUtils.getBean(processNode.getBeanName());
        List<XflowDO> users = discoveryService.findUserList(nextInstanceNodeId);
        if(users == null || users.isEmpty()){
            throw new FlowException("未找到用户, 请检查流程配置");
        }

        List<ProcessInstanceTask> tasks = users.stream().map(user -> ProcessInstanceTask.builder().
                taskId(IdUtils.fastUUID()).
                processInstanceId(instanceNode.getProcessInstanceId()).
                processInstanceNodeId(instanceNode.getProcessInstanceNodeId()).
                taskName(instanceNode.getNodeName()).
                taskStatus(ProcessInstanceTaskEnum.IN_PROGRESS.getCode()).
                userId(user.getUserId()).
                userName(user.getUserName()).
                account(user.getAccount()).
                deptId(user.getDeptId()).
                deptName(user.getDeptName()).
                build()).collect(Collectors.toList());

        Boolean flag = saveBatch(tasks);

        // 发送消息
        if(Boolean.TRUE.equals(flag)){
            try{
                if(messageServices != null && !messageServices.isEmpty()){
                    List<String> taskIds = tasks.stream().map(ProcessInstanceTask::getTaskId).collect(Collectors.toList());
                    for (IDispatchMessageService messageService : messageServices) {
                        if(messageService != null){
                            messageService.dispatchMessage(taskIds);
                        }
                    }
                }
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        return flag;
    }

    /**
     * 处理会签， 没有审批的记录全部标记为弃权
     * @param task
     * @return
     */
    @Override
    public Boolean dealOrSign(ProcessInstanceTask task) {
        List<ProcessInstanceTask> tasks = list(new QueryWrapper<ProcessInstanceTask>().
                eq("process_instance_id",task.getProcessInstanceId()).
                eq("process_instance_node_id",task.getProcessInstanceNodeId()).
                eq("task_status",ProcessInstanceTaskEnum.IN_PROGRESS.getCode()));
        tasks.forEach(t -> {
            t.setTaskStatus(ProcessInstanceTaskEnum.WAIVER.getCode());
        });
        updateBatchById(tasks);
        return true;
    }

    /**
     * 处理并签, 如果全部处理完成返回true ，否则返回false
     * @param task
     * @return
     */
    @Override
    public Boolean dealAndSign(ProcessInstanceTask task) {
        List<ProcessInstanceTask> tasks = list(new QueryWrapper<ProcessInstanceTask>().
                eq("process_instance_id",task.getProcessInstanceId()).
                eq("process_instance_node_id",task.getProcessInstanceNodeId()).
                eq("task_status",ProcessInstanceTaskEnum.IN_PROGRESS.getCode()));
        if(tasks.isEmpty()){
            return true;
        }
        return false;
    }

    @Override
    public List<ProcessInstanceTaskVO> listByInstanceNodeId(String processInstanceNodeId) {
        // 查询数据库获取任务列表
        List<ProcessInstanceTask> taskList = baseMapper.selectList(new QueryWrapper<ProcessInstanceTask>().eq("process_instance_node_id",processInstanceNodeId));

        // 转换实体为VO对象
        return taskList.stream()
                .map(this::convertToTaskVO)
                .collect(Collectors.toList());
    }

    private ProcessInstanceTaskVO convertToTaskVO(ProcessInstanceTask task) {
        ProcessInstanceTaskVO vo = BeanUtil.copyProperties(task, ProcessInstanceTaskVO.class);
        return vo;
    }


}
