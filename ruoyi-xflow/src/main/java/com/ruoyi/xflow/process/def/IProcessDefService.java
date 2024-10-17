package com.ruoyi.xflow.process.def;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.xflow.domain.ProcessDef;

/**
 * 流程定义Service接口
 *
 * @author hongcq
 * @date 2024-06-26
 */
public interface IProcessDefService extends IService<ProcessDef>
{

    ProcessDef getByProcessDefId(String processDefId);
}
