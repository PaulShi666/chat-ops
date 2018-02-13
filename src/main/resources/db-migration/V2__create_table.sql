/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50720
 Source Host           : localhost:3306
 Source Schema         : chat_ops

 Target Server Type    : MySQL
 Target Server Version : 50720
 File Encoding         : 65001

 Date: 13/02/2018 14:04:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `message_id` int(10) NOT NULL,
  `script` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `message_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of answer
-- ----------------------------
INSERT INTO `answer` VALUES (1, 1, NULL);
INSERT INTO `answer` VALUES (2, 2, NULL);
INSERT INTO `answer` VALUES (3, 3, NULL);
INSERT INTO `answer` VALUES (4, 4, NULL);
INSERT INTO `answer` VALUES (5, 5, NULL);
INSERT INTO `answer` VALUES (6, 6, NULL);
INSERT INTO `answer` VALUES (7, 7, NULL);
INSERT INTO `answer` VALUES (8, 8, NULL);

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (1, '查看CPU');
INSERT INTO `message` VALUES (2, '查看磁盘信息');
INSERT INTO `message` VALUES (3, '查看网络负载');
INSERT INTO `message` VALUES (4, '查看内存');
INSERT INTO `message` VALUES (5, '查看进程总数');
INSERT INTO `message` VALUES (6, '查看IP地址');
INSERT INTO `message` VALUES (7, '查看当前NGINX监控数据');
INSERT INTO `message` VALUES (8, '查看昨日NGINX监控数据');

SET FOREIGN_KEY_CHECKS = 1;
