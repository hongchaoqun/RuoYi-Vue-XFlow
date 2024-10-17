package com.ruoyi.xflow.process.instance.impl;

import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.ruoyi.xflow.common.FlowException;
import com.ruoyi.xflow.common.enums.ProcessInstanceEnum;
import com.ruoyi.xflow.common.enums.ProcessInstanceTaskEnum;
import com.ruoyi.xflow.domain.*;
import com.ruoyi.xflow.mapper.ProcessInstanceMapper;
import com.ruoyi.xflow.mapper.ProcessInstanceNodeMapper;
import com.ruoyi.xflow.mapper.ProcessInstanceTaskMapper;
import com.ruoyi.xflow.process.def.IProcessDefService;
import com.ruoyi.xflow.process.def.IProcessNodeService;
import com.ruoyi.xflow.process.instance.IFlowProcessInstanceService;
import com.ruoyi.xflow.process.instance.IProcessInstanceNodeService;
import com.ruoyi.xflow.vo.ProcessInstanceNodeVO;
import com.ruoyi.xflow.vo.ProcessNodeInfoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 流程实例管理Service业务层处理
 *
 * @author hongcq
 * @date 2024-06-26
 */
@Service
public class FlowProcessInstanceServiceImpl extends ServiceImpl<ProcessInstanceMapper, ProcessInstance> implements IFlowProcessInstanceService {

    @Resource
    private IProcessDefService defService;
    @Resource
    private IProcessNodeService processNodeService;
    @Resource
    private IProcessInstanceNodeService processInstanceNodeService;
    @Autowired
    private ProcessInstanceNodeMapper processInstanceNodeMapper;
    @Autowired
    private ProcessInstanceTaskMapper processInstanceTaskMapper;

    /**
     * 检查流程定义信息
     *
     * @param processDefId 流程定义ID
     */
    private void checkProcessDef(String processDefId){
        // 1.0 检查定义信息
        ProcessDef def = defService.getByProcessDefId(processDefId);
        if(def == null){
            throw new FlowException("流程定义不存在");
        }
        // 1.1 检查定义详情
        long count = processNodeService.count(new QueryWrapper<ProcessNode>().eq("process_def_id",processDefId));
        if(count <= 0){
            throw new FlowException("流程定义详情不存在");
        }
    }

    private ProcessInstance buildProcessInstance(String processDefId, XflowDO owner){
        return ProcessInstance.builder()
                .processInstanceId(IdUtil.randomUUID())
                .processDefId(processDefId)
                .ownerId(owner.getUserId())
                .ownerName(owner.getUserName())
                .ownerAccount(owner.getAccount())
                .deptId(owner.getDeptId())
                .deptName(owner.getDeptName())
                .status(ProcessInstanceEnum.IN_PROGRESS.getCode())
                .businessId(owner.getBusinessId())
                .businessType(owner.getBusinessType())
                .build();
    }

    /**
     * 启动流程实例
     * @param processDefId 流程定义id
     * @param owner 流程实例的所有者
     * @return 流程实例id
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String startProcessInstance(String processDefId, XflowDO owner) {

        checkProcessDef(processDefId);

        // 2.0 启动流程实例
        ProcessInstance instance = buildProcessInstance(processDefId,owner);
        save(instance);

        // 2.1 设置实例第一个节点
        ProcessInstanceTask task = processInstanceNodeService.setFirstNode(instance);

        // 2.1 自动完成第一个节点
        Boolean flag = processInstanceNodeService.complete(task.getTaskId(), ProcessInstanceTaskEnum.PASS.getCode(), "");
        if(Boolean.FALSE.equals(flag)){
            throw new FlowException("流程实例启动失败");
        }
        return instance.getProcessInstanceId();
    }

    /**
     * 获取流程实例详情 详情的所有节点由两部分组成：实践产生的节点和实例定义的节点
     * @param processInstanceId 流程实例id
     * @return 流程实例详情
     */
    @Override
    public List<ProcessInstanceNodeVO> getProcessInstanceDetail(String processInstanceId) {
        List<ProcessInstanceNodeVO> result = new ArrayList<>();
        List<ProcessInstanceNodeVO> list = processInstanceNodeService.listProcessInstanceNodeVo(processInstanceId);
        List<ProcessInstanceNodeVO> list2 = processNodeService.listProcessInstanceNodeVo(processInstanceId);
        result.addAll(list);
        result.addAll(list2);
        return result;
    }

    @Override
    public ProcessInstance getByInstanceId(String processInstanceId) {
        return baseMapper.selectByInstanceId(processInstanceId);
    }

    /**
     * 检查流程是否已结束
     * @param processInstanceId 流程实例id
     * @return 结束状态
     */
    @Override
    public boolean haveComplete(String processInstanceId) {
        ProcessInstance instance = getByInstanceId(processInstanceId);
        if(instance == null){
            throw new FlowException("流程实例不存在");
        }
        return ProcessInstanceEnum.COMPLETED.getCode().equals(instance.getStatus());
    }

    @Override
    public Map<String, ProcessNodeInfoVO> getProcessNodeInfoMapByUserId(List<String> processInstanceId, String userId) {
        return null;
    }

    @Override
    public Map<String, ProcessNodeInfoVO> getProcessNodeInfoMapByUserAccount(List<String> processInstanceId, String account) {
        Map<String, ProcessNodeInfoVO> nodeInfoVOMap = new HashMap<>();
        for (String s : processInstanceId) {
            ProcessInstance instance = getByInstanceId(s);
            if(instance == null){
                continue;
            }
            // 设置节点信息
            ProcessNodeInfoVO info = new ProcessNodeInfoVO();
            ProcessInstanceNode processInstanceNode = processInstanceNodeMapper.selectByInstanceNodeId(instance.getCurrentProcessInstanceNodeId());
            if(processInstanceNode == null){
                continue;
            }
            info.setProcessInstanceId(instance.getProcessInstanceId());
            boolean flag = false;
            // 查询用户任务
            if(account != null){
                Long count =  processInstanceTaskMapper.selectCount(new QueryWrapper<ProcessInstanceTask>()
                        .eq("process_instance_id", instance.getProcessInstanceId())
                        .eq("account", account)
                        .eq("task_status", ProcessInstanceTaskEnum.IN_PROGRESS.getCode())
                );
                if(count != null && count > 0){
                    flag = true;
                }
            }
            info.setHaveTask(flag);

            // 已办结的就不展示
            if(ProcessInstanceEnum.COMPLETED.getCode().equals(instance.getStatus()) ){
                info.setProcessNode("");
            }else {
                info.setProcessNode(processInstanceNode.getNodeName());
            }

            ProcessNode node = processNodeService.getByProcessNodeId(processInstanceNode.getNodeId());
            if(node != null){
                info.setProcessStage(node.getStage());
            }

            nodeInfoVOMap.put(s, info);
        }
        return nodeInfoVOMap;
    }

    @Override
    public boolean autoReturn(String processInstanceId) {
        return false;
    }
}
