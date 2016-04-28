/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : monitor

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2016-04-28 16:41:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for agent
-- ----------------------------
DROP TABLE IF EXISTS `agent`;
CREATE TABLE `agent` (
  `userID` int(11) NOT NULL,
  `agentID` varchar(36) NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`userID`,`agentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of agent
-- ----------------------------
INSERT INTO `agent` VALUES ('1', '6ad73730-0be2-42e0-86b4-c3905634223c', '0');
INSERT INTO `agent` VALUES ('1', 'fa3fa039-fb1a-4cde-8c58-368f7da17edf', '1');

-- ----------------------------
-- Table structure for agentinfo
-- ----------------------------
DROP TABLE IF EXISTS `agentinfo`;
CREATE TABLE `agentinfo` (
  `agentID` varchar(36) NOT NULL,
  `os` varchar(40) DEFAULT NULL,
  `osArc` varchar(10) DEFAULT NULL,
  `osVersion` varchar(10) DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `computerName` varchar(30) DEFAULT NULL,
  `hostName` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`agentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of agentinfo
-- ----------------------------
INSERT INTO `agentinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'Windows 7', 'amd64', '6.1', '192.168.48.95', 'TIAN-PC', 'Tian-PC');

-- ----------------------------
-- Table structure for devinfo
-- ----------------------------
DROP TABLE IF EXISTS `devinfo`;
CREATE TABLE `devinfo` (
  `agentID` varchar(36) NOT NULL,
  `devID` varchar(36) NOT NULL,
  `devInfo` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`agentID`,`devID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of devinfo
-- ----------------------------
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'CPU0', '2494#Intel#Core(TM) i7-4710MQ CPU @ 2.50GHz#-1');
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'CPU1', '2494#Intel#Core(TM) i7-4710MQ CPU @ 2.50GHz#-1');
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'CPU2', '2494#Intel#Core(TM) i7-4710MQ CPU @ 2.50GHz#-1');
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'CPU3', '2494#Intel#Core(TM) i7-4710MQ CPU @ 2.50GHz#-1');
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'CPU4', '2494#Intel#Core(TM) i7-4710MQ CPU @ 2.50GHz#-1');
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'CPU5', '2494#Intel#Core(TM) i7-4710MQ CPU @ 2.50GHz#-1');
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'CPU6', '2494#Intel#Core(TM) i7-4710MQ CPU @ 2.50GHz#-1');
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'CPU7', '2494#Intel#Core(TM) i7-4710MQ CPU @ 2.50GHz#-1');
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'FS0', 'local#NTFS#C:\\#C:\\');
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'FS1', 'local#NTFS#D:\\#D:\\');
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'FS2', 'local#NTFS#E:\\#E:\\');
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'FS3', 'local#NTFS#G:\\#G:\\');
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'NET0', 'eth6#192.168.48.95#255.255.252.0#192.168.51.255#2C:60:0C:38:01:6D#Realtek PCIe GBE Family Controller#Ethernet');
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'NET1', 'eth9#192.168.40.1#255.255.255.0#192.168.40.255#00:50:56:C0:00:01#VMware Virtual Ethernet Adapter for VMnet1#Ethernet');
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'NET2', 'eth10#192.168.25.1#255.255.255.0#192.168.25.255#00:50:56:C0:00:08#VMware Virtual Ethernet Adapter for VMnet8#Ethernet');
INSERT INTO `devinfo` VALUES ('fa3fa039-fb1a-4cde-8c58-368f7da17edf', 'NET3', 'lo0#127.0.0.1#255.0.0.0#0.0.0.0#00:00:00:00:00:00#Software Loopback Interface 1#Local Loopback');

-- ----------------------------
-- Table structure for flushmetric
-- ----------------------------
DROP TABLE IF EXISTS `flushmetric`;
CREATE TABLE `flushmetric` (
  `agentID` varchar(36) NOT NULL,
  `tag` int(2) NOT NULL,
  `metric` double(20,3) DEFAULT NULL,
  `timestamp` bigint(20) DEFAULT NULL,
  `devID` varchar(200) NOT NULL,
  PRIMARY KEY (`agentID`,`tag`,`devID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of flushmetric
-- ----------------------------

-- ----------------------------
-- Table structure for metric
-- ----------------------------
DROP TABLE IF EXISTS `metric`;
CREATE TABLE `metric` (
  `agentID` varchar(36) NOT NULL,
  `tag` int(2) DEFAULT NULL,
  `metric` double(20,3) DEFAULT NULL,
  `timestamp` bigint(20) DEFAULT NULL,
  `devID` varchar(200) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of metric
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'admin');
INSERT INTO `user` VALUES ('2', 'tian', 'tian');
INSERT INTO `user` VALUES ('3', '276913271@qq.com', '123456');
