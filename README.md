<h1 align="center" style="margin: 30px 0 30px; font-weight: bold;">RuoYi v3.8.8 & XFlow自定义流程引擎</h1>
<h4 align="center">基于RuoYi v3.8.8的Java 审批流程组件</h4>
<p align="center">
	<a href="https://gitee.com/y_project/RuoYi-Vue"><img src="https://img.shields.io/badge/RuoYi-v3.8.8-brightgreen.svg"></a>
	<a href="https://gitee.com/y_project/RuoYi-Vue/blob/master/LICENSE"><img src="https://img.shields.io/github/license/mashape/apistatus.svg"></a>
</p>

# 平台简介

若依是一套全部开源的快速开发平台，毫无保留给个人及企业免费使用。

# XFlow 介绍
简单的审批流程中间件。简化审批流程。

# 快速开始

# 1. 数据配置流程
## 1.1 概述
数据配置流程是数据配置的入口，通过数据配置流程可以配置数据源、数据表、数据字段、数据关系等。
目前前端暂未实现，后续会实现。所以暂时通过后端人员手动添加

## 1.2 数据表介绍
流程相关的表：
- xflow_process_def  流程定义表
- xflow_process_node 流程定义节点表
- xflow_process_instance 流程实例表
- xflow_process_instance_node 流程实例节点表
- xflow_process_instance_sub_node 并行子流程表
- xflow_process_instance_task 流程实例任务表

上面这些表是流程执行用到的表，相关代码在 purchase-platform-xflow 下

业务相关的表：
- pu_flow_collection 流程集合表
- xflow_process_form 流程配置表单
- xflow_process_form_runtime_result 流程运行时表单

这三张表是业务关联用到最多的表，可以自定义位置，业务方自行维护

## 1.3 需要配置的数据表说明

### xflow_process_def

| 字段名             | 字段类型         | 字段说明                   | 备注    |
|-------------------|-------------------|---------------------------|-------|
| id                | varchar(255)      | 唯一标识                   | 主键    |
| process_def_id    | varchar(255)      | 定义ID                     | 在这里定义的流程ID，唯一 |
| process_name      | varchar(255)      | 流程名                     | 可为空   |
| description       | varchar(255)      | 说明                       | 可为空   |


### xflow_process_node

| 字段名             | 字段类型         | 字段说明                               | 备注  |
|-------------------|-------------------|------------------------------------|-------|
| id                | varchar(255)      | 唯一标识                               | 主键  |
| process_def_id    | varchar(255)      | 流程定义id                             |       |
| node_id           | varchar(255)      | 节点ID                               |       |
| node_rank         | int(11)           | 定义好的节点顺序                           |       |
| node_name         | varchar(255)      | 节点名称                               |       |
| sign_type         | varchar(1)        | 会签或签类型； 0=或签 1=会签                  | 默认 '0' |
| level             | int(11)           | 等级，数字越大等级越低 ，默认是0，子流程是1            | 默认 '0' |
| parent_node_id    | varchar(255)      | 父节点id                              | 可为空 |
| next_node_id      | varchar(255)      | 下一个节点id                            |    |
| visibility        | varchar(50)       | 可见性 1=可见 0=不可见 ，若为不可见则流程详情不会查这个节点  | 默认 '1' |
| node_type         | varchar(50)       | 节点类型 0=流程节点 1=并行处理器 2=并行处理器的子流程节点  | 默认 '0' |
| form_id           | varchar(255)      | 表单id                               |       |
| bean_name         | varchar(255)      | 具体实现类在spring里的beanName             | 可为空 |
| stage             | varchar(1)        | 阶段：记录当前节点是开始，还是结束， 0=开始 1=进行中 2=结束 | 可为空 |

### xflow_process_form

