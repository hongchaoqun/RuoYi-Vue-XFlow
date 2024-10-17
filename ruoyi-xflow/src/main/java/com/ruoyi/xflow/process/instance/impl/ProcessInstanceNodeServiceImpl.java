package com.ruoyi.xflow.process.instance.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.xflow.common.FlowException;
import com.ruoyi.xflow.common.enums.*;
import com.ruoyi.xflow.component.IDispatchMessageService;
import com.ruoyi.xflow.component.InstanceNodePostProcessor;
import com.ruoyi.xflow.domain.ProcessInstance;
import com.ruoyi.xflow.domain.ProcessInstanceNode;
import com.ruoyi.xflow.domain.ProcessInstanceTask;
import com.ruoyi.xflow.domain.ProcessNode;
import com.ruoyi.xflow.mapper.ProcessInstanceMapper;
import com.ruoyi.xflow.mapper.ProcessInstanceNodeMapper;
import com.ruoyi.xflow.mapper.ProcessInstanceTaskMapper;
import com.ruoyi.xflow.mapper.ProcessNodeMapper;
import com.ruoyi.xflow.process.chain.ChainFactoryService;
import com.ruoyi.xflow.process.chain.handler.ProcessInstanceCardHandler;
import com.ruoyi.xflow.process.instance.IProcessInstanceNodeService;
import com.ruoyi.xflow.process.task.IProcessInstanceTaskService;
import com.ruoyi.xflow.vo.ProcessInstanceNodeVO;
import com.ruoyi.xflow.vo.ProcessInstanceTaskVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;


/**
 * 流程实例节点Service业务层处理
 *
 * @author hongcq
 * @date 2024-06-26
 */
@Service
@Slf4j
public class ProcessInstanceNodeServiceImpl extends ServiceImpl<ProcessInstanceNodeMapper, ProcessInstanceNode> implements IProcessInstanceNodeService
{

    @Resource
    private ProcessNodeMapper processNodeMapper;
    @Resource
    private IProcessInstanceTaskService processInstanceTaskService;
    @Resource
    private ProcessInstanceTaskMapper processInstanceTaskMapper;
    @Resource
    private ChainFactoryService chainFactoryService;
    @Resource
    private ProcessInstanceMapper processInstanceMapper;
    @Autowired
    private List<InstanceNodePostProcessor> instanceNodePostProcessors;
    @Autowired
    private List<IDispatchMessageService> messageServices;

    /**
     * 创建第一个节点，并且设置当前节点的用户任务
     * @param instance 流程实例
     * @return 用户任务
     */
    @Override
    public ProcessInstanceTask setFirstNode(ProcessInstance instance) {
        ProcessNode firstDefNode = processNodeMapper.selectFirstNodeByDefId(instance.getProcessDefId());
        assert firstDefNode != null;
        ProcessInstanceNode firstNode = ProcessInstanceNode.builder().
                processInstanceId(instance.getProcessInstanceId()).
                nodeId(firstDefNode.getNodeId()).
                nodeName(firstDefNode.getNodeName()).
                nodeStatus(ProcessInstanceNodeEnum.IN_PROGRESS.getCode()).
                processInstanceNodeId(IdUtils.fastUUID()).
                build();
        save(firstNode);

        // 设置用户任务
        return processInstanceTaskService.setFirstTask(instance, firstNode);
    }

    private boolean completeInstance(ProcessInstance instance){
        instance.setStatus(ProcessInstanceEnum.COMPLETED.getCode());
        processInstanceMapper.updateById(instance);
        return true;
    }

