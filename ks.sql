/*
Navicat MySQL Data Transfer

Source Server         : localhost2
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : db_lottery

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2017-08-13 16:40:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `betting`
-- ----------------------------
DROP TABLE IF EXISTS `betting`;
CREATE TABLE `betting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typename` varchar(100) DEFAULT NULL,
  `keyword` varchar(100) DEFAULT NULL COMMENT '关键字用来匹配投注',
  `rate` float DEFAULT NULL COMMENT '赔率',
  `demo` varchar(800) DEFAULT NULL COMMENT '案例',
  `top` float DEFAULT NULL,
  `min` float DEFAULT NULL,
  `max` float DEFAULT NULL,
  `info` varchar(800) DEFAULT NULL,
  `able` varchar(255) DEFAULT NULL,
  `config` varchar(255) DEFAULT NULL,
  `rebate` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting
-- ----------------------------
INSERT INTO `betting` VALUES ('2', '大', '大', '1.95', '大100', '30000', '10', '30000', '开奖号的三个数相加的和为（11、12、13、14、15、16、17 、18）中奖', '1', '11,12,13,14,15,16,17,18', '2');
INSERT INTO `betting` VALUES ('3', '小', '小', '1.95', '小100', '30000', '10', '30000', '开奖号的三个数相加的和为（3、4、5、6、7、8、9 、10）中奖', '1', '3,4,5,6,7,8,9,10', '1.5');
INSERT INTO `betting` VALUES ('4', '单', '单', '1.95', '单100', '30000', '10', '30000', '开奖号的三个数相加的和尾为单数（3、5、7、9、11、13、15、17）中奖', '1', '3,5,7,9,11,13,15,17', '2');
INSERT INTO `betting` VALUES ('5', '双', '双', '1.95', '双100', '30000', '10', '30000', '开奖号的三个数相加的和尾为双数（4、6、8、10、12、14、16、18）中奖', '1', '4,6,8,10,12,14,16,18', '2');
INSERT INTO `betting` VALUES ('6', '大单', '大单', '0', '大单100', '0', '0', '0', '开奖号的三个数相加的和为（11、13、15、17）中奖', '0', '11,13,15,17', '0');
INSERT INTO `betting` VALUES ('7', '大双', '大双', '0', '大双100', '0', '0', '0', '开奖号的三个数相加的和为（12、14、16、18）中奖', '0', '12,14,16,18', '0');
INSERT INTO `betting` VALUES ('8', '小双', '小双', '0', '小双100', '0', '0', '0', '开奖号的三个数相加的和为（4、6、8、10）中奖', '0', '4,6,8,10', '0');
INSERT INTO `betting` VALUES ('9', '小单', '小单', '0', '小单100', '0', '0', '0', '开奖号的三个数相加的和为（3、5、7、9）中奖', '0', '3,5,7,9', '0');
INSERT INTO `betting` VALUES ('11', '4和', '4和', '50', '5和100', '500', '10', '500', '开奖号的三个数相加的和', '1', '4', '10');
INSERT INTO `betting` VALUES ('12', '5和', '5和', '25', '5和100', '1000', '10', '1000', '开奖号的三个数相加的和', '1', '5', '10');
INSERT INTO `betting` VALUES ('13', '6和', '6和', '15', '5和100', '2000', '10', '2000', '开奖号的三个数相加的和', '1', '6', '10');
INSERT INTO `betting` VALUES ('14', '7和', '7和', '10', '5和100', '3000', '10', '3000', '开奖号的三个数相加的和', '1', '7', '10');
INSERT INTO `betting` VALUES ('15', '8和', '8和', '8', '5和100', '4000', '10', '4000', '开奖号的三个数相加的和', '1', '8', '10');
INSERT INTO `betting` VALUES ('16', '9和', '9和', '7', '5和100', '4000', '10', '4000', '开奖号的三个数相加的和', '1', '9', '10');
INSERT INTO `betting` VALUES ('17', '10和', '10和', '6', '5和100', '5000', '10', '5000', '开奖号的三个数相加的和', '1', '10', '10');
INSERT INTO `betting` VALUES ('18', '11和', '11和', '6', '5和100', '5000', '10', '5000', '开奖号的三个数相加的和', '1', '11', '10');
INSERT INTO `betting` VALUES ('19', '12和', '12和', '7', '5和100', '4000', '10', '4000', '开奖号的三个数相加的和', '1', '12', '10');
INSERT INTO `betting` VALUES ('20', '13和', '13和', '8', '5和100', '4000', '10', '4000', '开奖号的三个数相加的和', '1', '13', '10');
INSERT INTO `betting` VALUES ('21', '14和', '14和', '10', '5和100', '3000', '10', '3000', '开奖号的三个数相加的和', '1', '14', '10');
INSERT INTO `betting` VALUES ('22', '15和', '15和', '15', '5和100', '2000', '10', '2000', '开奖号的三个数相加的和', '1', '15', '10');
INSERT INTO `betting` VALUES ('23', '16和', '16和', '25', '5和100', '1000', '10', '1000', '开奖号的三个数相加的和', '1', '16', '10');
INSERT INTO `betting` VALUES ('24', '17和', '17和', '50', '5和100', '500', '10', '500', '开奖号的三个数相加的和', '1', '17', '10');
INSERT INTO `betting` VALUES ('25', '五码黑', '五码黑', '2.5', '12345黑100', '20000', '10', '20000', '购买的五个号中必须包含与开奖的三个号码相同视为中奖，开奖号如出现重叠号（如112、335等）或豹子号（111、、222等）则不中奖。（两个或两个以上的不中奖）', '1', '', '5');
INSERT INTO `betting` VALUES ('26', '五码红', '五码红', '0', '12345红100', '0', '0', '0', '开奖号码出现重叠号（如开奖号码224）购买的五个号中包含了（2、4）视为中奖，开奖号如未出现重叠号或出现豹子号则不中奖。', '0', '', '0');
INSERT INTO `betting` VALUES ('27', '四码黑', '四码黑', '6', '1234黑100', '5000', '10', '5000', '购买的四个号中必须包含与开奖的三个号码相同视为中奖，开奖号如出现重叠号，豹子号则不中奖。', '1', '', '5');
INSERT INTO `betting` VALUES ('28', '四码红', '四码红', '5', '1234红100', '6000', '10', '6000', '开奖号码出现重叠号（如开奖号码224）购买的四个号中包含了（2、4）视为中奖，开奖号如未出现重叠号或出现豹子号则不中奖。', '1', '', '5');
INSERT INTO `betting` VALUES ('29', '三码黑', '三码黑', '25', '123黑100', '1500', '10', '1500', '购买的三个号码与开奖号码完全相同不分顺序，则中奖，如出现重叠号，豹子号则不中奖。', '1', '', '10');
INSERT INTO `betting` VALUES ('30', '三码红', '三码红', '50', '123红100', '600', '10', '600', '开奖号码出现重叠号（如224和115），购买的三个号码包含开奖号码则中奖，如未出现重叠号或出现豹子号则不中奖。', '1', '', '10');
INSERT INTO `betting` VALUES ('31', '包红', '包红', '2', '包红100', '30000', '10', '30000', '开奖号码只要出现重叠号（如224或115）等则中奖，如未出现重叠号或出现豹子号则不中奖。', '1', '', '2');
INSERT INTO `betting` VALUES ('32', '二同号', '二同号', '10', '1对100', '3000', '10', '3000', '开奖号码必须出现重叠号（如开奖115），购买的号中与开奖中重叠号相同则中奖（包括豹子号），如购买1对开奖115中奖或开奖111也中奖，', '1', '', '10');
INSERT INTO `betting` VALUES ('33', '二不同', '二不同', '5', '12飞100', '6000', '10', '6000', '开奖号码中包含了购买的两个号则中奖，如购买2、3，开奖号123或236都中奖。只要包含所购买的两个数就中奖不分顺序。', '1', '', '10');
INSERT INTO `betting` VALUES ('34', '直选', '直选', '0', '123/100', '0', '0', '0', '开奖号中三位数与购买的三位数相同则中奖。', '0', '', '0');
INSERT INTO `betting` VALUES ('35', '通', '通', '25', '通100', '1500', '10', '1500', '开奖号码只要出现三个相同号则中奖，如开奖号：111、222、333、444/555/666等', '1', '', '5');
INSERT INTO `betting` VALUES ('36', '豹直选', '豹直选', '170', '1豹子100', '200', '10', '200', '开奖开出三个相同号码并与购买的三个号码相同则中奖，如购买2，开奖号码也出现222则中奖。', '1', '', '10');
INSERT INTO `betting` VALUES ('37', '半顺', '半顺', '2.5', '半顺100', '20000', '10', '20000', '开奖号码未出现重叠号，并出现两个连号，如开奖号126或235则中奖，出现重叠号（如223）或全顺（如123）或豹子号（三个相同号）则不中奖（两个相邻的号码）', '1', '', '5');
INSERT INTO `betting` VALUES ('38', '杂顺', '杂顺', '7', '杂顺100', '5000', '10', '5000', '开奖号码中的三个号都不相连（如开奖号135、246、136、146）则中奖，如出现重叠号或顺子号、半顺号、豹子号则不中奖。', '1', '', '5');
INSERT INTO `betting` VALUES ('39', '全顺', '全顺', '7', '顺子100', '5000', '10', '5000', '开奖号码中出现三个连续号（不分顺序），如123或345则中奖，如出现重叠号或豹子号则不中奖。', '1', '', '5');

-- ----------------------------
-- Table structure for `betting_log`
-- ----------------------------
DROP TABLE IF EXISTS `betting_log`;
CREATE TABLE `betting_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(500) DEFAULT NULL COMMENT '投注记录',
  `lottery` varchar(20) DEFAULT NULL COMMENT '期数',
  `created` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `betting_id` int(11) DEFAULT NULL,
  `money` decimal(10,0) DEFAULT NULL,
  `iswin` tinyint(4) DEFAULT NULL,
  `buynum` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of betting_log
-- ----------------------------

-- ----------------------------
-- Table structure for `lottery`
-- ----------------------------
DROP TABLE IF EXISTS `lottery`;
CREATE TABLE `lottery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lottery` varchar(255) DEFAULT NULL COMMENT '期数',
  `result` varchar(255) DEFAULT NULL COMMENT '结果',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lottery
-- ----------------------------