| 字段名             | 字段类型          | 字段说明                                | 备注    |
|-------------------|------------------|-------------------------------------|---------|
| id                | varchar(255)     | 唯一标识                                | 主键    |
| introduction      | varchar(255)     | 介绍                                  | 可为空  |
| runtime_form_type | varchar(255)     | 运行时的表单类型，这里约定前端展示什么样的表单，跟前端约定好的参考文档 | 可为空  |
| dept_id           | varchar(255)     | 部门ID                                | 可为空  |
| role_id           | bigint(20)       | 角色ID                                | 可为空  |
| process_node      | varchar(255)     | 当前节点需要的数据的来源节点                      | 可为空  |

这个表主要配置表单的来源节点，比如流程A的节点A需要表单B的数据，那么这里就配置A节点需要表单B的id，或者
节点A需要某个特定的岗位，那就把岗位id配置在这里。如果业务有什么特殊需求，可以自定义。

### xflow_process_form_runtime_result
流程每个节点的表单结果，提交到这个表里。 这张表的字段可以自定义。如果某个节点需要表单的数据，从这里查

### pu_flow_collection
流程集合表，这个表是业务方自己维护的，可以自定义位置，这里只作为流程集合的配置。第四期所有的可用流程都要配置到这里

基本上在数据库里配置这几张表就可以了。

## 1.4 配置案例
以自行采购申请流程为利，这个节点比较简单，就两个节点。

### 1.4.1 配置流程定义信息
1. 在xflow_process_def 表中配置流程定义信息，流程定义ID是流程的唯一标识，这里配置的流程ID是自行采购申请流程，
2. 把流程定义ID配置到 pu_flow_collection 表中。

### 1.4.2 配置流程节点信息
假设流程定义ID是 1800739065228230657，下面我们来依次配置两个节点，一个发起节点，一个部门审批节点。

##### 发起节点

| 字段名             | 字段值                 | 字段说明                               | 备注  |
|-------------------|---------------------|------------------------------------|-------|
| id                | 3423423             | 唯一标识                               | 主键  |
| process_def_id    | 1800739065228230657 | 流程定义id                             |       |
| node_id           | 1800739065228230957 | 节点ID                               |       |
| node_rank         | 1                   | 第一个节点                              |       |
| node_name         | 部门经办人发起             | 节点名称  产品顶的                         |       |
| sign_type         | 0                   | 会签或签类型； 0=或签 1=会签                  | 默认 '0' |
| level             | 0                   | 等级，数字越大等级越低 ，默认是0，子流程是1            | 默认 '0' |
| parent_node_id    |                     | 不填，没有父节点，只用并行的子节点需要配置              | 可为空 |
| next_node_id      |  2900739065228230905  | 下一个节点id， 有下一个节点的必填                 |    |
| visibility        | 1                   | 可见性 1=可见 0=不可见 ，若为不可见则流程详情不会查这个节点  | 默认 '1' |
| node_type         | 0                   | 节点类型 0=流程节点 1=并行处理器 2=并行处理器的子流程节点  | 默认 '0' |
| form_id           | 234334234234        | 自定义或自动生成，到时候要去配置表配这条数据             |       |
| bean_name         |                     | 第一个节点的用户是流程发起人，不用填                 | 可为空 |
| stage             | 0                   | 阶段：记录当前节点是开始，还是结束， 0=开始 1=进行中 2=结束 | 可为空 |

##### 结束节点 （第二个节点）