    /**
     * 完成任务； 先处理用户任务，
     * 或签完成一个任务，会签完成所有的用户任务后 -> 节点状态为已完成
     * @param taskId 任务id
     * @param code 审批码
     * @return 是否成功
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public synchronized Boolean complete(String taskId, String code, String auditComments) {

        boolean flag;
        if(ProcessInstanceTaskEnum.PASS.getCode().equals(code)){
            flag = agree(taskId, code,auditComments);
        }else if(ProcessInstanceTaskEnum.REJECT.getCode().equals(code)){
            flag = reject(taskId,code,auditComments);
        }else {
            throw new FlowException("审核状态参数异常");
        }
        return flag;
    }

    /**
     * 同意处理流程
     * @param taskId 用户任务id
     * @param code 审核状态
     * @param auditComments 审批意见
     * @return 是否成功
     */
    public Boolean agree(String taskId,String code, String auditComments){
        log.info("### 流程处理用户任务，taskId{} ###",taskId);
        ProcessInstanceTask task = processInstanceTaskService.getByTaskId(taskId);
        assert task != null;
        ProcessInstanceNode instanceNode = baseMapper.selectByInstanceNodeId(task.getProcessInstanceNodeId());
        assert instanceNode != null;
        // 0.0 检查该流程是否已处理，已处理的流程直接返回true
        if(!ProcessInstanceNodeEnum.IN_PROGRESS.getCode().equals(instanceNode.getNodeStatus())){
            return true;
        }

        ProcessInstance instance = processInstanceMapper.selectByInstanceId(instanceNode.getProcessInstanceId());
        assert instance != null;
        ProcessNode node = processNodeMapper.selectNodeByNodeId(instanceNode.getNodeId());
        assert node != null;

        // 1.0 处理当前节点用户任务
        boolean flag = dealTask(task, node, code,auditComments);
        if(!flag){
            log.info("### 流程处理用户任务，处理失败或者会签没有完成，不能进入下一步流程，跳出 ###");
            return true;
        }

        String nextInstanceNodeId;
        // 2.0 处理流程节点
        if(ProcessNodeTypeEnum.PROCESS.getCode().equals(node.getNodeType())){
            ProcessInstanceCardHandler handler = chainFactoryService.getChain(instance.getProcessDefId());
            // 处理流程节点后返回下一个节点的流程id
            nextInstanceNodeId = handler.dealTask(instanceNode.getProcessInstanceNodeId(), instanceNode.getNodeId());
        }else {
            // 子链节点特殊处理
            nextInstanceNodeId = chainFactoryService.getParallelSubChain(instanceNode.getProcessInstanceNodeId())
                    .dealTask(instanceNode.getProcessInstanceNodeSubId(), instanceNode.getProcessInstanceNodeId());
        }

        // 没有节点id，检查是否已经结束
        if(nextInstanceNodeId == null){
            if(!ProcessNodeStageEnum.END.getCode().equals(node.getStage())){
                throw new FlowException("审批流异常");
            }
            return completeInstance(instance);
        }

        // 3.0 新增下一个节点的用户任务
        boolean result = processInstanceTaskService.setNextTask(nextInstanceNodeId);
        if(result){
            // 执行后置处理
            // 同意后生成下一个节点和下一个节点的用户任务。 所以这里的后置处理，实现的时候要注意是对当前节点做操作，还是对下一个节点做操作
            try{
                if(instanceNodePostProcessors != null && !instanceNodePostProcessors.isEmpty()){
                    for (InstanceNodePostProcessor instanceNodePostProcessor : instanceNodePostProcessors) {
                        instanceNodePostProcessor.postProcessAfterInitialization(instance.getProcessInstanceId(), node);
                    }
                }
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 驳回处理流程
     * @param taskId 任务id
     * @param code 审核状态吗
     * @param auditComments 审核意见
     * @return 是否成功
     */
    public Boolean reject(String taskId,String code, String auditComments){
        log.info("### 流程驳回用户任务，taskId{} ###",taskId);
        ProcessInstanceTask task = processInstanceTaskService.getByTaskId(taskId);
        assert task != null;
        ProcessInstanceNode instanceNode = baseMapper.selectByInstanceNodeId(task.getProcessInstanceNodeId());
        assert instanceNode != null;
        // 0.0 检查该流程是否已处理，已处理的流程直接返回true
        if(!ProcessInstanceNodeEnum.IN_PROGRESS.getCode().equals(instanceNode.getNodeStatus())){
            return true;
        }

        ProcessInstance instance = processInstanceMapper.selectByInstanceId(instanceNode.getProcessInstanceId());
        assert instance != null;
        ProcessNode node = processNodeMapper.selectNodeByNodeId(instanceNode.getNodeId());
        assert node != null;

        // 1.0 处理当前节点用户任务
        boolean flag = dealTask(task, node, code,auditComments);
        if(!flag){
            log.info("### 流程处理用户任务，处理失败或者会签没有完成，不能进入下一步流程，跳出 ###");
            return true;
        }
        // TODO: 处理驳回或退回
        return returnInstanceNode(instance,instanceNode,node);
    }

    /**
     * 处理当前节点用户任务
     * @param task 用户任务
     * @param node 流程节点
     * @return true=处理成功,全部用户任务处理完成，可以进行流程流转；false=处理失败，或者会签没有全部完成，不能进行流程流转
     */
    private Boolean dealTask(ProcessInstanceTask task, ProcessNode node, String code,String auditComments){

        // 1. 处理当前节点
        task.setTaskStatus(code);
        task.setAuditComments(auditComments);
        task.setAuditTime(DateUtils.getNowDate());
        processInstanceTaskService.updateById(task);

        // 关闭待办消息
        try{
            log.info("### 用户任务完成，处理待办消息 ###");
            if(messageServices != null){
                for (IDispatchMessageService messageService : messageServices) {
                    if(messageService != null){
                        messageService.closeTask(task.getTaskId());
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        // 2. 判断当前节点是会签还是或签
        if(ProcessSignEnum.AND_SIGN.getCode().equals(node.getSignType())){
            // 2.1 会签处理
            return processInstanceTaskService.dealAndSign(task);
        }else {
            // 2.2 或签处理 把没有处理的其他节点设置为 弃权
            return processInstanceTaskService.dealOrSign(task);
        }
    }

    /**
     * 展示已发生的流程节点
     * @param processInstanceId 流程实例id
     * @return 已执行的流程节点
     */
    @Override
    public List<ProcessInstanceNodeVO> listProcessInstanceNodeVo(String processInstanceId) {
        List<ProcessInstanceNode> nodes = baseMapper.selectList(new QueryWrapper<ProcessInstanceNode>()
                .eq("process_instance_id", processInstanceId)
                .eq("visibility", ProcessNodeVisibilityEnum.ENABLE.getCode())
        );
        if(nodes == null || nodes.isEmpty()){
            return new ArrayList<>();
        }
        return nodes.stream().map(this::toNodeVO).collect(Collectors.toList());
    }

    @Override
    public List<ProcessInstanceNode> listInstanceNodeByDefNode(String processNodeId){
        return baseMapper.selectList(new QueryWrapper<ProcessInstanceNode>().eq("node_id", processNodeId));
    }

    private ProcessInstanceNodeVO toNodeVO(ProcessInstanceNode node){
        ProcessInstanceNodeVO vo = BeanUtil.copyProperties(node,ProcessInstanceNodeVO.class);
        List<ProcessInstanceTaskVO> tasks = processInstanceTaskService.listByInstanceNodeId(node.getProcessInstanceNodeId());
        vo.setTasks(tasks);
        return vo;
    }

    @Override
    public ProcessInstanceNode getByInstanceNodeId(String instanceNode) {
        return baseMapper.selectByInstanceNodeId(instanceNode);
    }

    @Override
    public ProcessInstanceNode getByProcessNodeIdAndInstanceId(String processNodeId, String processInstanceId) {
        return baseMapper.selectOne(new QueryWrapper<ProcessInstanceNode>()
                .eq("node_id", processNodeId)
                .eq("process_instance_id", processInstanceId)
                .eq("node_type", ProcessNodeTypeEnum.PROCESS.getCode())
        );
    }

    /**
     * 退回流程 退回到指定节点
     * @param currentInstanceNode 当前实例节点
     * @param currentNode 当前节点
     * @return 是否退回成功
     */
    private Boolean returnInstanceNode(ProcessInstance instance, ProcessInstanceNode currentInstanceNode, ProcessNode currentNode) {
        // 1.0 结束当前节点
        currentInstanceNode.setNodeStatus(ProcessInstanceNodeEnum.COMPLETED.getCode());
        updateById(currentInstanceNode);
        // 2.0 退回到指定节点
        if(currentNode.getReturnNode() == null){
            return completeInstance(instance);
        }else {
            ProcessNode node = processNodeMapper.selectNodeByNodeId(currentNode.getReturnNode());
            ProcessInstanceNode sonInstanceNode =  ProcessInstanceNode.builder()
                    .nodeStatus(ProcessInstanceNodeEnum.IN_PROGRESS.getCode())
                    .nodeId(currentNode.getReturnNode())
                    .nodeName(node.getNodeName())
                    .processInstanceNodeId(IdUtils.fastUUID())
                    .processInstanceId(instance.getProcessInstanceId())
                    .businessId(currentInstanceNode.getBusinessId())
                    .build();
            save(sonInstanceNode);

            instance.setCurrentProcessInstanceNodeId(sonInstanceNode.getProcessInstanceNodeId());
            processInstanceMapper.updateById(instance);

            // 3.0 生成新的用户任务
            return processInstanceTaskService.setNextTask(sonInstanceNode.getProcessInstanceNodeId());
        }
    }

    /**
     * 自动执行节点任务
     */
    @Override
    public void autoFinishInsNode(String instanceId, ProcessNode processNode) {

        // 获取下一个流程节点
        ProcessInstanceNode nextInstanceNode = baseMapper.selectByNodeIdAndInsIdAndStatus(processNode.getNodeId(), instanceId);
        log.info("#### autoFinishInsNode(): 自动执行节点任务，instanceId：{}，processNodeId:{}  ####",instanceId, processNode.getNodeId());
        assert nextInstanceNode != null;
        // 获取节点任务
        List<ProcessInstanceTask> tasks = processInstanceTaskMapper.selectByProcessInstanceNodeId(nextInstanceNode.getProcessInstanceNodeId());
        if(tasks == null || tasks.isEmpty()){
            log.warn("#### autoFinishInsNode(): 没有找到下一个节点的用户任务，自动执行结束，instanceId：{}，processNodeId:{}  ####",instanceId, processNode.getNodeId());
            return;
        }
        // 执行节点任务, 或签执行一个就可以，会签执行多个
        if(ProcessSignEnum.OR_SIGN.getCode().equals(processNode.getSignType())){
            ProcessInstanceTask task = tasks.get(0);
            agree(task.getTaskId(), ProcessInstanceTaskEnum.WAIVER.getCode(), AutoCommentEnum.COMPLETED.getDescription());
        }else {
            tasks.forEach(
                    task -> agree(task.getTaskId(), ProcessInstanceTaskEnum.WAIVER.getCode(), AutoCommentEnum.COMPLETED.getDescription())
            );
        }
    }

    /**
     * 获取流程中，指定的，最新的一个
     * @param processInstanceId
     * @param processNodeId
     * @return 流程节点列表
     */
    @Override
    public List<ProcessInstanceNode> getUnCompeleteNodeByInsIdAndNodeId(String processInstanceId, String processNodeId) {
         return baseMapper.selectList(new QueryWrapper<ProcessInstanceNode>()
                .eq("node_id", processNodeId)
                .eq("process_instance_id", processInstanceId)
                 .orderByDesc("create_time")
        );
    }
}
