
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for 72crm_admin_config
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_config`;
CREATE TABLE `72crm_admin_config` (
   `setting_id` int(9) NOT NULL AUTO_INCREMENT,
   `status` int(1) NOT NULL DEFAULT 0 COMMENT'status, 0: not enabled 1: enabled',
   `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'Set name',
   `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'value',
   `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Description',
   PRIMARY KEY (`setting_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Customer Rules' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 72crm_admin_config
-- ----------------------------
INSERT INTO `72crm_admin_config` VALUES (1, 1,'customerPoolSetting','','Customer high seas rule setting');
INSERT INTO `72crm_admin_config` VALUES (2, 1,'expiringContractDays', '24','Contract expiration reminder');
INSERT INTO `72crm_admin_config` VALUES (3, 0,'customerPoolSettingDealDays', '3','Customer high seas rule setting unsettled days');
INSERT INTO `72crm_admin_config` VALUES (4, 0,'customerPoolSettingFollowupDays', '31','Customer high seas rule setting has not followed up days');
INSERT INTO `72crm_admin_config` VALUES (5, 0,'followRecordOption','call','follow up record option');
INSERT INTO `72crm_admin_config` VALUES (6, 0,'followRecordOption','Send SMS','Follow up record option');
INSERT INTO `72crm_admin_config` VALUES (7, 0,'followRecordOption','home visit','follow-up record option');
INSERT INTO `72crm_admin_config` VALUES (18, 1,'putInPoolRemindDays', '2', NULL);
INSERT INTO `72crm_admin_config` VALUES (21, 1,'oa', '1','office management');
INSERT INTO `72crm_admin_config` VALUES (22, 1,'crm', '1','Customer Management');
INSERT INTO `72crm_admin_config` VALUES (23, 1,'project', '1','project management');
INSERT INTO `72crm_admin_config` VALUES (24, 0,'hrm', '2','human resource management');
INSERT INTO `72crm_admin_config` VALUES (25, 0,'jxc', '2','Invoicing management');

-- ----------------------------
-- Table structure for 72crm_admin_dept
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_dept`;
CREATE TABLE `72crm_admin_dept` (
   `dept_id` int(11) NOT NULL AUTO_INCREMENT,
   `pid` int(11) NULL DEFAULT 0 COMMENT'Parent ID top-level department is 0',
   `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'department name',
   `num` int(4) NULL DEFAULT NULL COMMENT'The bigger the order, the lower the order',
   `remark` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'Department Remarks',
   PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Department Table' ROW_FORMAT = Dynamic;
-- ----------------------------
-- Records of 72crm_admin_dept
-- ----------------------------
INSERT INTO `72crm_admin_dept` VALUES (1, 0,'office', NULL, NULL);

-- ----------------------------
-- Table structure for 72crm_admin_examine
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_examine`;
CREATE TABLE `72crm_admin_examine` (
  `examine_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_type` int(1) NOT NULL DEFAULT 1 COMMENT '1 Contract 2 Repayment',
  `examine_type` int(1) NULL DEFAULT NULL COMMENT'Audit type 1 Fixed approval 2 Authorized approval',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Approval flow name',
  `dept_ids` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT'Department ID (0 is all)',
  `user_ids` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT'Employee ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
  `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT'creator',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT'modification time',
  `update_user_id` bigint(20) NULL DEFAULT NULL COMMENT'modify person',
  `status` int(1) NULL DEFAULT NULL COMMENT'Status 1 enabled 0 disabled 2 deleted',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Process description',
  PRIMARY KEY (`examine_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Approval Process Table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 72crm_admin_examine
-- ----------------------------
INSERT INTO `72crm_admin_examine` VALUES (1, 2, 2,'Payment approval process', NULL, NULL, '2019-05-11 16:27:35', 3, '2019-05-11 16:27:35 ', 3, 1,'');
INSERT INTO `72crm_admin_examine` VALUES (2, 1, 2,'Contract approval process', NULL, NULL, '2019-05-11 16:27:11', 3, '2019-05-11 16:27:44' , 3, 1,'Description');

-- ----------------------------
-- Table structure for 72crm_admin_examine_log
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_examine_log`;
CREATE TABLE `72crm_admin_examine_log` (
  `log_id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT'ID',
  `record_id` int(11) NULL DEFAULT NULL COMMENT'Approval record ID',
  `examine_step_id` bigint(20) NULL DEFAULT NULL COMMENT'review step ID',
  `examine_status` int(1) NULL DEFAULT NULL COMMENT'audit status 0 unaudited 1 audit passed 2 audit rejected 3 audit withdrawn',
  `create_user` bigint(11) NULL DEFAULT NULL COMMENT'creator',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
  `examine_user` bigint(20) NULL DEFAULT NULL COMMENT'reviewer',
  `examine_time` datetime(0) NULL DEFAULT NULL COMMENT'review time',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Remarks for review',
  `is_recheck` int(1) NULL DEFAULT 0 COMMENT'Whether it is to withdraw the previous log 0 or null as the new data 1: Withdraw the previous data',
  `order_id` int(30) NULL DEFAULT NULL,
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Audit log table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_admin_examine_record
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_examine_record`;
CREATE TABLE `72crm_admin_examine_record` (
   `record_id` int(11) NOT NULL AUTO_INCREMENT COMMENT'audit record ID',
   `examine_id` int(11) NULL DEFAULT NULL COMMENT'Approval ID',
   `examine_step_id` bigint(20) NULL DEFAULT NULL COMMENT'ID of the current approval step',
   `examine_status` int(1) NULL DEFAULT NULL COMMENT'Audit status 0 Unaudited 1 Audit passed 2 Audit rejected 3 Under audit 4 Withdrawn',
   `create_user` bigint(20) NULL DEFAULT NULL COMMENT'creator',
   `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
   `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Remarks for review',
   PRIMARY KEY (`record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Audit record table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_admin_examine_step
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_examine_step`;
CREATE TABLE `72crm_admin_examine_step` (
   `step_id` bigint(20) NOT NULL AUTO_INCREMENT,
   `step_type` int(1) NULL DEFAULT NULL COMMENT'Step type 1, the person in charge, 2, the designated user (any one), 3, the designated user (multi-person countersign), 4, the supervisor of the superior approver',
   `examine_id` int(11) NOT NULL COMMENT'Approval ID',
   `check_user_id` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Approver ID (separated by commas) ,1,2,',
   `step_num` int(2) NULL DEFAULT 1 COMMENT'sort',
   `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
   `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Remarks',
   PRIMARY KEY (`step_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Approval step table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_admin_field
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_field`;
CREATE TABLE `72crm_admin_field` (
  `field_id` int(11) NOT NULL AUTO_INCREMENT COMMENT'primary key ID',
  `field_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Custom field English ID',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT'' COMMENT'Field name',
  `type` int(2) NOT NULL DEFAULT 1 COMMENT'Field type 1 Single line of text 2 Multiple lines of text 3 Single selection 4 Date 5 Number 6 Decimal 7 Mobile phone 8 File 9 Multiple selection 10 Personnel 11 Attachment 12 Department 13 Date and time 14 Email 15 Customer 16 Business Opportunity 17 Contact Person 18 Map 19 Product Type 20 Contract 21 Repayment Plan',
  `label` int(2) NOT NULL COMMENT'Label 1 Lead 2 Customer 3 Contact 4 Product 5 Business Opportunity 6 Contract 7 Repayment 8. Repayment plan',
  `remark` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Field description',
  `input_tips` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'input tips',
  `max_length` int(12) NULL DEFAULT NULL COMMENT'maximum length',
  `default_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'default value',
  `is_unique` int(1) NULL DEFAULT 0 COMMENT'is it unique 1 is 0 no',
  `is_null` int(1) NULL DEFAULT 0 COMMENT'Is it required 1 Yes 0 No',
  `sorting` int(5) NULL DEFAULT 1 COMMENT'Sort from small to large',
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT'If the type is an option, this cannot be empty. Multiple options are separated by',
  `operating` int(1) NULL DEFAULT 0 COMMENT'Is it possible to delete and modify 0 Change and delete 1 Change 2 and delete 3 None',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT'last modified time',
  `examine_category_id` int(11) NULL DEFAULT NULL COMMENT'Approval ID label is 10 required',
  `field_type` int(2) NOT NULL DEFAULT 0 COMMENT'Whether it is a custom field 0. Custom 1. Fixed',
  `relevant` int(11) NULL DEFAULT NULL COMMENT'Only for clues, replace the customer\'s custom field ID',
  PRIMARY KEY (`field_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 98 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Custom field table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 72crm_admin_field
-- ----------------------------
INSERT INTO `72crm_admin_field` VALUES (1,'leads_name','Leads name', 1, 1, NULL, NULL, 255,'', 1, 1, 0, NULL, 1, '2019-07-02 09:10 :19', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (2,'lead_source','Lead source', 3, 1, NULL, NULL, NULL,'', 0, 0, 1,'Promotion, search engine, advertising, referral, line Online registration, online inquiry, appointment appointment, telephone consultation, email consultation', 1, '2019-07-02 09:10:19', NULL, 0, NULL);
INSERT INTO `72crm_admin_field` VALUES (3,'telephone','Telephone', 1, 1, NULL, NULL, 255,'', 0, 0, 2, NULL, 1, '2019-07-02 09:10: 19', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (4,'mobile','Mobile', 7, 1, NULL, NULL, 255,'', 0, 0, 3, NULL, 1, '2019-07-02 09:10: 19', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (5,'customer_industry','Customer Industry', 3, 1, NULL, NULL, NULL,'', 0, 0, 4,'IT, financial industry, real estate, business services, transportation Logistics, production, government, cultural media', 1, '2019-07-02 09:10:19', NULL, 0, NULL);
INSERT INTO `72crm_admin_field` VALUES (6,'customer_level','Customer level', 3, 1, NULL, NULL, NULL,'', 0, 0, 5,'A (key customer), B (general customer) ,C (non-priority customers)', 1, '2019-07-02 09:10:19', NULL, 0, NULL);
INSERT INTO `72crm_admin_field` VALUES (7,'address','Address', 1, 1, NULL, NULL, 255,'', 0, 0, 6, NULL, 1, '2019-07-02 09:10: 19', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (8,'next_time','Next contact time', 13, 1, NULL, NULL, NULL,'', 0, 0, 7, NULL, 1, '2019-07-02 09 :10:19', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (9,'remark','Remark', 1, 1, NULL, NULL, 255,'', 0, 0, 8, NULL, 1, '2019-07-02 09:10: 19', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (10,'customer_name','Customer name', 1, 2, NULL, NULL, 255,'', 1, 1, 0, NULL, 1, '2019-07-02 09:10 :41', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (11,'mobile','Mobile', 7, 2, NULL, NULL, 255,'', 0, 0, 1, NULL, 1, '2019-07-02 09:10: 41', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (12,'telephone','Telephone', 1, 2, NULL, NULL, 255,'', 0, 0, 2, NULL, 1, '2019-07-02 09:10: 41', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (13,'website','URL', 1, 2, NULL, NULL, 255,'', 0, 0, 6, NULL, 1, '2019-07-02 09:10: 41', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (15,'next_time','Next contact time', 13, 2, NULL, NULL, NULL,'', 0, 0, 8, NULL, 1, '2019-07-02 09 :10:41', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (16,'remark','Remark', 1, 2, NULL, NULL, 255,'', 0, 0, 9, NULL, 1, '2019-07-02 09:10: 41', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (17,'customer_level','Customer level', 3, 2, NULL, NULL, NULL,'', 0, 0, 5,'A (key customer), B (general customer) ,C (non-priority customers)', 1, '2019-07-02 09:10:41', NULL, 0, NULL);
INSERT INTO `72crm_admin_field` VALUES (18,'customer_source','Customer source', 3, 2, NULL, NULL, NULL,'', 0, 0, 3,'Promotion, search engine, advertising, referral, online Online registration, online inquiry, appointment appointment, Mobai, telephone consultation, email consultation', 1, '2019-07-02 09:10:41', NULL, 0, NULL);
INSERT INTO `72crm_admin_field` VALUES (19,'customer_industry','Customer Industry', 3, 2, NULL, NULL, NULL,'', 0, 0, 4,'IT, financial industry, real estate, business services, transportation Logistics, production, government, cultural media', 1, '2019-07-02 09:10:41', NULL, 0, NULL);
INSERT INTO `72crm_admin_field` VALUES (20,'name','Name', 1, 3, NULL, NULL, 255,'', 0, 1, 0, NULL, 1, '2019-07-01 17:10: 21', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (21,'customer_id','Customer name', 15, 3, NULL, NULL, NULL,'', 0, 0, 1, NULL, 3, '2019-07-01 17:13 :28', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (22,'mobile','Mobile', 7, 3, NULL, NULL, 255,'', 0, 0, 2, NULL, 1, '2019-07-01 17:10: 21', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (23,'telephone','Telephone', 1, 3, NULL, NULL, 255,'', 0, 0, 3, NULL, 1, '2019-07-01 17:10: 21', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (24,'email','Email', 14, 3, NULL, NULL, 255,'', 0, 0, 4, NULL, 1, '2019-07-01 17:10 :21', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (25,'post','Post', 1, 3, NULL, NULL, 255,'', 0, 0, 5, NULL, 1, '2019-07-01 17:10: 21', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (26,'address','Address', 1, 3, NULL, NULL, 255,'', 0, 0, 6, NULL, 1, '2019-07-01 17:10: 21', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (27,'next_time','Next contact time', 13, 3, NULL, NULL, NULL,'', 0, 0, 7, NULL, 1, '2019-07-01 17 :10:21', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (28,'remark','Remark', 1, 3, NULL, NULL, 255,'', 0, 0, 8, NULL, 1, '2019-07-01 17:10: 21', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (29,'key_decision_maker', 'Key decision maker', 3, 3, NULL, NULL, NULL,'', 0, 0, 9,'Yes, No', 3, '2019-07-01 17:10:21', NULL, 0, NULL);
INSERT INTO `72crm_admin_field` VALUES (30,'sex','Sex', 3, 3, NULL, NULL, NULL,'', 0, 0, 10,'Male, Female', 3, '2019-07-01 17:10:21', NULL, 0, NULL);
INSERT INTO `72crm_admin_field` VALUES (31,'name','Product name', 1, 4, NULL, NULL, 255,'', 0, 0, 0, NULL, 1, '2019-07-01 17:22 :28', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (32,'category_id','Product type', 19, 4, NULL, NULL, NULL,'', 0, 1, 1, NULL, 3, '2019-07-01 17:55 :24', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (33,'num','Product code', 1, 4, NULL, NULL, 255,'', 1, 1, 2, NULL, 1, '2019-07-01 17:22 :28', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (34,'price','Price', 6, 4, NULL, NULL, 255,'', 0, 1, 3, NULL, 1, '2019-07-01 17:57: 01', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (35,'description','Product description', 1, 4, NULL, NULL, 255,'', 0, 0, 4, NULL, 1, '2019-07-01 17:22 :28', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (36,'on_or_off_the_shelf','On or off the shelf', 3, 4, NULL, NULL, NULL,'on', 0, 1, 5, 'on, off, delete', 3, '2019-07-01 17:22:28', NULL, 0, NULL);
INSERT INTO `72crm_admin_field` VALUES (37,'unit','Unit', 3, 4, NULL, NULL, NULL,'', 0, 0, 6,'piece, block, only, handle, bottle, ton, kg, m, box, set', 1, '2019-07-01 17:22:28', NULL, 0, NULL);
INSERT INTO `72crm_admin_field` VALUES (38,'business_name','Business name', 1, 5, NULL, NULL, 255,'', 0, 0, 0, NULL, 3, '2019-07-01 17:10 :31', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (39,'customer_id','Customer name', 15, 5, NULL, NULL, NULL,'', 0, 1, 1, NULL, 3, '2019-07-01 17:13 :25', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (40,'money','Opportunity amount', 6, 5, NULL, NULL, 255,'', 0, 0, 2, NULL, 1, '2019-07-01 17:10 :31', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (41,'deal_date','Expected deal date', 13, 5, NULL, NULL, NULL,'', 0, 0, 3, NULL, 1, '2019-07-01 17: 10:31', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (42,'remark','Remarks', 1, 5, NULL, NULL, 255,'', 0, 0, 4, NULL, 1, '2019-07-01 17:10: 31', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (43,'num','Contract number', 1, 6, NULL, NULL, 255,'', 1, 1, 0, NULL, 1, '2019-07-01 17:10 :34', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (44,'name','Contract name', 1, 6, NULL, NULL, 255,'', 0, 1, 1, NULL, 1, '2019-07-01 17:10 :34', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (45,'customer_id','Customer name', 15, 6, NULL, NULL, NULL,'', 0, 1, 2, NULL, 3, '2019-07-01 17:22 :49', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (46,'business_id','Business name', 16, 6, NULL, NULL, NULL,'', 0, 0, 3, NULL, 3, '2019-07-01 17:22 :57', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (47,'order_date','Order time', 4, 6, NULL, NULL, NULL,'', 0, 0, 4, NULL, 1, '2019-07-01 17: 10:34', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (48,'money','Contract amount', 6, 6, NULL, NULL, 255,'', 0, 0, 5, NULL, 1, '2019-07-01 17:10 :34', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (49,'start_time','Contract start time', 4, 6, NULL, NULL, NULL,'', 0, 0, 6, NULL, 1, '2019-07-01 17: 10:34', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (50,'end_time','Contract end time', 4, 6, NULL, NULL, NULL,'', 0, 0, 7, NULL, 1, '2019-09-23 13: 27:41', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (51,'contacts_id','Customer Contractor', 17, 6, NULL, NULL, NULL,'', 0, 0, 8, NULL, 3, '2019-07-01 17: 23:11', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (52,'company_user_id','Company contractor', 10, 6, NULL, NULL, NULL,'', 0, 0, 9, NULL, 3, '2019-07-01 17: 10:34', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (53,'remark','Remarks', 1, 6, NULL, NULL, 255,'', 0, 0, 10, NULL, 1, '2019-07-01 17:10: 34', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (54,'number','Receipt number', 1, 7, NULL, NULL, 255,'', 0, 1, 0, NULL, 1, '2019-07-01 17: 10:36', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (55,'customer_id','Customer name', 15, 7, NULL, NULL, NULL,'', 0, 1, 1, NULL, 3, '2019-07-01 17:23 :15', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (56,'contract_id','Contract number', 20, 7, NULL, NULL, NULL,'', 0, 1, 2, NULL, 3, '2019-07-01 17:23 :24', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (57,'return_time','Return date', 4, 7, NULL, NULL, NULL,'', 0, 0, 3, NULL, 1, '2019-07-01 17: 10:36', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (58,'money','Receipt amount', 6, 7, NULL, NULL, 255,'', 0, 0, 4, NULL, 1, '2019-07-01 17: 10:36', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (59,'plan_id','Number of periods', 21, 7, NULL, NULL, NULL,'', 0, 0, 5, NULL, 3, '2019-07-01 17:23 :35', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (60,'remark','Remark', 1, 7, NULL, NULL, 255,'', 0, 0, 6, NULL, 1, '2019-07-01 17:10: 36', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (61,'payment_method','Payment method', 3, 7, NULL, NULL, NULL,'', 0, 0, 7,'Check, cash, postal remittance, wire transfer, Online transfer, Alipay, WeChat Pay, others', 1, '2019-07-01 17:10:36', NULL, 0, NULL);
INSERT INTO `72crm_admin_field` VALUES (62,'content','Approval reason', 2, 10, NULL, NULL, 0,'', 0, 1, 0, NULL, 1, '2019-06-27 14:00 :42', 7, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (63,'remark','Remark', 2, 10, NULL, NULL, 0,'', 0, 1, 1, NULL, 1, '2019-06-27 14:01: 13', 7, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (64,'single_line_of_text','Single line text', 1, 10, NULL,'', 255,'', 0, 0, 2, NULL, 0, '2019-06-29 17 :52:18', 7, 0, NULL);
INSERT INTO `72crm_admin_field` VALUES (65,'staff','Staff', 10, 10, NULL,'', NULL,'', 0, 0, 3, NULL, 0, '2019-06-29 17:52 :11', 7, 0, NULL);
INSERT INTO `72crm_admin_field` VALUES (66,'multi_line_text','Multi-line text', 2, 10, NULL,'', 1000,'', 0, 0, 4, NULL, 0, '2019-06- 29 17:52:09', 7, 0, NULL);
INSERT INTO `72crm_admin_field` VALUES (67,'attachment','Attachment', 8, 10, NULL,'', NULL,'', 0, 0, 5, NULL, 0, '2019-06-29 17:52 :01', 7, 0, NULL);
INSERT INTO `72crm_admin_field` VALUES (68,'customer_id','Customer name', 15, 8, NULL, NULL, NULL,'', 0, 0, 1, NULL, 3, '2019-06-28 16:52 :13', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (69,'contract_id','Contract number', 20, 8, NULL, NULL, 11,'', 0, 0, 2, NULL, 3, '2019-06-28 16:55 :17', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (70,'money','Planned payment amount', 6, 8, NULL, NULL, NULL,'', 0, 0, 3, NULL, 3, '2019-06-28 16 :53:04', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (71,'return_date','Planned return date', 4, 8, NULL, NULL, NULL,'', 0, 0, 4, NULL, 3, '2019-06-28 16 :54:01', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (72,'remind','Remind a few days in advance', 5, 8, NULL, NULL, 11,'', 0, 0, 5, NULL, 3, '2019-06-28 16 :55:13', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (73,'remark','remark', 2, 8, NULL, NULL, 1000,'', 0, 0, 6, NULL, 3, '2019-06-28 16:55: 07', NULL, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (74,'content','Approval content', 1, 10, NULL,'', NULL,'', 0, 1, 0, NULL, 3, NULL, 1, 1, NULL) ;
INSERT INTO `72crm_admin_field` VALUES (75,'remark','Remark', 2, 10, NULL,'', 1000,'', 0, 0, 1, NULL, 3, NULL, 1, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (76,'type_id','Type of leave', 3, 10, NULL,'', NULL,'annual leave', 0, 1, 0,'annual leave, personal leave, sick leave, maternity leave, adjusted leave ,Marriage leave, funeral leave, other', 3, NULL, 2, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (77,'content','Approval content', 1, 10, NULL,'', NULL,'', 0, 1, 1, NULL, 3, NULL, 2, 1, NULL) ;
INSERT INTO `72crm_admin_field` VALUES (78,'start_time','Start time', 13, 10, NULL,'', NULL,'', 0, 1, 2, NULL, 3, NULL, 2, 1, NULL) ;
INSERT INTO `72crm_admin_field` VALUES (79,'end_time','End time', 13, 10, NULL,'', NULL,'', 0, 1, 3, NULL, 3, NULL, 2, 1, NULL) ;
INSERT INTO `72crm_admin_field` VALUES (80,'duration','Duration', 6, 10, NULL,'', NULL,'', 0, 1, 4, NULL, 3, NULL, 2, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (81,'remark','Remark', 2, 10, NULL,'', 1000,'', 0, 0, 5, NULL, 3, NULL, 2, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (82,'content','Business trip reason', 1, 10, NULL,'', NULL,'', 0, 1, 0, NULL, 3, '2019-06-30 18: 13:08', 3, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (83,'remark','Remark', 2, 10, NULL,'', 1000,'', 0, 0, 1, NULL, 3, '2019-06-30 18:13 :08', 3, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (84,'duration','Total days on business trip', 6, 10, NULL,'', NULL,'', 0, 1, 2, NULL, 3, '2019-06-30 18 :13:08', 3, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (85,'cause','Itinerary details', 22, 10, NULL,'', NULL,'', 0, 1, 2, NULL, 3, '2019-06-30 18: 13:08', 3, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (86,'content','Reason for overtime', 1, 10, NULL,'', NULL,'', 0, 1, 0, NULL, 3, '2019-06-30 18: 13:08', 4, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (87,'start_time','Start time', 13, 10, NULL,'', NULL,'', 0, 1, 1, NULL, 3, '2019-06-30 18: 13:08', 4, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (88,'end_time','End time', 13, 10, NULL,'', NULL,'', 0, 1, 2, NULL, 3, '2019-06-30 18: 13:08', 4, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (89,'duration','Total days of overtime', 6, 10, NULL,'', NULL,'', 0, 1, 3, NULL, 3, '2019-06-30 18 :13:08', 4, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (90,'remark','Remark', 2, 10, NULL,'', 1000,'', 0, 0, 4, NULL, 3, '2019-06-30 18:13 :08', 4, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (91,'content','Travel matter', 1, 10, NULL,'', NULL,'', 0, 1, 0, NULL, 3, '2019-06-30 18 :13:08', 5, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (92,'money','Total reimbursement amount', 6, 10, NULL,'', 0,'', 0, 1, 1, NULL, 3, '2019-06-30 18 :13:08', 5, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (93,'remark','Remark', 2, 10, NULL,'', 1000,'', 0, 0, 2, NULL, 3, '2019-06-30 18:13 :08', 5, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (94,'cause','Cost details', 23, 10, NULL,'', 1000,'', 0, 0, 2, NULL, 3, '2019-06-30 18: 13:08', 5, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (95,'content','Reason for borrowing', 1, 10, NULL,'', NULL,'', 0, 1, 0, NULL, 3, '2019-06-30 18: 13:08', 6, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (96,'money','Loan amount (đồng)', 6, 10, NULL,'', 0,'', 0, 1, 1, NULL, 3, '2019-06- 30 18:13:08', 6, 1, NULL);
INSERT INTO `72crm_admin_field` VALUES (97,'remark','Remark', 2, 10, NULL,'', 1000,'', 0, 0, 2, NULL, 3, '2019-06-30 18:13 :08', 6, 1, NULL);

-- ----------------------------
-- Table structure for 72crm_admin_field_sort
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_field_sort`;
CREATE TABLE `72crm_admin_field_sort` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT'field id',
  `label` int(2) NOT NULL COMMENT'Label 1 Lead 2 Customer 3 Contact 4 Product 5 Business Opportunity 6 Contract 7 Repayment 8 High Seas',
  `field_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'field name',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'Field Chinese name',
  `type` int(2) NULL DEFAULT NULL COMMENT'Field type 1 Single line of text 2 Multiple lines of text 3 Single selection 4 Date 5 Number 6 Decimal 7 Mobile phone 8 File 9 Multiple selection 10 Personnel 11 Attachment 12 Department 13 Date and time 14 Email 15 Customer 16 Business Opportunities 17 Contacts 18 Map 19 Product Type 20 Contract 21 Repayment Plan',
  `sort` int(5) NOT NULL DEFAULT 0 COMMENT'Field sort',
  `user_id` bigint(20) NOT NULL DEFAULT 0 COMMENT'user id',
  `is_hide` int(1) NOT NULL DEFAULT 1 COMMENT'Whether to hide 0, not hide 1, hide',
  `field_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Field sorting table' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for 72crm_admin_field_style
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_field_style`;
CREATE TABLE `72crm_admin_field_style` (
   `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT'style sheet id',
   `style` int(5) NULL DEFAULT NULL COMMENT'Field width',
   `type` int(2) NULL DEFAULT NULL COMMENT'Field Type\'1 Lead 2 Customer 3 Contact 4 Product 5 Business Opportunity 6 Contract 7 Repayment 8 High Seas\'',
   `field_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'field name',
   `user_id` bigint(20) NULL DEFAULT NULL COMMENT'user id',
   `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
   `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT'update time',
   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Field style sheet' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_admin_fieldv
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_fieldv`;
CREATE TABLE `72crm_admin_fieldv` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `field_id` int(11) NULL DEFAULT NULL,
   `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'field name',
   `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
   `create_time` datetime(0) NULL DEFAULT NULL,
   `batch_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
   PRIMARY KEY (`id`) USING BTREE,
   INDEX `batch_id`(`batch_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Custom field value' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_admin_file
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_file`;
CREATE TABLE `72crm_admin_file`  (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'accessory name',
  `size` int(10) NOT NULL COMMENT 'Attachment size (bytes)',
  `create_user_id` bigint(20) NOT NULL COMMENT 'Creator ID',
  `create_time` datetime(0) NOT NULL COMMENT 'Creation time',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'File real path',
  `file_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'file path',
  `file_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'file' COMMENT 'file type',
  `batch_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Batch id',
  PRIMARY KEY (`file_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Annex table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_menu`;
CREATE TABLE `72crm_admin_menu`  (
  `menu_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Menu ID',
  `parent_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT 'Upper menu ID',
  `menu_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'Menu name',
  `realm` varchar(127) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'link address',
  `menu_type` int(1) NULL DEFAULT NULL COMMENT 'Menu type 1 Menu 2 Menu 3 Button 4 Special',
  `sort` int(4) UNSIGNED NULL DEFAULT 0 COMMENT 'Sort (valid at the same level)',
  `status` int(4) NULL DEFAULT 1 COMMENT 'State 1 enabled 0 disabled',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Menu description',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 193 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Backstage menu table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 72crm_admin_menu
-- ----------------------------
INSERT INTO `72crm_admin_menu` VALUES (1, 0,'all','crm', 0, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (2, 0,'all','bi', 0, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (3, 0,'all','manage', 0, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (9, 1,'lead management','leads', 1, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (10, 1,'Customer Management','customer', 1, 2, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (11, 1,'Contact Management','contacts', 1, 3, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (12, 1,'Business Opportunity Management','business', 1, 4, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (13, 1,'Contract Management','contract', 1, 5, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (14, 1,'Receipt management','receivables', 1, 6, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (15, 1,'Product Management','product', 1, 7, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (17, 9,'New','save', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (18, 9,'Edit','update', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (19, 9,'View list','index', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (20, 9,'View details','read', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (21, 9,'import','excelimport', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (22, 9,'Export','excelexport', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (23, 9,'delete','delete', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (24, 9,'transfer','transfer', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (25, 9,'transform','transform', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (26, 10,'New','save', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (27, 10,'Edit','update', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (28, 10,'View list','index', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (29, 10,'View details','read', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (30, 10,'import','excelimport', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (31, 10,'export','excelexport', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (32, 10,'delete','delete', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (33, 10,'transfer','transfer', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (34, 10,'putinpool','putinpool', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (35, 10,'lock/unlock','lock', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (36, 10,'Edit team members','teamsave', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (40, 11,'New','save', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (41, 11,'Edit','update', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (42, 11,'View list','index', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (43, 11,'View details','read', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (44, 11,'delete','delete', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (45, 11,'transfer','transfer', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (46, 12,'New','save', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (47, 12,'Edit','update', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (48, 12,'View list','index', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (49, 12,'View details','read', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (50, 12,'delete','delete', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (51, 12,'transfer','transfer', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (52, 12,'Edit team members','teamsave', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (53, 13,'New','save', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (54, 13,'Edit','update', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (55, 13,'View list','index', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (56, 13,'View details','read', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (57, 13,'delete','delete', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (58, 13,'transfer','transfer', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (59, 13,'Edit team members','teamsave', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (60, 14,'New','save', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (61, 14,'Edit','update', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (62, 14,'View list','index', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (63, 14,'View details','read', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (64, 14,'delete','delete', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (65, 15,'New','save', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (66, 15,'Edit','update', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (67, 15,'View list','index', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (68, 15,'View details','read', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (69, 15,'On/Off','status', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (97, 2,'achievement goal achievement','achievement', 1, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (98, 2,'Sales funnel','business', 1, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (99, 2,'Employee Customer Analysis','customer', 1, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (101, 2,'employee performance analysis','contract', 1, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (102, 97,'View','read', 3, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (103, 98,'View','read', 3, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (104, 99,'View','read', 3, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (106, 101,'View','read', 3, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (107, 11,'Contact Export','excelexport', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (108, 11,'Contact import','excelimport', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (109, 15,'product import','excelimport', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (110, 15,'product export','excelexport', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (117, 2,'Product Analysis','product', 1, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (118, 117,'View','read', 3, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (123, 2,'Customer Portrait Analysis','portrait', 1, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (124, 123,'View','read', 3, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (125, 2,'ranking','ranking', 1, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (126, 125,'View','read', 3, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (127, 1,'High Seas Management','pool', 1, 4, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (128, 127,'View list','index', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (129, 127,'distribution','distribute', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (130, 127,'Receive','receive', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (131, 127,'Export','excelexport', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (137, 0,'Project Management','work', 0, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (138, 137,'task','task', 1, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (139, 138,'Create','save', 3, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (140, 137,'task list','taskClass', 1, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (141, 140,'New task list','save', 3, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (142, 140,'Edit task list','update', 3, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (143, 140,'Delete task list','delete', 3, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (144, 137,'Project','work', 1, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (145, 144,'Project Settings','update', 3, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (146, 2,'Office Analysis','oa', 1, 10, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (147, 146,'View','read', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (148, 0,'all','oa', 0, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (149, 0,'all','project', 0, 0, 1,'project management role permissions');
INSERT INTO `72crm_admin_menu` VALUES (150, 148,'Address Book','book', 1, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (151, 150,'View','read', 3, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (152, 149,'Project Management','projectManage', 1, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (153, 152,'New Project','save', 3, 2, 1,'projectSave');
INSERT INTO `72crm_admin_menu` VALUES (160, 3,'Enterprise Homepage','system', 1, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (161, 160,'View','read', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (162, 160,'Edit','update', 3, 2, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (163, 3,'Application Management','configSet', 1, 2, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (164, 163,'View','read', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (165, 163,'Disable/Enable','update', 3, 2, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (166, 3,'Employee and Department Management','users', 1, 3, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (167, 166,'Department/Employee View','read', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (168, 166,'Employee New','userSave', 3, 2, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (169, 166,'Employee Disable/Activate','userEnables', 3, 3, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (170, 166,'Employee Operation','userUpdate', 3, 4, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (171, 166,'Department New','deptSave', 3, 5, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (172, 166,'Department Edit','deptUpdate', 3, 6, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (173, 166,'department delete','deptDelete', 3, 7, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (174, 3,'Role authority management','permission', 1, 4, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (175, 174,'Role permission settings','update', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (176, 3,'Workbench Settings','oa', 1, 5, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (177, 176,'Office Approval Management','examine', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (178, 3,'Approval Process Management','examineFlow', 1, 6, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (179, 178,'Approval process management','update', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (180, 3,'Customer Management Settings','crm', 1, 7, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (181, 180,'Custom field settings','field', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (182, 180,'Customer High Seas Rules','pool', 3, 2, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (183, 180,'Business parameter settings','setting', 3, 3, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (184, 180,'Performance goal setting','achievement', 3, 4, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (185, 3,'Project Management Settings','work', 1, 8, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (186, 185,'Project Management','update', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (187, 148,'announcement','announcement', 1, 2, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (188, 187,'New','save', 3, 1, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (189, 187,'Edit','update', 3, 2, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (190, 187,'delete','delete', 3, 3, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (191, 10,'Set deal status','dealStatus', 3, 0, 1, NULL);
INSERT INTO `72crm_admin_menu` VALUES (192, 13,'Contract voided','discard', 3, 1, 1, NULL);

-- ----------------------------
-- Table structure for 72crm_admin_message
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_message`;
CREATE TABLE `72crm_admin_message` (
  `message_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT'message ID',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'message title',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'content',
  `label` int(2) NULL DEFAULT NULL COMMENT'message category 1 task 2 log 3 oa approval 4 announcement 5 schedule 6 crm message',
  `type` int(2) NULL DEFAULT NULL COMMENT'Message type, see AdminMessageEnum',
  `type_id` int(11) NULL DEFAULT NULL COMMENT'association ID',
  `create_user` bigint(20) NOT NULL COMMENT'Message creator 0 is the system',
  `recipient_user` bigint(20) NOT NULL COMMENT'recipient',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
  `is_read` int(1) NULL DEFAULT 0 COMMENT'Whether it has been read 0 unread 1 read',
  `read_time` datetime(0) NULL DEFAULT NULL COMMENT'Read time',
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='System Message Table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_admin_record
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_record`;
CREATE TABLE `72crm_admin_record` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `types` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'association type',
  `types_id` int(11) NOT NULL COMMENT'type ID',
  `content` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'Follow-up content',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'follow-up type',
  `next_time` datetime(0) NULL DEFAULT NULL COMMENT'Next contact time',
  `business_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Business Opportunity ID',
  `contacts_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Contact ID',
  `create_time` datetime(0) NOT NULL COMMENT'create time',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
  `create_user_id` bigint(20) NOT NULL COMMENT'creator ID',
  `batch_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Batch such as attachment batch',
  PRIMARY KEY (`record_id`) USING BTREE,
  UNIQUE INDEX `record_id`(`record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Follow-up record' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_role`;
CREATE TABLE `72crm_admin_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'name',
  `role_type` int(11) NULL DEFAULT NULL COMMENT '0, custom role 1, management role 2, customer management role 3, personnel role 4, financial role 5, project role 6, project custom role 7, office role 8, Project management role',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Remarks',
  `status` int(3) NULL DEFAULT 1 COMMENT '1 enable 0 disable',
  `data_type` int(1) NOT NULL DEFAULT 5 COMMENT'Data permission 1, myself, 2, myself and subordinates, 3. this department, 4. this department and subordinate departments, 5, all',
  `is_hidden` int(1) NOT NULL DEFAULT 1 COMMENT '0 hidden 1 not hidden',
  `label` int(2) NULL DEFAULT NULL COMMENT '1 System project administrator role 2 Project management role 3 Project editor role 4 Project read-only role',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Role Table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 72crm_admin_role
-- ----------------------------
INSERT INTO `72crm_admin_role` VALUES (1,'Super Administrator', 1,'admin', 1, 5, 1, NULL);
INSERT INTO `72crm_admin_role` VALUES (2,'System Settings Administrator', 1, NULL, 1, 2, 1, NULL);
INSERT INTO `72crm_admin_role` VALUES (3,'Department and employee administrators', 1, NULL, 1, 5, 1, NULL);
INSERT INTO `72crm_admin_role` VALUES (4,'Approval flow administrator', 1, NULL, 1, 5, 1, NULL);
INSERT INTO `72crm_admin_role` VALUES (5,'Workbench Administrator', 1, NULL, 1, 5, 1, NULL);
INSERT INTO `72crm_admin_role` VALUES (6,'Customer Administrator', 1, NULL, 1, 5, 1, NULL);
INSERT INTO `72crm_admin_role` VALUES (7,'Announcement Administrator', 7, NULL, 1, 5, 1, NULL);
INSERT INTO `72crm_admin_role` VALUES (8,'Sales Manager Role', 2, NULL, 1, 2, 1, NULL);
INSERT INTO `72crm_admin_role` VALUES (9,'Administrative management', 2, NULL, 1, 1, 1, NULL);
INSERT INTO `72crm_admin_role` VALUES (10,'Financial roles', 2, NULL, 1, 1, 1, NULL);
INSERT INTO `72crm_admin_role` VALUES (11,'Salesperson Role', 2, NULL, 1, 2, 1, NULL);
INSERT INTO `72crm_admin_role` VALUES (12,'Project Administrator', 8,'project', 1, 5, 1, 1);
INSERT INTO `72crm_admin_role` VALUES (13,'Administration', 5,'', 1, 5, 0, 2);
INSERT INTO `72crm_admin_role` VALUES (14,'Edit', 5, NULL, 1, 5, 1, 3);
INSERT INTO `72crm_admin_role` VALUES (15,'Read Only', 5, NULL, 1, 5, 1, 4);
INSERT INTO `72crm_admin_role` VALUES (47,'Test item', 8, NULL, 1, 5, 1, NULL);

-- ----------------------------
-- Table structure for 72crm_admin_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_role_menu`;
CREATE TABLE `72crm_admin_role_menu` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `role_id` int(11) NOT NULL COMMENT'role ID',
   `menu_id` int(11) NOT NULL COMMENT'Menu ID',
   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 122 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Character menu correspondence table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 72crm_admin_role_menu
-- ----------------------------
INSERT INTO `72crm_admin_role_menu` VALUES (1, 14, 139);
INSERT INTO `72crm_admin_role_menu` VALUES (2, 14, 141);
INSERT INTO `72crm_admin_role_menu` VALUES (3, 14, 142);
INSERT INTO `72crm_admin_role_menu` VALUES (4, 14, 143);
INSERT INTO `72crm_admin_role_menu` VALUES (5, 3, 166);
INSERT INTO `72crm_admin_role_menu` VALUES (6, 3, 167);
INSERT INTO `72crm_admin_role_menu` VALUES (7, 3, 168);
INSERT INTO `72crm_admin_role_menu` VALUES (8, 3, 169);
INSERT INTO `72crm_admin_role_menu` VALUES (9, 3, 170);
INSERT INTO `72crm_admin_role_menu` VALUES (10, 3, 171);
INSERT INTO `72crm_admin_role_menu` VALUES (11, 3, 172);
INSERT INTO `72crm_admin_role_menu` VALUES (12, 3, 173);
INSERT INTO `72crm_admin_role_menu` VALUES (13, 4, 178);
INSERT INTO `72crm_admin_role_menu` VALUES (14, 4, 179);
INSERT INTO `72crm_admin_role_menu` VALUES (15, 5, 176);
INSERT INTO `72crm_admin_role_menu` VALUES (16, 5, 177);
INSERT INTO `72crm_admin_role_menu` VALUES (17, 6, 180);
INSERT INTO `72crm_admin_role_menu` VALUES (18, 6, 181);
INSERT INTO `72crm_admin_role_menu` VALUES (19, 6, 182);
INSERT INTO `72crm_admin_role_menu` VALUES (20, 6, 183);
INSERT INTO `72crm_admin_role_menu` VALUES (21, 6, 184);
INSERT INTO `72crm_admin_role_menu` VALUES (22, 7, 187);
INSERT INTO `72crm_admin_role_menu` VALUES (23, 7, 188);
INSERT INTO `72crm_admin_role_menu` VALUES (24, 7, 189);
INSERT INTO `72crm_admin_role_menu` VALUES (25, 7, 190);
INSERT INTO `72crm_admin_role_menu` VALUES (26, 2, 3);
INSERT INTO `72crm_admin_role_menu` VALUES (27, 2, 160);
INSERT INTO `72crm_admin_role_menu` VALUES (28, 2, 161);
INSERT INTO `72crm_admin_role_menu` VALUES (29, 2, 162);
INSERT INTO `72crm_admin_role_menu` VALUES (30, 2, 163);
INSERT INTO `72crm_admin_role_menu` VALUES (31, 2, 164);
INSERT INTO `72crm_admin_role_menu` VALUES (32, 2, 165);
INSERT INTO `72crm_admin_role_menu` VALUES (33, 2, 166);
INSERT INTO `72crm_admin_role_menu` VALUES (34, 2, 167);
INSERT INTO `72crm_admin_role_menu` VALUES (35, 2, 168);
INSERT INTO `72crm_admin_role_menu` VALUES (36, 2, 169);
INSERT INTO `72crm_admin_role_menu` VALUES (37, 2, 170);
INSERT INTO `72crm_admin_role_menu` VALUES (38, 2, 171);
INSERT INTO `72crm_admin_role_menu` VALUES (39, 2, 172);
INSERT INTO `72crm_admin_role_menu` VALUES (40, 2, 173);
INSERT INTO `72crm_admin_role_menu` VALUES (41, 2, 174);
INSERT INTO `72crm_admin_role_menu` VALUES (42, 2, 175);
INSERT INTO `72crm_admin_role_menu` VALUES (43, 2, 176);
INSERT INTO `72crm_admin_role_menu` VALUES (44, 2, 177);
INSERT INTO `72crm_admin_role_menu` VALUES (45, 2, 178);
INSERT INTO `72crm_admin_role_menu` VALUES (46, 2, 179);
INSERT INTO `72crm_admin_role_menu` VALUES (47, 2, 180);
INSERT INTO `72crm_admin_role_menu` VALUES (48, 2, 181);
INSERT INTO `72crm_admin_role_menu` VALUES (49, 2, 182);
INSERT INTO `72crm_admin_role_menu` VALUES (50, 2, 183);
INSERT INTO `72crm_admin_role_menu` VALUES (51, 2, 184);
INSERT INTO `72crm_admin_role_menu` VALUES (52, 2, 185);
INSERT INTO `72crm_admin_role_menu` VALUES (53, 2, 186);
INSERT INTO `72crm_admin_role_menu` VALUES (54, 8, 1);
INSERT INTO `72crm_admin_role_menu` VALUES (55, 8, 9);
INSERT INTO `72crm_admin_role_menu` VALUES (56, 8, 17);
INSERT INTO `72crm_admin_role_menu` VALUES (57, 8, 18);
INSERT INTO `72crm_admin_role_menu` VALUES (58, 8, 19);
INSERT INTO `72crm_admin_role_menu` VALUES (59, 8, 20);
INSERT INTO `72crm_admin_role_menu` VALUES (60, 8, 21);
INSERT INTO `72crm_admin_role_menu` VALUES (61, 8, 22);
INSERT INTO `72crm_admin_role_menu` VALUES (62, 8, 23);
INSERT INTO `72crm_admin_role_menu` VALUES (63, 8, 24);
INSERT INTO `72crm_admin_role_menu` VALUES (64, 8, 25);
INSERT INTO `72crm_admin_role_menu` VALUES (65, 8, 10);
INSERT INTO `72crm_admin_role_menu` VALUES (66, 8, 26);
INSERT INTO `72crm_admin_role_menu` VALUES (67, 8, 27);
INSERT INTO `72crm_admin_role_menu` VALUES (68, 8, 28);
INSERT INTO `72crm_admin_role_menu` VALUES (69, 8, 29);
INSERT INTO `72crm_admin_role_menu` VALUES (70, 8, 30);
INSERT INTO `72crm_admin_role_menu` VALUES (71, 8, 31);
INSERT INTO `72crm_admin_role_menu` VALUES (72, 8, 32);
INSERT INTO `72crm_admin_role_menu` VALUES (73, 8, 33);
INSERT INTO `72crm_admin_role_menu` VALUES (74, 8, 34);
INSERT INTO `72crm_admin_role_menu` VALUES (75, 8, 35);
INSERT INTO `72crm_admin_role_menu` VALUES (76, 8, 36);
INSERT INTO `72crm_admin_role_menu` VALUES (77, 8, 191);
INSERT INTO `72crm_admin_role_menu` VALUES (78, 8, 11);
INSERT INTO `72crm_admin_role_menu` VALUES (79, 8, 40);
INSERT INTO `72crm_admin_role_menu` VALUES (80, 8, 41);
INSERT INTO `72crm_admin_role_menu` VALUES (81, 8, 42);
INSERT INTO `72crm_admin_role_menu` VALUES (82, 8, 43);
INSERT INTO `72crm_admin_role_menu` VALUES (83, 8, 44);
INSERT INTO `72crm_admin_role_menu` VALUES (84, 8, 45);
INSERT INTO `72crm_admin_role_menu` VALUES (85, 8, 107);
INSERT INTO `72crm_admin_role_menu` VALUES (86, 8, 108);
INSERT INTO `72crm_admin_role_menu` VALUES (87, 8, 12);
INSERT INTO `72crm_admin_role_menu` VALUES (88, 8, 46);
INSERT INTO `72crm_admin_role_menu` VALUES (89, 8, 47);
INSERT INTO `72crm_admin_role_menu` VALUES (90, 8, 48);
INSERT INTO `72crm_admin_role_menu` VALUES (91, 8, 49);
INSERT INTO `72crm_admin_role_menu` VALUES (92, 8, 50);
INSERT INTO `72crm_admin_role_menu` VALUES (93, 8, 51);
INSERT INTO `72crm_admin_role_menu` VALUES (94, 8, 52);
INSERT INTO `72crm_admin_role_menu` VALUES (95, 8, 13);
INSERT INTO `72crm_admin_role_menu` VALUES (96, 8, 53);
INSERT INTO `72crm_admin_role_menu` VALUES (97, 8, 54);
INSERT INTO `72crm_admin_role_menu` VALUES (98, 8, 55);
INSERT INTO `72crm_admin_role_menu` VALUES (99, 8, 56);
INSERT INTO `72crm_admin_role_menu` VALUES (100, 8, 57);
INSERT INTO `72crm_admin_role_menu` VALUES (101, 8, 58);
INSERT INTO `72crm_admin_role_menu` VALUES (102, 8, 59);
INSERT INTO `72crm_admin_role_menu` VALUES (103, 8, 14);
INSERT INTO `72crm_admin_role_menu` VALUES (104, 8, 60);
INSERT INTO `72crm_admin_role_menu` VALUES (105, 8, 61);
INSERT INTO `72crm_admin_role_menu` VALUES (106, 8, 62);
INSERT INTO `72crm_admin_role_menu` VALUES (107, 8, 63);
INSERT INTO `72crm_admin_role_menu` VALUES (108, 8, 64);
INSERT INTO `72crm_admin_role_menu` VALUES (109, 8, 15);
INSERT INTO `72crm_admin_role_menu` VALUES (110, 8, 65);
INSERT INTO `72crm_admin_role_menu` VALUES (111, 8, 66);
INSERT INTO `72crm_admin_role_menu` VALUES (112, 8, 67);
INSERT INTO `72crm_admin_role_menu` VALUES (113, 8, 68);
INSERT INTO `72crm_admin_role_menu` VALUES (114, 8, 69);
INSERT INTO `72crm_admin_role_menu` VALUES (115, 8, 109);
INSERT INTO `72crm_admin_role_menu` VALUES (116, 8, 110);
INSERT INTO `72crm_admin_role_menu` VALUES (117, 8, 127);
INSERT INTO `72crm_admin_role_menu` VALUES (118, 8, 128);
INSERT INTO `72crm_admin_role_menu` VALUES (119, 8, 129);
INSERT INTO `72crm_admin_role_menu` VALUES (120, 8, 130);
INSERT INTO `72crm_admin_role_menu` VALUES (121, 8, 131);

-- ----------------------------
-- Table structure for 72crm_admin_scene
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_scene`;
CREATE TABLE `72crm_admin_scene` (
   `scene_id` int(10) NOT NULL AUTO_INCREMENT,
   `type` int(5) NOT NULL COMMENT'Classification',
   `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'scene name',
   `user_id` bigint(20) NOT NULL COMMENT'User ID',
   `sort` int(5) NOT NULL COMMENT'sort ID',
   `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'attribute value',
   `is_hide` int(1) NOT NULL COMMENT '1 hide',
   `is_system` int(1) NOT NULL COMMENT '1 system 0 custom',
   `bydata` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'system parameter',
   `create_time` datetime(0) NOT NULL COMMENT'create time',
   `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
   PRIMARY KEY (`scene_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='scene' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_admin_scene_default
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_scene_default`;
CREATE TABLE `72crm_admin_scene_default` (
   `default_id` int(11) NOT NULL AUTO_INCREMENT,
   `type` int(5) NOT NULL COMMENT'type',
   `user_id` bigint(20) NOT NULL COMMENT'Personnel ID',
   `scene_id` int(11) NOT NULL COMMENT'Scene ID',
   PRIMARY KEY (`default_id`) USING BTREE,
   UNIQUE INDEX `default_id`(`default_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Scene default relationship table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_admin_user
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_user`;
CREATE TABLE `72crm_admin_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT'primary key',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Username',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'password',
  `salt` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'safety character',
  `img` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'avatar',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
  `realname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'real name',
  `num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Employee Number',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'mobile phone number',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'mailbox',
  `sex` int(1) NULL DEFAULT NULL COMMENT '0 not selected 1 male 2 female',
  `dept_id` int(11) NULL DEFAULT NULL COMMENT'Department',
  `post` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'post',
  `status` int(3) NULL DEFAULT 2 COMMENT'Status, 0 disabled, 1 normal, 2 not activated',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT'Direct superior ID',
  `last_login_time` datetime(0) NULL DEFAULT NULL COMMENT'Last login time',
  `last_login_ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Last login IP Note that it is compatible with IPV6',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='User Table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 72crm_admin_user
-- ----------------------------
INSERT INTO `72crm_admin_user` VALUES (3, 'admin', '51a10f3b4724642d6987d90510e6edf5', '7d65f7cbc0ce4a259d741ae0ef33730c', '', '2019-02-13 15:43:26', 'admin', '390823685766627', '12312341234', NULL, NULL, 1, '1', 1, 0, '2019-09-23 14:06:41', '127.0.0.1');

-- ----------------------------
-- Table structure for 72crm_admin_user_role
-- ----------------------------
DROP TABLE IF EXISTS `72crm_admin_user_role`;
CREATE TABLE `72crm_admin_user_role` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `user_id` bigint(20) NOT NULL COMMENT'User ID',
   `role_id` int(11) NOT NULL COMMENT'role ID',
   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='User role correspondence table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 72crm_admin_user_role
-- ----------------------------
INSERT INTO `72crm_admin_user_role` VALUES (1, 3, 1);

-- ----------------------------
-- Table structure for 72crm_crm_achievement
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_achievement`;
CREATE TABLE `72crm_crm_achievement` (
  `achievement_id` int(11) NOT NULL AUTO_INCREMENT,
  `obj_id` int(11) NULL DEFAULT NULL COMMENT'Object ID',
  `type` int(2) NULL DEFAULT 0 COMMENT '1 company 2 department 3 employees',
  `year` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'year',
  `january` decimal(18, 2) NULL DEFAULT 0.00 COMMENT'January',
  `february` decimal(18, 2) NULL DEFAULT 0.00 COMMENT'February',
  `march` decimal(18, 2) NULL DEFAULT 0.00 COMMENT'March',
  `april` decimal(18, 2) NULL DEFAULT 0.00 COMMENT'April',
  `may` decimal(18, 2) NULL DEFAULT 0.00 COMMENT'May',
  `june` decimal(18, 2) NULL DEFAULT 0.00 COMMENT'June',
  `july` decimal(18, 2) NULL DEFAULT 0.00 COMMENT'July',
  `august` decimal(18, 2) NULL DEFAULT 0.00 COMMENT'August',
  `september` decimal(18, 2) NULL DEFAULT 0.00 COMMENT'September',
  `october` decimal(18, 2) NULL DEFAULT 0.00 COMMENT'October',
  `november` decimal(18, 2) NULL DEFAULT 0.00 COMMENT'November',
  `december` decimal(18, 2) NULL DEFAULT 0.00 COMMENT'December',
  `status` int(2) NULL DEFAULT NULL COMMENT '1 sales (target) 2 payment (target)',
  `yeartarget` decimal(18, 2) NULL DEFAULT 0.00 COMMENT'year target',
  PRIMARY KEY (`achievement_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='performance target' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_action_record
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_action_record`;
CREATE TABLE `72crm_crm_action_record` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `create_user_id` bigint(20) NOT NULL COMMENT'Operator ID',
   `create_time` datetime(0) NOT NULL COMMENT'create time',
   `types` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'type',
   `action_id` int(11) NOT NULL COMMENT'ID of the operated object',
   `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'content',
   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Field operation record table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_area
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_area`;
CREATE TABLE `72crm_crm_area` (
   `code_id` int(11) NULL DEFAULT NULL,
   `parent_id` int(11) NULL DEFAULT NULL,
   `city_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Place name table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 72crm_crm_area
-- ----------------------------
INSERT INTO `72crm_crm_area` VALUES (11, 0,'Beijing');
INSERT INTO `72crm_crm_area` VALUES (1101, 11,'Beijing City');
INSERT INTO `72crm_crm_area` VALUES (110101, 1101,'Dongcheng District');
INSERT INTO `72crm_crm_area` VALUES (110102, 1101,'Xicheng District');
INSERT INTO `72crm_crm_area` VALUES (110103, 1101,'Chongwen District');
INSERT INTO `72crm_crm_area` VALUES (110104, 1101,'Xuanwu District');
INSERT INTO `72crm_crm_area` VALUES (110105, 1101,'Chaoyang District');
INSERT INTO `72crm_crm_area` VALUES (110106, 1101,'Fengtai District');
INSERT INTO `72crm_crm_area` VALUES (110107, 1101,'Shijingshan District');
INSERT INTO `72crm_crm_area` VALUES (110108, 1101,'Haidian District');
INSERT INTO `72crm_crm_area` VALUES (110109, 1101,'Mentougou District');
INSERT INTO `72crm_crm_area` VALUES (110111, 1101,'Fangshan District');
INSERT INTO `72crm_crm_area` VALUES (110112, 1101,'Tongzhou District');
INSERT INTO `72crm_crm_area` VALUES (110113, 1101,'Shunyi District');
INSERT INTO `72crm_crm_area` VALUES (110114, 1101,'Changping District');
INSERT INTO `72crm_crm_area` VALUES (1102, 11,'Beijing County');
INSERT INTO `72crm_crm_area` VALUES (110224, 1102,'Daxing County');
INSERT INTO `72crm_crm_area` VALUES (110226, 1102,'Pinggu County');
INSERT INTO `72crm_crm_area` VALUES (110227, 1102,'Huairou County');
INSERT INTO `72crm_crm_area` VALUES (110228, 1102,'Miyun County');
INSERT INTO `72crm_crm_area` VALUES (110229, 1102,'Yanqing County');
INSERT INTO `72crm_crm_area` VALUES (12, 0,'Tianjin');
INSERT INTO `72crm_crm_area` VALUES (1201, 12,'Tianjin Municipality');
INSERT INTO `72crm_crm_area` VALUES (120101, 1201,'Peace Zone');
INSERT INTO `72crm_crm_area` VALUES (120102, 1201,'Hedong District');
INSERT INTO `72crm_crm_area` VALUES (120103, 1201,'Hexi District');
INSERT INTO `72crm_crm_area` VALUES (120104, 1201,'Nankai District');
INSERT INTO `72crm_crm_area` VALUES (120105, 1201,'Hebei District');
INSERT INTO `72crm_crm_area` VALUES (120106, 1201,'Hongqiao District');
INSERT INTO `72crm_crm_area` VALUES (120107, 1201,'Tanggu District');
INSERT INTO `72crm_crm_area` VALUES (120108, 1201,'Hangu District');
INSERT INTO `72crm_crm_area` VALUES (120109, 1201,'Dagang District');
INSERT INTO `72crm_crm_area` VALUES (120110, 1201,'Dongli District');
INSERT INTO `72crm_crm_area` VALUES (120111, 1201,'Xiqing District');
INSERT INTO `72crm_crm_area` VALUES (120112, 1201,'Jinnan District');
INSERT INTO `72crm_crm_area` VALUES (120113, 1201,'Beichen District');
INSERT INTO `72crm_crm_area` VALUES (120114, 1201,'Wuqing District');
INSERT INTO `72crm_crm_area` VALUES (1202, 12,'Tianjin County');
INSERT INTO `72crm_crm_area` VALUES (120221, 1202,'Ninghe County');
INSERT INTO `72crm_crm_area` VALUES (120223, 1202,'Jinghai County');
INSERT INTO `72crm_crm_area` VALUES (120224, 1202,'Baodi County');
INSERT INTO `72crm_crm_area` VALUES (120225, 1202,'This county');


-- ----------------------------
-- Table structure for 72crm_crm_business
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_business`;
CREATE TABLE `72crm_crm_business` (
  `business_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NULL DEFAULT NULL COMMENT'Business Opportunity Status Group',
  `status_id` int(11) NULL DEFAULT NULL COMMENT'Sales stage',
  `next_time` datetime(0) NULL DEFAULT NULL COMMENT'Next contact time',
  `customer_id` int(11) NOT NULL COMMENT'Customer ID',
  `deal_date` datetime(0) NULL DEFAULT NULL COMMENT'Estimated transaction date',
  `business_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'Business Opportunity Name',
  `money` decimal(18, 2) NULL DEFAULT NULL COMMENT'opportunity amount',
  `discount_rate` decimal(10, 2) NULL DEFAULT NULL COMMENT'full order discount',
  `total_price` decimal(10, 2) NULL DEFAULT NULL COMMENT'Total product amount',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'Remark',
  `create_user_id` bigint(20) NOT NULL COMMENT'creator ID',
  `owner_user_id` bigint(20) NULL DEFAULT NULL COMMENT'Person in charge ID',
  `create_time` datetime(0) NOT NULL COMMENT'create time',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
  `batch_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Batch such as attachment batch',
  `ro_user_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'read-only permission',
  `rw_user_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'Read and write permissions',
  `is_end` int(4) NOT NULL DEFAULT 0 COMMENT '1 win order 2 lose order 3 invalid',
  `status_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'',
  PRIMARY KEY (`business_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Business Opportunity Table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_business_change
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_business_change`;
CREATE TABLE `72crm_crm_business_change` (
   `change_id` int(10) NOT NULL AUTO_INCREMENT,
   `business_id` int(10) NOT NULL COMMENT'Business Opportunity ID',
   `status_id` int(10) NOT NULL COMMENT'Phase ID',
   `create_time` datetime(0) NOT NULL COMMENT'create time',
   `create_user_id` bigint(20) NOT NULL COMMENT'creator',
   PRIMARY KEY (`change_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Business Opportunity Phase Change Table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_business_product
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_business_product`;
CREATE TABLE `72crm_crm_business_product` (
   `r_id` int(11) NOT NULL AUTO_INCREMENT,
   `business_id` int(11) NOT NULL COMMENT'Business Opportunity ID',
   `product_id` int(11) NOT NULL COMMENT'Product ID',
   `price` decimal(18, 2) NOT NULL COMMENT'Product unit price',
   `sales_price` decimal(18, 2) NOT NULL COMMENT'sales price',
   `num` int(10) NOT NULL COMMENT'number',
   `discount` decimal(10, 2) NOT NULL COMMENT'Discount',
   `subtotal` decimal(18, 2) NOT NULL COMMENT'Subtotal (price after discount)',
   `unit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'Unit',
   PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Business Opportunity Product Relationship Table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_business_status
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_business_status`;
CREATE TABLE `72crm_crm_business_status` (
   `status_id` int(11) NOT NULL AUTO_INCREMENT,
   `type_id` int(11) NOT NULL COMMENT'Business opportunity status category ID',
   `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'Identification',
   `rate` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'winning rate',
   `order_num` int(4) NULL DEFAULT NULL COMMENT'Order',
   PRIMARY KEY (`status_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Business Opportunity Status' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 72crm_crm_business_status
-- ----------------------------
INSERT INTO `72crm_crm_business_status` VALUES (1, 9,'Verify customer', '20', 1);
INSERT INTO `72crm_crm_business_status` VALUES (2, 9,'demand analysis', '30', 2);
INSERT INTO `72crm_crm_business_status` VALUES (3, 9,'Proposal/quotation', '80', 3);

-- ----------------------------
-- Table structure for 72crm_crm_business_type
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_business_type`;
CREATE TABLE `72crm_crm_business_type` (
   `type_id` int(11) NOT NULL AUTO_INCREMENT,
   `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'Identification',
   `dept_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'Department ID',
   `create_user_id` bigint(20) NOT NULL COMMENT'creator ID',
   `create_time` datetime(0) NOT NULL COMMENT'create time',
   `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
   `status` int(1) NOT NULL DEFAULT 1 COMMENT '1 enable 0 disable',
   PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Business Opportunity Status Group Type' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 72crm_crm_business_type
-- ----------------------------
INSERT INTO `72crm_crm_business_type` VALUES (1,'Default business group','', 3, '2019-05-11 16:25:09', NULL, 1);

-- ----------------------------
-- Table structure for 72crm_crm_contacts
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_contacts`;
CREATE TABLE `72crm_crm_contacts` (
  `contacts_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Contact name',
  `next_time` datetime(0) NULL DEFAULT NULL COMMENT'Next contact time',
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'Mobile',
  `telephone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'Phone',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'email',
  `post` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Title',
  `customer_id` int(11) NOT NULL COMMENT'Customer ID',
  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'address',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'Remark',
  `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT'creator ID',
  `owner_user_id` bigint(20) NULL DEFAULT NULL COMMENT'Person in charge ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
  `batch_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'batch',
  PRIMARY KEY (`contacts_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Contact table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_contacts_business
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_contacts_business`;
CREATE TABLE `72crm_crm_contacts_business` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `business_id` int(11) NOT NULL,
   `contacts_id` int(11) NOT NULL,
   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Business Opportunity Contact Association Table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_contract
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_contract`;
CREATE TABLE `72crm_crm_contract` (
  `contract_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'contract name',
  `customer_id` int(11) NULL DEFAULT NULL COMMENT'Customer ID',
  `business_id` int(11) NULL DEFAULT NULL COMMENT'Business Opportunity ID',
  `check_status` int(4) NULL DEFAULT 0 COMMENT '0 Unreviewed 1 Approved 2 Approved rejected 3 Under review 4 Withdrawn 5 Draft 6 Obsolete',
  `examine_record_id` int(11) NULL DEFAULT NULL COMMENT'audit record ID',
  `order_date` datetime(0) NULL DEFAULT NULL COMMENT'Order date',
  `create_user_id` bigint(20) NOT NULL COMMENT'creator ID',
  `owner_user_id` bigint(20) NULL DEFAULT NULL COMMENT'Person in charge ID',
  `create_time` datetime(0) NOT NULL COMMENT'create time',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
  `num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'contract number',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT'start time',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT'End time',
  `money` decimal(18, 2) NULL DEFAULT NULL COMMENT'contract amount',
  `discount_rate` decimal(10, 2) NULL DEFAULT NULL COMMENT'full order discount',
  `total_price` decimal(10, 2) NULL DEFAULT NULL COMMENT'Total product amount',
  `types` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'contract type',
  `payment_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'payment method',
  `batch_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'Batch such as attachment batch',
  `ro_user_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT'read-only permission',
  `rw_user_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT'Read and write permissions',
  `contacts_id` int(11) NULL DEFAULT NULL COMMENT'Customer contractor (contact id)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Remarks',
  `company_user_id` int(11) NULL DEFAULT NULL COMMENT'company contractor',
  PRIMARY KEY (`contract_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Contract Form' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_contract_product
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_contract_product`;
CREATE TABLE `72crm_crm_contract_product` (
   `r_id` int(11) NOT NULL AUTO_INCREMENT,
   `contract_id` int(11) NOT NULL COMMENT'Contract ID',
   `product_id` int(11) NOT NULL COMMENT'Product ID',
   `price` decimal(18, 2) NOT NULL COMMENT'Product unit price',
   `sales_price` decimal(18, 2) NOT NULL COMMENT'sales price',
   `num` int(10) NOT NULL COMMENT'number',
   `discount` decimal(10, 2) NOT NULL COMMENT'Discount',
   `subtotal` decimal(18, 2) NOT NULL COMMENT'Subtotal (price after discount)',
   `unit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'Unit',
   PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Contract product relationship table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_customer
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_customer`;
CREATE TABLE `72crm_crm_customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'customer name',
  `followup` int(11) NULL DEFAULT NULL COMMENT'followup status 0 not followed up 1 followed up',
  `is_lock` int(1) NOT NULL DEFAULT 0 COMMENT '1lock',
  `next_time` datetime(0) NULL DEFAULT NULL COMMENT'Next contact time',
  `deal_status` int(4) NOT NULL DEFAULT 0 COMMENT'Deal status 0 not executed 1 executed',
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'mobile phone',
  `telephone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'Phone',
  `website` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'URL',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'Remark',
  `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT'creator ID',
  `owner_user_id` bigint(20) NULL DEFAULT NULL COMMENT'Person in charge ID',
  `ro_user_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT'read-only permission',
  `rw_user_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT'Read and write permissions',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'Province and urban area',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'location information',
  `detail_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'Detailed address',
  `lng` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'Geographical location longitude',
  `lat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'Geographical location dimension',
  `create_time` datetime(0) NOT NULL COMMENT'create time',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
  `batch_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'Batch such as attachment batch',
  `last_content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Customer table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_customer_setting
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_customer_setting`;
CREATE TABLE `72crm_crm_customer_setting` (
   `setting_id` int(11) NOT NULL AUTO_INCREMENT COMMENT'primary key ID',
   `setting_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Rule name',
   `customer_num` int(11) NULL DEFAULT NULL COMMENT'The number of customers that can be owned',
   `customer_deal` int(1) NULL DEFAULT 0 COMMENT'Does the transaction customer occupy the quantity 0 not occupied 1 occupied',
   `type` int(1) NULL DEFAULT NULL COMMENT'Type 1 has a limit on the number of customers 2 has a limit on the number of locked customers',
   `create_time` datetime(0) NULL DEFAULT NULL,
   PRIMARY KEY (`setting_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Restrictions on the number of customers owned and locked by employees' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 72crm_crm_customer_setting
-- ----------------------------
INSERT INTO `72crm_crm_customer_setting` VALUES (24, NULL, 5, 0, 1, '2019-09-23 14:16:23');
INSERT INTO `72crm_crm_customer_setting` VALUES (25, NULL, 2, 0, 2, '2019-09-23 14:16:38');

-- ----------------------------
-- Table structure for 72crm_crm_customer_settinguser
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_customer_settinguser`;
CREATE TABLE `72crm_crm_customer_settinguser` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT'Primary key ID',
   `setting_id` int(11) NOT NULL COMMENT'Customer rule restriction ID',
   `user_id` bigint(20) NULL DEFAULT NULL COMMENT'user id',
   `dept_id` int(11) NULL DEFAULT NULL COMMENT'Department ID',
   `type` int(1) NULL DEFAULT NULL COMMENT '1 employee 2 department',
   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Employee owns and locks the customer employee association table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_customer_stats
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_customer_stats`;
CREATE TABLE `72crm_crm_customer_stats` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `user_id` bigint(20) NOT NULL COMMENT'user id',
   `customer_num` int(10) NOT NULL DEFAULT 0 COMMENT'Total number of customers',
   `create_time` datetime(0) NOT NULL COMMENT'Statistical time',
   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Daily customer statistics' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_leads
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_leads`;
CREATE TABLE `72crm_crm_leads` (
  `leads_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_transform` int(1) NULL DEFAULT 0 COMMENT '1 has been transformed 0 has not been transformed',
  `followup` int(11) NULL DEFAULT NULL COMMENT'followup status 0 not followed up 1 followed up',
  `leads_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'lead name',
  `customer_id` int(11) NULL DEFAULT NULL COMMENT'Customer id',
  `next_time` datetime(0) NULL DEFAULT NULL COMMENT'Next contact time',
  `telephone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'telephone',
  `mobile` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'mobile phone number',
  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'address',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT'' COMMENT'Remark',
  `create_user_id` bigint(20) NOT NULL COMMENT'creator ID',
  `owner_user_id` bigint(20) NULL DEFAULT NULL COMMENT'Person in charge ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
  `batch_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'Batch such as attachment batch',
  `last_content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`leads_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='clue table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_owner_record
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_owner_record`;
CREATE TABLE `72crm_crm_owner_record` (
   `record_id` int(11) NOT NULL AUTO_INCREMENT,
   `type_id` int(11) NOT NULL COMMENT'object id',
   `type` int(4) NOT NULL COMMENT'object type',
   `pre_owner_user_id` bigint(20) NULL DEFAULT NULL COMMENT'Previous person in charge',
   `post_owner_user_id` bigint(20) NULL DEFAULT NULL COMMENT'take over the person in charge',
   `create_time` datetime(0) NOT NULL COMMENT'create time',
   PRIMARY KEY (`record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Responsible person change record table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_product
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_product`;
CREATE TABLE `72crm_crm_product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'product name',
  `num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'product code',
  `price` decimal(18, 2) NULL DEFAULT NULL COMMENT'price',
  `status` int(1) NULL DEFAULT 0 COMMENT'Status 1 on shelf 0 off shelf 3 delete',
  `category_id` int(11) NULL DEFAULT NULL COMMENT'Product category ID',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT'Product description',
  `create_user_id` bigint(20) NOT NULL COMMENT'creator ID',
  `owner_user_id` bigint(20) NULL DEFAULT NULL COMMENT'Person in charge ID',
  `create_time` datetime(0) NOT NULL COMMENT'create time',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
  `batch_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'batch',
  PRIMARY KEY (`product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Product table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_product_category
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_product_category`;
CREATE TABLE `72crm_crm_product_category` (
   `category_id` int(11) NOT NULL AUTO_INCREMENT,
   `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
   `pid` int(11) NULL DEFAULT 0,
   PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Product Classification Table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 72crm_crm_product_category
-- ----------------------------
INSERT INTO `72crm_crm_product_category` VALUES (23,'default', 0);

-- ----------------------------
-- Table structure for 72crm_crm_receivables
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_receivables`;
CREATE TABLE `72crm_crm_receivables` (
  `receivables_id` int(11) NOT NULL AUTO_INCREMENT COMMENT'Receipt ID',
  `number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Return payment number',
  `plan_id` int(11) NULL DEFAULT NULL COMMENT'Payment plan ID',
  `customer_id` int(11) NULL DEFAULT NULL COMMENT'Customer ID',
  `contract_id` int(11) NULL DEFAULT NULL COMMENT'Contract ID',
  `check_status` int(4) NULL DEFAULT NULL COMMENT '0 Unreviewed 1 Approved 2 Approved rejected 3 Under review 4 Withdrawn',
  `examine_record_id` int(11) NULL DEFAULT NULL COMMENT'audit record ID',
  `return_time` date NULL DEFAULT NULL COMMENT'Return date',
  `return_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'return method',
  `money` decimal(18, 2) NULL DEFAULT NULL COMMENT'Receipt amount',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Remarks',
  `create_user_id` bigint(20) NOT NULL COMMENT'creator ID',
  `owner_user_id` bigint(20) NULL DEFAULT NULL COMMENT'Person in charge ID',
  `create_time` datetime(0) NOT NULL COMMENT'create time',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Remarks',
  `batch_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'batch',
  PRIMARY KEY (`receivables_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Return Form' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_crm_receivables_plan
-- ----------------------------
DROP TABLE IF EXISTS `72crm_crm_receivables_plan`;
CREATE TABLE `72crm_crm_receivables_plan` (
  `plan_id` int(11) NOT NULL AUTO_INCREMENT,
  `num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'number of periods',
  `receivables_id` int(11) NULL DEFAULT NULL COMMENT'Receipt ID',
  `status` int(4) NULL DEFAULT NULL COMMENT '1 completed 0 not completed',
  `money` decimal(18, 2) NULL DEFAULT NULL COMMENT'Planned payment amount',
  `return_date` datetime(0) NULL DEFAULT NULL COMMENT'Planned payment date',
  `return_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Planned payment method',
  `remind` int(4) NULL DEFAULT NULL COMMENT'Remind a few days in advance',
  `remind_date` datetime(0) NULL DEFAULT NULL COMMENT'remind date',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Remarks',
  `create_user_id` bigint(20) NOT NULL COMMENT'creator ID',
  `owner_user_id` bigint(20) NULL DEFAULT NULL COMMENT'Person in charge ID',
  `create_time` datetime(0) NOT NULL COMMENT'create time',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
  `file_batch` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Attachment batch ID',
  `contract_id` int(11) NOT NULL COMMENT'Contract ID',
  `customer_id` int(11) NOT NULL COMMENT'Customer ID',
  PRIMARY KEY (`plan_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Payment plan table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_oa_action_record
-- ----------------------------
DROP TABLE IF EXISTS `72crm_oa_action_record`;
CREATE TABLE `72crm_oa_action_record` (
   `log_id` int(11) NOT NULL AUTO_INCREMENT,
   `user_id` bigint(20) NOT NULL COMMENT'Operator ID',
   `type` int(1) NOT NULL COMMENT'operation type',
   `action_id` int(10) NULL DEFAULT NULL COMMENT'action object id',
   `create_time` datetime(0) NOT NULL COMMENT'Operation time',
   `join_user_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'CC IDs',
   `dept_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'CC department IDs',
   `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'Operation content',
   PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='oa operation record table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_oa_announcement
-- ----------------------------
DROP TABLE IF EXISTS `72crm_oa_announcement`;
CREATE TABLE `72crm_oa_announcement` (
  `announcement_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'title',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'content',
  `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT'creator ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT'start time',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT'End time',
  `dept_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Notification department',
  `owner_user_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Notification person',
  `read_user_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Read users',
  PRIMARY KEY (`announcement_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Announcement table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_oa_event
-- ----------------------------
DROP TABLE IF EXISTS `72crm_oa_event`;
CREATE TABLE `72crm_oa_event` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT'title',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'content',
  `start_time` datetime(0) NOT NULL COMMENT'start time',
  `end_time` datetime(0) NOT NULL COMMENT'End time',
  `create_user_id` bigint(20) NOT NULL COMMENT'creator ID',
  `create_time` datetime(0) NOT NULL COMMENT'create time',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
  `type` int(2) NULL DEFAULT NULL COMMENT '0 do not remind 1 every day 2 weekly 3 monthly 4 yearly',
  `owner_user_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'participants',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'location',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Remarks',
  `color` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT'color',
  `remind_type` int(11) NULL DEFAULT NULL COMMENT'Reminder time 0 Reminder on time 1: 5 minutes ago 2: 15 minutes ago 3: 30 minutes ago 4: One hour ago 5: Two hours ago 6: One day ago 7: Two 8 days before: a week ago',
  PRIMARY KEY (`event_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Schedule' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_oa_event_notice
-- ----------------------------
DROP TABLE IF EXISTS `72crm_oa_event_notice`;
CREATE TABLE `72crm_oa_event_notice` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `event_id` int(11) NOT NULL COMMENT'Agenda ID',
   `noticetype` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '1 day 2 weeks 3 months 4 years 0 no reminder',
   `repeat` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
   `start_time` int(11) NOT NULL COMMENT'start time',
   `stop_time` int(11) NOT NULL COMMENT'Introduction time',
   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Schedule reminder setting table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_oa_event_relation
-- ----------------------------
DROP TABLE IF EXISTS `72crm_oa_event_relation`;
CREATE TABLE `72crm_oa_event_relation` (
  `eventrelation_id` int(11) NOT NULL AUTO_INCREMENT COMMENT'Schedule related business table',
  `event_id` int(11) NOT NULL COMMENT'Agenda ID',
  `customer_ids` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Customer IDs',
  `contacts_ids` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Contact IDs',
  `business_ids` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Business IDs',
  `contract_ids` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Contract IDs',
  `status` int(2) NULL DEFAULT 0 COMMENT'Status 1 is available',
  `create_time` datetime(0) NOT NULL COMMENT'create time',
  PRIMARY KEY (`eventrelation_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Schedule related business table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_oa_examine
-- ----------------------------
DROP TABLE IF EXISTS `72crm_oa_examine`;
CREATE TABLE `72crm_oa_examine` (
  `examine_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL DEFAULT 1 COMMENT'Approval type',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'content',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Remarks',
  `type_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'leave type',
  `money` decimal(18, 2) NULL DEFAULT NULL COMMENT'Total amount of travel and reimbursement',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT'start time',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT'End time',
  `duration` decimal(4, 1) NULL DEFAULT NULL COMMENT'Duration',
  `create_user_id` bigint(20) NOT NULL COMMENT'creator ID',
  `create_time` datetime(0) NOT NULL COMMENT'create time',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
  `batch_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Attachment batch id',
  PRIMARY KEY (`examine_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Approval Form' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_oa_examine_category
-- ----------------------------
DROP TABLE IF EXISTS `72crm_oa_examine_category`;
CREATE TABLE `72crm_oa_examine_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'name',
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Description',
  `type` int(1) NULL DEFAULT 0 COMMENT '1 Ordinary approval 2 Leave approval 3 Business trip approval 4 Overtime approval 5 Travel reimbursement 6 Loan application 0 Custom approval',
  `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT'creator ID',
  `status` int(1) NULL DEFAULT 1 COMMENT '1 is enabled, 0 is disabled',
  `is_sys` int(1) NULL DEFAULT NULL COMMENT '1 is the system type and cannot be deleted',
  `examine_type` int(1) NULL DEFAULT NULL COMMENT '1 fixed 2 optional',
  `user_ids` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Visible range (employee)',
  `dept_ids` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Visible range (department)',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
  `is_deleted` int(1) NULL DEFAULT 0 COMMENT '1 has been deleted',
  `delete_time` datetime(0) NULL DEFAULT NULL COMMENT'delete time',
  `delete_user_id` bigint(20) NULL DEFAULT NULL COMMENT'Delete person ID',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Approval Type Table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of 72crm_oa_examine_category
-- ----------------------------
INSERT INTO `72crm_oa_examine_category` VALUES (1,'General approval','General approval', 1, 3, 1, 1, 2,'','', '2019-04-26 15:06:34', '2019 -04-26 15:06:34', 0, NULL, NULL);
INSERT INTO `72crm_oa_examine_category` VALUES (2,'Leave Approval','Leave Approval', 2, 3, 1, 1, 2,'','', '2019-04-17 18:52:44', '2019 -04-17 18:52:44', 0, NULL, NULL);
INSERT INTO `72crm_oa_examine_category` VALUES (3,'Business trip approval','Business trip approval', 3, 3, 1, 1, 2,'','', '2019-04-17 18:52:50', '2019 -04-17 18:52:50', 0, NULL, NULL);
INSERT INTO `72crm_oa_examine_category` VALUES (4,'Overtime approval','Overtime approval', 4, 3, 1, 1, 2,'','', '2019-04-17 18:52:59', '2019 -04-17 18:52:59', 0, NULL, NULL);
INSERT INTO `72crm_oa_examine_category` VALUES (5,'Travel Reimbursement','Travel Reimbursement', 5, 3, 1, 1, 2,'','', '2019-04-17 18:53:13', '2019-04-17 18:53:13', 0, NULL, NULL);
INSERT INTO `72crm_oa_examine_category` VALUES (6,'Loan application','Loan application', 6, 3, 1, 1, 2,'','', '2019-04-17 18:54:44', '2019 -04-17 18:54:44', 0, NULL, NULL);

-- ----------------------------
-- Table structure for 72crm_oa_examine_log
-- ----------------------------
DROP TABLE IF EXISTS `72crm_oa_examine_log`;
CREATE TABLE `72crm_oa_examine_log` (
  `log_id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT'ID',
  `record_id` int(11) NULL DEFAULT NULL COMMENT'Approval record ID',
  `examine_step_id` bigint(20) NULL DEFAULT NULL COMMENT'review step ID',
  `examine_status` int(1) NULL DEFAULT NULL COMMENT'audit status 0 unaudited 1 audit passed 2 audit rejected 4 withdrawn audit',
  `create_user` bigint(20) NULL DEFAULT NULL COMMENT'creator',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
  `examine_user` bigint(20) NULL DEFAULT NULL COMMENT'reviewer',
  `examine_time` datetime(0) NULL DEFAULT NULL COMMENT'review time',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Remarks for review',
  `is_recheck` int(1) NULL DEFAULT 0 COMMENT'Whether it is to withdraw the previous log 0 or null as the new data 1: Withdraw the previous data',
  `order_id` int(30) NULL DEFAULT NULL COMMENT'order id',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Audit log table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_oa_examine_record
-- ----------------------------
DROP TABLE IF EXISTS `72crm_oa_examine_record`;
CREATE TABLE `72crm_oa_examine_record` (
   `record_id` int(11) NOT NULL AUTO_INCREMENT COMMENT'audit record ID',
   `examine_id` int(11) NULL DEFAULT NULL COMMENT'Approval ID',
   `examine_step_id` bigint(20) NULL DEFAULT NULL COMMENT'ID of the current approval step',
   `examine_status` int(1) NULL DEFAULT NULL COMMENT'Audit status 0 Unaudited 1 Audit passed 2 Audit rejected 3 Under audit 4 Withdrawn',
   `create_user` bigint(20) NULL DEFAULT NULL COMMENT'creator',
   `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
   `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Remarks for review',
   PRIMARY KEY (`record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Audit record table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_oa_examine_relation
-- ----------------------------
DROP TABLE IF EXISTS `72crm_oa_examine_relation`;
CREATE TABLE `72crm_oa_examine_relation` (
  `r_id` int(11) NOT NULL AUTO_INCREMENT COMMENT'Approval of related business table',
  `examine_id` int(11) NULL DEFAULT NULL COMMENT'Approval ID',
  `customer_ids` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Customer IDs',
  `contacts_ids` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Contact IDs',
  `business_ids` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Business IDs',
  `contract_ids` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Contract IDs',
  `status` int(2) NULL DEFAULT 1 COMMENT'Status 1 is available',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Approval of related business tables' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_oa_examine_step
-- ----------------------------
DROP TABLE IF EXISTS `72crm_oa_examine_step`;
CREATE TABLE `72crm_oa_examine_step` (
   `step_id` bigint(20) NOT NULL AUTO_INCREMENT,
   `step_type` int(1) NULL DEFAULT NULL COMMENT'Step type 1, the person in charge, 2, the designated user (any one), 3, the designated user (multi-person countersign), 4, the supervisor of the superior approver',
   `category_id` int(11) NOT NULL COMMENT'Approval ID',
   `check_user_id` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Approver ID (separated by commas) ,1,2,',
   `step_num` int(2) NULL DEFAULT 1 COMMENT'sort',
   `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
   PRIMARY KEY (`step_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Approval step table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_oa_examine_travel
-- ----------------------------
DROP TABLE IF EXISTS `72crm_oa_examine_travel`;
CREATE TABLE `72crm_oa_examine_travel` (
  `travel_id` int(11) NOT NULL AUTO_INCREMENT,
  `examine_id` int(11) NOT NULL COMMENT'Approval ID',
  `start_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'departure place',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT'Departure time',
  `end_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Destination',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT'arrival time',
  `traffic` decimal(18, 2) NULL DEFAULT NULL COMMENT'traffic fee',
  `stay` decimal(18, 2) NULL DEFAULT NULL COMMENT'accommodation fee',
  `diet` decimal(18, 2) NULL DEFAULT NULL COMMENT'food and beverage expenses',
  `other` decimal(18, 2) NULL DEFAULT NULL COMMENT'Other expenses',
  `money` decimal(18, 2) NULL DEFAULT NULL COMMENT'amount',
  `vehicle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Transportation',
  `trip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'One way round trip (one way, round trip)',
  `duration` decimal(4, 1) NULL DEFAULT NULL COMMENT'Duration',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Remarks',
  `batch_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'batch id',
  PRIMARY KEY (`travel_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Differential travel schedule' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_oa_log
-- ----------------------------
DROP TABLE IF EXISTS `72crm_oa_log`;
CREATE TABLE `72crm_oa_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(2) NOT NULL DEFAULT 1 COMMENT'Log type (1 daily report, 2 weekly report, March report)',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'log title',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT'log content',
  `tomorrow` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Tomorrow\'s work content',
  `question` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Encountered a problem',
  `create_user_id` bigint(20) NOT NULL COMMENT'creator ID',
  `create_time` datetime(0) NOT NULL COMMENT'create time',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT'update time',
  `send_user_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Notification person',
  `send_dept_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Notification Department',
  `read_user_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'read people',
  `batch_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'File batch ID',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Work log table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_oa_log_relation
-- ----------------------------
DROP TABLE IF EXISTS `72crm_oa_log_relation`;
CREATE TABLE `72crm_oa_log_relation` (
  `r_id` int(11) NOT NULL AUTO_INCREMENT COMMENT'Log related business table',
  `log_id` int(11) NULL DEFAULT NULL COMMENT'log ID',
  `customer_ids` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Customer IDs',
  `contacts_ids` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Contact IDs',
  `business_ids` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Business Opportunity IDs',
  `contract_ids` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Contract IDs',
  `status` int(2) NULL DEFAULT NULL COMMENT'Status 1 is available',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
  PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Log related business table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_task
-- ----------------------------
DROP TABLE IF EXISTS `72crm_task`;
CREATE TABLE `72crm_task` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT COMMENT'task table',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'task name',
  `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT'creator ID',
  `main_user_id` bigint(20) NULL DEFAULT NULL COMMENT'Person in charge ID',
  `owner_user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'team member ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT'New time',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT'Update time',
  `status` int(2) NULL DEFAULT 1 COMMENT'Completion status 1 in progress 2 postponed 3 archive 5 finished',
  `class_id` int(5) NULL DEFAULT 0 COMMENT'class id',
  `label_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'label, number splicing',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT'Description',
  `pid` int(11) NULL DEFAULT 0 COMMENT'Parent ID',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT'start time',
  `stop_time` datetime(0) NULL DEFAULT NULL COMMENT'End time',
  `priority` int(2) NULL DEFAULT NULL COMMENT'Priority from large to small 3 high 2 medium 1 low',
  `work_id` int(11) NULL DEFAULT 0 COMMENT'Project ID',
  `is_top` int(2) NULL DEFAULT 0 COMMENT'Workbench display 0 inbox 1 do it today, 2 do the next step, 3 do it later',
  `is_open` int(2) NULL DEFAULT 1 COMMENT'Is it open?',
  `order_num` int(4) NULL DEFAULT 999 COMMENT'Order ID',
  `top_order_num` int(4) NULL DEFAULT 999 COMMENT'My task order ID',
  `archive_time` datetime(0) NULL DEFAULT NULL COMMENT'Archive time',
  `ishidden` int(2) NULL DEFAULT 0 COMMENT'Whether to delete 0 Not deleted 1 Delete',
  `hidden_time` datetime(0) NULL DEFAULT NULL COMMENT'Delete time',
  `batch_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'batch',
  `is_archive` int(2) NULL DEFAULT 0 COMMENT '1 archive',
  PRIMARY KEY (`task_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Task table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_task_comment
-- ----------------------------
DROP TABLE IF EXISTS `72crm_task_comment`;
CREATE TABLE `72crm_task_comment` (
   `comment_id` int(11) NOT NULL AUTO_INCREMENT COMMENT'Comment table',
   `user_id` bigint(20) NOT NULL COMMENT'Commenter ID',
   `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'content (answer)',
   `create_time` datetime(0) NULL DEFAULT NULL COMMENT'New time',
   `main_id` int(11) NULL DEFAULT 0 COMMENT'The id of the main comment',
   `pid` bigint(20) NULL DEFAULT 0 COMMENT'reply object ID',
   `status` int(2) NULL DEFAULT 1 COMMENT'status',
   `type_id` int(11) NULL DEFAULT 0 COMMENT'Comment project task ID or comment other module ID',
   `favour` int(7) NULL DEFAULT 0 COMMENT'Like',
   `type` int(2) NULL DEFAULT 0 COMMENT'Comment category 1: Task comment 2: Log comment',
   PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Task Comment Form' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_task_relation
-- ----------------------------
DROP TABLE IF EXISTS `72crm_task_relation`;
CREATE TABLE `72crm_task_relation` (
   `r_id` int(11) NOT NULL AUTO_INCREMENT COMMENT'Task related business table',
   `task_id` int(11) NULL DEFAULT NULL COMMENT'task ID',
   `customer_ids` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Customer IDs',
   `contacts_ids` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Contact IDs',
   `business_ids` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Business Opportunity IDs',
   `contract_ids` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Contract IDs',
   `status` int(2) NULL DEFAULT NULL COMMENT'Status 1 is available',
   `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
   PRIMARY KEY (`r_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Task related business table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_work
-- ----------------------------
DROP TABLE IF EXISTS `72crm_work`;
CREATE TABLE `72crm_work` (
  `work_id` int(11) NOT NULL AUTO_INCREMENT COMMENT'Project ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'Project name',
  `status` int(2) NULL DEFAULT 1 COMMENT'Status 1 enable 3 archive 2 delete',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
  `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT'creator ID',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT'Description',
  `color` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT'color',
  `is_open` int(2) NULL DEFAULT 1 COMMENT'Is it visible to everyone 1 Yes 0 No',
  `owner_user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'project member',
  `archive_time` datetime(0) NULL DEFAULT NULL COMMENT'Archive time',
  `delete_time` datetime(0) NULL DEFAULT NULL COMMENT'delete time',
  `batch_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`work_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Item table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_work_task_class
-- ----------------------------
DROP TABLE IF EXISTS `72crm_work_task_class`;
CREATE TABLE `72crm_work_task_class` (
   `class_id` int(11) NOT NULL AUTO_INCREMENT COMMENT'task classification table',
   `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'category name',
   `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
   `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT'creator ID',
   `status` int(2) NULL DEFAULT 0 COMMENT'Status 1 is normal',
   `work_id` int(11) NULL DEFAULT NULL COMMENT'Project ID',
   `order_num` int(4) NULL DEFAULT NULL COMMENT'Order',
   PRIMARY KEY (`class_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Task classification table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_work_task_label
-- ----------------------------
DROP TABLE IF EXISTS `72crm_work_task_label`;
CREATE TABLE `72crm_work_task_label` (
   `label_id` int(11) NOT NULL AUTO_INCREMENT,
   `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'tag name',
   `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
   `create_user_id` bigint(20) NULL DEFAULT NULL COMMENT'creator ID',
   `status` int(2) NULL DEFAULT 0 COMMENT'status',
   `color` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT'color',
   PRIMARY KEY (`label_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Task Tag Table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_work_task_log
-- ----------------------------
DROP TABLE IF EXISTS `72crm_work_task_log`;
CREATE TABLE `72crm_work_task_log` (
   `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT'Project log table',
   `user_id` bigint(20) NOT NULL COMMENT'Operator ID',
   `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT'content',
   `create_time` datetime(0) NULL DEFAULT NULL COMMENT'create time',
   `status` int(2) NULL DEFAULT 0 COMMENT'Status 4 delete',
   `task_id` int(11) NULL DEFAULT 0 COMMENT'task ID',
   `work_id` int(11) NULL DEFAULT 0 COMMENT'Project ID',
   PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Task log table' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for 72crm_work_user
-- ----------------------------
DROP TABLE IF EXISTS `72crm_work_user`;
CREATE TABLE `72crm_work_user` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `work_id` int(11) NOT NULL COMMENT'Project ID',
   `user_id` bigint(20) NOT NULL COMMENT'Member ID',
   `role_id` int(11) NOT NULL COMMENT'role ID',
   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT ='Project Member Table' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