| 字段名             | 字段值                               | 字段说明                               | 备注  |
|-------------------|-----------------------------------|------------------------------------|-------|
| id                | 3453454656757                     | 唯一标识                               | 主键  |
| process_def_id    | 1800739065228230657               | 流程定义id                             |       |
| node_id           | 2900739065228230905               | 节点ID，这个要配置到上一条记录里                  |       |
| node_rank         | 2                                 | 第二个节点                              |       |
| node_name         | 部门负责人人审批                          | 节点名称  产品顶的                         |       |
| sign_type         | 0                                 | 会签或签类型； 0=或签 1=会签                  | 默认 '0' |
| level             | 0                                 | 等级，数字越大等级越低 ，默认是0，子流程是1            | 默认 '0' |
| parent_node_id    |                                   | 不填，没有父节点，只用并行的子节点需要配置              | 可为空 |
| next_node_id      |                                   | 最后一个节点不用填                          |    |
| visibility        | 1                                 | 可见性 1=可见 0=不可见 ，若为不可见则流程详情不会查这个节点  | 默认 '1' |
| node_type         | 0                                 | 节点类型 0=流程节点 1=并行处理器 2=并行处理器的子流程节点  | 默认 '0' |
| form_id           | 564334234211                      | 自定义或自动生成，到时候要去配置表配这条数据             |       |
| bean_name         | deptHead4UserDiscoveryServiceImpl | 获取发起人的部门负责人，自己去代码里加类，然后添加到这里       | 可为空 |
| stage             | 0                                 | 阶段：记录当前节点是开始，还是结束， 0=开始 1=进行中 2=结束 | 可为空 |


流程节点配置完成后，需要配置表单信息，刚刚我们配置了两个 form_id，所有要在xflow_process_form 里添加两条记录

##### flow_process_form 的记录
第一个节点的表单

| 字段名             | 字段值          | 字段说明            | 备注    |
|-------------------|--------------|-----------------|---------|
| id                | 234334234234     | 唯一标识            | 主键    |
| introduction      | 自行采购申请的第一个表单 | 介绍              | 可为空  |
| runtime_form_type | 1            | 跟前端约定好的表单类型     | 可为空  |
| dept_id           |              | 第一节点取默认值不用填     | 可为空  |
| role_id           |              | 第一节点取默认值不用填     | 可为空  |
| process_node      |              | 当前节点需要的数据的来源节点，第一节点取默认值不用填 | 可为空  |

第二个节点的表单

| 字段名             | 字段值          | 字段说明               | 备注    |
|-------------------|--------------|--------------------|---------|
| id                | 234334234234 | 唯一标识               | 主键    |
| introduction      | 自行采购申请的第一个表单 | 介绍                 | 可为空  |
| runtime_form_type | 1            | 跟前端约定好的表单类型        | 可为空  |
| dept_id           |              | 不用填                | 可为空  |
| role_id           | 40           | 部门领导的岗位id，通过这个id查到该岗位下的所有用户 | 可为空  |
| process_node      |              | 当前节点需要的数据的来源节点不用填  | 可为空  |

到这里，流程配置就完成了

# 2. 后端业务对接流程

## 2.1 业务记录中发起流程
1. 从pu_flow_collection表中获取自己的流程定义id，根据产品原型自己想办法
2. 执行业务的新增修改方法
3. 拿流程定义id，调用流程发起方法，返回值是流程实例id
4. 把流程实例id,更新回原业务记录中

参考代码：
```java
    /**
     * 提交申请表单
     * @param purchaseRequest
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean inputTable(PurchasingGoodsAddDTO purchaseRequest) {

        // 1. 根据固定的业务要求获取流程定义id
        // TODO: 根据不同条件获取不同的defId,这里先写一个固定值测试
        String defId = "1798249268811202562";
        
        // 2. 执行业务新增修改
        String reqId = add(purchaseRequest);
        if(StringUtils.isEmpty(reqId)){
            throw new ServiceException("采购申请创建失败");
        }
        PurchaseRequest request = this.getById(reqId);
        if(request == null){
            throw new ServiceException("采购申请不存在");
        }

        // 3. 启动流程
        XflowDO xflowDO = new XflowDO();
        xflowDO.setAccount(request.getAccount());
        xflowDO.setDeptId(request.getDeptId());
        String insId = flowProcessInstanceService.startProcessInstance(defId, xflowDO);
        if(insId == null){
            throw  new ServiceException("流程启动失败");
        }
        
        // 4. 更新业务记录
        request.setInstanceId(insId);
        request.setStatus(PurchaseRequestStatusEnum.UNDER_REVIEW.getCode());
        return updateById(request);
    }
```

