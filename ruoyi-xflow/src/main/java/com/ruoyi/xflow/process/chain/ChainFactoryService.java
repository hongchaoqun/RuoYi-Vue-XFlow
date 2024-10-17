package com.ruoyi.xflow.process.chain;


import com.ruoyi.xflow.domain.ProcessInstanceNode;
import com.ruoyi.xflow.domain.ProcessInstanceSubNode;
import com.ruoyi.xflow.domain.ProcessNode;
import com.ruoyi.xflow.mapper.ProcessInstanceMapper;
import com.ruoyi.xflow.mapper.ProcessInstanceNodeMapper;
import com.ruoyi.xflow.mapper.ProcessInstanceSubNodeMapper;
import com.ruoyi.xflow.mapper.ProcessNodeMapper;
import com.ruoyi.xflow.process.chain.handler.ProcessInstanceCardHandler;
import com.ruoyi.xflow.process.chain.handler.ProcessInstanceParallelCardHandler;
import com.ruoyi.xflow.process.instance.IProcessInstanceSubNodeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 责任链工厂
 * @Author hongcq
 * @Date 2024/6/26
 */
@Service
public class ChainFactoryService {

    @Resource
    private ProcessNodeMapper processNodeMapper;
    @Resource
    private ProcessInstanceNodeMapper processInstanceNodeMapper;
    @Resource
    private ProcessInstanceMapper processInstanceMapper;
    @Resource
    private ProcessInstanceSubNodeMapper processInstanceSubNodeMapper;
    @Resource
    private IProcessInstanceSubNodeService processInstanceSubNodeService;


    /**
     * 获取链 (第一个节点)
     * @param defId 流程定义id
     * @return 第一个节点
     */
    public ProcessInstanceCardHandler getChain(String defId) {
        List<ProcessNode> nodes = processNodeMapper.listByDefId(defId);

        List<ProcessInstanceCardHandler> handlers = nodes.stream()
                .map(node -> new ProcessInstanceCardHandler(node, processInstanceNodeMapper, processNodeMapper,processInstanceMapper, processInstanceSubNodeMapper,processInstanceSubNodeService))
                .collect(Collectors.toList());

        // 组装链条
        for (ProcessInstanceCardHandler handler : handlers) {
            // 把最后一个节点的nextCard设置为null
            if (handlers.indexOf(handler) == handlers.size() - 1) {
                handler.setNextCard(null);
                break;
            }
            handler.setNextCard(handlers.get(handlers.indexOf(handler) + 1));
        }
        return handlers.get(0);
    }

    /**
     * 获取子链的第一个节点
     * @param processInstanceNodeId 流程实例节点
     * @return 子链的第一个节点
     */
    public ProcessInstanceParallelCardHandler getParallelSubChain(String processInstanceNodeId) {

        // 子链中的流程节点，通过他找父节点
        ProcessInstanceNode processInstanceNode = processInstanceNodeMapper.selectByInstanceNodeId(processInstanceNodeId);
        assert processInstanceNode != null;
        ProcessNode processNode = processNodeMapper.selectNodeByNodeId(processInstanceNode.getNodeId());
        assert processNode != null;

        // 查找同依流程中父节点
        //ProcessInstanceNode parentNode = processInstanceNodeMapper.selectByNodeIdAndInsId(processNode.getParentNodeId(), processInstanceNode.getProcessInstanceId());
        // 20240805 原本以为一个流程中只有一个这样的节点，但是如果驳回了继续执行就会有多个，
        ProcessInstanceNode parentNode = processInstanceNodeMapper.selectByNodeIdAndInsIdAndStatus(processNode.getParentNodeId(), processInstanceNode.getProcessInstanceId());


        assert parentNode != null;

        List<ProcessInstanceSubNode> sonInstanceNodes = processInstanceSubNodeMapper.selectSonNodeByParentId(parentNode.getProcessInstanceNodeId());
        List<ProcessInstanceParallelCardHandler> handlers = sonInstanceNodes.stream()
                .map(node -> new ProcessInstanceParallelCardHandler(node, processInstanceNodeMapper, processNodeMapper,processInstanceMapper,processInstanceSubNodeMapper))
                .collect(Collectors.toList());

        // 组装链条
        for (ProcessInstanceParallelCardHandler handler : handlers) {
            // 把最后一个节点的nextCard设置为null
            if (handlers.indexOf(handler) == handlers.size() - 1) {
                handler.setNextCard(null);
                break;
            }
            handler.setNextCard(handlers.get(handlers.indexOf(handler) + 1));
        }
        return handlers.get(0);
    }
}
