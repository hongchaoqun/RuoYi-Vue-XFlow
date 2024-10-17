/*
Navicat MySQL Data Transfer

Source Server         : 42.194.138.48
Source Server Version : 50719
Source Host           : 42.194.138.48:63309
Source Database       : solvay_purchase_platform

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2024-09-29 16:01:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for wflow_variable
-- ----------------------------
DROP TABLE IF EXISTS `wflow_variable`;
CREATE TABLE `wflow_variable` (
  `code` varchar(100) NOT NULL COMMENT '编号',
  `name` varchar(200) NOT NULL COMMENT '名称',
  `value` text NOT NULL COMMENT '值',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for xflow_approver_settings
-- ----------------------------
DROP TABLE IF EXISTS `xflow_approver_settings`;
CREATE TABLE `xflow_approver_settings` (
  `id` varchar(255) NOT NULL,
  `type` varchar(1) DEFAULT NULL COMMENT '类型： 0是审批节点类型 1是特殊节点类型',
  `special_type` varchar(255) DEFAULT NULL COMMENT '特殊节点的类型',
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `bean_name` varchar(255) DEFAULT NULL COMMENT 'beanName',
  `info` varchar(255) DEFAULT NULL COMMENT '介绍',
  `business_type` varchar(255) DEFAULT NULL COMMENT '业务类型',
  `deleted` varchar(1) DEFAULT '0' COMMENT '是否删除，1表示已删除',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='审批人设置表';

-- ----------------------------
-- Table structure for xflow_operation_items
-- ----------------------------
DROP TABLE IF EXISTS `xflow_operation_items`;
CREATE TABLE `xflow_operation_items` (
  `id` varchar(255) NOT NULL,
  `runtime_form_type` varchar(255) NOT NULL COMMENT '表格类型',
  `is_required` varchar(1) DEFAULT '1' COMMENT '是否必填，0=否，1=是',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `form_type` varchar(255) NOT NULL COMMENT '类型',
  `field` varchar(255) DEFAULT NULL COMMENT '对应字段',
  `deleted` varchar(1) DEFAULT '0' COMMENT '是否删除，1表示已删除',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作项表';

-- ----------------------------
-- Table structure for xflow_process_def
-- ----------------------------
DROP TABLE IF EXISTS `xflow_process_def`;
CREATE TABLE `xflow_process_def` (
  `id` varchar(255) NOT NULL COMMENT '唯一标识',
  `process_def_id` varchar(255) NOT NULL COMMENT '定义ID',
  `process_name` varchar(255) DEFAULT NULL COMMENT '流程名',
  `description` varchar(255) DEFAULT NULL COMMENT '说明',
  `deleted` varchar(1) DEFAULT '0' COMMENT '是否删除',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程定义表';

-- ----------------------------
-- Table structure for xflow_process_form
-- ----------------------------
DROP TABLE IF EXISTS `xflow_process_form`;
CREATE TABLE `xflow_process_form` (
  `id` varchar(255) NOT NULL COMMENT '唯一标识',
  `introduction` varchar(255) DEFAULT NULL COMMENT '介绍',
  `runtime_form_type` varchar(255) DEFAULT NULL COMMENT '运行时的表单类型',
  `dept_id` varchar(255) DEFAULT NULL COMMENT '部门ID',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `deleted` varchar(1) DEFAULT '0' COMMENT '是否删除',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `process_node` varchar(255) DEFAULT NULL COMMENT '当前节点需要的数据的来源节点 （比如前一个节点）',
  `source_from_form` varchar(255) DEFAULT '0' COMMENT '对应节点的审批人是否来自表单 0=否 1=是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程中固定的表单配置';

-- ----------------------------
-- Table structure for xflow_process_form_runtime_result
-- ----------------------------
DROP TABLE IF EXISTS `xflow_process_form_runtime_result`;
CREATE TABLE `xflow_process_form_runtime_result` (
  `id` varchar(255) NOT NULL,
  `runtime_form_type` char(255) NOT NULL COMMENT '表单类型，跟前端商量好',
  `process_instance_id` varchar(255) NOT NULL,
  `process_instance_node_id` varchar(255) NOT NULL COMMENT '流程实例节点id',
  `process_task_id` varchar(255) NOT NULL COMMENT '提交结果对应的用户任务id',
  `process_node_id` varchar(255) NOT NULL,
  `audit_type` varchar(255) NOT NULL COMMENT '审批类型 0=通过 1=驳回',
  `audit_opinions` varchar(255) DEFAULT NULL COMMENT '审核意见',
  `undertake_dept_id` varchar(255) DEFAULT NULL COMMENT '业务字段： 承办部门id',
  `completely` char(1) DEFAULT NULL COMMENT '业务字段：项目是否填写完整 0=否 1=是',
  `overall_plan_dept_id` varchar(255) DEFAULT NULL COMMENT '业务字段：指定统筹部门id,多选',
  `operator` varchar(255) DEFAULT NULL COMMENT '经办人id',
  `deleted` varchar(255) DEFAULT '0',
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `general_review_result` varchar(255) DEFAULT NULL COMMENT '一般性审核结果',
  `performance_risk_review_result` varchar(255) DEFAULT NULL COMMENT '履约风险审核结果',
  `applicable_single_situation` varchar(255) DEFAULT NULL COMMENT '适用单一来源采购情形',
  `single_source_purchase_result` varchar(255) DEFAULT NULL COMMENT '单一来源采购公式结果',
  `is_included_in_plan` varchar(10) DEFAULT NULL COMMENT '是否列入计划',
  `is_project_filled_completely` varchar(10) DEFAULT NULL COMMENT '项目是否填写完整',
  `non_tendering_review_result` varchar(255) DEFAULT NULL COMMENT '非倾向性审核结果',
  `competitiveness_review_result` varchar(255) DEFAULT NULL COMMENT '竞争性审核结果',
  `budget_result` varchar(255) DEFAULT NULL COMMENT '预算结果',
  `reviewed_amount` decimal(15,2) DEFAULT NULL COMMENT '审核金额',
  `reviewed_quantity` int(11) DEFAULT NULL COMMENT '审核数量',
  `final_released_amount` decimal(15,2) DEFAULT NULL COMMENT '最终下拨金额',
  `item_num` varchar(255) DEFAULT NULL COMMENT '项目编号',
  `suggested_method` varchar(255) DEFAULT NULL COMMENT '建议采购方式',
  `contact_sign_time` datetime DEFAULT NULL COMMENT '合同签订时间',
  `dept_options` varchar(255) DEFAULT NULL COMMENT '指定其他节点部门id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for xflow_process_instance
-- ----------------------------
DROP TABLE IF EXISTS `xflow_process_instance`;
CREATE TABLE `xflow_process_instance` (
  `id` varchar(255) NOT NULL COMMENT '唯一标识',
  `process_instance_id` varchar(255) NOT NULL COMMENT '流程实例ID',
  `process_def_id` varchar(255) NOT NULL COMMENT '流程定义ID',
  `owner_name` varchar(255) DEFAULT NULL,
  `owner_id` varchar(255) DEFAULT NULL,
  `owner_account` varchar(255) DEFAULT NULL,
  `dept_id` varchar(255) DEFAULT NULL,
  `dept_name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `current_process_instance_node_id` varchar(255) DEFAULT NULL,
  `deleted` varchar(1) DEFAULT '0' COMMENT '是否删除',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `business_id` varchar(255) DEFAULT NULL COMMENT '业务id',
  `business_type` varchar(255) DEFAULT NULL COMMENT '业务类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for xflow_process_instance_node
-- ----------------------------
DROP TABLE IF EXISTS `xflow_process_instance_node`;
CREATE TABLE `xflow_process_instance_node` (
  `id` varchar(255) NOT NULL COMMENT '唯一标识',
  `process_instance_id` varchar(255) NOT NULL COMMENT '流程实例ID',
  `process_instance_node_id` varchar(255) NOT NULL COMMENT '流程实例节点ID',
  `node_id` varchar(255) NOT NULL COMMENT '定义节点ID',
  `node_name` varchar(255) DEFAULT NULL COMMENT '节点名称',
  `node_status` varchar(255) DEFAULT NULL COMMENT '节点状态',
  `sub_id` varchar(255) DEFAULT NULL COMMENT '在子节点中的id记录',
  `node_type` varchar(255) DEFAULT '0' COMMENT '节点类型 0=流程节点 1=并行处理器 2并行处理器的子流程节点',
  `visibility` varchar(255) DEFAULT '1' COMMENT '可见性 1=可见 0=不可见',
  `deleted` varchar(1) DEFAULT '0' COMMENT '是否删除',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `business_id` varchar(255) DEFAULT NULL COMMENT '预留字段，业务系统自行取用',
  `process_instance_node_sub_id` varchar(255) DEFAULT NULL COMMENT '原数据id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for xflow_process_instance_sub_node
-- ----------------------------
DROP TABLE IF EXISTS `xflow_process_instance_sub_node`;
CREATE TABLE `xflow_process_instance_sub_node` (
  `id` varchar(255) NOT NULL,
  `process_instance_id` varchar(255) NOT NULL,
  `process_instance_node_sub_id` varchar(255) NOT NULL,
  `node_id` varchar(255) NOT NULL,
  `node_rank` int(11) NOT NULL COMMENT '节点排序',
  `parent_process_instance_node_id` varchar(255) NOT NULL COMMENT '流程实例节点id',
  `node_name` varchar(255) DEFAULT NULL,
  `node_status` varchar(255) DEFAULT NULL,
  `node_type` varchar(255) DEFAULT '0' COMMENT '节点类型 0=流程节点 1=并行处理器 2并行处理器的子流程节点',
  `visibility` varchar(255) DEFAULT '1' COMMENT '可见性 1=可见 0=不可见',
  `stage` varchar(255) DEFAULT '1',
  `deleted` varchar(255) DEFAULT '0',
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `business_id` varchar(255) NOT NULL COMMENT '预留字段，业务系统自行取用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='子流程节点记录表';

-- ----------------------------
-- Table structure for xflow_process_instance_task
-- ----------------------------
DROP TABLE IF EXISTS `xflow_process_instance_task`;
CREATE TABLE `xflow_process_instance_task` (
  `id` varchar(255) NOT NULL COMMENT '唯一标识',
  `task_id` varchar(255) NOT NULL,
  `process_instance_id` varchar(255) NOT NULL COMMENT '流程实例ID',
  `process_instance_node_id` varchar(255) NOT NULL COMMENT '流程实例节点ID',
  `task_name` varchar(255) NOT NULL COMMENT '任务名',
  `user_id` varchar(255) DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名',
  `account` varchar(255) DEFAULT NULL COMMENT '用户工号',
  `dept_id` varchar(255) DEFAULT NULL COMMENT '部门ID',
  `dept_name` varchar(255) DEFAULT NULL COMMENT '部门名',
  `task_status` varchar(10) DEFAULT NULL,
  `deleted` varchar(1) DEFAULT '0' COMMENT '是否删除',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_comments` text COMMENT '审核意见',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for xflow_process_node
-- ----------------------------
DROP TABLE IF EXISTS `xflow_process_node`;
CREATE TABLE `xflow_process_node` (
  `id` varchar(255) NOT NULL COMMENT '唯一标识',
  `process_def_id` varchar(255) NOT NULL COMMENT '流程定义id',
  `node_id` varchar(255) NOT NULL COMMENT '节点ID',
  `node_rank` int(11) NOT NULL COMMENT '定义好的节点顺序',
  `node_name` varchar(255) NOT NULL COMMENT '节点名称',
  `sign_type` varchar(1) DEFAULT '0' COMMENT '会签，或签的类型； 0=或签 1=会签',
  `level` int(11) DEFAULT '0' COMMENT '等级， 数字越大等级越低，0级节点没有父id',
  `parent_node_id` varchar(255) DEFAULT NULL COMMENT '父节点id',
  `next_node_id` varchar(255) DEFAULT NULL COMMENT '下一个节点id',
  `visibility` varchar(50) DEFAULT '1' COMMENT '可见性 1=可见 0=不可见',
  `node_type` varchar(50) DEFAULT '0' COMMENT '节点类型 0=流程节点 1=并行处理器 2并行处理器的子流程节点',
  `form_id` varchar(255) NOT NULL COMMENT '表单id',
  `bean_name` varchar(255) DEFAULT NULL COMMENT '具体实现类在 spring里的beanName',
  `stage` varchar(1) DEFAULT NULL COMMENT '阶段： 记录当前节点是开始，还是结束 0=开始 1=进行中 2=结束',
  `deleted` varchar(1) DEFAULT '0' COMMENT '是否删除',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `return_node` varchar(255) DEFAULT NULL COMMENT '驳回返回的节点',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for xflow_special_node
-- ----------------------------
DROP TABLE IF EXISTS `xflow_special_node`;
CREATE TABLE `xflow_special_node` (
  `id` varchar(255) NOT NULL,
  `special_type` varchar(255) NOT NULL COMMENT '特殊类型',
  `introduction` varchar(255) DEFAULT NULL COMMENT '介绍',
  `process_node_id` varchar(255) DEFAULT NULL COMMENT '定义节点id',
  `deleted` varchar(1) DEFAULT '0' COMMENT '是否删除，1表示已删除',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `related_node_id` varchar(255) DEFAULT NULL COMMENT '关联的节点。当前记录的节点没法判断，直接看关联节点跳不跳',
  `process_def_id` varchar(255) DEFAULT NULL COMMENT '配置一下定义id,如果定义id对不上，快速失败，节约时间',
  `related_special_type` varchar(255) DEFAULT NULL COMMENT '关联的节点类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='特殊流程节点配置';