## 2.2 业务记录中审核
因为现在没有做流程回调修改业务表的功能，所以每次审核后，业务方主动查询一下，当前的流程状态，做对应的业务逻辑处理

1. 根据taskId获取用户任务
2. 调用流程接口流转审批
3. 审核成功， 各业务处理自己的业务逻辑

参考代码
```java
    @Override
    public Boolean audit(ProcessApprovalDTO approvalDTO) {
        // 1. 根据taskId获取用户任务
        ProcessInstanceTask task = taskService.getByTaskId(approvalDTO.getTaskId());
        if(task == null){
            throw new ServiceException("用户任务不存在");
        }
        // 2. 调用流程接口流转审批
        boolean flag =  processFormRuntimeResultService.deal(approvalDTO);
        if(!flag){
            throw new ServiceException("流程审批失败");
        }
        // 3. 审核成功， 各业务处理自己的业务逻辑
        // 3.1 查看流程是否已经结束
        boolean complete = processInstanceService.haveComplete(task.getProcessInstanceId());
        if(complete){
            // 流程结束后操作
            operationAfterReview(request, approvalDTO.getAuditType());
        }
        return flag;
    }

    /**
     * 审核后操作， 因为没有回调回来，所以需要主动查询。通过，驳回后做对应的业务逻辑
     */
    private void operationAfterReview(PurchaseRequest request, String auditType){
        List<String> tableTypes = Arrays.asList(PurchaseRequestTableTypeEnum.TABLE_TYPE_9.getCode(),
                PurchaseRequestTableTypeEnum.TABLE_TYPE_10.getCode(),
                PurchaseRequestTableTypeEnum.TABLE_TYPE_14.getCode()
        );
        if(tableTypes.contains(request.getTableType())){
            sendToRecord(request);
        }
        if(PASS.equals(auditType)){
            request.setStatus(PurchaseRequestStatusEnum.REVIEWED.getCode());
            request.setPassingTime(new Date());
        }else {
            request.setStatus(PurchaseRequestStatusEnum.REJECTED.getCode());
            request.setPassingTime(new Date());
        }
        updateById(request);
    }

```
## 2.3 列表显示
列表中显示流程状态，和当前登录人的审批状态（这条记录需不需要审批）

processInstanceService.getProcessNodeInfoMapByUserAccount(), 这个方法会返回一个map，key是流程实例id，value是流程节点信息, 获取到之后组装一下

```java
    @DataScope(userAlias = "m", deptAlias = "d")
    @Override
    public IPage<PurchaseRequestPageVO> pageList(PurchaseRequestPageDTO pageDTO) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if(loginUser == null){
            throw new ServiceException("用户未登录");
        }
        IPage<PurchaseRequestPageVO> vos = purchaseRequestMapper.pageList(new Page<PurchaseRequestPageDTO>(pageDTO.getPageNum(), pageDTO.getPageSize()),pageDTO);
        List<String> instanceIds = vos.getRecords().stream()
                .filter(vo -> vo.getInstanceId() != null && !vo.getInstanceId().isEmpty())
                .map(PurchaseRequestPageVO::getInstanceId)
                .collect(Collectors.toList());
        if(!instanceIds.isEmpty()){
            // 组装流程数据
            Map<String, ProcessNodeInfoVO> infoMap = processInstanceService.getProcessNodeInfoMapByUserAccount(instanceIds, loginUser.getUser().getUserName());
            if(infoMap != null){
                vos.getRecords().forEach(vo -> Optional.ofNullable(infoMap.get(vo.getInstanceId())).ifPresent(infoVO -> {
                    vo.setHaveTask(infoVO.getHaveTask());
                    vo.setProcessNode(infoVO.getProcessNode());
                }));
            }
        }
        // 其他相关数据
        setFollowTheLabelMsg(pageDTO, vos);
        return vos;
    }
```

# 3. 前端对接流程
todo...







