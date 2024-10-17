package com.ruoyi.xflow.process.chain.handler;


import com.ruoyi.xflow.domain.ProcessInstance;
import com.ruoyi.xflow.domain.ProcessNode;
import lombok.Setter;

/**
 * 流程实例节点抽象类
 * @Author hongcq
 * @Date 2024/6/25
 */
public abstract class AbstractProcessInstanceCard {

    /**
     * 下一个节点
     * -- SETTER --
     *  设置下一个节点
     *
     * @param nextCard 下一个节点
     */
    @Setter
    protected AbstractProcessInstanceCard nextCard;

    /**
     * 当前节点元数据，从流程定义中获取
     */
    ProcessNode node;

    protected  AbstractProcessInstanceCard(ProcessNode node){
        this.node = node;
    }


    /**
     * 处理任务模板方法, 如果实际当前节点是定义的当前节点，则处理当前任务，否则处理下一个任务
     * @param processInstanceNodeId 流程实例节点id
     * @param processNodeId 流程定义节点id
     */
    public String dealTask(String processInstanceNodeId, String processNodeId) {
        if(processNodeId.equals(node.getNodeId())){
           return processCurrentTask(processInstanceNodeId);
        }else {
            return this.nextCard.dealTask(processInstanceNodeId, processNodeId);
        }
    }

    /**
     * 流程节点和用户任务1对1关系 ，当前流程只会有1个用户任务，如果是会签或者并行，会生成多个子节点
     *
     * 处理当前任务
     * @param processInstanceNodeId 流程实例节点id
     */
    abstract String processCurrentTask(String processInstanceNodeId);

    /**
     * 生成下一个节点
     * @param processInstanceNodeId 流程实例节点id
     */
    abstract String processNextTask(String processInstanceNodeId, ProcessInstance processInstance) ;
}
