package com.ruoyi.xflow.component;

import java.util.List;

/**
 * 消息待办分发接口 （执行监听器）
 */
public interface IDispatchMessageService {

    void dispatchMessage(List<String> processInstanceTaskId);

    void closeTask(String taskId);
}
