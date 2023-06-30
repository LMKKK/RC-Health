/*
 Navicat Premium Data Transfer

 Source Server         : MySQL8
 Source Server Type    : MySQL
 Source Server Version : 80031 (8.0.31)
 Source Host           : localhost:3306
 Source Schema         : health_system

 Target Server Type    : MySQL
 Target Server Version : 80031 (8.0.31)
 File Encoding         : 65001

 Date: 30/06/2023 12:36:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for appointment
-- ----------------------------
DROP TABLE IF EXISTS `appointment`;
CREATE TABLE `appointment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `appointment_people_id` int NULL DEFAULT NULL COMMENT '预约人ID',
  `appointment_people` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '预约人',
  `appointment_time` datetime NULL DEFAULT NULL COMMENT '预约时间',
  `meal_id` int NULL DEFAULT NULL COMMENT '套餐ID',
  `meal_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '套餐名称',
  `remark` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '说明',
  `create_people` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_del` int NOT NULL DEFAULT 0 COMMENT '删除标志：0，正常，1，删除',
  `group_ids` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `meal_id`(`meal_id` ASC) USING BTREE,
  INDEX `appointment_people_id`(`appointment_people_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '预约信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of appointment
-- ----------------------------
INSERT INTO `appointment` VALUES (12, 28, 'lmk', '2023-06-24 00:00:00', 5, '普通体检', NULL, 'lmk', '2023-06-24 16:10:14', '2023-06-27 14:38:55', 1, NULL);
INSERT INTO `appointment` VALUES (16, 45, 'dxy', '2023-06-27 00:00:00', 7, '入职体检套餐', NULL, 'dxy', '2023-06-27 14:29:38', NULL, 0, NULL);
INSERT INTO `appointment` VALUES (17, 28, 'lmk', '2023-06-28 00:00:00', 9, '老年体检套餐', NULL, 'lmk', '2023-06-27 14:38:51', NULL, 0, NULL);
INSERT INTO `appointment` VALUES (18, 45, '丁向阳', '2023-06-29 00:00:00', 8, '青少年体检', NULL, '丁向阳', '2023-06-27 22:07:38', NULL, 0, NULL);
INSERT INTO `appointment` VALUES (19, 45, '丁向阳', '2023-06-30 00:00:00', 9, '老年体检套餐', '88', '丁向阳', '2023-06-27 22:08:44', NULL, 0, NULL);
INSERT INTO `appointment` VALUES (20, 54, '我是miniK', '2023-06-30 00:00:00', 9, '老年体检套餐', '我身体倍棒儿~~~', '我是miniK', '2023-06-28 18:00:13', NULL, 0, NULL);
INSERT INTO `appointment` VALUES (21, 45, '丁向阳', '2023-06-30 00:00:00', 0, '自定义', NULL, '丁向阳', '2023-06-28 22:41:05', NULL, 0, '7,12');
INSERT INTO `appointment` VALUES (22, 45, '丁向阳', '2023-06-28 00:00:00', 0, '自定义', '自定义检查组测试', '丁向阳', '2023-06-28 22:44:44', NULL, 0, '12,10');
INSERT INTO `appointment` VALUES (23, 54, '我是miniK', '2023-06-28 00:00:00', 0, '自定义', NULL, '我是miniK', '2023-06-28 23:24:57', NULL, 0, '7,9');
INSERT INTO `appointment` VALUES (24, 32, '王思博', '2023-07-01 00:00:00', 0, '自定义', '我快要不行了！！！', '王思博', '2023-06-29 12:15:44', NULL, 0, '11,7');
INSERT INTO `appointment` VALUES (25, 32, '王思博', '2023-06-29 00:00:00', 9, '老年体检套餐', '我要入住养老院了，需要体检', '王思博', '2023-06-29 12:27:34', NULL, 0, NULL);
INSERT INTO `appointment` VALUES (26, 45, '丁向阳', '2023-06-30 00:00:00', 0, '自定义', NULL, '丁向阳', '2023-06-30 09:29:21', NULL, 0, '7,8');

-- ----------------------------
-- Table structure for appointment_rule
-- ----------------------------
DROP TABLE IF EXISTS `appointment_rule`;
CREATE TABLE `appointment_rule`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `month` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '预约月份',
  `day` date NULL DEFAULT NULL COMMENT '预约时间',
  `limit_people` int NULL DEFAULT NULL COMMENT '可预约人数',
  `remark` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '备注说明',
  `create_people` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_del` int NOT NULL DEFAULT 0 COMMENT '删除标志：0，正常，1，删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '预约管理(规则)' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of appointment_rule
-- ----------------------------
INSERT INTO `appointment_rule` VALUES (1, '2023-06', '2023-06-21', 1, NULL, '管理员', '2023-06-21 14:48:31', '2023-06-23 17:54:11', 0);
INSERT INTO `appointment_rule` VALUES (2, '2023-06', '2023-06-22', 77, NULL, '管理员', '2023-06-21 14:48:51', NULL, 0);
INSERT INTO `appointment_rule` VALUES (3, '2023-06', '2023-06-28', 178, NULL, '管理员', '2023-06-21 14:49:24', '2023-06-21 14:49:45', 0);
INSERT INTO `appointment_rule` VALUES (4, '2023-06', '2023-06-24', 80, NULL, '管理员', '2023-06-21 15:01:11', NULL, 0);
INSERT INTO `appointment_rule` VALUES (5, '2023-06', '2023-06-23', 74, NULL, '管理员', '2023-06-21 15:01:14', NULL, 0);
INSERT INTO `appointment_rule` VALUES (6, '2023-06', '2023-06-30', 76, NULL, '管理员', '2023-06-23 15:51:32', NULL, 0);
INSERT INTO `appointment_rule` VALUES (7, '2023-06', '2023-06-29', 20, NULL, '管理员', '2023-06-23 15:51:35', '2023-06-23 17:55:15', 0);
INSERT INTO `appointment_rule` VALUES (8, '2023-06', '2023-06-27', 10, NULL, '管理员', '2023-06-23 17:59:05', '2023-06-27 14:25:05', 0);
INSERT INTO `appointment_rule` VALUES (9, '2023-06', '2023-06-26', 1, NULL, '管理员', '2023-06-23 17:59:09', NULL, 0);
INSERT INTO `appointment_rule` VALUES (10, '2023-06', '2023-06-19', 1, NULL, '管理员', '2023-06-23 17:59:10', NULL, 0);
INSERT INTO `appointment_rule` VALUES (11, '2023-06', '2023-06-20', 1, NULL, '管理员', '2023-06-23 17:59:12', NULL, 0);
INSERT INTO `appointment_rule` VALUES (12, '2023-06', '2023-06-18', 12, NULL, '管理员', '2023-06-23 17:59:19', NULL, 0);
INSERT INTO `appointment_rule` VALUES (13, '2023-06', '2023-06-25', 12, NULL, '管理员', '2023-06-23 17:59:21', NULL, 0);
INSERT INTO `appointment_rule` VALUES (14, '2023-06', '2023-06-17', 12, NULL, '管理员', '2023-06-23 17:59:23', NULL, 0);
INSERT INTO `appointment_rule` VALUES (15, '2023-06', '2023-06-14', 12, NULL, '管理员', '2023-06-24 19:39:39', '2023-06-24 19:40:11', 0);
INSERT INTO `appointment_rule` VALUES (16, '2023-06', '2023-06-13', 232, NULL, '管理员', '2023-06-24 19:40:14', NULL, 0);
INSERT INTO `appointment_rule` VALUES (17, '2023-06', '2023-06-09', 234, NULL, '管理员', '2023-06-24 19:40:35', NULL, 0);
INSERT INTO `appointment_rule` VALUES (18, '2023-06', '2023-06-01', 10, NULL, '管理员', '2023-06-25 11:19:57', NULL, 0);
INSERT INTO `appointment_rule` VALUES (19, '2023-06', '2023-06-02', 9, NULL, '管理员', '2023-06-25 11:20:19', NULL, 0);
INSERT INTO `appointment_rule` VALUES (20, '2023-06', '2023-06-03', 15, NULL, '管理员', '2023-06-25 11:20:41', NULL, 0);
INSERT INTO `appointment_rule` VALUES (21, '2023-06', '2023-06-10', 57, NULL, '管理员', '2023-06-25 11:20:42', '2023-06-25 11:23:32', 0);
INSERT INTO `appointment_rule` VALUES (22, '2023-06', '2023-06-04', 67, NULL, '管理员', '2023-06-25 11:21:39', NULL, 0);
INSERT INTO `appointment_rule` VALUES (23, '2023-06', '2023-06-05', 56, NULL, '管理员', '2023-06-25 11:22:06', NULL, 0);
INSERT INTO `appointment_rule` VALUES (24, '2023-06', '2023-06-06', 35, NULL, '管理员', '2023-06-25 11:22:24', NULL, 0);
INSERT INTO `appointment_rule` VALUES (25, '2023-06', '2023-06-07', 23, NULL, '管理员', '2023-06-25 11:22:36', NULL, 0);
INSERT INTO `appointment_rule` VALUES (26, '2023-06', '2023-06-08', 56, NULL, '管理员', '2023-06-25 11:22:51', NULL, 0);
INSERT INTO `appointment_rule` VALUES (27, '2023-06', '2023-06-11', 53, NULL, '管理员', '2023-06-25 11:22:54', '2023-06-25 11:23:47', 0);
INSERT INTO `appointment_rule` VALUES (28, '2023-06', '2023-06-12', 75, NULL, '管理员', '2023-06-25 11:24:17', '2023-06-25 11:24:43', 0);
INSERT INTO `appointment_rule` VALUES (29, '2023-06', '2023-06-15', 48, NULL, '管理员', '2023-06-25 11:24:37', NULL, 0);
INSERT INTO `appointment_rule` VALUES (31, '2023-06', '2023-06-16', 86, NULL, '管理员', '2023-06-25 11:25:16', NULL, 0);
INSERT INTO `appointment_rule` VALUES (32, '2023-07', '2023-07-01', 1, NULL, '管理员', '2023-06-28 22:43:35', NULL, 0);
INSERT INTO `appointment_rule` VALUES (33, '2023-07', '2023-07-02', 5, NULL, '管理员', '2023-06-29 13:57:20', NULL, 0);
INSERT INTO `appointment_rule` VALUES (34, '2023-07', '2023-07-03', 56, NULL, '管理员', '2023-06-29 13:57:26', NULL, 0);
INSERT INTO `appointment_rule` VALUES (35, '2023-07', '2023-07-04', 76, NULL, '管理员', '2023-06-29 13:57:31', NULL, 0);
INSERT INTO `appointment_rule` VALUES (36, '2023-07', '2023-07-05', 37, NULL, '管理员', '2023-06-29 13:57:39', NULL, 0);
INSERT INTO `appointment_rule` VALUES (37, '2023-07', '2023-07-06', 10, NULL, '管理员', '2023-06-29 13:57:46', NULL, 0);

-- ----------------------------
-- Table structure for check_files
-- ----------------------------
DROP TABLE IF EXISTS `check_files`;
CREATE TABLE `check_files`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `sex` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '性别',
  `age` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `card_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号',
  `phone` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电话',
  `address` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '住址',
  `weight` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '体重',
  `height` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '身高',
  `blood_type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '血型',
  `medical_history` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '既往病史',
  `remark` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '说明',
  `create_people` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_del` int NOT NULL DEFAULT 0 COMMENT '删除标志：0，正常，1，删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '健康档案信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of check_files
-- ----------------------------
INSERT INTO `check_files` VALUES (1, 21, '杨用户', '男', '80', 'dasdasd', 'asd', 'dasd', 'dasd', 'dasd', 'dasdd', 'asd', 'dsd', '杨用户', '2023-06-23 19:11:24', NULL, 0);
INSERT INTO `check_files` VALUES (2, 29, '测试用户', '男', '18', '23333', '125231', '山东省', '60', '178', 'B', '无', '无', '测试用户', '2023-06-24 20:02:07', NULL, 0);
INSERT INTO `check_files` VALUES (3, 31, 'abc', '女', '19', '2342342', NULL, NULL, '45', '119', 'A', '恋爱脑', '无', 'sss', '2023-06-24 20:05:23', NULL, 0);
INSERT INTO `check_files` VALUES (4, 45, '丁向阳', '男', '18', '37232120', '2131231', '荣成市-崖头街道- -哈理工', '79', '178', 'B', '人傻', '无', 'dxy', '2023-06-27 14:31:09', '2023-06-30 12:35:05', 0);
INSERT INTO `check_files` VALUES (5, 54, '刘明凯', '男', '18', '37232120', '18254321828', '荣成市-夏庄镇-战家村委会-76号居民楼5单元5号', '60', '178', 'O', '精神不正常、精神涣散、恋爱脑、大脑残', '无', '我是miniK', '2023-06-27 17:07:37', '2023-06-30 12:34:59', 0);
INSERT INTO `check_files` VALUES (6, 54, '刘明凯', '男', '18', '37232120', '18254321828', '荣成市-夏庄镇-战家村委会-76号居民楼5单元5号', '78', '178', 'B', '多动症、焦虑症、烦死了你丫的', '无', '我是miniK', '2023-06-27 19:47:43', '2023-06-30 12:34:54', 0);
INSERT INTO `check_files` VALUES (7, 45, '丁向阳', '男', '18', '37232120010', '18254321828', '荣成市-港湾街道-渔港社区居委会-哈理工', '77', '189', 'RH', '猎杀对决开了房间阿卡丽', '阿斯顿发大水', '丁向阳', '2023-06-28 20:54:42', '2023-06-30 12:35:08', 0);
INSERT INTO `check_files` VALUES (8, 45, '丁向阳', '男', '18', '372321200', '18254321828', '荣成市-港湾街道-渔港社区居委会-哈理工', '78', '78', 'B', '阿萨德开发科塑料袋', '阿法法师', '丁向阳', '2023-06-28 21:05:24', '2023-06-30 12:35:12', 0);
INSERT INTO `check_files` VALUES (9, 45, '丁向阳', '男', '18', '372321200109', '18254321828', '荣成市-港湾街道-渔港社区居委会-哈理工', NULL, NULL, NULL, NULL, NULL, '丁向阳', '2023-06-30 09:40:44', '2023-06-30 12:35:17', 0);

-- ----------------------------
-- Table structure for check_group
-- ----------------------------
DROP TABLE IF EXISTS `check_group`;
CREATE TABLE `check_group`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `items_ids` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '选中的项目ID集合',
  `number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '检查组编码',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称',
  `suit_sex` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '适用性别',
  `mnemonic_code` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '助记码',
  `duty_doctor_id` int NULL DEFAULT NULL COMMENT '负责医生ID',
  `duty_doctor_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '负责医生名称',
  `remark` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '说明',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_del` int NOT NULL DEFAULT 0 COMMENT '删除标志：0，正常，1，删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `duty_doctor_id`(`duty_doctor_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '检查组信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of check_group
-- ----------------------------
INSERT INTO `check_group` VALUES (7, '16,17,18', '0001', '血常规', '女', 'XCG', 28, 'lmk', NULL, '2023-06-24 21:51:07', '2023-06-24 21:51:16', 0);
INSERT INTO `check_group` VALUES (8, '20,21,28,29', '0002', '视力检查', '不限', 'EYE', NULL, NULL, NULL, '2023-06-24 22:41:32', '2023-06-24 22:41:49', 0);
INSERT INTO `check_group` VALUES (9, '24,25', '0003', '听力检查', '不限', 'EAR', 28, 'lmk', '听力检查', '2023-06-25 20:28:24', '2023-06-25 20:29:00', 0);
INSERT INTO `check_group` VALUES (10, '28,29', '0004', '验光检查', '不限', 'eye-lay', 55, '刘医生', NULL, '2023-06-25 20:41:01', '2023-06-25 20:47:14', 0);
INSERT INTO `check_group` VALUES (11, '32,33', '0005', '尿常规', '不限', 'NJ', 59, '张医生', NULL, '2023-06-25 20:51:35', '2023-06-25 21:26:36', 0);
INSERT INTO `check_group` VALUES (12, '31,30', '0006', '血压检查', '不限', 'XY', NULL, NULL, NULL, '2023-06-25 21:03:03', NULL, 0);

-- ----------------------------
-- Table structure for check_items
-- ----------------------------
DROP TABLE IF EXISTS `check_items`;
CREATE TABLE `check_items`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '项目编码',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '项目名称',
  `suit_sex` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '适用性别',
  `suit_age` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '适用年龄',
  `remark` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '说明',
  `create_people` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `state` int NOT NULL DEFAULT 0 COMMENT '状态',
  `is_del` int NOT NULL DEFAULT 0 COMMENT '删除标志：0，正常，1，删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '体检项目' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of check_items
-- ----------------------------
INSERT INTO `check_items` VALUES (16, '0001', '红细胞浓度', '不限', '0-100', NULL, '管理员', '2023-06-24 21:40:22', NULL, 0, 0);
INSERT INTO `check_items` VALUES (17, '0002', '白细胞浓度', '不限', '0-100', NULL, '管理员', '2023-06-24 21:40:38', NULL, 0, 0);
INSERT INTO `check_items` VALUES (18, '0003', '蛋白质浓度', '不限', '0-100', NULL, '管理员', '2023-06-24 21:40:58', NULL, 0, 0);
INSERT INTO `check_items` VALUES (19, '0004', '汗毛数量', '不限', '0-100', NULL, '管理员', '2023-06-24 21:42:02', NULL, 0, 0);
INSERT INTO `check_items` VALUES (20, '0005', '左眼视力', '不限', '0-100', NULL, '管理员', '2023-06-24 21:42:24', NULL, 0, 0);
INSERT INTO `check_items` VALUES (21, '0006', '右眼视力', '不限', '0-100', NULL, '管理员', '2023-06-24 21:44:03', NULL, 0, 0);
INSERT INTO `check_items` VALUES (22, '0007', 'asss', '不限', '0-100', NULL, '管理员', '2023-06-24 21:44:12', '2023-06-24 22:14:02', 0, 1);
INSERT INTO `check_items` VALUES (23, '0008', 'abcc', '不限', '0-100', NULL, '管理员', '2023-06-24 21:44:16', '2023-06-24 21:44:34', 0, 1);
INSERT INTO `check_items` VALUES (24, '0007', '左耳听力', '不限', '0-100', NULL, '管理员', '2023-06-24 22:27:56', '2023-06-25 20:38:46', 0, 0);
INSERT INTO `check_items` VALUES (25, '0008', '右耳听力', '男', '0-100', NULL, '管理员', '2023-06-24 22:35:44', '2023-06-24 22:35:50', 0, 0);
INSERT INTO `check_items` VALUES (26, '0009', '雄性激素浓度', '女', '0-100', NULL, '管理员', '2023-06-24 22:36:07', '2023-06-24 22:37:45', 0, 0);
INSERT INTO `check_items` VALUES (27, '0010', '眼角膜厚度', '不限', '0-100', NULL, '管理员', '2023-06-24 22:38:01', '2023-06-24 22:39:54', 0, 0);
INSERT INTO `check_items` VALUES (28, '0011', '左眼散光', '不限', '0-100', '左眼散光度数', '管理员', '2023-06-25 20:39:14', NULL, 0, 0);
INSERT INTO `check_items` VALUES (29, '0012', '右眼散光', '不限', '0-100', '右眼散光度数', '管理员', '2023-06-25 20:39:30', '2023-06-28 23:34:14', 0, 0);
INSERT INTO `check_items` VALUES (30, '0013', '收缩压', '不限', '0-100', NULL, '管理员', '2023-06-25 20:57:48', NULL, 0, 0);
INSERT INTO `check_items` VALUES (31, '0014', '舒张压', '不限', '0-100', NULL, '管理员', '2023-06-25 20:58:11', NULL, 0, 0);
INSERT INTO `check_items` VALUES (32, '0015', '尿白细胞', '不限', '0-100', '单位 个/HP', '管理员', '2023-06-25 21:25:21', NULL, 0, 0);
INSERT INTO `check_items` VALUES (33, '0016', '尿红细胞', '不限', '0-100', '单位 个/HP', '管理员', '2023-06-25 21:26:02', NULL, 0, 0);

-- ----------------------------
-- Table structure for check_items_data
-- ----------------------------
DROP TABLE IF EXISTS `check_items_data`;
CREATE TABLE `check_items_data`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `appointment_id` int NULL DEFAULT NULL COMMENT '预约ID',
  `meal_id` int NULL DEFAULT NULL COMMENT '套餐ID',
  `meal_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '套餐名称',
  `group_id` int NULL DEFAULT NULL COMMENT '检查组ID',
  `group_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '检查组名称',
  `item_id` int NULL DEFAULT NULL COMMENT '体检项目ID',
  `item_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '体检项目名称',
  `item_value` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '体检项目值',
  `user_id` int NULL DEFAULT NULL COMMENT '体检人员ID',
  `user_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '体检人员名称',
  `check_time` datetime NULL DEFAULT NULL COMMENT '体检日期',
  `remark` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '说明',
  `create_people` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_del` int NOT NULL DEFAULT 0 COMMENT '删除标志：0，正常，1，删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `groupId`(`group_id` ASC) USING BTREE,
  INDEX `appointment_id`(`appointment_id` ASC) USING BTREE,
  INDEX `meal_id`(`meal_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '每个体检项数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of check_items_data
-- ----------------------------
INSERT INTO `check_items_data` VALUES (11, 12, 5, '普通体检', 6, '血常规', 6, '红细胞浓度', '11', 28, 'lmk', '2023-06-24 16:18:52', NULL, 'lmk', '2023-06-24 16:18:51', NULL, 0);
INSERT INTO `check_items_data` VALUES (12, 12, 5, '普通体检', 6, '血常规', 7, '白细胞浓度', '11', 28, 'lmk', '2023-06-24 16:18:52', NULL, 'lmk', '2023-06-24 16:18:51', NULL, 0);
INSERT INTO `check_items_data` VALUES (13, 12, 5, '普通体检', 6, '血常规', 8, '血小板浓度', '11', 28, 'lmk', '2023-06-24 16:18:52', NULL, 'lmk', '2023-06-24 16:18:51', NULL, 0);
INSERT INTO `check_items_data` VALUES (14, 11, 5, '普通体检', 6, '血常规', 6, '红细胞浓度', '989', 29, '用户1672514829035773954', '2023-06-24 16:21:21', NULL, '用户1672514829035773954', '2023-06-24 16:21:21', NULL, 0);
INSERT INTO `check_items_data` VALUES (15, 11, 5, '普通体检', 6, '血常规', 7, '白细胞浓度', '19', 29, '用户1672514829035773954', '2023-06-24 16:21:21', NULL, '用户1672514829035773954', '2023-06-24 16:21:21', NULL, 0);
INSERT INTO `check_items_data` VALUES (16, 11, 5, '普通体检', 6, '血常规', 8, '血小板浓度', '113', 29, '用户1672514829035773954', '2023-06-24 16:21:21', NULL, '用户1672514829035773954', '2023-06-24 16:21:21', NULL, 0);
INSERT INTO `check_items_data` VALUES (17, 13, 6, '入职体检', 6, '血常规', 6, '红细胞浓度', '123', 29, '测试用户', '2023-06-24 19:32:36', NULL, '测试用户', '2023-06-24 19:32:35', NULL, 0);
INSERT INTO `check_items_data` VALUES (18, 13, 6, '入职体检', 6, '血常规', 7, '白细胞浓度', '22', 29, '测试用户', '2023-06-24 19:32:36', NULL, '测试用户', '2023-06-24 19:32:35', NULL, 0);
INSERT INTO `check_items_data` VALUES (19, 13, 6, '入职体检', 6, '血常规', 8, '血小板浓度', '99', 29, '测试用户', '2023-06-24 19:32:36', NULL, '测试用户', '2023-06-24 19:32:35', NULL, 0);
INSERT INTO `check_items_data` VALUES (20, 13, 6, '入职体检', 1, '88888888888', 9, '身高', '180', 29, '测试用户', '2023-06-24 19:33:07', NULL, '测试用户', '2023-06-24 19:33:07', NULL, 0);
INSERT INTO `check_items_data` VALUES (21, 13, 6, '入职体检', 1, '88888888888', 10, '体重', '90', 29, '测试用户', '2023-06-24 19:33:07', NULL, '测试用户', '2023-06-24 19:33:07', NULL, 0);
INSERT INTO `check_items_data` VALUES (22, 16, 7, '入职体检套餐', 7, '血常规', 16, '红细胞浓度', '35', 45, 'dxy', '2023-06-27 22:05:29', NULL, 'lmk', '2023-06-27 14:34:54', '2023-06-27 22:05:28', 0);
INSERT INTO `check_items_data` VALUES (23, 16, 7, '入职体检套餐', 7, '血常规', 17, '白细胞浓度', '12', 45, 'dxy', '2023-06-27 22:05:29', NULL, 'lmk', '2023-06-27 14:34:54', '2023-06-27 22:05:29', 0);
INSERT INTO `check_items_data` VALUES (24, 16, 7, '入职体检套餐', 7, '血常规', 18, '蛋白质浓度', '123', 45, 'dxy', '2023-06-27 22:05:29', NULL, 'lmk', '2023-06-27 14:34:54', '2023-06-27 22:05:29', 0);
INSERT INTO `check_items_data` VALUES (25, 16, 7, '入职体检套餐', 9, '听力检查', 24, '左耳听力', '5.2', 45, 'dxy', '2023-06-27 22:05:29', NULL, 'lmk', '2023-06-27 14:34:54', '2023-06-27 22:05:29', 0);
INSERT INTO `check_items_data` VALUES (26, 16, 7, '入职体检套餐', 9, '听力检查', 25, '右耳听力', '12', 45, 'dxy', '2023-06-27 22:05:29', NULL, 'lmk', '2023-06-27 14:34:54', '2023-06-27 22:05:29', 0);
INSERT INTO `check_items_data` VALUES (27, 17, 9, '老年体检套餐', 9, '听力检查', 24, '左耳听力', '12', 28, 'lmk', '2023-06-28 20:41:39', NULL, 'lmk', '2023-06-27 21:43:15', '2023-06-27 21:50:08', 0);
INSERT INTO `check_items_data` VALUES (28, 17, 9, '老年体检套餐', 9, '听力检查', 25, '右耳听力', '78', 28, 'lmk', '2023-06-28 20:41:39', NULL, 'lmk', '2023-06-27 21:43:15', '2023-06-27 21:50:08', 0);
INSERT INTO `check_items_data` VALUES (29, 15, 7, '入职体检套餐', 7, '血常规', 16, '红细胞浓度', '12', 59, '用户1673576404140277762', '2023-06-27 22:01:33', NULL, NULL, '2023-06-27 22:00:11', '2023-06-27 22:01:32', 0);
INSERT INTO `check_items_data` VALUES (30, 15, 7, '入职体检套餐', 7, '血常规', 17, '白细胞浓度', '78', 59, '用户1673576404140277762', '2023-06-27 22:01:33', NULL, NULL, '2023-06-27 22:00:11', '2023-06-27 22:01:32', 0);
INSERT INTO `check_items_data` VALUES (31, 15, 7, '入职体检套餐', 7, '血常规', 18, '蛋白质浓度', '98', 59, '用户1673576404140277762', '2023-06-27 22:01:33', NULL, NULL, '2023-06-27 22:00:11', '2023-06-27 22:01:32', 0);
INSERT INTO `check_items_data` VALUES (32, 15, 7, '入职体检套餐', 9, '听力检查', 24, '左耳听力', '77', 59, '用户1673576404140277762', '2023-06-27 22:01:33', NULL, NULL, '2023-06-27 22:00:11', '2023-06-27 22:01:32', 0);
INSERT INTO `check_items_data` VALUES (33, 15, 7, '入职体检套餐', 9, '听力检查', 25, '右耳听力', '99', 59, '用户1673576404140277762', '2023-06-27 22:01:33', NULL, NULL, '2023-06-27 22:00:11', '2023-06-27 22:01:32', 0);
INSERT INTO `check_items_data` VALUES (34, 19, 9, '老年体检套餐', 9, '听力检查', 24, '左耳听力', '21', 45, '丁向阳', '2023-06-27 22:28:07', NULL, 'lmk', '2023-06-27 22:09:00', '2023-06-27 22:28:07', 0);
INSERT INTO `check_items_data` VALUES (35, 19, 9, '老年体检套餐', 9, '听力检查', 25, '右耳听力', '22', 45, '丁向阳', '2023-06-27 22:28:08', NULL, 'lmk', '2023-06-27 22:09:00', '2023-06-27 22:28:07', 0);
INSERT INTO `check_items_data` VALUES (36, 23, 0, '自定义', 7, '血常规', 16, '红细胞浓度', '78', 54, '我是miniK', '2023-06-28 23:25:29', NULL, 'lmk', '2023-06-28 23:25:29', NULL, 0);
INSERT INTO `check_items_data` VALUES (37, 23, 0, '自定义', 7, '血常规', 17, '白细胞浓度', '65', 54, '我是miniK', '2023-06-28 23:25:29', NULL, 'lmk', '2023-06-28 23:25:29', NULL, 0);
INSERT INTO `check_items_data` VALUES (38, 23, 0, '自定义', 7, '血常规', 18, '蛋白质浓度', '98', 54, '我是miniK', '2023-06-28 23:25:29', NULL, 'lmk', '2023-06-28 23:25:29', NULL, 0);
INSERT INTO `check_items_data` VALUES (39, 23, 0, '自定义', 9, '听力检查', 24, '左耳听力', '12', 54, '我是miniK', '2023-06-28 23:25:29', NULL, 'lmk', '2023-06-28 23:25:29', NULL, 0);
INSERT INTO `check_items_data` VALUES (40, 23, 0, '自定义', 9, '听力检查', 25, '右耳听力', '4', 54, '我是miniK', '2023-06-28 23:25:29', NULL, 'lmk', '2023-06-28 23:25:29', NULL, 0);
INSERT INTO `check_items_data` VALUES (41, 25, 9, '老年体检套餐', 9, '听力检查', 24, '左耳听力', '123', 32, '王思博', '2023-06-29 12:29:52', NULL, 'lmk', '2023-06-29 12:29:52', NULL, 0);
INSERT INTO `check_items_data` VALUES (42, 25, 9, '老年体检套餐', 9, '听力检查', 25, '右耳听力', '23', 32, '王思博', '2023-06-29 12:29:52', NULL, 'lmk', '2023-06-29 12:29:52', NULL, 0);
INSERT INTO `check_items_data` VALUES (43, 26, 0, '自定义', 7, '血常规', 16, '红细胞浓度', '12', 45, '丁向阳', '2023-06-30 09:31:12', NULL, 'lmk', '2023-06-30 09:31:12', NULL, 0);
INSERT INTO `check_items_data` VALUES (44, 26, 0, '自定义', 7, '血常规', 17, '白细胞浓度', '32', 45, '丁向阳', '2023-06-30 09:31:12', NULL, 'lmk', '2023-06-30 09:31:12', NULL, 0);
INSERT INTO `check_items_data` VALUES (45, 26, 0, '自定义', 7, '血常规', 18, '蛋白质浓度', '43', 45, '丁向阳', '2023-06-30 09:31:12', NULL, 'lmk', '2023-06-30 09:31:12', NULL, 0);
INSERT INTO `check_items_data` VALUES (46, 20, 9, '老年体检套餐', 7, '血常规', 16, '红细胞浓度', '18', 54, '我是miniK', '2023-06-30 12:02:29', NULL, 'lmk', '2023-06-30 12:02:28', NULL, 0);
INSERT INTO `check_items_data` VALUES (47, 20, 9, '老年体检套餐', 7, '血常规', 17, '白细胞浓度', '87', 54, '我是miniK', '2023-06-30 12:02:29', NULL, 'lmk', '2023-06-30 12:02:28', NULL, 0);
INSERT INTO `check_items_data` VALUES (48, 20, 9, '老年体检套餐', 7, '血常规', 18, '蛋白质浓度', '12', 54, '我是miniK', '2023-06-30 12:02:29', NULL, 'lmk', '2023-06-30 12:02:28', NULL, 0);
INSERT INTO `check_items_data` VALUES (49, 20, 9, '老年体检套餐', 9, '听力检查', 24, '左耳听力', '767', 54, '我是miniK', '2023-06-30 12:02:29', NULL, 'lmk', '2023-06-30 12:02:28', NULL, 0);
INSERT INTO `check_items_data` VALUES (50, 20, 9, '老年体检套餐', 9, '听力检查', 25, '右耳听力', '22', 54, '我是miniK', '2023-06-30 12:02:29', NULL, 'lmk', '2023-06-30 12:02:28', NULL, 0);

-- ----------------------------
-- Table structure for check_set_meal
-- ----------------------------
DROP TABLE IF EXISTS `check_set_meal`;
CREATE TABLE `check_set_meal`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '套餐编码',
  `group_ids` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '检查组ID',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '套餐名称',
  `suit_sex` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '适用性别',
  `suit_age` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '适用年龄',
  `mnemonic_code` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '助记码',
  `remark` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '说明',
  `create_people` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `state` int NOT NULL DEFAULT 0 COMMENT '状态',
  `is_del` int NOT NULL DEFAULT 0 COMMENT '删除标志：0，正常，1，删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '检查套餐' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of check_set_meal
-- ----------------------------
INSERT INTO `check_set_meal` VALUES (0, '0004', '', '自定义', '不限', NULL, 'CUSTOM', NULL, '管理员', '2023-06-28 22:00:39', '2023-06-28 22:01:08', 0, 0);
INSERT INTO `check_set_meal` VALUES (7, '0001', '7,9,8,11,12', '入职体检套餐', '不限', NULL, 'RZ', '快速入职必备！当天做，当天出结果', '管理员', '2023-06-25 21:42:00', NULL, 0, 0);
INSERT INTO `check_set_meal` VALUES (8, '0002', '8,10', '青少年体检', '不限', NULL, 'QSN', '', '管理员', '2023-06-25 21:44:26', NULL, 0, 0);
INSERT INTO `check_set_meal` VALUES (9, '0003', '9,7', '老年体检套餐', '不限', NULL, 'OLD', NULL, '管理员', '2023-06-25 21:45:02', '2023-06-30 09:07:38', 0, 0);

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '作者',
  `time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (5, '一胖毁所有？不，被你嫌弃多年的脂肪，其实好处不少', '<p>好不容易熬到春节，家里宰杀好了猪、牛、羊、鸡、鱼，年货零食堆满一桌。在外吃了一年外卖，大家都冲着这几天好好进补。</p><p>但在享受老母亲的投喂时，一个声音总在耳边响起：“别吃啦，再吃就胖出天际啦。”看着身上厚厚的脂肪，你满满的负罪感涌上心头……</p><p>其实，被你嫌弃的皮下脂肪（如位于臀部、髋部、手臂等处的脂肪），也有大作用。</p><p><br/></p><p><img src=\"https://pimg.39.net/PictureLib/A/f76/20230130/org_1619946473057816593.png\"/></p><p><br/></p><p>◎ 图：站酷海洛PLUS</p><p><strong>女性的皮下脂肪，可预防中风和老年痴呆的发生</strong></p><p>在人体中，脂肪组织主要分布在三大区域：上半身皮下脂肪、下半身皮下脂肪以及腹腔内脂肪。其中，皮下脂肪是贮存在皮下的脂肪组织，人体约有2/3的脂肪贮存在皮下组织。</p><p>前阵子，一项发表在国际顶级期刊《Diabetes》的研究表明，女性囤积在身体的皮下脂肪，可以在更年期前预防大脑炎症，减少中风和老年痴呆的发生风险。</p><p><br/></p><p><img src=\"https://pimg.39.net/PictureLib/A/f76/20230130/org_1619946465898139664.png\"/></p><p><br/></p><p>◎ 图：《Diabetes》网站截图</p><p>研究报告显示，女性倾向于沉积皮下脂肪，可起到预防大脑炎症的作用，这种情况至少会持续到更年期；而任何年龄的男性都更容易沉积内脏脂肪（即：将军肚），这种脂肪易引起炎症，诱发心脏病、中风等。</p><p><br/></p><p><img src=\"https://pimg.39.net/PictureLib/A/f76/20230130/org_1619946469673009169.png\"/></p><p><br/></p><p>◎ 图：站酷海洛PLUS</p><p>为了了解大脑是如何发炎的，研究人员观察了雄性和雌性肥胖小鼠在不同时间段脂肪组织数量、脂肪组织增加的位置、性激素水平、大脑炎症水平等情况。具体动物实验大致如下：</p><p>实验一：给小鼠投喂高脂饮食，与雄性小鼠相比，雌性小鼠在进入更年期前皮下脂肪更多，内脏脂肪更少，且未发现大脑炎症或胰岛素抵抗迹象（胰岛素抵抗可增加炎症并导致糖尿病）；待48周绝经后，雌性小鼠的脂肪位置开始囤积在内脏部位，与雄性小鼠相似。</p><p>实验二：切除小鼠的皮下脂肪，皮下脂肪的减少增加了雌性小鼠的大脑炎症，却没有改变雌激素和其他性激素的水平。而没有切除皮下脂肪的小鼠，即使是高脂饮食（该饮食可增加全身炎症），至更年期后才出现与雄性小鼠相似的大脑炎症表现。</p><p>实验三：给小鼠投喂低脂饮食，切除小鼠的皮下脂肪，小鼠内脏脂肪增加，身体出现炎症反应，但未出现大脑炎症。</p><p>根据实验，研究人员提出了新观点：在性别差异影响的脂肪组织差异分布背后，女性由于皮下脂肪组织的存在，能够提供更多的炎症保护，并可预防中风等神经系统疾病。</p><p><br/></p><p><img src=\"https://pimg.39.net/PictureLib/A/f76/20230130/org_1619946471132631056.png\"/></p><p><br/></p><p>◎ 图：站酷海洛PLUS</p><p><strong>别再盲目减肥，适量“囤脂”更健康</strong></p><p>“减肥、‘暴瘦’”一直是很多女性的健康与时尚追求，脂肪量的减少固然能让人更显苗条，但人没了脂肪，却是一件相当恐怖的事。</p><p>有一种病叫做“先天全身性脂肪营养不良综合症”，患有这种病的人，可表现出完全的皮下脂肪组织缺失，他们胃口巨大却伴随着代谢异常，脂肪在肝脏的异常堆积可造成肝损伤，诱发肝硬化，还会造成胰岛素拮抗，导致糖尿病，而且该类病人的血脂往往很高，可增加患急性胰腺炎的风险……</p><p><br/></p><p><img src=\"https://pimg.39.net/PictureLib/A/f76/20230130/org_1619946469249384457.png\"/></p><p><br/></p><p>◎ 图：站酷海洛PLUS</p><p>脂肪是人体重要的“余粮储存库”，可保护人体深层组织，在冬眠的哺乳动物中，皮下脂肪几乎提供过冬的全部能量。由于人类身上毛发少，冬天囤点脂肪，可起到御寒保暖的作用。</p><p>另外，随着医学对脂肪研究的逐渐深入，脂肪与机体其他组织间的关系也开始被人们所认识，如：体内脂肪是维持女性卵巢功能、生育功能的重要条件；女性脂肪量对股骨颈、全髋和腰椎骨密度具有正面影响；低皮下组织指数与女性肝硬化患者高病死率相关。</p><p>此前法国一项颠覆性的动物研究显示：脂肪组织在生物新陈代谢过程中发挥着重要作用，如白色脂肪组织中含有血液中的巨噬细胞和淋巴细胞，这两种细胞均是人体重要的免疫细胞。研究者还发现，小鼠脂肪组织竟能生成造血干细胞，而造血干细胞除了分化造血细胞外，还可分化出肥大细胞（一种免疫细胞，在机体抗击过敏和发炎中发挥着至关重要的作用）。</p><p><br/></p><p><img src=\"https://pimg.39.net/PictureLib/A/f76/20230130/org_1619946473032646672.png\"/></p><p><br/></p><p>◎ 图：站酷海洛PLUS</p><p>可见，脂肪并非洪水猛兽，它一直充当着人体的保护角色，我们应好好尊重它的存在。当然，过多脂肪堆积可引起病理性肥胖，增加高血压、高血脂、糖尿病等疾病的发生风险。通常我们用“体脂率”来反映人体内脂肪含量的多少，成人女性体脂率的正常范围为20%-25%，男性为15%-18%，若体脂率过高，依然需要“管住嘴、迈开腿”。</p>', '管理员', '2021-07-17 19:14:14');
INSERT INTO `news` VALUES (9, '美国CMS限制渤健Aduhelm医疗保险覆盖范围', '<h2 id=\"nfj37\"><p>就在渤健（Biogen）高管于日前举行的摩根大通医疗保健会议上，还在为其颇具争议的阿尔茨海默氏症药物Aduhelm辩护后仅一天，美国医疗保险和医疗补助服务中心（CMS）就发布了针对该药物一份拟议的国家保险范围确定（NCD） 决定备忘录。</p><p>拟议的覆盖范围将涵盖美国食品和药物管理局（FDA)）基于证据有条件批准（CED） 来治疗阿尔茨海默病的单克隆抗体，这意味着 FDA 批准的此类药物将仅当他们参加了合格的临床试验时才能使用 Medicare。拟议的覆盖范围在30天内向公众征求意见。</p><p>令人遗憾的是，这一决定对渤健来说并不是好消息，该草案宣布后不久，渤健股价就下跌超过8%。CMS直言，医疗保险只会支付该类药物和任何必要医学影像扫描的费用，而且前提是这类患者必须参加合格的临床试验。CMS表示，这些随机对照试验需要证明接受治疗的患者在认知和功能方面具有临床意义的益处。</p><p>Aduhelm于2021年6月获得美国食品和药品监督管理局（FDA）的加速批准，批准决定是基于生物标志物证据表明该药物清除了β-淀粉样蛋白，这是在阿尔茨海默病患者大脑中发现的两种异常蛋白质之一，另一个蛋白是tau。实际上，该疗法的临床益处（包括改善认知和记忆，或至少减缓记忆和认知恶化），并没有那么令人信服，在加速批准途径下，渤健被要求进行上市后IV期临床试验，提供足够的证据证明Aduhelm具有足够的临床益处。</p><p>2021年12月中旬，渤健宣布与其开发合作伙伴卫材（Eisai）一起，计划于2022年3月向FDA提交IV期试验的最终方案，并于今年5月开始患者筛查。两家公司预计将招募1300多名早期阿尔茨海默病患者，该试验的临床终点将安排在治疗开始后的18个月内，可能在研究开始后的四年内完成。自从该药物上市为止，保险公司支付这种药物的速度一直很慢，尽管该药物获得了美国FDA批准，但该药物很难被认为是医学治疗上所必需的疗法，更多地被认为是实验性的疗法。</p><p>美国CMS的决定可能会使得保险公司有更多机会拒绝支付治疗费用。这对渤健是又一个打击，但这一决定也会对许多其他目前正在开发针对阿尔茨海默病的药物、专注于清除β－淀粉样蛋白的生物制药公司产生影响。美国CMS声明的决定意味着，研发淀粉样蛋白的单克隆抗体的公司必须重新设计临床试验，更加专注于疗法的临床改进。有望受到该决定影响的其他公司还包括礼来和罗氏。</p><p>不过，美国CMS公告是初步的，随后将有30天的公众意见征询期，最终决定预计在3月或4月做出。目前，美国有超过600万人被诊断出患有阿尔茨海默病，这些患者中的大多数已经足够大，可以接受医疗保险。Aduhelm原始价格为每位患者每年56，000美元，12月下旬，为了提高药物的业绩，渤健将价格降低了一半至28，200美元。【相关阅读：业绩惨淡、质疑不休、副作用...渤健Aduhelm降价50%，能否打通销路？】</p><p><br/></p><p>美国CMS官员Chiquita Brooks-LaSure表示，阿尔茨海默病是一种灾难性的疾病，已经影响到数百万美国家庭的生活，在美国整个国家承保范围确定过程中，美国CMS一直并将继续致力于为美国公众提供明确、值得信赖、基于证据的决定，此次针对Aduhelm的决定只有在对公众对医疗保险患者承保的利益和风险的反馈进行全面分析后才能做出。Brooks-LaSure表示在美国CMS专家审查了Aduhelm所有相关的公开可用证据和利益相关者的反馈后，美国CMS提出了基于现实证据的医保覆盖政策，不过在最终确定此提案之前，美国CMS还有更多的机会听取医保患者、家人和护理人员，以及许多其他利益相关者的意见，包括患者权益团体、医疗专家、州政府和行业专业人士等。</p><p>参考来源：Medicare to Limit Coverage of Biogen\'s Aduhelm and Similar Drugs</p></h2>', '管理员', '2023-06-23 16:09:49');
INSERT INTO `news` VALUES (10, '画风突变！“瓦格纳”称击落俄军直升机，部队已入俄境，到底发生了什么？', '<p>一夜之间，“瓦格纳”画风突变。</p><p>俄罗斯联邦安全局宣布已对俄私营军事集团“瓦格纳”创始人普里戈任号召叛乱进行刑事立案，但普里戈任似乎不甘罢休，又扔出一个“重磅炸弹”。据外媒24日报道，普里戈任自称，“瓦格纳”部队已越过俄乌边界进入俄罗斯，并击落一俄军直升机。</p><p>据分析，普里戈任把矛头直指俄罗斯防长绍伊古，近期两者之间究竟发生了什么？</p><p><img src=\"https://news.ycwb.com/pic/2023-06/24/52031690_e9e6bbf1-c441-4c41-9bc5-d0e935fa5768copy.jpg\"/>普里戈任 资料图</p><p>综合多家外媒24日报道，俄私营军事集团“瓦格纳”创始人普里戈任在社交平台Telegram上发布一段音频中称，“瓦格纳”成员已越过俄乌边界“进入罗斯托夫地区”。普里戈任还称“将阻止任何摧毁我们的人”，并强调“这不是军事政变，而是正义的游行”，其还将矛头指向俄罗斯国防部长绍伊古，“我的部队将会惩罚绍伊古。”</p><p>据BBC报道，普里戈任在上述音频中称，“瓦格纳”成员在越过俄乌边界进入俄境内的过程中，被命令阻止他们的俄军退到一边允许通行，“瓦格纳”成员“现在正进入罗斯托夫地区”。罗斯托夫是俄罗斯一侧靠近俄乌边界的一个地区。据介绍，罗斯托夫州的首府——顿河畔罗斯托夫是俄罗斯南部军事总部所在地，也负责监督俄军在乌克兰的战斗。</p><p>不过，BBC称，该媒体无法证实普里戈任上述说法是否属实，目前也没有看到“瓦格纳”成员位于俄境内的图片或视频。</p><p>当天，普里戈任还表示，一架俄军直升机在俄罗斯罗斯托夫地区附近向民用车队开火，被“瓦格纳”部队击落。同样，普里戈任没有提供证据，媒体也未能证实他的说法。</p><p><img src=\"https://news.ycwb.com/pic/2023-06/24/52031690_22af231c-fccc-42b5-b32c-a877b85c8e47copy.jpg\"/>当地时间24日，根据塔斯社报道，俄罗斯首都莫斯科已加强安全措施</p><p>据报道，普里戈任23日指控，俄罗斯国防部军队袭击了“瓦格纳”雇佣军的营地，“瓦格纳”军人遭到“巨大损失”，他承诺会对此作出回应。他在社交平台称，其实自己已经准备向国防部妥协，但对方却发动了袭击，“消灭了很多人。”</p><p>当地时间23日，俄罗斯国防部发布声明称，在社交网络上以普里戈任名义传播的所有关于 “俄罗斯国防部对‘瓦格纳私人军事公司后方营地’进行打击 ”的消息和视频都是不真实的，是一种信息挑衅。俄国防部强调俄罗斯联邦武装力量继续在特别军事行动地区与乌克兰武装部队的接触线上执行战斗任务。</p><p>由于局势的严重性和可能在俄罗斯境内引发对抗，俄罗斯联邦安全局对普里戈任号召叛乱进行了刑事立案。</p><p>其实，普里戈任对俄罗斯国防部的不满早已备受关注。</p><p>据报道，俄罗斯国防部副部长潘科夫6月10日表示，将要求“志愿部队”直接与国防部签署合同。一些分析人士认为，此言意在针对俄罗斯私人军事集团“瓦格纳”。俄罗斯国防部宣称，此举是为了提高在乌克兰作战的俄罗斯部队的效率。据悉，这些合同必须在7月1日前签署。</p><p>当地时间6月11日，俄罗斯瓦格纳集团创始人普里戈任发表音频讲话，公开拒绝把瓦格纳集团归为俄罗斯国防部麾下。他表示，俄国防部长绍伊古无法管理好一支军队，“瓦格纳不会与绍伊古（俄国防部长）签署任何合同。”普里戈任在回应国防部声明时说，“绍伊古不能正确管理我们的部队。”</p><p><img src=\"https://news.ycwb.com/pic/2023-06/24/52031690_4203cab6-d25e-4f10-9d4e-3421728b5a6bcopy.png\"/>当地时间5月27日，顿涅茨克地区巴赫穆特，俄罗斯瓦格纳集团的军人在城市街道上</p><p>报道称，瓦格纳集团在俄乌冲突中发挥了重要作用，与俄罗斯正规军并肩作战。然而几个月来，普里戈任一直陷入与绍伊古和俄军总参谋长格拉西莫夫的公开争论之中。他多次指责这两人无能，并故意限制对在乌作战的“瓦格纳”部队的补给。<br/></p><p>据报道，表面上看，“瓦格纳”跟俄正规军没有任何直接关系，也未被正式登记在册，却参与了俄罗斯在叙利亚、乌克兰的军事行动，也曾在中非共和国、利比亚、苏丹等地参与保护油田及输油管道等重要设施的行动。如今，用英国军情部门的说法，“瓦格纳”是索列达尔和巴赫穆特战事的中坚力量。</p><p>瓦格纳集团何去何从？俄罗斯紧张局势未来如何影响俄乌冲突的走向？都令人担忧。</p>', '管理员', '2023-06-24 12:49:22');
INSERT INTO `news` VALUES (12, '测试阿里云OSS存储', '<p><img src=\"http://localhost:9090/files/11b3b0f9fb4d475f826178179d566855\" style=\"max-width:100%;\" contenteditable=\"false\"/><br/>这是我的图片</p>', '管理员', '2023-06-24 20:39:57');
INSERT INTO `news` VALUES (13, '我的文件为什么没有上传成功呢', '<p><img src=\"http://localhost:9090/files/9e6ce71b449d4e87b7fc6dec7d0c2494\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', '管理员', '2023-06-24 20:54:08');
INSERT INTO `news` VALUES (14, '获取真实文件上传路径', '<p><img src=\"http://localhost:9090/files/d72fe78dac794ba6bb53e617661462bd\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', '管理员', '2023-06-24 21:01:38');
INSERT INTO `news` VALUES (15, '甲流来势汹汹，是不是得过新冠的人更易感染？', '<p>高烧、咳嗽、刀片嗓、浑身难受……近些日子，这些熟悉的“感觉”又回来了，只是这一次导致医院发热门诊人满为患的并不是“新冠病毒”，而是甲型流感，没错就是每年都会定期出现被大家俗称的“甲流”。</p><p>这一次的“甲流”之所以被大家重视，除了其传播速度以及症状严重程度比往年更甚外，两者相似症状也让不少人担心是否是新冠“死灰复燃”，种种因素下，这次流感很快被推到了热搜第一的位置。</p><p><br/></p><p><img src=\"https://image.39.net/auth/w/20221027/1585459723841437696.jpg\"/><br/></p><p>经历过漫长的新冠，再到今年这波甲流，置身其中的人这才意识到：中国人对健康的焦虑，似乎达到了巅峰。</p><p><strong>01</strong></p><p><strong>甲流正在我国南北方快速传播，</strong></p><p><strong>比往年更严重</strong></p><p>从数字上看，甲流已经成为近段时间的主流疾病，阳性率和病例数都在不断上涨。</p><p>3月2日，国家流感中心发布的第741期“中国流感监测周报”显示，近3周流感病毒阳性率呈上升趋势，2023年第8周（2月20日-26日）为25.1%。此外，据中国疾控中心最新数据，仅3月2日一天，全国发热门诊就诊量就有30.4万人次，而哨点医院平均每4个流感样病例中，就有1人能检出流感病毒。</p><p>以北京市为例，该市2月底的流感样病例数较2019年同期上升了78%，甲型流感病毒占绝对优势，甲型H1N1亚型占64%、甲型H3N2亚型占35%，乙型流感占1%。</p><p>其实不单单是在中国，今年开春，全球的流感形势都很严峻，相比于以往，其传播速度以及造成的症状严重程度更甚，究其原因，“主要是新冠三年期间，大家都养成了戴口罩的习惯，个人防护做得比较好，因此既往3年，流感整体感染情况较低，人群感染率低的情况下，导致人体对流感病毒的免疫力较低，口罩脱掉后，流感病毒流行，这时身体由于没有对流感具有很强的抵抗力，就比较容易出现大范围流行。”中山大学附属第三医院感染科主任林炳亮在接受媒体采访时说道。</p><p><strong>专家预估，这波流感至少将会持续一个多月后才能结束。</strong></p><p><strong>02</strong></p><p><strong>恐慌：又一次疾病中的囤药风波</strong></p><p>感染人数持续上升后，医生发现药不够了！</p><p>与普通感冒需要的退烧药不同，针对甲流的特效药并不多，奥司他韦属于应用最为广泛的一类，成人和1岁以上的儿童均可以服用，根据《流行性感冒诊疗方案（2020年版）》中表示，对于重症，或有重症流感高危因素的流感样病例，应当尽早给予经验性抗流感病毒治疗，且最好在48小时内进行抗病毒治疗。</p><p>2月底，多地出现了奥司他韦短缺的情况，缺药的焦虑让国人又开始了新一轮的囤药潮，线上线下，几乎全面断货，黄牛手中的药价从几十元涨到了几百元。</p><p><br/></p><p><img src=\"https://image.39.net/auth/w/20200318/61289.jpg\"/><br/></p><p>其实，对于这样的画面并不陌生，去年从奥密克戎抢布洛芬、paxlovid，XBB1.5抢蒙脱石散，大家对于健康的焦虑，在新冠的影响下被刻意放大，第一时间想到的就是囤药，但等真正事后才发现，多数是“杞人忧天”，以布洛芬为例，奥密克戎的病程基本都是一周左右，多数不适症状仅有3天，需要布洛芬只有几颗，几盒几十盒囤的结果就是药品白白过期，而蒙脱石散的抢购甚至都还没有等来XBB1.5的出现。</p><p>专家表示，并不是每个患有流感的病人都需要服用抗病毒药物，甲流本身就属于季节性流感病毒感染，是自限性疾病，多数人在3-5天之后就会好转，且奥司他韦具有一定的耐药性，不宜长期服用。<strong>更为重要的是，奥司他韦是一种处方药物，应在医生的指导下使用。</strong></p><p>盲目的囤药反而会引发更多的危害，没有临床医生的指导，把多种消炎药、退烧药、感冒药联合起来服用，造成了急性肝损伤的病例比比皆是，有的人甚至为了及早预防吃药过度，住进了ICU。</p><p>原以为这个教训足够惨痛，但如今，剧情轮转到了甲流。</p><p><strong>03</strong></p><p><strong>被忽视的甲流疫苗</strong></p><p>这么多年来，流感的危害性一直被大家所忽视。</p><p>根据世界卫生组织的数据，流感每年在全球造成约300万-500万严重病例，以及约29万-65万例相关呼吸道疾病死亡，最近的一次大事件是2009年“猪流感”（H1N1流感）就造成全球约50万人死亡。</p><p><strong>和新冠一样，流感也会导致“白肺”的出现，在孕妇、老人、婴幼儿和慢性基础疾病患者中出现几率较大，十分危险。</strong></p><p>但它又不同于新冠，针对甲流的流感疫苗一直存在，作为最直接有效的手段，却被国人一直忽视。</p><p><br/></p><p><img src=\"https://image.39.net/auth/w/20221027/1585474756327641088.jpg\"/><br/></p><p>数据最能反映情况，中国疾控中心的副研究员彭质斌，曾在2022全国疫苗与健康大会上披露，2021-2022年流感流行季，我国疫苗接种率仅2.46%，相比之下，美国的流感疫苗接种率达到了52.1%。对于流感这样的呼吸系统传染病，接种率起码要达到50%以上，才能形成一定的群体保护。</p><p>为什么会出现这样的结果？专家表示还是认知不足，在一项针对疫苗接种调查显示<strong>，近4成的人认为自己身体好，不怕流感，3成的人甚至不知道流感疫苗。</strong></p><p>此外，由于流感属于二类疫苗，遵循居民自愿，自费接种原则，不少人不愿意花钱，再加上流感疫苗不像其他疫苗接种一次就行，流感病毒容易发生变异，目前的流感疫苗需要每年接种，这也导致了接种率低。</p><p>身边的人纷纷中招，等到你想到要接种流感疫苗时，往往又太迟了，专家表示，<strong>流感疫苗一般在接种2-4周后才能产生抗体</strong>，因此需要在流感来临前接种，此外，疫苗属于季节性供应疫苗，错过了9-12月，很多时候就打不了。</p><p>幸运的是，甲流属于季节性疾病，有再多的不适总会归于平静，但从人满为患的发热门诊里，从一系列的囤药风波中，我们总要学会什么，下一次疾病来临前，别再重蹈覆辙。</p>', '管理员', '2023-06-26 21:48:44');
INSERT INTO `news` VALUES (16, '2类药不能混吃，多吃可致肝肾衰竭！多人已中招', '<h1>2类药不能混吃，多吃可致肝肾衰竭！多人已中招</h1><p><i><a href=\"javascript:void(0);\" target=\"_self\"></a></i><i><a href=\"javascript:void(0);\" target=\"_self\"></a></i><i><a href=\"javascript:void(0);\" target=\"_self\"></a></i></p><p><i><a href=\"javascript:void(0);\" target=\"_self\"></a></i><i><a href=\"javascript:void(0);\" target=\"_self\"></a></i><i><a href=\"javascript:void(0);\" target=\"_self\"></a></i></p><p><i><a href=\"javascript:void(0);\" target=\"_self\">举报/反馈</a></i></p><p><em>2023-01-31 09:53:48</em><em><a href=\"http://www.39.net/\" target=\"_blank\">39健康网</a></em></p><p>栏目关注：<a href=\"http://wpdata.39.net/c1.htm?sp=0,98048,79038,23248&amp;target=http%3a%2f%2fpf.39.net%2fa%2f191228%2f7717114.html\">湿疹常识</a><a href=\"http://wpdata.39.net/c1.htm?sp=0,98049,79039,23248&amp;target=http%3a%2f%2fcare.39.net%2fdzbj%2f\">大众保健</a><a href=\"http://wpdata.39.net/c1.htm?sp=0,98044,79034,23248&amp;target=http%3a%2f%2fsex.39.net%2fa%2f170503%2f5350424.html\">健康完全手册</a><a href=\"http://wpdata.39.net/c1.htm?sp=0,98013,30791,23248&amp;target=http%3a%2f%2fnews.39.net%2fxinzhi%2f\">健康新知</a><a href=\"http://wpdata.39.net/c1.htm?sp=0,98047,79037,23248&amp;target=http%3a%2f%2fcm.39.net%2fa%2f2011329%2f1647183.html\">中医祛斑</a><a href=\"http://wpdata.39.net/c1.htm?sp=0,98046,79036,23248&amp;target=http%3a%2f%2fwoman.39.net%2fnxbj%2f\">女性保健</a></p><p><a href=\"http://wpdata.39.net/c1.htm?sp=0,129167,29437,22079&amp;target=http%3a%2f%2fhx.39.net%2fbytq%2f\">中医专业治疗鼻炎</a><a href=\"http://wpdata.39.net/c1.htm?sp=0,141438,110453,22079&amp;target=https%3a%2f%2fe.cn.miaozhen.com%2fr%2fk%3d6018610%26p%3dID4%26rt%3d2%26ns%3d__IP__%26ni%3d__IESID__%26v%3d__LOC__%26vo%3d3e7b36918%26vr%3d2%26o%3dhttp%253A%252F%252Fek.39.net%252Fbjtrtkj%252F\">北京同仁堂 关爱儿童健康</a><a href=\"http://wpdata.39.net/c1.htm?sp=0,97465,78498,22079&amp;target=http%3a%2f%2fdlt.zoosnet.net%2fLR%2fChatpre.aspx%3fid%3dDLT37277555%26lng%3dcn%26e%3d39_pc%26r%3d39_pc%26p%3d39_pc\">肛周湿疣中医治疗配方</a><a href=\"http://wpdata.39.net/c1.htm?sp=0,139806,109429,22079&amp;target=http%3a%2f%2fpdt.zoosnet.net%2fLR%2fChatpre.aspx%3fid%3dPDT82410052%26e%3d39ask%26r%3d39ask%26p%3d39ask\">前列腺炎治疗哪家医院好？</a><a href=\"http://wpdata.39.net/c1.htm?sp=0,97459,78492,22079&amp;target=http%3a%2f%2ffitness.39.net%2fa%2f190603%2f7189563.html\">女人的胸要怎样才是最美</a><a href=\"http://wpdata.39.net/c1.htm?sp=0,97457,78491,22079&amp;target=http%3a%2f%2fman.39.net%2fa%2f190529%2f7176474.html\">会染病的避孕套你用过吗</a></p><p>核心提示：　自从“阳“了以后很多人都出现了明显的身体不适↓↓↓“热得快”　“宝娟嗓”　“水泥鼻”　病急之下有些人开始乱投医一通乱吃却把自己吃进ICU</p><p>自从“阳“了以后</p><p>很多人都出现了</p><p>明显的身体不适↓↓↓</p><p>“热得快” “宝娟嗓” “水泥鼻”</p><p><img src=\"https://pimg.39.net/PictureLib/A/f76/20221223/org_1606166133247967248.png\"/></p><p><br/></p><p>病急之下</p><p>有些人开始乱投医一通乱吃</p><p><strong>却把自己吃进ICU</strong></p><p><br/></p><p><img src=\"https://pimg.39.net/PictureLib/A/f76/20221223/p_1606166400630652944.png\"/></p><p><br/></p><p>最后导致</p><p><img src=\"https://pimg.39.net/PictureLib/A/f76/20221223/org_1606166140776747024.png\"/></p><p><br/></p><p>“乱吃药”“选药难”</p><p>似乎成了目前的主要问题</p><p><br/></p><p>以重点药品布洛芬为例</p><p>光是看药盒上的模特男姿势</p><p>就让人眼花缭乱</p><p><br/></p><p><img src=\"https://pimg.39.net/PictureLib/A/f76/20221223/org_1606166605279137808.png\"/></p><p><br/></p><p>（图源网络）</p><p>那么这些药物怎么分辨？</p><p>有什么误区需注意？</p><p><br/></p><p>今天这期叔就和大家聊聊</p><p><strong>疫情期间，常见药物的用药问题</strong></p><p><img src=\"https://pimg.39.net/PictureLib/A/f76/20221223/org_1606166139786887184.png\"/><img src=\"https://pimg.39.net/PictureLib/A/f76/20221223/org_1606166138671202321.png\"/><img src=\"https://pimg.39.net/PictureLib/A/f76/20221223/org_1606166138633457680.png\"/><img src=\"https://pimg.39.net/PictureLib/A/f76/20221223/org_1606166132451049488.png\"/></p><p><br/></p><p><br/></p><p><img src=\"https://pimg.39.net/PictureLib/A/f76/20221223/org_1606166138230804496.png\"/></p><p><br/></p><p><br/></p><p><img src=\"https://pimg.39.net/PictureLib/A/f76/20221223/org_1606166134523039760.png\"/><img src=\"https://pimg.39.net/PictureLib/A/f76/20221223/org_1606166132794986512.png\"/></p><p><br/></p><p><br/></p><p><img src=\"https://pimg.39.net/PictureLib/A/f76/20221223/org_1606166133071806480.png\"/></p><p><br/></p><p>疫情期间</p><p>日常戴好口罩、科学锻炼、均衡饮食</p><p>保持健康的身体和心理状态</p><p>才有利于提高免疫力</p><p>加快恢复速度</p><p><br/></p><p>如果有以下情况</p><p>建议及时就医：</p><p><br/></p><p>·服用退烧药但温度仍超过38.5℃</p><p><strong>并且持续超过2~3天</strong></p><p><strong><br/></strong></p><p><strong>·出现呼吸困难、胸痛、抽搐、</strong></p><p><strong>意识混乱、严重腹泻或呕吐等症状时</strong></p><p>有可能是病毒入侵肺部的症状</p><p>有演变成重症的危险</p><p>请及时就医</p><p><br/></p><p><img src=\"https://pimg.39.net/PictureLib/A/f76/20221223/org_1606168319705088016.png\"/></p><p><br/></p><p><br/></p><p><strong>参考资料：</strong></p><p>[1]刘洪奕，徐培红.对乙酰氨基酚和布洛芬交替使用与单一使用处方比较[J].中国临床药学杂志，2019，28(06)：434-436.DOI：10.19577/j.1007-4406.2019.06.008.</p><p>[2]张文婷.退烧药布洛芬和对乙酰氨基酚如何选择[J].家庭医学，2021(08)：62.</p><p>[3]金锐，张爽，朱玲萃.用感冒药，需防对乙酰氨基酚过量[J].家庭医药.就医选药，2021(10)：34-37.</p><p>[4]米洁，李媛，李洋，段紫云，成华.联合或交替使用解热镇痛药的处方分析[J].药学服务与研究，2021，21(05)：347-350.</p><p></p><p>[5]谷彤彤，张航，程楚豪，黄贝贝.布洛芬与对乙酰氨基酚的药品不良反应对比分析[J].中国医院用药评价与分析，2022，22(09)：1145-1148+1152.DOI：10.14009/j.issn.1672-2124.2022.09.027.</p>', '管理员', '2023-06-26 21:49:52');
INSERT INTO `news` VALUES (17, 'Neurology：多吃类黄酮，健康长寿不痴呆！', '<p>类黄酮是一组具有生物活性的酚类化合物，是在不同植物性食物中大量发现的植物营养素的子集。类黄酮存在于不同类型的水果、蔬菜、坚果、种子、香料、谷物、树皮、根、茎、花和其他植物性食物以及茶和酒等饮料中。</p><p>此前发表在国际学术期刊《自然-通讯》（Nature Communications）的一项最新研究表明，食用富含类黄酮（Flavonoids）的食物，如苹果和茶，可以预防癌症和心脏病，尤其是对吸烟者和酗酒者。</p><p><br/></p><p><img src=\"https://image.39.net/auth/w/20180416/30557.jpg\"/></p><p><br/></p><p>随着通过富含水果和蔬菜的饮食越来越多地使用类黄酮，世界各地进行了不同的研究，以评估其潜在的健康益处和抗癌特性。为了前瞻性地研究长期膳食类黄酮与主观认知能力下降（SCD）之间的关系，来自哈佛大学与浙江大学的专家开展了相关研究，结果发表在Neurology杂志上。</p><p>研究人员对护士健康研究（NHS）（1984-2006年）中的49493名女性和健康专家随访研究（HPFS）（1986-2002年）中的27842名男性进行了跟踪调查。泊松回归法被用来评估膳食类黄酮（黄酮醇、黄酮、黄烷酮、黄烷-3-醇、花青素、聚合类黄酮和原花青素）与随后的SCD之间的关联。</p><p>在调整了年龄、总能量摄入、主要非饮食因素和特定饮食因素后，较高的总黄酮摄入与较低的SCD几率有关。在总黄酮摄入量的最高五分位数与最低五分位数的比较中，SCD的3个单位增量的集合风险降低19%（OR=0.81，95% CI：0.76，0.89）。</p><p>进一步在汇总的结果中，观察到黄酮（OR= 0.62 [95% CI 0.57， 0.68]）、黄烷酮（OR=0.64 [0.58， 0.68]）和花青素（OR=0.76 [0.72， 0.84]）的关联性最强，分别降低38%、36%、24%的封信。黄酮的剂量反应曲线最陡峭，其次是花青素。最后，文章还指出，许多富含黄酮的食物，如草莓、橙子、葡萄柚、柑橘汁、苹果/梨、芹菜、辣椒和香蕉，与SCD的低风险明显相关。</p><p>综上，该结果支持较高的类黄酮摄入量对维持美国男性和女性的认知功能有好处。</p>', '管理员', '2023-06-26 22:16:03');
INSERT INTO `news` VALUES (18, '“健康中国·传承中医药文化第二届粤港澳大湾区网络视听作品征评展播活动”启动', '<p><img src=\"https://pimg.39.net/PictureLib/A/f76/20230413/org_1646456622014402576.jpg\"/><br/></p><p><br/></p><p>2023年4月11日下午，“健康中国·传承中医药文化第二届粤港澳大湾区网络视听作品征评展播活动”（以下简称“活动”）启动仪式在佛山举行。第三届国医大师、著名中医肿瘤学家周岱翰教授，广东省广播电视局党组书记、局长、省人大教科文卫委主任委员刘小毅，广东省中医药局副局长柯忠，广州中医药大学党委常委、副校长林彬，广东省广播电视网络股份有限公司党委书记、董事长、省人大华侨民族宗教委员会副主任委员、广东省网络视听新媒体协会会长叶志容，广电网络党委委员、副总经理李继光，中国网络视听节目服务协会副会长、国家广电总局网络视听节目管理司原司长魏党军，佛山市人大常委会副主任贾伟，佛山市委宣传部副部长、市委网信办主任黎才远，佛山市文广旅体局党组成员、副局长张远征，澳门中医药学会会长石崇荣，广东省卫生健康宣传教育中心主任郑子谦，广东省健康中国研究会副会长杨增欣，人之初杂志社社长李楠楠。活动特别支持单位佛山市中医院、广东省广播电视网络股份有限公司佛山分公司领导和员工出席启动仪式，现场还有来自省广电局网络视听节目管理处、广州中医药大学宣传处、广东省网络视听新媒体协会、广东各网络音视频制作机构、各网络视听平台负责人、广东高校传媒学院学生以及新闻媒体记者共约150人参加启动仪式。<br/></p><p><br/></p><p><br/><img src=\"https://pimg.39.net/PictureLib/A/f76/20230413/org_1646453629357527048.jpg\"/></p><p><br/></p><p>主办、支持单位代表启动活动仪式<br/></p><p><br/></p><p><br/><img src=\"https://pimg.39.net/PictureLib/A/f76/20230413/org_1646453635950968848.jpg\"/></p><p><br/></p><p>主办、支持、承办单位领导合影<br/></p><p>启动仪式上，广东省广播电视局党组书记、局长刘小毅、广东省中医药局副局长柯忠、中国网络视听节目服务协会副会长魏党军、香港注册中医学会副会长陈仿阳、澳门中医药学会石崇荣分别代表主办单位、支持单位致辞。佛山市人大常委会副主任贾伟致辞，介绍佛山中医药文化及产业发展。第三届国医大师、著名中医肿瘤学家周岱翰教授致辞祝贺，谈中医药传承保护和守正创新的个人心得，并对活动给予高度认可。本活动特别支持单位佛山市中医院党委副书记、广东省名中医徐志强结合医院运用新媒体平台，打造系列特色专栏，向大众普及中医药知识，科普传播佛山中医药文化等进行分享。佛山传统文化展演节目《佛山功夫名匠》，通过醒狮与佛山功夫人物结合表演将活动推上高潮。</p><p><br/></p><p><br/><img src=\"https://pimg.39.net/PictureLib/A/f76/20230413/org_1646453316932210704.jpg\"/></p><p><br/></p><p>周岱翰国医大师致辞<br/></p><p>局党组书记、局长刘小毅在致辞中提出，希望活动能达到三个方面的效果：一是着力推动中医药题材精品创作，二是着力提升中医药文化传播效能，三是着力促进粤港澳网络视听产业融合协作。期待活动能吸引更多粤港澳大湾区年轻人关注传统中医药文化，推动网络视听赋能中医药文化的创造性转化和创新性发展。</p><p><br/></p><p><br/><img src=\"https://pimg.39.net/PictureLib/A/f76/20230413/org_1646453327292141585.jpg\"/></p><p><br/></p><p>贾伟副主任致辞<br/></p><p><br/></p><p><br/><img src=\"https://pimg.39.net/PictureLib/A/f76/20230413/org_1646453308912701456.jpg\"/></p><p><br/></p><p>魏党军副会长致辞<br/></p><p><br/></p><p><br/><img src=\"https://pimg.39.net/PictureLib/A/f76/20230413/org_1646453659111915537.jpg\"/></p><p><br/></p><p>石崇荣会长致辞<br/></p><p><br/></p><p><br/><img src=\"https://pimg.39.net/PictureLib/A/f76/20230413/org_1646453313643872272.jpg\"/></p><p><br/></p><p>徐志强副书记致辞<br/></p><p>本届活动，广东省网络视听新媒体协会、香港注册中医学会、澳门中医药学会三家机构签订“粤港澳大湾区中医药文化传播协作共建机制”协议书，广泛团结并致力发展粤港澳大湾区爱国爱港爱澳积极力量，不断探索中医药文化传播新路径、新形式、新力量，促进粤港澳大湾区中医药文化传播，服务粤港澳大湾区建设大局。</p><p><br/></p><p><br/><img src=\"https://pimg.39.net/PictureLib/A/f76/20230413/org_1646453321126510606.jpg\"/></p><p><br/></p><p>林庆明副会长介绍活动<br/></p><p>据介绍，该活动将向全社会征集、推选、扶持和展示一批多角度展现中医药文化精粹、传承创新成果的网络视听优秀作品，并充分利用网络视听新媒体的特色优势，创新中医药文化传承发展方式，在全社会形成“信中医、爱中医、用中医”的浓厚氛围和共同发展中医药的良好格局，进一步提高全社会对中医药的认可程度，特别吸引更多青年力量关注这项传统文化的发展，积极参与中医药文化的传承工作。主办单位之一广东广电网络还利用广电5G赋能活动开展，运用192号卡新服务，为中医药文化“进社区、进企业、进学校、进乡村、进家庭”助力添彩！</p><p><br/></p><p><br/><img src=\"https://pimg.39.net/PictureLib/A/f76/20230413/org_1646453326419726352.jpg\"/></p><p><br/></p><p>《佛山功夫名匠》表演<br/></p><p>优秀作品不但有机会在活动官方宣传专区、广电网络有线电视专区、重点网络视听平台、主流媒体等多渠道高强度曝光展播，并有机会荣获主办单位联合颁发的荣誉证书，还有机会分享20万元扶持资金！</p>', '管理员', '2023-06-26 22:20:56');
INSERT INTO `news` VALUES (19, '飞利浦呼吸机召回范围扩大 拖累四季度收益同比下滑近20%', '<p>在2021年的大部分时间里，飞利浦都在努力减轻旗下CPAP和BiPAP等多款呼吸设备召回导致的后果。不幸的是，对于这家荷兰设备制造商来说，召回问题直到2022年可能仍然会继续存在并影响该公司未来的业绩。</p><p>来自本周三发布的最新消息，飞利浦在第四季度收益报告定稿之前警告称，此期间公司的收入将远低于此前的预测值。此外，飞利浦还概述了将进一步扩大呼吸机召回范围的举措，这也会导致飞利浦未来无论是在财务损失上，还是在受影响设备的数量上都有恶化的趋势。</p><p>根据该公司最新的预计显示，2021年该公司最后一个季度的全球总销售额将达到49亿欧元（约合56亿美元）。飞利浦指出尽管这一数据要比第二季度和第三季度报告的42亿欧元的收入实现了一定程度的业绩增长，但比起飞利浦此前对该期间的收入估计整整降低了约3.5亿欧元，与2020年最后一个季度收入60亿欧元相比，更是同比下降高达18%。</p><p>飞利浦此次预计该公司全年销售额约为172亿欧元（约合197亿美元），与去年同期相比下降1%。飞利浦分析造成此次业绩下滑问题的根源，包括该公司旗下呼吸机遭到召回、全球电子元件和货运能力短缺以及医疗设备安装延迟等等。该公司表示，这些问题的综合影响直接导致了飞利浦全年销售额出现了5%的下滑。</p><p>对此，飞利浦首席执行官Fransvan Houten在一份声明中表示，未来市场上仍存在对飞利浦创新产品和解决方案的良好需求，订单量也有望创历史新高，然而除了客户推迟在医院安装设备外，飞利浦业务的全球供应链问题也面临显著加剧的困境。不过Houten也指出，飞利浦正在与供应商和政府密切合作，以解决医疗保健供应链中的短缺问题，并确保相关机构和人员能够优先考虑挽救生命的医疗设备的重要性。</p><p>此外，此次飞利浦发布的更新文件还指出，在启动召回并开始维修和更换计划几个月后，飞利浦已将受影响的呼吸设备列表，扩大涵盖到许多最初未包括在内的旧设备。目前来看，受到此次飞利浦全球召回事件影响的范围涉及全球各地的总计约520万台机器，远高于最初估计的300万至400万台受影响的设备。</p><p>不过，更多的召回机器需要维修和更换也意味着飞利浦有充足的现金流。为适应此次召回事件带来的冲击，该公司表示除了在2021年第一季度和第二季度的2.5亿欧元准备金之外，还将承担另一项2.25亿欧元的现场行动准备金。召回设备的补救计划已于去年9月开始，此前美国FDA要求飞利浦使用一种新材料来替代召回设备中有缺陷的泡沫成分。Houten表示，迄今为止，飞利浦已完成生产了约150万个维修套件和替换设备，其中近一半已经分发给了相关客户。</p>', '管理员', '2023-06-26 22:21:33');
INSERT INTO `news` VALUES (20, '推动养老服务体系实现“从有到优”', '<p>构建社会化养老服务体系，是实施积极应对人口老龄化国家战略的重要内容。党的十八大以来，我国养老服务制度框架不断完善，养老服务设施基本实现城乡全覆盖，社会化养老服务体系实现了“从无到有”；“十四五”时期，面对新任务，我们要推动养老服务体系实现“从有到优”的新突破。</p><p>　　一个好的养老服务体系，必须保证养老服务对象的普遍性、服务供给的可及性、服务质量的可靠性、服务价格的可承受性。当前，我国已经出台基本养老服务清单，正加快健全基本养老服务制度体系；已经全面放开养老服务市场，大力发展养老产业；已经出台城企联动普惠养老专项行动等政策。下一步，要抓好统筹协同发展，激发制度化、体系化推进的效能。</p><p>　　聚焦基本养老服务需求，优化养老服务资源配置。从照护服务的角度看，失能、失智、高龄老年人，独居、孤寡、计划生育特殊家庭老年人和纯老年人家庭等群体是政策支持的重点。必须优化资源配置方式，推动资源下沉，加快完善社区居家层面的社会化服务体系，多措并举增加社区居家养老服务供给，提高财政资金的使用效能。</p><p>　　聚焦市场机制作用发挥，推进老龄事业和产业协同发展。要研究以财政资金撬动市场的作用机理和优化路径，带动养老消费市场整体发展。要发挥金融的支持作用，大力发展企业年金、职业年金、个人储蓄性养老保险和商业养老保险，大力发展长期护理保险、普惠保、大病保险等金融产品。大力发展电子支付、保险支付等方式，为处置纠纷和维护老年人权益提供便利，引导老年人放心消费、舒心消费。</p><p>　　聚焦基层社会治理改革，破解养老服务“最后一米”难题。基层是一切工作的落脚点。要坚持党建引领，深化基层社会治理改革，创新资源统筹机制，构建乡镇（街道）“一体化”养老服务体系，着力打通养老服务“最后一米”的供需对接。乡镇（街道）应承担资源统筹、需求发现、服务组织、回应呼声和监督管理等方面的职责；按照“条块结合”的原则，与职能部门密切合作，统筹辖区内机构、社区、居家养老服务协调发展，统筹辖区内养老服务设施、项目、队伍一体化推进。要发挥老年人协会的作用，充分反映老年人诉求。</p><p>　　在推进中国式现代化进程中，要将老龄政策融入经济社会发展政策当中，将应对老龄化问题作为一项长远的、系统的社会治理工程有序推进。其中，当务之急是以整体性治理为牵引，着力补齐社会化养老服务体系建设的短板，提升老龄化社会的治理水平。</p><p>　　（摘编自《大众日报》）</p><p><br/></p><p>　　《 人民日报 》（ 2023年06月19日 05 版）</p>', '管理员', '2023-06-26 22:23:01');
INSERT INTO `news` VALUES (21, '讲述《本草纲目》故事 推动中医药文化走向世界', '<p><strong>央视网消息：</strong>5月27日，当湖北蕲春李时珍故里举行纪念李时珍诞辰505周年之际，由赵中振教授编著、中国人口出版社出版的《中振话纲目》举行首发仪式。</p><p>明朝中期，瘟疫肆虐。李时珍弃官不做，以拯救苍生为使命。历时三十余载，踏遍千山万水，历尽千辛万苦，创作出《本草纲目》这一旷世之作，为后世留下了一部重要的中医药典籍，对世界健康事业发展和东西文化交流作出了重要贡献。</p><p><img src=\"https://p4.img.cctvpic.com/photoworkspace/contentimg/2023/06/02/2023060217043194525.jpg\" alt=\"讲述《本草纲目》故事\"/></p><p>赵中振教授是北京中医药大学本草纲目研究所所长、香港浸会大学中医药学院原副院长，是国家科技进步二等奖、香港特别行政区荣誉勋章获得者。曾任《典籍里的中国》第四集《本草纲目》指导专家。《中振话纲目》凝聚了赵中振教授40多年中医药研究的成果，记录了他行走30多个省份和40多个国家地区寻草问药的故事，在人间烟火气里展现了经世致用、兼济天下的情怀，践行着“治身以治天下、寿国以寿万民”的抱负，体现了四海一家、文明互鉴的理念。</p><p><img src=\"https://p2.img.cctvpic.com/photoworkspace/contentimg/2023/06/02/2023060217050023494.jpg\" alt=\"讲述《本草纲目》故事\"/></p><p>中华中医药学会副秘书长陈俊峰表示，在中华民族五千多年的文明长河里，中医药不仅守护着中国人的健康，也承载着深厚的中华文化底蕴。赵中振先生多年来出版了《当代药用植物典》《常用中药材鉴别图典》等许多享誉海外的中医药经典译著，以多种方式向国际社会介绍中医药文化，为促进中医药传承创新发展、推进健康中国建设、传承中华优秀传统文化，起到了积极引领作用。</p><p><img src=\"https://p2.img.cctvpic.com/photoworkspace/contentimg/2023/06/02/2023060217052458532.jpg\" alt=\"讲述《本草纲目》故事\"/></p><p>在首发式现场，赵中振教授向李时珍纪念馆捐赠了《中振话纲目》。全国中药鉴定学教育研究会会长康廷国教授、中国中医药信息研究会李时珍研究分会会长梅全喜教授、全国药史本草学会主任委员万芳教授以及企业、读者、媒体代表近千人参加活动。</p><p>（央视网综合新华网）</p>', 'lmk', '2023-06-27 10:46:48');
INSERT INTO `news` VALUES (22, '2023北京国际生命健康产业跨境博览会将于7月举办', '<p>“2023北京国际生命健康产业跨境博览会暨生命健康创新者年会”（以下简称“健康博览会”）将于7月11日至13日在北京中国国际展览中心举办。大会将实行“线上+线下”双会场融合模式，并进行全球同步直播。</p><p>本届“健康博览会”由世界中医药学会联合会、中国研究型医院学会、商务部外贸发展事务局、世界生命科学大会联合组织共同主办。活动将涵盖30个主题论坛、100多个活动议题，包括技术交流会、产品对接洽谈、国际合作项目推介会、中关村生命健康产业园招商等配套活动。</p><p>会议期间，“生命健康创新者年会”将以“创新赛道的4D法则”为主题，在北京中国国际展览中心的静安庄馆举行。届时，生命健康相关行业最具影响力的专家学者、知名企业高管、协会机构负责人等将汇聚北京，围绕生命健康产业发展与前沿趋势，聚焦智慧与创新，前瞻谋划，共商未来。</p><p>“生命健康创新者年会”共分为六大主论坛，深度剖析创新动向，四大分会场聚焦重点领域深度话题。论坛内容不仅涉及行业的政策解读与研究，也有全新创新商业模式探讨，更有前沿技术与赛道的实战研讨。</p><p>（经济参考报 记者：闫磊）</p>', 'lmk', '2023-06-27 10:48:48');
INSERT INTO `news` VALUES (23, '“五一”健康指南来了', '<p>愉快的“五一”假期即将开启，市疾控专家提醒，度过一个健康祥和的假期，健康防护必不可少。疾控专家为大家开出一份“五一”健康指南。</p><p><img src=\"https://p4.img.cctvpic.com/photoworkspace/contentimg/2023/04/28/2023042815060860372.jpg\" alt=\"\"/></p><p><br/></p><p><strong>生吃有风险，小心入乡随俗的“美食之旅”</strong></p><p>“舌尖上的美味，生吃往往可致食源性寄生虫病。”市疾控中心血地寄防制科主任医师谢朝勇提醒，美食不可辜负，但市民们也要小心“隐形杀手”，比如生猪牛肉、生食淡水鱼虾、福寿螺等。除了肉类和水产品，生吃清脆可口的荸荠的危害，常常被大众忽视。</p><p><br/></p><p>“荸荠多种植在水田里，在生长过程中，很容易被水中一些寄生虫的幼虫寄生。最常见的寄生虫叫布氏姜片吸虫，当人们用牙啃荸荠皮或者生吃荸荠时，幼虫就会进入体内、寄生在小肠并发育为成虫，导致姜片虫病，让人出现腹痛、腹泻、恶心、呕吐、发热、过敏和水肿等症状。”谢朝勇提醒，“和急性的食物中毒不同，有时感染姜片虫可能要1—2个月后才发作。”</p><p><br/></p><p>谢朝勇提醒，改变不良饮食习惯，切记无论用何种烹饪方式，食物要煮熟，生熟分开，“切不可在旅途中‘入乡随俗’地生食。”</p><p><br/></p><p><strong>亲近自然，有些水不能“亲密接触”</strong></p><p><br/></p><p>气温渐升，不少家庭会选择走近大自然。“但亲近自然的同时，必须要提高警惕，有些水可不能‘亲密接触’。”谢朝勇提醒市民，需谨防在沿江地区感染血吸虫病。</p><p><br/></p><p>血吸虫病是一种人畜共患的寄生虫病，人一旦接触带有血吸虫的疫水，被血吸虫叮咬后，短短10秒钟，它就能钻入皮肤，引发感染，严重时会损伤肝脏，甚至导致死亡。</p><p><br/></p><p>近几年，我市未发生本地感染的血吸虫病人。“但由于野生动物传染源和钉螺难以彻底清除，加之长江上游一些血吸虫病重点防制地区的影响，我市沿江地区感染血吸虫病的风险依然存在。”谢朝勇表示，“血吸虫病多发季节为5-10月，因此‘五一’期间外出游玩，接触水源时一定要提高警惕。”</p><p><br/></p><p>谢朝勇表示，不接触疫水是预防血吸虫病最好的方法。</p><p><br/></p><p><strong>出境游要防蚊虫叮咬</strong></p><p><br/></p><p>休假期间，又可以畅游世界啦！“不过，在欣赏异国风景、享受异国美食的同时，可别忘了防范疟疾。”谢朝勇提醒。</p><p><br/></p><p>“疟疾俗称‘打摆子’，恶性疟疾如不及时治疗将危及生命。”谢朝勇解释，“虽然南京市已无本地感染病例，但境外输入性疟疾持续不断，且以更易发生重症疟疾的恶性疟为主。”</p><p><br/></p><p>“如果近期从境外回国，一旦出现发热等症状，应及时就医，并且主动告知医生旅居史，尽快进行疟疾快速检测筛查，如确诊疟疾，按医嘱全程、足量服用抗疟药物，通常可以治愈。”谢朝勇提醒，“避免按蚊叮咬是预防疟疾最简便有效的措施。市民如果在疟疾高流行地区旅居时应加强个人防护，尽量避免在蚊虫活动高峰期（黄昏和夜晚）去野外活动。”</p>', 'lmk', '2023-06-27 10:49:18');
INSERT INTO `news` VALUES (24, '警惕甲亢和甲减发生转换 ', '<h1><br/></h1><p>2023-06-26 18:31</p><article><p><img src=\"https://p5.itc.cn/q_70/images03/20230626/9bf603b13f1a40639241f4821979b24b.png\"/></p><p>甲状腺是位于颈前部的腺体，形状像一只蝴蝶，主要功能是合成和分泌甲状腺激素。甲状腺激素包括甲状腺素（T4）和三碘甲状腺原氨酸（T3），在血液中含量甚微，但作用很大，如参与营养物质和能量代谢，促进生长发育，调节体温、心率和血压等，是一切生理活动的基础。因此，甲状腺也被喻为“人体的发动机”。</p><p>甲状腺功能亢进症（甲亢）和甲状腺功能减退症（甲减）是两种常见的甲状腺疾病，它们是因甲状腺激素合成或分泌过多或过少所致。很多人在治疗这两种疾病时都有“治起来很麻烦”的感觉。比如，有的人明明是甲亢，治着治着却成了甲减，而且治疗时间常常是经年累月。其实，甲亢和甲减就像硬币的两面，既相互对立，也可以相互转换。我们就来聊一聊这两种疾病的治疗。</p><p><strong>甲亢和甲减各有啥特点</strong></p><p>甲亢是指甲状腺产生过多的甲状腺激素，导致机体兴奋性增高和代谢亢进，表现为怕热多汗、多食善饥、腹泻消瘦、失眠易怒、心率快、手抖等，有的患者还会出现眼球突出等眼部症状。</p><p>甲减和甲亢正好相反，是由于甲状腺不能合成和分泌足够的甲状腺激素，导致全身代谢减缓、机体兴奋性降低。患者会有怕冷少汗、乏力纳差、体重增加、便秘、少言易困、反应迟钝、心率慢、面部虚肿等症状。</p><p>甲亢和甲减的临床表现虽然不同，甚至完全相反，但是主要的病因都与甲状腺自身免疫异常有关。</p><p>甲亢最常见的病因是格雷夫斯病（Graves病），这是一种自身免疫性疾病。患者体内产生一种促甲状腺激素受体抗体（TRAb），不断地刺激甲状腺细胞增生和分泌过多的甲状腺激素，从而导致甲亢。</p><p>甲减最常见的病因是自身免疫甲状腺炎，如桥本甲状腺炎，就是血液中甲状腺过氧化物酶抗体（TPOAb）或甲状腺球蛋白抗体（TGAb）水平升高。这种免疫反应破坏了甲状腺，进而减少了甲状腺激素的合成和分泌，导致甲减。</p><p><strong>甲亢和甲减哪个更好治</strong></p><p>甲亢和甲减的治疗方式截然不同。甲亢时甲状腺激素增多，需要减少激素的量，主要包括三种方法：抗甲状腺药物抑制激素合成，放射性碘破坏甲状腺，手术切除甲状腺。这三种方法各有利弊，选择何种治疗方案，需要结合患者的年龄和病情等因素综合考量。最常采用的方法是使用抗甲状腺药物，如甲巯咪唑和丙硫氧嘧啶，疗程通常为1.5~2年，用药期间要根据甲状腺功能调整药物剂量，还要注意药物的副作用。</p><p>甲减患者体内的甲状腺激素减少，需要额外补充。目前临床上主要使用的替代药物是左甲状腺素（L-T4）。补充的原则是缺多少补多少。甲状腺激素的替代量会随着体重、年龄、季节、疾病进展等因素的改变而调整。所以，需要定期检测甲状腺功能，调整L-T4剂量。</p><p>值得注意的是，不当的治疗会导致甲亢和甲减之间的相互转换。对于甲亢患者，如果药物过量或治疗时间过长，可能会因过度抑制甲状腺激素合成而导致甲减。放射性碘和手术治疗甲亢也可能导致甲减。同样，治疗甲减也会导致甲亢，这是因为用药剂量超过生理需求量，导致医源性甲状腺毒症。相对而言，甲减更容易治疗，因为单药治疗就能保持甲状腺功能稳定，而且安全。</p><p><strong>患者饮食需要注意什么</strong></p><p>我们都知道，碘与甲状腺关系密切，是合成甲状腺激素必不可少的原料。碘营养水平与甲状腺疾病患病风险之间的关系呈现为U型曲线，也就是说碘缺乏或者碘过量都会引起甲状腺疾病。世界卫生组织推荐成人每天碘摄入量为150微克，妊娠期妇女和哺乳期妇女增加到每天250微克。甲亢患者对碘的生物利用度明显增高，因此需要适当限制碘的摄入，但不必严格限制，通常建议可以继续食用加碘食盐，少吃或不吃富碘食物（如海带、紫菜、虾皮等），不用含碘药品（如胺碘酮、含碘造影剂等）。</p><p>甲减患者的补碘根据具体情况而有所不同。如果是甲状腺全切或完全破坏所致的甲减，患者需要接受甲状腺激素的替代治疗，因此是否补碘对甲状腺都无明显影响。如果还有甲状腺组织的患者，可以保持正常的碘饮食，包括食用加碘食盐。而碘缺乏所致的甲减患者，食用加碘盐是最有效的补碘方法。碘过量所致的甲减程度较轻，常见于亚临床甲减患者，这些患者要限制碘的摄入。</p><p><strong>日常注意事项有何不同</strong></p><p>甲亢和甲减患者在日常生活中的注意事项也有所不同。</p><p>甲亢患者需要充分休息，保持情绪稳定，补充足够的蛋白质、碳水化合物、维生素和矿物质。临床上，甲亢患者饮食误区最多的是不敢吃海鲜。事实上绝大多数的海鲜含碘量并不多，患者是可以享用的。</p><p>甲减患者常并发血脂异常，因此饮食中脂肪摄入应控制在总热量的20%左右，限制食用高脂肪食物。无论是甲亢患者还是甲减患者，都需要定期复查甲状腺功能，遵医嘱服药，不要擅自调药或停药，以保证疾病得到有效控制。</p><p>总之，甲亢和甲减在临床表现、发病机制以及治疗方式等方面都表现出截然相反的特征，但同时也存在着紧密的联系，甚至有时可以互相转换。这就像一枚硬币，一面是数字，一面是图案，看似大相径庭的两面，却只有合在一起才能构成一枚完整的硬币。我们也可以通过甲亢和甲减这两种疾病，从正反两个方面理解甲状腺的功能。</p><p>甲状腺疾病纷繁复杂，每种疾病的病因、机制和诊治都不尽相同。因此，如果怀疑自己患有甲状腺疾病，最好及时就医，以确保得到正确的诊治和照护。</p><p>文：中国医科大学附属第一医院内分泌代谢病科 王浩宇 单忠艳</p><p>编辑：王建影 栾兆琳 于梦非</p><p>校对：杨真宇</p><p>审核：徐秉楠 王乐民</p></article>', '管理员', '2023-06-27 14:27:02');
INSERT INTO `news` VALUES (25, '夏吃姜赛参汤，但不是人人都适合，4大原则需谨记', '<p>生姜，是厨房中很常见的一种烹饪辅料，其辛辣的味道能去腥提味，但在医生眼里，它的保健养生效果也极佳，民间更有“夏季吃姜胜过参汤”的说法。</p><p>为什么夏季要吃姜？</p><p><img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230301/d9d7f7fb-2ef0-4521-b4bf-e9b1375a6fcc2285.png\"/> <img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230301/d9d7f7fb-2ef0-4521-b4bf-e9b1375a6fcc2285.png\"/> <img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230301/d9d7f7fb-2ef0-4521-b4bf-e9b1375a6fcc2285.png\"/> <img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230301/d9d7f7fb-2ef0-4521-b4bf-e9b1375a6fcc2285.png\"/></p><p>夏季吃姜能为身体带来什么好处呢？</p><figure><img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230626/c15a77c2-9857-416f-ac1f-84d2d5e7166f4025.jpg\"/></figure><p>01、增进食欲</p><p>夏天天气炎热，很容易食欲不振，而生姜中的姜辣素能刺激舌头上的味觉神经，刺激胃黏膜上的感受器，通过神经反射增强胃肠蠕动，促进消化液的分泌，起到开胃、促消化、增食欲的作用。</p><p>02、驱风散寒</p><p>夏季时很多人贪图凉快，爱吃冰凉的东西，喜欢长时间待在空调房中，这些行为都会使得体内寒气过重，此时可以借助生姜驱风散寒。</p><figure><img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230626/c3846bbd-1a06-4e60-a38c-31be47c1a16d4585.jpg\"/></figure><p>03、保护肠胃</p><p>夏季细菌异常活跃，食物在存放的过程中非常容易受到污染，如果不小心食用这类食物，会引起急性肠胃炎。</p><p>而生姜可以起到抗菌作用，尤其对沙门氏菌有一定的作用，能保护肠胃；另外美国路易斯维尔大学的一项研究指出，生姜中的类外泌体会增加肠道中的有益菌、减少有害菌，从而完善肠道屏障功能，促进肠道健康。</p><p>吃生姜的3大原则</p><p><img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230301/d9d7f7fb-2ef0-4521-b4bf-e9b1375a6fcc2285.png\"/> <img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230301/d9d7f7fb-2ef0-4521-b4bf-e9b1375a6fcc2285.png\"/> <img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230301/d9d7f7fb-2ef0-4521-b4bf-e9b1375a6fcc2285.png\"/> <img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230301/d9d7f7fb-2ef0-4521-b4bf-e9b1375a6fcc2285.png\"/></p><p>生姜虽好，但不是人人都适合，也不是随便什么时候都能吃的，吃生姜也有讲究：</p><p>01、不宜吃的人群</p><p>① 内热重的人：肺热胃热、口臭、痔疮、痛疮溃烂等的人不易吃辛热的生姜。</p><p>② 阴虚体质的人：阴虚者，手心和脚心都会发热，还有口干舌燥、爱发火、皮肤干、睡不好的症状。</p><figure><img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230626/ec2ba600-f2c9-48b1-aba5-1bd2a470e73e610.jpg\"/></figure><p>③ 肝炎患者：生姜食用过多，容易引发人体肝火旺盛，不利于肝病的恢复。</p><p>④ 胃溃疡患者：生姜食用过多，会对胃粘膜造成刺激，加重溃疡症状。</p><p>02、吃姜当趁“早”</p><p>“晚吃姜赛砒霜”，这是因为生姜的辛温发散作用，对肠胃有一定刺激，会影响到人在夜间的正常休息，甚至导致失眠；且容易产生内热，时间长了则会出现“上火”的现象，特别是阴虚体质的人。</p><p>早上吃姜，正好生发胃气、促进消化、提神，因而最好早上吃。</p><p>不过常年手脚冰凉症患者晚上适当吃些姜也是可以的，以促进血液循环，缓解身体冰冷的症状。</p><figure><img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230626/1dbcb16a-b0c1-441e-bba2-a4f21850bd195697.jpg\"/></figure><p>03、腐烂生姜不能吃</p><p>“烂姜不烂味”，因而不少人即使生姜烂了，也舍不得扔，继续拿来做调味品，其实这种做法是错误的。</p><p>腐烂的生姜会有黄樟素这样的有害物质产生，是肝癌、食道癌等疾病的诱因之一。</p><figure><img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230626/feee54f9-2b9a-4895-9fab-8d022004ca298941.jpg\"/></figure><p>生姜的花式用法</p><p><img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230301/d9d7f7fb-2ef0-4521-b4bf-e9b1375a6fcc2285.png\"/> <img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230301/d9d7f7fb-2ef0-4521-b4bf-e9b1375a6fcc2285.png\"/> <img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230301/d9d7f7fb-2ef0-4521-b4bf-e9b1375a6fcc2285.png\"/> <img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230301/d9d7f7fb-2ef0-4521-b4bf-e9b1375a6fcc2285.png\"/></p><p>生姜的吃法很多，能当调味料，能搭配着做茶饮，也能制成外敷贴：</p><p>01、生姜+炒白术——调理脾虚</p><p>做法：三片生姜、20克炒白术，煮水代茶饮。</p><p>炒白术补虚燥湿、止泻，配合散寒暖胃的生姜，此茶饮适合胃虚寒、舌苔偏厚偏白的人饮用。喝到胃不难受，就可以停止了。</p><figure><img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230626/72819a87-47f5-4fa3-8b0c-cf43f087e8605227.jpg\"/></figure><p>02、生姜+大枣+杏仁——调理肺气虚</p><p>做法：将一小把杏仁、三颗红枣、四片生姜一起煮水喝。</p><p>杏仁宣肺止咳、润肠通便；枣甘温而补之，配合姜辛温而行，对于改善肺气虚，亦或是呼吸系统疾病带来的咳嗽、喘憋、痰多等不适有好处。</p><figure><img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230626/efb2e0ab-34af-47b2-96b9-5bc3ce64b528945.jpg\"/></figure><p>03、陈皮+生姜皮——排尿酸</p><p>做法：陈皮5-10克、生姜皮5-10克，泡水代茶饮。</p><p>陈皮理气健脾、燥湿化痰；生姜皮行气消肿。这两味药搭配在一起，有利于尿酸的排泄。</p><p>注意：生姜是热的，而生姜皮是寒的，痛风发作本来就是体内有热，只能用生姜皮，而不能用生姜。</p><figure><img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230626/6ee73207-73a2-4908-b12f-e22c97fa20c39433.jpg\"/></figure><p>04、生姜+花椒+葱白——缓解关节痛</p><p>夏季长时间吹空调和电扇，很多人会出现关节不适，这时不妨试试下面的热敷法：</p><figure><img src=\"https://jk-tt.oss-cn-beijing.aliyuncs.com/20230626/4c030a44-bc58-42cf-ab18-4dcfe51082193141.jpg\"/></figure><p>做法：取花椒100克，鲜生姜25片，葱白25根切碎，将它们混在一起，装入布包里。</p><p></p><p>将药包放在患处，再在上面放置一个热水袋，热敷30分钟左右。热敷后你会感到关节处热乎乎的，没有了紧绷的感觉，关节疼痛也能缓解甚至消失。</p>', 'lmk', '2023-06-27 14:37:45');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `path` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '资源路径',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'Home', '/home', '主页', 'el-icon-house');
INSERT INTO `permission` VALUES (4, 'Order', '/order', '我的订单', 'el-icon-s-order');
INSERT INTO `permission` VALUES (9, 'User', '/user', '用户管理', 'el-icon-user');
INSERT INTO `permission` VALUES (10, 'Permission', '/permisssion', '权限菜单', 'el-icon-menu');
INSERT INTO `permission` VALUES (11, 'Role', '/role', '角色管理', 'el-icon-s-custom');
INSERT INTO `permission` VALUES (13, 'Person', '/person', '个人信息', '');
INSERT INTO `permission` VALUES (14, 'Password', '/password', '修改密码', NULL);
INSERT INTO `permission` VALUES (19, 'checkItems', '/checkItems', '检查项管理', 'el-icon-s-order');
INSERT INTO `permission` VALUES (20, 'checkingGroup', '/checkingGroup', '检查组管理', 'el-icon-s-fold');
INSERT INTO `permission` VALUES (21, 'checkSetMeal', '/checkSetMeal', '检查套餐管理', 'el-icon-s-shop');
INSERT INTO `permission` VALUES (22, 'appointment', '/appointment', '预约管理', 'el-icon-chat-round');
INSERT INTO `permission` VALUES (23, 'appointmentUser', '/appointmentUser', '预约体检', 'ChatDotRound');
INSERT INTO `permission` VALUES (24, 'checkItemsData', '/checkItemsData', '体检信息', 'CircleCheck');
INSERT INTO `permission` VALUES (25, 'information', '/information', '健康资讯管理', 'el-icon-chat-dot-square');
INSERT INTO `permission` VALUES (26, 'checkFiles', '/checkFiles', '健康档案管理', 'el-icon-s-custom');
INSERT INTO `permission` VALUES (27, 'informationShow', '/informationShow', '健康资讯', 'el-icon-s-promotion');
INSERT INTO `permission` VALUES (28, 'informationDetail', '/informationDetail', '文章详情', NULL);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'admin', '超级管理员');
INSERT INTO `role` VALUES (2, 'user', '普通用户');
INSERT INTO `role` VALUES (3, 'doctor', '医生');
INSERT INTO `role` VALUES (4, 'visitor', '访客');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `role_id` int NOT NULL COMMENT '角色id',
  `permission_id` int NOT NULL COMMENT '资源id',
  PRIMARY KEY (`role_id`, `permission_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES (1, 1);
INSERT INTO `role_permission` VALUES (1, 9);
INSERT INTO `role_permission` VALUES (1, 10);
INSERT INTO `role_permission` VALUES (1, 11);
INSERT INTO `role_permission` VALUES (1, 13);
INSERT INTO `role_permission` VALUES (1, 14);
INSERT INTO `role_permission` VALUES (1, 19);
INSERT INTO `role_permission` VALUES (1, 20);
INSERT INTO `role_permission` VALUES (1, 21);
INSERT INTO `role_permission` VALUES (1, 22);
INSERT INTO `role_permission` VALUES (1, 25);
INSERT INTO `role_permission` VALUES (1, 26);
INSERT INTO `role_permission` VALUES (2, 1);
INSERT INTO `role_permission` VALUES (2, 13);
INSERT INTO `role_permission` VALUES (2, 14);
INSERT INTO `role_permission` VALUES (2, 23);
INSERT INTO `role_permission` VALUES (2, 24);
INSERT INTO `role_permission` VALUES (2, 26);
INSERT INTO `role_permission` VALUES (2, 27);
INSERT INTO `role_permission` VALUES (2, 28);
INSERT INTO `role_permission` VALUES (3, 1);
INSERT INTO `role_permission` VALUES (3, 13);
INSERT INTO `role_permission` VALUES (3, 14);
INSERT INTO `role_permission` VALUES (3, 23);
INSERT INTO `role_permission` VALUES (3, 24);
INSERT INTO `role_permission` VALUES (3, 25);
INSERT INTO `role_permission` VALUES (3, 27);
INSERT INTO `role_permission` VALUES (3, 28);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `account` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '账户余额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '$2a$10$.cxJ637DYA1PRSzfPmBO0efS1W2eTQefS51b83Nr5xgRNAW0ffgjO', '管理员', 18, '男', '荣成市-城西街道-河崖村委会-哈理工', 'http://localhost:9090/files/a1e2e1e1b34b430984882c97f923a114', 100000.00);
INSERT INTO `user` VALUES (28, 'lmk', '$2a$10$xG0FKnnc2CPXtRBR6KF49ufEYjFJBLFMxFYCPcpHDLqxUfLm6e9A2', 'lmk', 19, '男', '荣成市-宁津街道-南泊村委会-苑家村02号', 'http://localhost:9090/files/51ddc9ad3fd049999fb627002d1d9a62', 0.00);
INSERT INTO `user` VALUES (32, 'wsl', '$2a$10$g/8F0R5..GSdnkK.U3M6zu7vlZfFDMLCw2Pao8X3GKxEgwiK0t77W', '王思博', 21, '男', '荣成市-东山街道-干占村委会-沟里住', NULL, 0.00);
INSERT INTO `user` VALUES (45, 'dxy', '$2a$10$M90HWRYwurhzAJFWGu1aTuVI4O56qY188kZnnl1SWG9.RVPa13dTG', '丁向阳', 18, '男', '荣成市-港湾街道-渔港社区居委会-哈理工', NULL, 0.00);
INSERT INTO `user` VALUES (46, 'lm98k', '$2a$10$WPIUpQlAQJaFDTcWGY0upurs00hY4zuCUK7QQR7T6iZHWMaGHQeqG', '小明', 19, '男', '荣成市-宁津街道-南泊村委会-苑家村02号', NULL, 0.00);
INSERT INTO `user` VALUES (47, 'lsls', '$2a$10$CqhgA0YWlUjqgnSsWEXmUeIUst89bpHlkmW8ge3Fjl/E.C0YVgJFK', '小红', 21, '男', '荣成市-东山街道-干占村委会-沟里住', NULL, 0.00);
INSERT INTO `user` VALUES (48, 'kkk', '$2a$10$XIOazvelvEDTxb0o2FBYFeKG6xaBlmLT41G6.lglswfXppiLRxRQq', 'K医生', 39, '男', '荣成市-寻山街道-寻山所村委会-哈理工', NULL, 0.00);
INSERT INTO `user` VALUES (54, 'miniK', '$2a$10$Uxwj4j9mzWRsfyjBl6dRwepOirKNMgBgx83Wc1Op0akQWpthWoTvG', '我是miniK', 18, '男', '荣成市-夏庄镇-战家村委会-76号居民楼5单元5号', 'http://localhost:9090/files/3bdf76dd4ae94f55867e9f8ba016a3a7', 0.00);
INSERT INTO `user` VALUES (55, 'docker_liu', '$2a$10$nSyaTGMcXWpgbF9G8W1pg.lzOl2WuUWip5EmxnxS7KjWBic3.T/K2', '刘医生', 58, '男', '荣成市- - - ', NULL, 0.00);
INSERT INTO `user` VALUES (56, 'docker_wang', '$2a$10$RfhcEA5HBj3D2Gu8qR9k4.BJbW9nvDQdgkF6xSH0Ee.qhQAmeB/Ta', '王医生', 67, '男', '荣成市-港湾街道-渔港社区居委会- ', NULL, 0.00);
INSERT INTO `user` VALUES (57, 'admin123', '$2a$10$2ccPwyzELYd3sp2bdXD8VuWtlNP3RcmkxDMIR0Eda9cv4YqzViDcC', '管理员', 18, '男', '荣成市-城西街道-河崖村委会-哈理工', NULL, 0.00);
INSERT INTO `user` VALUES (58, 'xiaoli', '$2a$10$NF6UtjrTCRhljT1XvyGkneMP5u0YUfwL199JwChu4ht0HSKTedZVq', '小李', 18, '女', '荣成市-城西街道-河崖村委会-哈理工', NULL, 0.00);
INSERT INTO `user` VALUES (59, 'docker_zhang', '$2a$10$bWUuvsdF/FpU.Ub2FmPC/OBAvAmkn0MhqA1qdKtlhopA6ux6ALGhS', '张医生', 37, '男', '荣成市- - - ', NULL, 0.00);
INSERT INTO `user` VALUES (60, 'docter_z', '$2a$10$Mf10rrjXzBs3oarjncMcj.rYq4ohFNpo7MMPNs2KloC4Sj5lLs17O', '张医生', 58, '男', '荣成市- - - ', NULL, 0.00);
INSERT INTO `user` VALUES (61, 'dd', '$2a$10$/v4ePhR7s6ZgmMmk3mT4RevtOFvjx/f.fYscpd./EVqckd.lrhN.O', '丁医生', 35, '男', '荣成市- - - ', NULL, 0.00);
INSERT INTO `user` VALUES (62, 'safsa', '$2a$10$tiun.SF72gMDNBNtSyuGZuAd3HffvbdZvj6zT8SAL3VDiEazAIEVy', '我', 12, '男', '荣成市-桃园街道-北桥头村委会- ', NULL, 0.00);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `user_id` int NOT NULL COMMENT '用户id',
  `role_id` int NOT NULL COMMENT '角色id',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, 1);
INSERT INTO `user_role` VALUES (28, 3);
INSERT INTO `user_role` VALUES (32, 2);
INSERT INTO `user_role` VALUES (45, 2);
INSERT INTO `user_role` VALUES (46, 2);
INSERT INTO `user_role` VALUES (47, 2);
INSERT INTO `user_role` VALUES (48, 2);
INSERT INTO `user_role` VALUES (49, 2);
INSERT INTO `user_role` VALUES (51, 2);
INSERT INTO `user_role` VALUES (54, 2);
INSERT INTO `user_role` VALUES (55, 3);
INSERT INTO `user_role` VALUES (56, 3);
INSERT INTO `user_role` VALUES (57, 2);
INSERT INTO `user_role` VALUES (58, 2);
INSERT INTO `user_role` VALUES (59, 3);
INSERT INTO `user_role` VALUES (60, 3);
INSERT INTO `user_role` VALUES (61, 3);
INSERT INTO `user_role` VALUES (62, 2);

SET FOREIGN_KEY_CHECKS = 1;
