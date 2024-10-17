/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80028
Source Host           : localhost:3306
Source Database       : ry-vue

Target Server Type    : MYSQL
Target Server Version : 80028
File Encoding         : 65001

Date: 2024-07-02 11:20:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('1', '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2024-07-02 11:15:54', '', null, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES ('2', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2024-07-02 11:15:54', '', null, '初始化密码 123456');
INSERT INTO `sys_config` VALUES ('3', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2024-07-02 11:15:54', '', null, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES ('4', '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2024-07-02 11:15:54', '', null, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES ('5', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2024-07-02 11:15:54', '', null, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES ('6', '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2024-07-02 11:15:54', '', null, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('100', '0', '0', '若依科技', '0', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-07-02 11:15:53', '', null);
INSERT INTO `sys_dept` VALUES ('101', '100', '0,100', '深圳总公司', '1', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-07-02 11:15:53', '', null);
INSERT INTO `sys_dept` VALUES ('102', '100', '0,100', '长沙分公司', '2', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-07-02 11:15:53', '', null);
INSERT INTO `sys_dept` VALUES ('103', '101', '0,100,101', '研发部门', '1', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-07-02 11:15:53', '', null);
INSERT INTO `sys_dept` VALUES ('104', '101', '0,100,101', '市场部门', '2', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-07-02 11:15:53', '', null);
INSERT INTO `sys_dept` VALUES ('105', '101', '0,100,101', '测试部门', '3', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-07-02 11:15:53', '', null);
INSERT INTO `sys_dept` VALUES ('106', '101', '0,100,101', '财务部门', '4', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-07-02 11:15:53', '', null);
INSERT INTO `sys_dept` VALUES ('107', '101', '0,100,101', '运维部门', '5', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-07-02 11:15:53', '', null);
INSERT INTO `sys_dept` VALUES ('108', '102', '0,100,102', '市场部门', '1', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-07-02 11:15:53', '', null);
INSERT INTO `sys_dept` VALUES ('109', '102', '0,100,102', '财务部门', '2', '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2024-07-02 11:15:53', '', null);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES ('1', '1', '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2024-07-02 11:15:54', '', null, '性别男');
INSERT INTO `sys_dict_data` VALUES ('2', '2', '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '性别女');
INSERT INTO `sys_dict_data` VALUES ('3', '3', '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '性别未知');
INSERT INTO `sys_dict_data` VALUES ('4', '1', '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2024-07-02 11:15:54', '', null, '显示菜单');
INSERT INTO `sys_dict_data` VALUES ('5', '2', '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES ('6', '1', '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2024-07-02 11:15:54', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('7', '2', '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('8', '1', '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2024-07-02 11:15:54', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('9', '2', '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '停用状态');
INSERT INTO `sys_dict_data` VALUES ('10', '1', '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2024-07-02 11:15:54', '', null, '默认分组');
INSERT INTO `sys_dict_data` VALUES ('11', '2', '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '系统分组');
INSERT INTO `sys_dict_data` VALUES ('12', '1', '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2024-07-02 11:15:54', '', null, '系统默认是');
INSERT INTO `sys_dict_data` VALUES ('13', '2', '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '系统默认否');
INSERT INTO `sys_dict_data` VALUES ('14', '1', '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2024-07-02 11:15:54', '', null, '通知');
INSERT INTO `sys_dict_data` VALUES ('15', '2', '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '公告');
INSERT INTO `sys_dict_data` VALUES ('16', '1', '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2024-07-02 11:15:54', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('17', '2', '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '关闭状态');
INSERT INTO `sys_dict_data` VALUES ('18', '99', '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '其他操作');
INSERT INTO `sys_dict_data` VALUES ('19', '1', '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '新增操作');
INSERT INTO `sys_dict_data` VALUES ('20', '2', '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '修改操作');
INSERT INTO `sys_dict_data` VALUES ('21', '3', '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '删除操作');
INSERT INTO `sys_dict_data` VALUES ('22', '4', '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '授权操作');
INSERT INTO `sys_dict_data` VALUES ('23', '5', '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '导出操作');
INSERT INTO `sys_dict_data` VALUES ('24', '6', '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '导入操作');
INSERT INTO `sys_dict_data` VALUES ('25', '7', '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '强退操作');
INSERT INTO `sys_dict_data` VALUES ('26', '8', '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '生成操作');
INSERT INTO `sys_dict_data` VALUES ('27', '9', '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '清空操作');
INSERT INTO `sys_dict_data` VALUES ('28', '1', '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '正常状态');
INSERT INTO `sys_dict_data` VALUES ('29', '2', '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2024-07-02 11:15:54', '', null, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES ('1', '用户性别', 'sys_user_sex', '0', 'admin', '2024-07-02 11:15:54', '', null, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES ('2', '菜单状态', 'sys_show_hide', '0', 'admin', '2024-07-02 11:15:54', '', null, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES ('3', '系统开关', 'sys_normal_disable', '0', 'admin', '2024-07-02 11:15:54', '', null, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES ('4', '任务状态', 'sys_job_status', '0', 'admin', '2024-07-02 11:15:54', '', null, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES ('5', '任务分组', 'sys_job_group', '0', 'admin', '2024-07-02 11:15:54', '', null, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES ('6', '系统是否', 'sys_yes_no', '0', 'admin', '2024-07-02 11:15:54', '', null, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES ('7', '通知类型', 'sys_notice_type', '0', 'admin', '2024-07-02 11:15:54', '', null, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES ('8', '通知状态', 'sys_notice_status', '0', 'admin', '2024-07-02 11:15:54', '', null, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES ('9', '操作类型', 'sys_oper_type', '0', 'admin', '2024-07-02 11:15:54', '', null, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES ('10', '系统状态', 'sys_common_status', '0', 'admin', '2024-07-02 11:15:54', '', null, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES ('1', '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_job` VALUES ('2', '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_job` VALUES ('3', '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2024-07-02 11:15:54', '', null, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) DEFAULT '' COMMENT '路由名称',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '0', '1', 'system', null, '', '', '1', '0', 'M', '0', '0', '', 'system', 'admin', '2024-07-02 11:15:54', '', null, '系统管理目录');
INSERT INTO `sys_menu` VALUES ('2', '系统监控', '0', '2', 'monitor', null, '', '', '1', '0', 'M', '0', '0', '', 'monitor', 'admin', '2024-07-02 11:15:54', '', null, '系统监控目录');
INSERT INTO `sys_menu` VALUES ('3', '系统工具', '0', '3', 'tool', null, '', '', '1', '0', 'M', '0', '0', '', 'tool', 'admin', '2024-07-02 11:15:54', '', null, '系统工具目录');
INSERT INTO `sys_menu` VALUES ('4', '若依官网', '0', '4', 'http://ruoyi.vip', null, '', '', '0', '0', 'M', '0', '0', '', 'guide', 'admin', '2024-07-02 11:15:54', '', null, '若依官网地址');
INSERT INTO `sys_menu` VALUES ('100', '用户管理', '1', '1', 'user', 'system/user/index', '', '', '1', '0', 'C', '0', '0', 'system:user:list', 'user', 'admin', '2024-07-02 11:15:54', '', null, '用户管理菜单');
INSERT INTO `sys_menu` VALUES ('101', '角色管理', '1', '2', 'role', 'system/role/index', '', '', '1', '0', 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2024-07-02 11:15:54', '', null, '角色管理菜单');
INSERT INTO `sys_menu` VALUES ('102', '菜单管理', '1', '3', 'menu', 'system/menu/index', '', '', '1', '0', 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2024-07-02 11:15:54', '', null, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES ('103', '部门管理', '1', '4', 'dept', 'system/dept/index', '', '', '1', '0', 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2024-07-02 11:15:54', '', null, '部门管理菜单');
INSERT INTO `sys_menu` VALUES ('104', '岗位管理', '1', '5', 'post', 'system/post/index', '', '', '1', '0', 'C', '0', '0', 'system:post:list', 'post', 'admin', '2024-07-02 11:15:54', '', null, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES ('105', '字典管理', '1', '6', 'dict', 'system/dict/index', '', '', '1', '0', 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2024-07-02 11:15:54', '', null, '字典管理菜单');
INSERT INTO `sys_menu` VALUES ('106', '参数设置', '1', '7', 'config', 'system/config/index', '', '', '1', '0', 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2024-07-02 11:15:54', '', null, '参数设置菜单');
INSERT INTO `sys_menu` VALUES ('107', '通知公告', '1', '8', 'notice', 'system/notice/index', '', '', '1', '0', 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2024-07-02 11:15:54', '', null, '通知公告菜单');
INSERT INTO `sys_menu` VALUES ('108', '日志管理', '1', '9', 'log', '', '', '', '1', '0', 'M', '0', '0', '', 'log', 'admin', '2024-07-02 11:15:54', '', null, '日志管理菜单');
INSERT INTO `sys_menu` VALUES ('109', '在线用户', '2', '1', 'online', 'monitor/online/index', '', '', '1', '0', 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2024-07-02 11:15:54', '', null, '在线用户菜单');
INSERT INTO `sys_menu` VALUES ('110', '定时任务', '2', '2', 'job', 'monitor/job/index', '', '', '1', '0', 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2024-07-02 11:15:54', '', null, '定时任务菜单');
INSERT INTO `sys_menu` VALUES ('111', '数据监控', '2', '3', 'druid', 'monitor/druid/index', '', '', '1', '0', 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2024-07-02 11:15:54', '', null, '数据监控菜单');
INSERT INTO `sys_menu` VALUES ('112', '服务监控', '2', '4', 'server', 'monitor/server/index', '', '', '1', '0', 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2024-07-02 11:15:54', '', null, '服务监控菜单');
INSERT INTO `sys_menu` VALUES ('113', '缓存监控', '2', '5', 'cache', 'monitor/cache/index', '', '', '1', '0', 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2024-07-02 11:15:54', '', null, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES ('114', '缓存列表', '2', '6', 'cacheList', 'monitor/cache/list', '', '', '1', '0', 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2024-07-02 11:15:54', '', null, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES ('115', '表单构建', '3', '1', 'build', 'tool/build/index', '', '', '1', '0', 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2024-07-02 11:15:54', '', null, '表单构建菜单');
INSERT INTO `sys_menu` VALUES ('116', '代码生成', '3', '2', 'gen', 'tool/gen/index', '', '', '1', '0', 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2024-07-02 11:15:54', '', null, '代码生成菜单');
INSERT INTO `sys_menu` VALUES ('117', '系统接口', '3', '3', 'swagger', 'tool/swagger/index', '', '', '1', '0', 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2024-07-02 11:15:54', '', null, '系统接口菜单');
INSERT INTO `sys_menu` VALUES ('500', '操作日志', '108', '1', 'operlog', 'monitor/operlog/index', '', '', '1', '0', 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2024-07-02 11:15:54', '', null, '操作日志菜单');
INSERT INTO `sys_menu` VALUES ('501', '登录日志', '108', '2', 'logininfor', 'monitor/logininfor/index', '', '', '1', '0', 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2024-07-02 11:15:54', '', null, '登录日志菜单');
INSERT INTO `sys_menu` VALUES ('1000', '用户查询', '100', '1', '', '', '', '', '1', '0', 'F', '0', '0', 'system:user:query', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1001', '用户新增', '100', '2', '', '', '', '', '1', '0', 'F', '0', '0', 'system:user:add', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1002', '用户修改', '100', '3', '', '', '', '', '1', '0', 'F', '0', '0', 'system:user:edit', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1003', '用户删除', '100', '4', '', '', '', '', '1', '0', 'F', '0', '0', 'system:user:remove', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1004', '用户导出', '100', '5', '', '', '', '', '1', '0', 'F', '0', '0', 'system:user:export', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1005', '用户导入', '100', '6', '', '', '', '', '1', '0', 'F', '0', '0', 'system:user:import', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1006', '重置密码', '100', '7', '', '', '', '', '1', '0', 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1007', '角色查询', '101', '1', '', '', '', '', '1', '0', 'F', '0', '0', 'system:role:query', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1008', '角色新增', '101', '2', '', '', '', '', '1', '0', 'F', '0', '0', 'system:role:add', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1009', '角色修改', '101', '3', '', '', '', '', '1', '0', 'F', '0', '0', 'system:role:edit', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1010', '角色删除', '101', '4', '', '', '', '', '1', '0', 'F', '0', '0', 'system:role:remove', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1011', '角色导出', '101', '5', '', '', '', '', '1', '0', 'F', '0', '0', 'system:role:export', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1012', '菜单查询', '102', '1', '', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:query', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1013', '菜单新增', '102', '2', '', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:add', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1014', '菜单修改', '102', '3', '', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1015', '菜单删除', '102', '4', '', '', '', '', '1', '0', 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1016', '部门查询', '103', '1', '', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:query', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1017', '部门新增', '103', '2', '', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:add', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1018', '部门修改', '103', '3', '', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1019', '部门删除', '103', '4', '', '', '', '', '1', '0', 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1020', '岗位查询', '104', '1', '', '', '', '', '1', '0', 'F', '0', '0', 'system:post:query', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1021', '岗位新增', '104', '2', '', '', '', '', '1', '0', 'F', '0', '0', 'system:post:add', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1022', '岗位修改', '104', '3', '', '', '', '', '1', '0', 'F', '0', '0', 'system:post:edit', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1023', '岗位删除', '104', '4', '', '', '', '', '1', '0', 'F', '0', '0', 'system:post:remove', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1024', '岗位导出', '104', '5', '', '', '', '', '1', '0', 'F', '0', '0', 'system:post:export', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1025', '字典查询', '105', '1', '#', '', '', '', '1', '0', 'F', '0', '0', 'system:dict:query', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1026', '字典新增', '105', '2', '#', '', '', '', '1', '0', 'F', '0', '0', 'system:dict:add', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1027', '字典修改', '105', '3', '#', '', '', '', '1', '0', 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1028', '字典删除', '105', '4', '#', '', '', '', '1', '0', 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1029', '字典导出', '105', '5', '#', '', '', '', '1', '0', 'F', '0', '0', 'system:dict:export', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1030', '参数查询', '106', '1', '#', '', '', '', '1', '0', 'F', '0', '0', 'system:config:query', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1031', '参数新增', '106', '2', '#', '', '', '', '1', '0', 'F', '0', '0', 'system:config:add', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1032', '参数修改', '106', '3', '#', '', '', '', '1', '0', 'F', '0', '0', 'system:config:edit', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1033', '参数删除', '106', '4', '#', '', '', '', '1', '0', 'F', '0', '0', 'system:config:remove', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1034', '参数导出', '106', '5', '#', '', '', '', '1', '0', 'F', '0', '0', 'system:config:export', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1035', '公告查询', '107', '1', '#', '', '', '', '1', '0', 'F', '0', '0', 'system:notice:query', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1036', '公告新增', '107', '2', '#', '', '', '', '1', '0', 'F', '0', '0', 'system:notice:add', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1037', '公告修改', '107', '3', '#', '', '', '', '1', '0', 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1038', '公告删除', '107', '4', '#', '', '', '', '1', '0', 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1039', '操作查询', '500', '1', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1040', '操作删除', '500', '2', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1041', '日志导出', '500', '3', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1042', '登录查询', '501', '1', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1043', '登录删除', '501', '2', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1044', '日志导出', '501', '3', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1045', '账户解锁', '501', '4', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1046', '在线查询', '109', '1', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1047', '批量强退', '109', '2', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1048', '单条强退', '109', '3', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1049', '任务查询', '110', '1', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1050', '任务新增', '110', '2', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1051', '任务修改', '110', '3', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1052', '任务删除', '110', '4', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1053', '状态修改', '110', '5', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1054', '任务导出', '110', '6', '#', '', '', '', '1', '0', 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1055', '生成查询', '116', '1', '#', '', '', '', '1', '0', 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1056', '生成修改', '116', '2', '#', '', '', '', '1', '0', 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1057', '生成删除', '116', '3', '#', '', '', '', '1', '0', 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1058', '导入代码', '116', '4', '#', '', '', '', '1', '0', 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1059', '预览代码', '116', '5', '#', '', '', '', '1', '0', 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_menu` VALUES ('1060', '生成代码', '116', '6', '#', '', '', '', '1', '0', 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2024-07-02 11:15:54', '', null, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES ('1', '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2024-07-02 11:15:54', '', null, '管理员');
INSERT INTO `sys_notice` VALUES ('2', '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2024-07-02 11:15:54', '', null, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES ('1', 'ceo', '董事长', '1', '0', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_post` VALUES ('2', 'se', '项目经理', '2', '0', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_post` VALUES ('3', 'hr', '人力资源', '3', '0', 'admin', '2024-07-02 11:15:54', '', null, '');
INSERT INTO `sys_post` VALUES ('4', 'user', '普通员工', '4', '0', 'admin', '2024-07-02 11:15:54', '', null, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 'admin', '1', '1', '1', '1', '0', '0', 'admin', '2024-07-02 11:15:54', '', null, '超级管理员');
INSERT INTO `sys_role` VALUES ('2', '普通角色', 'common', '2', '2', '1', '1', '0', '0', 'admin', '2024-07-02 11:15:54', '', null, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES ('2', '100');
INSERT INTO `sys_role_dept` VALUES ('2', '101');
INSERT INTO `sys_role_dept` VALUES ('2', '105');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('2', '1');
INSERT INTO `sys_role_menu` VALUES ('2', '2');
INSERT INTO `sys_role_menu` VALUES ('2', '3');
INSERT INTO `sys_role_menu` VALUES ('2', '4');
INSERT INTO `sys_role_menu` VALUES ('2', '100');
INSERT INTO `sys_role_menu` VALUES ('2', '101');
INSERT INTO `sys_role_menu` VALUES ('2', '102');
INSERT INTO `sys_role_menu` VALUES ('2', '103');
INSERT INTO `sys_role_menu` VALUES ('2', '104');
INSERT INTO `sys_role_menu` VALUES ('2', '105');
INSERT INTO `sys_role_menu` VALUES ('2', '106');
INSERT INTO `sys_role_menu` VALUES ('2', '107');
INSERT INTO `sys_role_menu` VALUES ('2', '108');
INSERT INTO `sys_role_menu` VALUES ('2', '109');
INSERT INTO `sys_role_menu` VALUES ('2', '110');
INSERT INTO `sys_role_menu` VALUES ('2', '111');
INSERT INTO `sys_role_menu` VALUES ('2', '112');
INSERT INTO `sys_role_menu` VALUES ('2', '113');
INSERT INTO `sys_role_menu` VALUES ('2', '114');
INSERT INTO `sys_role_menu` VALUES ('2', '115');
INSERT INTO `sys_role_menu` VALUES ('2', '116');
INSERT INTO `sys_role_menu` VALUES ('2', '117');
INSERT INTO `sys_role_menu` VALUES ('2', '500');
INSERT INTO `sys_role_menu` VALUES ('2', '501');
INSERT INTO `sys_role_menu` VALUES ('2', '1000');
INSERT INTO `sys_role_menu` VALUES ('2', '1001');
INSERT INTO `sys_role_menu` VALUES ('2', '1002');
INSERT INTO `sys_role_menu` VALUES ('2', '1003');
INSERT INTO `sys_role_menu` VALUES ('2', '1004');
INSERT INTO `sys_role_menu` VALUES ('2', '1005');
INSERT INTO `sys_role_menu` VALUES ('2', '1006');
INSERT INTO `sys_role_menu` VALUES ('2', '1007');
INSERT INTO `sys_role_menu` VALUES ('2', '1008');
INSERT INTO `sys_role_menu` VALUES ('2', '1009');
INSERT INTO `sys_role_menu` VALUES ('2', '1010');
INSERT INTO `sys_role_menu` VALUES ('2', '1011');
INSERT INTO `sys_role_menu` VALUES ('2', '1012');
INSERT INTO `sys_role_menu` VALUES ('2', '1013');
INSERT INTO `sys_role_menu` VALUES ('2', '1014');
INSERT INTO `sys_role_menu` VALUES ('2', '1015');
INSERT INTO `sys_role_menu` VALUES ('2', '1016');
INSERT INTO `sys_role_menu` VALUES ('2', '1017');
INSERT INTO `sys_role_menu` VALUES ('2', '1018');
INSERT INTO `sys_role_menu` VALUES ('2', '1019');
INSERT INTO `sys_role_menu` VALUES ('2', '1020');
INSERT INTO `sys_role_menu` VALUES ('2', '1021');
INSERT INTO `sys_role_menu` VALUES ('2', '1022');
INSERT INTO `sys_role_menu` VALUES ('2', '1023');
INSERT INTO `sys_role_menu` VALUES ('2', '1024');
INSERT INTO `sys_role_menu` VALUES ('2', '1025');
INSERT INTO `sys_role_menu` VALUES ('2', '1026');
INSERT INTO `sys_role_menu` VALUES ('2', '1027');
INSERT INTO `sys_role_menu` VALUES ('2', '1028');
INSERT INTO `sys_role_menu` VALUES ('2', '1029');
INSERT INTO `sys_role_menu` VALUES ('2', '1030');
INSERT INTO `sys_role_menu` VALUES ('2', '1031');
INSERT INTO `sys_role_menu` VALUES ('2', '1032');
INSERT INTO `sys_role_menu` VALUES ('2', '1033');
INSERT INTO `sys_role_menu` VALUES ('2', '1034');
INSERT INTO `sys_role_menu` VALUES ('2', '1035');
INSERT INTO `sys_role_menu` VALUES ('2', '1036');
INSERT INTO `sys_role_menu` VALUES ('2', '1037');
INSERT INTO `sys_role_menu` VALUES ('2', '1038');
INSERT INTO `sys_role_menu` VALUES ('2', '1039');
INSERT INTO `sys_role_menu` VALUES ('2', '1040');
INSERT INTO `sys_role_menu` VALUES ('2', '1041');
INSERT INTO `sys_role_menu` VALUES ('2', '1042');
INSERT INTO `sys_role_menu` VALUES ('2', '1043');
INSERT INTO `sys_role_menu` VALUES ('2', '1044');
INSERT INTO `sys_role_menu` VALUES ('2', '1045');
INSERT INTO `sys_role_menu` VALUES ('2', '1046');
INSERT INTO `sys_role_menu` VALUES ('2', '1047');
INSERT INTO `sys_role_menu` VALUES ('2', '1048');
INSERT INTO `sys_role_menu` VALUES ('2', '1049');
INSERT INTO `sys_role_menu` VALUES ('2', '1050');
INSERT INTO `sys_role_menu` VALUES ('2', '1051');
INSERT INTO `sys_role_menu` VALUES ('2', '1052');
INSERT INTO `sys_role_menu` VALUES ('2', '1053');
INSERT INTO `sys_role_menu` VALUES ('2', '1054');
INSERT INTO `sys_role_menu` VALUES ('2', '1055');
INSERT INTO `sys_role_menu` VALUES ('2', '1056');
INSERT INTO `sys_role_menu` VALUES ('2', '1057');
INSERT INTO `sys_role_menu` VALUES ('2', '1058');
INSERT INTO `sys_role_menu` VALUES ('2', '1059');
INSERT INTO `sys_role_menu` VALUES ('2', '1060');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '103', 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2024-07-02 11:15:53', 'admin', '2024-07-02 11:15:53', '', null, '管理员');
INSERT INTO `sys_user` VALUES ('2', '105', 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2024-07-02 11:15:53', 'admin', '2024-07-02 11:15:53', '', null, '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES ('1', '1');
INSERT INTO `sys_user_post` VALUES ('2', '2');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('2', '2');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流程定义表';

-- ----------------------------
-- Records of xflow_process_def
-- ----------------------------
INSERT INTO `xflow_process_def` VALUES ('1782594277784793089', '1782597153848406017', '测试流程', null, '0', null, null, null, null);
INSERT INTO `xflow_process_def` VALUES ('1798242236502704129', '1798249268811202562', '校级采购申请流程-单一采购来源', null, '0', null, null, null, null);

-- ----------------------------
-- Table structure for xflow_process_form
-- ----------------------------
DROP TABLE IF EXISTS `xflow_process_form`;
CREATE TABLE `xflow_process_form` (
  `id` varchar(255) NOT NULL COMMENT '唯一标识',
  `introduction` varchar(255) DEFAULT NULL COMMENT '介绍',
  `runtime_form_type` varchar(255) DEFAULT NULL COMMENT '运行时的表单类型',
  `dept_id` varchar(255) DEFAULT NULL COMMENT '部门ID',
  `role_id` bigint DEFAULT NULL COMMENT '角色ID',
  `deleted` varchar(1) DEFAULT '0' COMMENT '是否删除',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `process_node` varchar(255) DEFAULT NULL COMMENT '当前节点需要的数据的来源节点 （比如前一个节点）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流程中固定的表单配置';

-- ----------------------------
-- Records of xflow_process_form
-- ----------------------------
INSERT INTO `xflow_process_form` VALUES ('1', '根据岗位获取用户', '', null, '1', '0', null, null, null, null, null);
INSERT INTO `xflow_process_form` VALUES ('2', '节点->表单类型1配置', '1', null, null, '0', null, null, null, null, null);
INSERT INTO `xflow_process_form` VALUES ('3', '根据岗位获取后保处管理员', '8', null, '4', '0', null, null, null, null, null);
INSERT INTO `xflow_process_form` VALUES ('4', '从前一个表单中获取多个统筹部门', null, null, null, '0', null, null, null, null, '1798607743957401601');
INSERT INTO `xflow_process_form` VALUES ('5', '子流程，选经办人', '3', null, null, '0', null, null, null, null, null);
INSERT INTO `xflow_process_form` VALUES ('6', '子流程，经办人审核', '5', null, null, '0', null, null, null, null, '1798988676577427458');

-- ----------------------------
-- Table structure for xflow_process_form_runtime_result
-- ----------------------------
DROP TABLE IF EXISTS `xflow_process_form_runtime_result`;
CREATE TABLE `xflow_process_form_runtime_result` (
  `id` varchar(255) NOT NULL,
  `runtime_form_type` char(255) NOT NULL COMMENT '表单类型，跟前端商量好',
  `process_instance_node_id` varchar(255) NOT NULL COMMENT '流程实例节点id',
  `process_task_id` varchar(255) NOT NULL COMMENT '提交结果对应的用户任务id',
  `process_node_id` varchar(255) NOT NULL,
  `audit_type` varchar(255) NOT NULL COMMENT '审批类型 0=通过 1=驳回',
  `audit_opinions` varchar(255) DEFAULT NULL COMMENT '审核意见',
  `undertake_dept_id` varchar(255) DEFAULT NULL COMMENT '业务字段： 承办部门id',
  `completely` char(1) DEFAULT NULL COMMENT '业务字段：项目是否填写完整 0=否 1=是',
  `overall_plan_dept_id` varchar(255) DEFAULT NULL COMMENT '业务字段：指定统筹部门id,多选',
  `operator` varchar(255) DEFAULT NULL COMMENT '经办人id',
  `deleted` varchar(255) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of xflow_process_form_runtime_result
-- ----------------------------

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of xflow_process_instance
-- ----------------------------
INSERT INTO `xflow_process_instance` VALUES ('1806237597243801601', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', '1782597153848406017', '管理员01', '1', 'admin', '221', null, 'IN_PROGRESS', 'bd857458-db30-47bc-9c38-a0dfdecefe0f', '0', 'admin', '2024-06-27 16:06:16', 'admin', '2024-06-27 16:06:16');
INSERT INTO `xflow_process_instance` VALUES ('1806249835870617601', '2feffb33-de9e-47ab-b352-931778d5bdea', '1782597153848406017', '管理员01', '1', 'admin', '221', null, 'COMPLETED', '597b6a21-01d8-4a17-9b57-f5392bb958f0', '0', 'admin', '2024-06-27 16:54:54', 'admin', '2024-06-27 16:54:54');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of xflow_process_instance_node
-- ----------------------------
INSERT INTO `xflow_process_instance_node` VALUES ('1806237597893918721', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', '7ecff7d0-a212-4d87-8c91-ff0bc19fabed', '1782654335478509569', '测试节点1', 'COMPLETED', null, null, null, '0', 'admin', '2024-06-27 16:06:16', 'admin', '2024-06-27 16:06:16', null);
INSERT INTO `xflow_process_instance_node` VALUES ('1806242908839137281', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', '284e4ed0-76cc-4c30-aa13-0b7248817e8b', '1796000784643641346', '测试节点2', 'COMPLETED', null, null, null, '0', 'admin', '2024-06-27 16:27:23', 'admin', '2024-06-27 16:27:23', null);
INSERT INTO `xflow_process_instance_node` VALUES ('1806245045258223617', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', 'bd857458-db30-47bc-9c38-a0dfdecefe0f', '1798235361988116481', '测试节点3', 'IN_PROGRESS', null, null, null, '0', 'admin', '2024-06-27 16:35:52', 'admin', '2024-06-27 16:35:52', null);
INSERT INTO `xflow_process_instance_node` VALUES ('1806249836390711298', '2feffb33-de9e-47ab-b352-931778d5bdea', '679b302e-38c0-4c83-b20f-886e50f97609', '1782654335478509569', '测试节点1', 'COMPLETED', null, null, null, '0', 'admin', '2024-06-27 16:54:54', 'admin', '2024-06-27 16:54:54', null);
INSERT INTO `xflow_process_instance_node` VALUES ('1806249839196700673', '2feffb33-de9e-47ab-b352-931778d5bdea', '6e4096d4-f80b-4697-bf76-de8eee2fa364', '1796000784643641346', '测试节点2', 'COMPLETED', null, null, null, '0', 'admin', '2024-06-27 16:54:55', 'admin', '2024-06-27 16:54:55', null);
INSERT INTO `xflow_process_instance_node` VALUES ('1806250479058751490', '2feffb33-de9e-47ab-b352-931778d5bdea', '597b6a21-01d8-4a17-9b57-f5392bb958f0', '1798235361988116481', '测试节点3', 'COMPLETED', null, null, null, '0', 'admin', '2024-06-27 16:57:27', 'admin', '2024-06-27 16:57:27', null);

-- ----------------------------
-- Table structure for xflow_process_instance_sub_node
-- ----------------------------
DROP TABLE IF EXISTS `xflow_process_instance_sub_node`;
CREATE TABLE `xflow_process_instance_sub_node` (
  `id` varchar(255) NOT NULL,
  `process_instance_id` varchar(255) NOT NULL,
  `process_instance_node_sub_id` varchar(255) NOT NULL,
  `node_id` varchar(255) NOT NULL,
  `node_rank` int NOT NULL COMMENT '节点排序',
  `parent_process_instance_node_id` varchar(255) NOT NULL COMMENT '流程实例节点id',
  `node_name` varchar(255) DEFAULT NULL,
  `node_status` varchar(255) DEFAULT NULL,
  `node_type` varchar(255) DEFAULT '0' COMMENT '节点类型 0=流程节点 1=并行处理器 2并行处理器的子流程节点',
  `visibility` varchar(255) DEFAULT '1' COMMENT '可见性 1=可见 0=不可见',
  `stage` varchar(255) DEFAULT '1',
  `deleted` varchar(255) DEFAULT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `business_id` varchar(255) DEFAULT NULL COMMENT '预留字段，业务系统自行取用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='子流程节点记录表';

-- ----------------------------
-- Records of xflow_process_instance_sub_node
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of xflow_process_instance_task
-- ----------------------------
INSERT INTO `xflow_process_instance_task` VALUES ('1806237598216880129', '8ac8fff4-f2f4-40ac-9ef8-346b1ce6584c', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', '7ecff7d0-a212-4d87-8c91-ff0bc19fabed', '测试节点1', '1', '管理员01', 'admin', '221', null, '1', '0', 'admin', '2024-06-27 16:06:16', 'admin', '2024-06-27 16:06:16', '2024-06-27 16:28:20', '同意');
INSERT INTO `xflow_process_instance_task` VALUES ('1806242910537830401', '29606e72-656a-489d-803a-9dcd3b83fe53', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', '284e4ed0-76cc-4c30-aa13-0b7248817e8b', '测试节点2', '1', '管理员01', 'admin', '221', null, '1', '0', 'admin', '2024-06-27 16:27:23', 'admin', '2024-06-27 16:27:23', '2024-06-27 16:35:51', '同意');
INSERT INTO `xflow_process_instance_task` VALUES ('1806242910600744961', '1811cd0e-1414-46a6-9888-0ec2ac1ff1bb', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', '284e4ed0-76cc-4c30-aa13-0b7248817e8b', '测试节点2', '120523', '阮铁权', '20021004', '20170000', null, '3', '0', 'admin', '2024-06-27 16:27:23', 'admin', '2024-06-27 16:27:23', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806242910600744962', '7f4aa1bc-0653-4ee9-a314-d250422654ca', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', '284e4ed0-76cc-4c30-aa13-0b7248817e8b', '测试节点2', '120524', '陈文涛', '20021010', '20010000', null, '3', '0', 'admin', '2024-06-27 16:27:23', 'admin', '2024-06-27 16:27:23', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806242910600744963', '0a357786-16f4-4d67-a20e-53619575f64b', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', '284e4ed0-76cc-4c30-aa13-0b7248817e8b', '测试节点2', '120855', '费君清', '20162057', '20010000', null, '3', '0', 'admin', '2024-06-27 16:27:23', 'admin', '2024-06-27 16:27:23', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806242910600744964', '7b3df2a0-7fd1-42af-961e-0810d920c79b', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', '284e4ed0-76cc-4c30-aa13-0b7248817e8b', '测试节点2', '120926', '王伟', '20141047', '20170000', null, '3', '0', 'admin', '2024-06-27 16:27:23', 'admin', '2024-06-27 16:27:23', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806242910600744965', '2c844532-6440-420d-94cb-e237bdbc4bc1', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', '284e4ed0-76cc-4c30-aa13-0b7248817e8b', '测试节点2', '121134', '钟逸楠', '20181103', '20170000', null, '3', '0', 'admin', '2024-06-27 16:27:23', 'admin', '2024-06-27 16:27:23', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806242910667853825', '2c924837-8a90-412d-82e5-1620de31ed69', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', '284e4ed0-76cc-4c30-aa13-0b7248817e8b', '测试节点2', '121615', '陈伟雄', '20031003', '20170000', null, '3', '0', 'admin', '2024-06-27 16:27:23', 'admin', '2024-06-27 16:27:23', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806242910667853826', '14116547-fc4f-4937-8e04-9e8719b58b50', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', '284e4ed0-76cc-4c30-aa13-0b7248817e8b', '测试节点2', '121620', '戴宏飞', '20211010', '20170000', null, '3', '0', 'admin', '2024-06-27 16:27:23', 'admin', '2024-06-27 16:27:23', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806242910667853827', 'da519d0f-4520-45a3-a06f-9b863787ef70', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', '284e4ed0-76cc-4c30-aa13-0b7248817e8b', '测试节点2', '121969', '常生月', '20212011', '20170000', null, '3', '0', 'admin', '2024-06-27 16:27:23', 'admin', '2024-06-27 16:27:23', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806242910667853828', '32d26244-9eb9-43b8-a103-cb1c2f17fecc', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', '284e4ed0-76cc-4c30-aa13-0b7248817e8b', '测试节点2', '122115', '修刚', '20231088', '20010000', null, '3', '0', 'admin', '2024-06-27 16:27:23', 'admin', '2024-06-27 16:27:23', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806245046969499650', '76b83a7c-5848-4184-aca7-e68edf51b5e0', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', 'bd857458-db30-47bc-9c38-a0dfdecefe0f', '测试节点3', '1', '管理员01', 'admin', '221', null, '0', '0', 'admin', '2024-06-27 16:35:52', 'admin', '2024-06-27 16:35:52', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806245046969499651', '76d4d06c-478b-4c30-8119-e9e6e267f985', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', 'bd857458-db30-47bc-9c38-a0dfdecefe0f', '测试节点3', '120523', '阮铁权', '20021004', '20170000', null, '0', '0', 'admin', '2024-06-27 16:35:52', 'admin', '2024-06-27 16:35:52', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806245046969499652', '98f9702d-6480-4479-9715-a9afe822ac30', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', 'bd857458-db30-47bc-9c38-a0dfdecefe0f', '测试节点3', '120524', '陈文涛', '20021010', '20010000', null, '0', '0', 'admin', '2024-06-27 16:35:52', 'admin', '2024-06-27 16:35:52', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806245046969499653', 'c3ba6ce2-6796-44ce-9f31-0f22619a7af0', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', 'bd857458-db30-47bc-9c38-a0dfdecefe0f', '测试节点3', '120855', '费君清', '20162057', '20010000', null, '0', '0', 'admin', '2024-06-27 16:35:52', 'admin', '2024-06-27 16:35:52', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806245047032414209', 'fd1528af-2596-4d36-a5d7-803c91c644f4', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', 'bd857458-db30-47bc-9c38-a0dfdecefe0f', '测试节点3', '120926', '王伟', '20141047', '20170000', null, '0', '0', 'admin', '2024-06-27 16:35:52', 'admin', '2024-06-27 16:35:52', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806245047032414210', 'e8075597-82fd-4c5a-b62a-815602e7e3dd', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', 'bd857458-db30-47bc-9c38-a0dfdecefe0f', '测试节点3', '121134', '钟逸楠', '20181103', '20170000', null, '0', '0', 'admin', '2024-06-27 16:35:52', 'admin', '2024-06-27 16:35:52', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806245047032414211', 'ad549d05-0716-4b5a-9795-936ea46c4aae', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', 'bd857458-db30-47bc-9c38-a0dfdecefe0f', '测试节点3', '121615', '陈伟雄', '20031003', '20170000', null, '0', '0', 'admin', '2024-06-27 16:35:52', 'admin', '2024-06-27 16:35:52', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806245047032414212', 'bc27f872-41c8-4d01-b8d8-ffc62772fd33', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', 'bd857458-db30-47bc-9c38-a0dfdecefe0f', '测试节点3', '121620', '戴宏飞', '20211010', '20170000', null, '0', '0', 'admin', '2024-06-27 16:35:52', 'admin', '2024-06-27 16:35:52', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806245047032414213', '6c3b417f-e667-4f07-82bb-185e94e1f0e3', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', 'bd857458-db30-47bc-9c38-a0dfdecefe0f', '测试节点3', '121969', '常生月', '20212011', '20170000', null, '0', '0', 'admin', '2024-06-27 16:35:52', 'admin', '2024-06-27 16:35:52', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806245047032414214', '1ec88db2-10f3-4099-bfd3-bd745ee8ffd6', 'd2ae8666-f984-43c0-b82d-0b1f5e4247a5', 'bd857458-db30-47bc-9c38-a0dfdecefe0f', '测试节点3', '122115', '修刚', '20231088', '20010000', null, '0', '0', 'admin', '2024-06-27 16:35:52', 'admin', '2024-06-27 16:35:52', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806249836780781569', '0691ff16-0359-4c0e-81a2-f5e37f8a5f12', '2feffb33-de9e-47ab-b352-931778d5bdea', '679b302e-38c0-4c83-b20f-886e50f97609', '测试节点1', '1', '管理员01', 'admin', '221', null, '1', '0', 'admin', '2024-06-27 16:54:54', 'admin', '2024-06-27 16:54:54', '2024-06-27 16:54:54', '');
INSERT INTO `xflow_process_instance_task` VALUES ('1806249840769564674', '070f2710-cc1b-4b11-a053-b9901ae2be03', '2feffb33-de9e-47ab-b352-931778d5bdea', '6e4096d4-f80b-4697-bf76-de8eee2fa364', '测试节点2', '1', '管理员01', 'admin', '221', null, '1', '0', 'admin', '2024-06-27 16:54:55', 'admin', '2024-06-27 16:54:55', '2024-06-27 16:57:27', '同意');
INSERT INTO `xflow_process_instance_task` VALUES ('1806249840769564675', 'ae048d65-45f4-4b33-96fe-92b03efaccba', '2feffb33-de9e-47ab-b352-931778d5bdea', '6e4096d4-f80b-4697-bf76-de8eee2fa364', '测试节点2', '120523', '阮铁权', '20021004', '20170000', null, '3', '0', 'admin', '2024-06-27 16:54:55', 'admin', '2024-06-27 16:54:55', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806249840769564676', '664a9d46-0c6a-46d4-8fc7-118a422871ca', '2feffb33-de9e-47ab-b352-931778d5bdea', '6e4096d4-f80b-4697-bf76-de8eee2fa364', '测试节点2', '120524', '陈文涛', '20021010', '20010000', null, '3', '0', 'admin', '2024-06-27 16:54:55', 'admin', '2024-06-27 16:54:55', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806249840769564677', '8c494a64-dc47-4b3e-8be9-a606b4d0265b', '2feffb33-de9e-47ab-b352-931778d5bdea', '6e4096d4-f80b-4697-bf76-de8eee2fa364', '测试节点2', '120855', '费君清', '20162057', '20010000', null, '3', '0', 'admin', '2024-06-27 16:54:55', 'admin', '2024-06-27 16:54:55', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806249840769564678', '5f8cd83c-c9f7-4a8f-8121-018ba92086d8', '2feffb33-de9e-47ab-b352-931778d5bdea', '6e4096d4-f80b-4697-bf76-de8eee2fa364', '测试节点2', '120926', '王伟', '20141047', '20170000', null, '3', '0', 'admin', '2024-06-27 16:54:55', 'admin', '2024-06-27 16:54:55', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806249840769564679', 'c84d2c7f-de61-4b7f-ac1b-de9986ae44dc', '2feffb33-de9e-47ab-b352-931778d5bdea', '6e4096d4-f80b-4697-bf76-de8eee2fa364', '测试节点2', '121134', '钟逸楠', '20181103', '20170000', null, '3', '0', 'admin', '2024-06-27 16:54:55', 'admin', '2024-06-27 16:54:55', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806249840769564680', '03f4b760-d27f-4fdb-bb3f-102a8dd67f73', '2feffb33-de9e-47ab-b352-931778d5bdea', '6e4096d4-f80b-4697-bf76-de8eee2fa364', '测试节点2', '121615', '陈伟雄', '20031003', '20170000', null, '3', '0', 'admin', '2024-06-27 16:54:55', 'admin', '2024-06-27 16:54:55', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806249840769564681', 'f0d65cfa-d7c9-4f4e-bca2-c130177bead7', '2feffb33-de9e-47ab-b352-931778d5bdea', '6e4096d4-f80b-4697-bf76-de8eee2fa364', '测试节点2', '121620', '戴宏飞', '20211010', '20170000', null, '3', '0', 'admin', '2024-06-27 16:54:55', 'admin', '2024-06-27 16:54:55', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806249840769564682', '62c14b95-9c19-44d4-9ff0-3807f9e31d13', '2feffb33-de9e-47ab-b352-931778d5bdea', '6e4096d4-f80b-4697-bf76-de8eee2fa364', '测试节点2', '121969', '常生月', '20212011', '20170000', null, '3', '0', 'admin', '2024-06-27 16:54:55', 'admin', '2024-06-27 16:54:55', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806249840769564683', '76ca13af-78bc-4808-97f6-a0857964205c', '2feffb33-de9e-47ab-b352-931778d5bdea', '6e4096d4-f80b-4697-bf76-de8eee2fa364', '测试节点2', '122115', '修刚', '20231088', '20010000', null, '3', '0', 'admin', '2024-06-27 16:54:55', 'admin', '2024-06-27 16:54:55', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806250480841330690', '2638c260-dd1f-4f9b-8ce1-f8fd3b41928c', '2feffb33-de9e-47ab-b352-931778d5bdea', '597b6a21-01d8-4a17-9b57-f5392bb958f0', '测试节点3', '1', '管理员01', 'admin', '221', null, '1', '0', 'admin', '2024-06-27 16:57:28', 'admin', '2024-06-27 16:57:28', '2024-06-27 17:05:04', '同意');
INSERT INTO `xflow_process_instance_task` VALUES ('1806250480904245249', '79f69f6e-0fb8-4432-b3c4-bc16c1ecd602', '2feffb33-de9e-47ab-b352-931778d5bdea', '597b6a21-01d8-4a17-9b57-f5392bb958f0', '测试节点3', '120523', '阮铁权', '20021004', '20170000', null, '3', '0', 'admin', '2024-06-27 16:57:28', 'admin', '2024-06-27 16:57:28', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806250480904245250', '078ee734-d2c3-41dd-995b-e844b67ecf42', '2feffb33-de9e-47ab-b352-931778d5bdea', '597b6a21-01d8-4a17-9b57-f5392bb958f0', '测试节点3', '120524', '陈文涛', '20021010', '20010000', null, '3', '0', 'admin', '2024-06-27 16:57:28', 'admin', '2024-06-27 16:57:28', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806250480904245251', 'a4f511f6-84ff-41d4-a29c-0ec28a6c02d2', '2feffb33-de9e-47ab-b352-931778d5bdea', '597b6a21-01d8-4a17-9b57-f5392bb958f0', '测试节点3', '120855', '费君清', '20162057', '20010000', null, '3', '0', 'admin', '2024-06-27 16:57:28', 'admin', '2024-06-27 16:57:28', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806250480904245252', '20d368b8-4430-4945-a28b-0a8dfcd64390', '2feffb33-de9e-47ab-b352-931778d5bdea', '597b6a21-01d8-4a17-9b57-f5392bb958f0', '测试节点3', '120926', '王伟', '20141047', '20170000', null, '3', '0', 'admin', '2024-06-27 16:57:28', 'admin', '2024-06-27 16:57:28', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806250480904245253', 'a737ea6a-f6a9-4259-9c36-c6c2e57446fc', '2feffb33-de9e-47ab-b352-931778d5bdea', '597b6a21-01d8-4a17-9b57-f5392bb958f0', '测试节点3', '121134', '钟逸楠', '20181103', '20170000', null, '3', '0', 'admin', '2024-06-27 16:57:28', 'admin', '2024-06-27 16:57:28', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806250480904245254', '12328624-b83e-4cd0-8b29-a26869431482', '2feffb33-de9e-47ab-b352-931778d5bdea', '597b6a21-01d8-4a17-9b57-f5392bb958f0', '测试节点3', '121615', '陈伟雄', '20031003', '20170000', null, '3', '0', 'admin', '2024-06-27 16:57:28', 'admin', '2024-06-27 16:57:28', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806250480904245255', '982a279c-7ab6-4114-bca3-eb7ddc8c8001', '2feffb33-de9e-47ab-b352-931778d5bdea', '597b6a21-01d8-4a17-9b57-f5392bb958f0', '测试节点3', '121620', '戴宏飞', '20211010', '20170000', null, '3', '0', 'admin', '2024-06-27 16:57:28', 'admin', '2024-06-27 16:57:28', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806250480904245256', '68dbe673-f601-482e-a243-9de31fe377b9', '2feffb33-de9e-47ab-b352-931778d5bdea', '597b6a21-01d8-4a17-9b57-f5392bb958f0', '测试节点3', '121969', '常生月', '20212011', '20170000', null, '3', '0', 'admin', '2024-06-27 16:57:28', 'admin', '2024-06-27 16:57:28', null, null);
INSERT INTO `xflow_process_instance_task` VALUES ('1806250480904245257', '2ee8b839-27cd-40fa-9715-c722eddf0e24', '2feffb33-de9e-47ab-b352-931778d5bdea', '597b6a21-01d8-4a17-9b57-f5392bb958f0', '测试节点3', '122115', '修刚', '20231088', '20010000', null, '3', '0', 'admin', '2024-06-27 16:57:28', 'admin', '2024-06-27 16:57:28', null, null);

-- ----------------------------
-- Table structure for xflow_process_node
-- ----------------------------
DROP TABLE IF EXISTS `xflow_process_node`;
CREATE TABLE `xflow_process_node` (
  `id` varchar(255) NOT NULL COMMENT '唯一标识',
  `process_def_id` varchar(255) NOT NULL COMMENT '流程定义id',
  `node_id` varchar(255) NOT NULL COMMENT '节点ID',
  `node_rank` int NOT NULL COMMENT '定义好的节点顺序',
  `node_name` varchar(255) NOT NULL COMMENT '节点名称',
  `sign_type` varchar(1) DEFAULT '0' COMMENT '会签，或签的类型； 0=或签 1=会签',
  `level` int DEFAULT '0' COMMENT '等级， 数字越大等级越低，0级节点没有父id',
  `parent_node_id` varchar(255) DEFAULT NULL COMMENT '父节点id',
  `next_node_id` varchar(255) DEFAULT NULL COMMENT '下一个节点id',
  `visibility` varchar(50) DEFAULT '1' COMMENT '可见性 1=可见 0=不可见',
  `node_type` varchar(50) DEFAULT '0' COMMENT '节点类型 0=流程节点 1=并行处理器 2并行处理器的子流程节点',
  `form_id` varchar(255) DEFAULT NULL COMMENT '表单id',
  `bean_name` varchar(255) DEFAULT NULL COMMENT '具体实现类在 spring里的beanName',
  `stage` varchar(1) DEFAULT NULL COMMENT '阶段： 记录当前节点是开始，还是结束 0=开始 1=进行中 2=结束',
  `deleted` varchar(1) DEFAULT '0' COMMENT '是否删除',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of xflow_process_node
-- ----------------------------
INSERT INTO `xflow_process_node` VALUES ('1782602944082644993', '1782597153848406017', '1782654335478509569', '1', '测试节点1', '0', '0', null, '1796000784643641346', '1', null, '1', 'post4UserDiscoveryServiceImpl', '0', '0', null, null, null, null);
INSERT INTO `xflow_process_node` VALUES ('1796000721502588929', '1782597153848406017', '1796000784643641346', '2', '测试节点2', '0', '0', null, '1798235361988116481', '1', null, '1', 'post4UserDiscoveryServiceImpl', '1', '0', null, null, null, null);
INSERT INTO `xflow_process_node` VALUES ('1796008304145670145', '1782597153848406017', '1798235361988116481', '3', '测试节点3', '0', '0', null, null, '1', null, '1', 'post4UserDiscoveryServiceImpl', '2', '0', null, null, null, null);
INSERT INTO `xflow_process_node` VALUES ('1798249505281867777', '1798249268811202562', '1798250070099427330', '1', '项目负责人提交', '0', '0', null, '1798532015022735361', '1', '0', null, null, '0', '0', null, null, null, null);
INSERT INTO `xflow_process_node` VALUES ('1798522364445130753', '1798249268811202562', '1798532015022735361', '2', '部门负责人审批', '0', '0', null, '1798607743957401601', '1', '0', '2', 'deptHead4UserDiscoveryServiceImpl', '1', '0', null, null, null, null);
INSERT INTO `xflow_process_node` VALUES ('1798607488197132290', '1798249268811202562', '1798607743957401601', '3', '后勤保障处经办人审批', '0', '0', null, '1798607743928041474', '1', '0', '3', 'post4UserDiscoveryServiceImpl', '1', '0', null, null, null, null);
INSERT INTO `xflow_process_node` VALUES ('1798607775787974657', '1798249268811202562', '1798607743928041474', '4', '并行处理器', '0', '0', null, '1798988676577427458', '0', '1', '4', 'form4DeptDiscoveryServiceImpl', '1', '0', null, null, null, null);
INSERT INTO `xflow_process_node` VALUES ('1798986475054366722', '1798249268811202562', '1798988676577427458', '5', '统筹部门（归口部门）负责人', '1', '0', '1798607743928041474', '1800359861689057282', '1', '2', '5', 'processInsNode4UserDiscoveryServiceImpl', '1', '0', null, null, null, null);
INSERT INTO `xflow_process_node` VALUES ('1800359643602026497', '1798249268811202562', '1800359861689057282', '6', '统筹部门（归口部门）经办人', '1', '0', '1798607743928041474', '1800360995904356353', '1', '2', '2', 'processInsNodeAndForm4UserDiscoveryServiceImpl', '1', '0', null, null, null, null);
INSERT INTO `xflow_process_node` VALUES ('1800360125330423809', '1798249268811202562', '1800360995904356353', '7', '统筹部门（归口部门）负责人', '1', '0', '1798607743928041474', '1800739065270173698', '1', '2', '2', 'processInsNode4UserDiscoveryServiceImpl', '3', '0', null, null, null, null);
INSERT INTO `xflow_process_node` VALUES ('1800460073745055746', '1798249268811202562', '1800739065270173698', '8', '承办部门，负责人', '0', '0', null, '1801067729891426305', '1', '0', null, 'form4UserDiscoveryServiceImpl', '1', '0', null, null, null, null);
INSERT INTO `xflow_process_node` VALUES ('1801065666075754498', '1798249268811202562', '1801067729891426305', '9', '承办部门，经办人', '0', '0', null, '1803598150961266690', '1', '0', null, 'form4UserDiscoveryServiceImpl', '1', '0', null, null, null, null);
INSERT INTO `xflow_process_node` VALUES ('1801069890234810370', '1798249268811202562', '1803598150961266690', '10', '承办部门，负责人', '0', '0', null, '1803599262133059585', '1', '0', null, 'form4UserDiscoveryServiceImpl', '1', '0', null, null, null, null);
INSERT INTO `xflow_process_node` VALUES ('1803599085536083969', '1798249268811202562', '1803599262133059585', '11', '招投标中心反馈并抄送承办部门', '0', '0', null, '1803599674340868098', '1', '0', null, 'post4UserDiscoveryServiceImpl', '1', '0', null, null, null, null);
INSERT INTO `xflow_process_node` VALUES ('1803599611069792257', '1798249268811202562', '1803599674340868098', '12', '使用部门反馈', '0', '0', null, '1803600083017072642', '1', '0', null, 'sponsor4UserDiscoveryServiceImpl', '1', '0', null, null, null, null);
INSERT INTO `xflow_process_node` VALUES ('1803599747405643777', '1798249268811202562', '1803600083017072642', '13', '承办部门确认并抄送招投标中心', '0', '0', null, null, '1', '0', null, 'form4UserDiscoveryServiceImpl', '2', '0', null, null, null, null);
