CREATE TABLE work_order (
  work_order_id VARCHAR(100) NOT NULL COMMENT '主键',
  work_time VARCHAR(1000) COMMENT '申请下队时间',
  confirm_work_time_start DATE COMMENT '确认下队开始时间',
  confirm_work_time_end DATE COMMENT '确认下队结束时间',
  work_space VARCHAR(1000) COMMENT '下队地点',
  work_for_team VARCHAR(1000) COMMENT '申请国家队',
  work_for_reason VARCHAR(4000) COMMENT '下队解决问题',
  work_for_reason_images VARCHAR(4000) COMMENT '下对解决问题附件（图片）',
  work_expert VARCHAR(200) COMMENT '申请专家',
  work_expert_name VARCHAR(200) COMMENT '申请专家姓名',
  confirm_work_expert VARCHAR(200) COMMENT '确认下队专家',
  confirm_work_expert_name VARCHAR(200) COMMENT '确认下队专家姓名',
  work_expert_optional VARCHAR(4000) COMMENT '备选专家',
  work_expert_optional_name VARCHAR(4000) COMMENT '备选专家姓名',
  work_order_creator VARCHAR(200) COMMENT '申请人',
  work_order_creator_name VARCHAR(200) COMMENT '申请人姓名',
  work_order_creator_phone VARCHAR(100) COMMENT '申请人联系方式',
  work_order_creator_photo VARCHAR(200) COMMENT '申请人头像URL',
  work_order_create_time DATETIME COMMENT '申请提交时间',
  work_order_reviewer` VARCHAR(100) COMMENT '确认人',
  work_order_reviewer_name VARCHAR(200) COMMENT '确认人姓名',
  work_order_reviewer_phone VARCHAR(100) COMMENT '确认人联系方式',
  work_order_reviewer_photo VARCHAR(200) COMMENT '确认人头像URL',
  evaluation_point VARCHAR(100) COMMENT '工作单评分',
  evaluation_content VARCHAR(4000) COMMENT '工作单评价内容',
  work_order_status VARCHAR(100) COMMENT '工作单状态',
  work_order_approval_status VARCHAR(100) COMMENT '工作单审批状态',
  work_order_done_evaluate_status VARCHAR(100) COMMENT '工作单评价状态',
  work_order_done_approval_status VARCHAR(100) COMMENT '工作单工作报告审批状态',
  PRIMARY KEY (work_order_id)
) CHARSET=utf8;

CREATE TABLE expert_daily_log (
  daily_log_id VARCHAR(100) NOT NULL COMMENT '主键',
  work_order_id VARCHAR(100) COMMENT '工作单ID',
  work_type VARCHAR(200) COMMENT '工作类型',
  work_type_name VARCHAR(400) COMMENT '工作类型名称',
  daily_log_content VARCHAR(4000) COMMENT '工作内容',
  daily_log_date DATE COMMENT '工作日期',
  PRIMARY KEY (daily_log_id)
) CHARSET=utf8;

CREATE TABLE work_order_approval_record (
  record_id VARCHAR(100) NOT NULL COMMENT '主键',
  work_order_id VARCHAR(100) COMMENT '工作单ID',
  record_content VARCHAR(4000) COMMENT '审批意见',
  record_time DATETIME COMMENT '审批时间',
  record_user_id VARCHAR(100) COMMENT '审批人',
  record_user_name VARCHAR(100) COMMENT '审批人姓名',
  PRIMARY KEY (record_id)
) CHARSET=utf8;

CREATE TABLE report_approval_record (
  record_id VARCHAR(100) NOT NULL COMMENT '主键',
  work_order_id VARCHAR(100) COMMENT '工作单ID',
  record_content VARCHAR(4000) COMMENT '审批意见',
  record_time DATETIME COMMENT '审批时间',
  record_user_id VARCHAR(100) COMMENT '审批人',
  record_user_name VARCHAR(100) COMMENT '审批人姓名',
  PRIMARY KEY (record_id)
) CHARSET=utf8;

CREATE TABLE work_order_carbon_copy (
  carbon_copy_id VARCHAR(100) NOT NULL COMMENT '主键',
  work_order_id VARCHAR(100) COMMENT '工作单ID',
  carbon_copy_user VARCHAR(1000) COMMENT '抄送人',
  carbon_copy_content VARCHAR(4000) COMMENT '抄送附言',
  PRIMARY KEY (carbon_copy_id)
) CHARSET=utf8;

CREATE TABLE problem (
  problem_id VARCHAR(100) NOT NULL COMMENT '主键ID',
  content VARCHAR(4000) COMMENT '反馈内容',
  title VARCHAR(200) COMMENT '反馈摘要',
  creator VARCHAR(200) COMMENT '反馈人',
  creator_name VARCHAR(200) COMMENT '反馈人姓名',
  creator_phone VARCHAR(100) COMMENT '反馈人电话',
  creator_photo VARCHAR(200) COMMENT '反馈人头像URL',
  create_time DATETIME COMMENT '反馈时间',
  re VARCHAR(4000) COMMENT '回复内容',
  re_user VARCHAR(200) COMMENT '回复人',
  re_user_name VARCHAR(200) COMMENT '回复人姓名',
  status VARCHAR(100) COMMENT '状态',
  PRIMARY KEY (`problem_id`)
) CHARSET=utf8;

CREATE TABLE work_feedback (
  id varchar(32),
  work_no varchar(100),
  weixin_no varchar(100),
  create_time DATETIME
);

CREATE TABLE work_feedback_attacment (
  id varchar(32),
  url varchar(400),
  attr_type TINYINT,
  feedback_id varchar(32)
);

ALTER TABLE work_feedback_attacment ADD COLUMN file_name varchar(400);