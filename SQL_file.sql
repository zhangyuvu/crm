/*
Navicat MySQL Data Transfer

Source Server         : zy的连接
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2021-07-22 20:18:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tbl_activity
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity`;
CREATE TABLE `tbl_activity` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `startDate` char(10) DEFAULT NULL,
  `endDate` char(10) DEFAULT NULL,
  `cost` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_activity
-- ----------------------------
INSERT INTO `tbl_activity` VALUES ('26d880d7b35e4793b799334e95cc9e04', '40f6cdea0bd34aceb77492a1656d9fb3', '发传单1', '2021-07-16', '2021-07-27', '1000', '165561651', '2021-07-16 16:13:15', '李四', null, null);
INSERT INTO `tbl_activity` VALUES ('63525a8b212d4a548e969b7710aeae22', '06f5fc056eac41558a964f96daa7f27c', '电视推广', '2021-07-21', '2021-07-31', '20000', '561561', '2021-07-15 21:39:25', '李四', null, null);
INSERT INTO `tbl_activity` VALUES ('84750bc1937e455d9e47260669484f10', '06f5fc056eac41558a964f96daa7f27c', '发传单3', '2021-07-15', '2021-07-31', '1000', '123456', '2021-07-15 21:34:43', '李四', '2021-07-16 20:15:23', '李四');
INSERT INTO `tbl_activity` VALUES ('b0604657a29944a9b08e4c76f2898a1d', '40f6cdea0bd34aceb77492a1656d9fb3', '百度推广', '2021-07-20', '2021-07-28', '20000', '我真的服了你', '2021-07-16 16:26:41', '李四', '2021-07-16 19:59:12', '李四');
INSERT INTO `tbl_activity` VALUES ('de295181aa5f4920a6d2a20b22458a9c', '06f5fc056eac41558a964f96daa7f27c', '发传单2', '2021-07-06', '2021-07-21', '1200', '6519781', '2021-07-16 16:26:09', '李四', null, null);
INSERT INTO `tbl_activity` VALUES ('fb873f84a95d431c98c79d9322fc2146', '06f5fc056eac41558a964f96daa7f27c', '电视推广', '2021-07-15', '2021-07-31', '200000', '3198561615', '2021-07-15 21:39:05', '李四', null, null);

-- ----------------------------
-- Table structure for tbl_activity_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity_remark`;
CREATE TABLE `tbl_activity_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL COMMENT '0表示未修改，1表示已修改',
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_activity_remark
-- ----------------------------
INSERT INTO `tbl_activity_remark` VALUES ('84750bc1937e455d9e47260669484f01', '我是你咯咯', '2021-07-16 16:13:15', '李四', '2021-07-17 16:24:35', '李四', '1', '84750bc1937e455d9e47260669484f10');
INSERT INTO `tbl_activity_remark` VALUES ('8d0f9933312142be94c84d59cd25fc6e', '她是幺平', '2021-07-17 11:09:23', '李四', '2021-07-17 16:25:38', '李四', '1', '84750bc1937e455d9e47260669484f10');
INSERT INTO `tbl_activity_remark` VALUES ('a84dc43290af45efaa17cbb6dbea84c5', '我是爹', '2021-07-17 11:07:41', '李四', '2021-07-17 16:24:15', '李四', '1', '84750bc1937e455d9e47260669484f10');

-- ----------------------------
-- Table structure for tbl_clue
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue`;
CREATE TABLE `tbl_clue` (
  `id` char(32) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `owner` char(32) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue
-- ----------------------------
INSERT INTO `tbl_clue` VALUES ('c273645a9a6449d79862e7ab3e176fe8', '老干妈', '先生', '06f5fc056eac41558a964f96daa7f27c', '老干妈', 'ceo', 'laoganma@qq.com', '1237894561252', 'website', '147852', '将来联系', '交易会', '李四', '2021-07-19 09:16:52', null, null, '这条线索挺好的', 'sdanhfmsinvnn', '2021-07-26', '无');

-- ----------------------------
-- Table structure for tbl_clue_activity_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_activity_relation`;
CREATE TABLE `tbl_clue_activity_relation` (
  `id` char(32) NOT NULL,
  `clueId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue_activity_relation
-- ----------------------------
INSERT INTO `tbl_clue_activity_relation` VALUES ('b9ea8aa470b449dab103b67909585e55', 'c273645a9a6449d79862e7ab3e176fe8', '63525a8b212d4a548e969b7710aeae22');
INSERT INTO `tbl_clue_activity_relation` VALUES ('ef23183bfb254a1e8032e1e0407a86a0', 'c273645a9a6449d79862e7ab3e176fe8', 'fb873f84a95d431c98c79d9322fc2146');

-- ----------------------------
-- Table structure for tbl_clue_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_remark`;
CREATE TABLE `tbl_clue_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `clueId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue_remark
-- ----------------------------
INSERT INTO `tbl_clue_remark` VALUES ('f9f1cdfe2cc449c8a67502ee74c3fd4f', '老干妈备注1', '李四', '2021-07-19 09:16:52', null, null, '0', 'c273645a9a6449d79862e7ab3e176fe8');

-- ----------------------------
-- Table structure for tbl_contacts
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts`;
CREATE TABLE `tbl_contacts` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `birth` char(10) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts
-- ----------------------------
INSERT INTO `tbl_contacts` VALUES ('5fd72f68683a442a8c57becaf0ce1d77', '06f5fc056eac41558a964f96daa7f27c', '交易会', '0fcb9dce67fc4fedb3cf8ad9229a30dc', '老干妈', '先生', 'laoganma@qq.com', '147852', 'ceo', null, '李四', '2021-07-21 09:38:47', null, null, '这条线索挺好的', 'sdanhfmsinvnn', '2021-07-26', '无');
INSERT INTO `tbl_contacts` VALUES ('c46eb7bb3cfb4f06a86e1d6edad93540', '40f6cdea0bd34aceb77492a1656d9fb3', '聊天', 'b3065a3b168e4cd8be012f949a777c0d', '学姐', '女士', 'xj@nanxiang.com', '1234567', '学生', null, '李四', '2021-07-20 16:55:18', null, null, '这是一条好线索', '这条线索不能丢失 很重要', '2021-07-22', '山东省');

-- ----------------------------
-- Table structure for tbl_contacts_activity_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_activity_relation`;
CREATE TABLE `tbl_contacts_activity_relation` (
  `id` char(32) NOT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts_activity_relation
-- ----------------------------
INSERT INTO `tbl_contacts_activity_relation` VALUES ('1f29cc89bafc40f4811bf1c36cfa112c', 'c46eb7bb3cfb4f06a86e1d6edad93540', 'de295181aa5f4920a6d2a20b22458a9c');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('28413c03ed6346a89c3e3374d53125f5', '5fd72f68683a442a8c57becaf0ce1d77', '63525a8b212d4a548e969b7710aeae22');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('303d78fd4fd3417a97ef8538b51be9eb', '5fd72f68683a442a8c57becaf0ce1d77', 'fb873f84a95d431c98c79d9322fc2146');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('42be3e17e78e4c80990fa9ab3e71951a', 'c46eb7bb3cfb4f06a86e1d6edad93540', '84750bc1937e455d9e47260669484f10');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('fa068d6e768b49789e42cd9b6fa3c5e6', 'c46eb7bb3cfb4f06a86e1d6edad93540', '26d880d7b35e4793b799334e95cc9e04');

-- ----------------------------
-- Table structure for tbl_contacts_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_remark`;
CREATE TABLE `tbl_contacts_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts_remark
-- ----------------------------
INSERT INTO `tbl_contacts_remark` VALUES ('4b4301d294f6400cb15b7153806f39da', '学姐备注2', '李四', '2021-07-20 16:55:18', null, null, '0', 'c46eb7bb3cfb4f06a86e1d6edad93540');
INSERT INTO `tbl_contacts_remark` VALUES ('4db8669143d54b5b98cda74278c51098', '学姐备注1', '李四', '2021-07-20 16:55:18', null, null, '0', 'c46eb7bb3cfb4f06a86e1d6edad93540');
INSERT INTO `tbl_contacts_remark` VALUES ('58eb4a160db14f8680c494258a23d0af', '老干妈备注1', '李四', '2021-07-21 09:38:47', null, null, '0', '5fd72f68683a442a8c57becaf0ce1d77');
INSERT INTO `tbl_contacts_remark` VALUES ('9b351ddf2f514410b5f26b852541698f', '学姐备注3', '李四', '2021-07-20 16:55:18', null, null, '0', 'c46eb7bb3cfb4f06a86e1d6edad93540');

-- ----------------------------
-- Table structure for tbl_customer
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer`;
CREATE TABLE `tbl_customer` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customer
-- ----------------------------
INSERT INTO `tbl_customer` VALUES ('0fcb9dce67fc4fedb3cf8ad9229a30dc', '06f5fc056eac41558a964f96daa7f27c', '老干妈', 'website', '1237894561252', '李四', '2021-07-21 09:38:47', null, null, 'sdanhfmsinvnn', '2021-07-26', '这条线索挺好的', '无');
INSERT INTO `tbl_customer` VALUES ('246ccc7034a947ffbdcd60507fb014d7', '06f5fc056eac41558a964f96daa7f27c', '阿里巴巴', null, null, '李四', '2021-07-21 09:32:08', null, null, null, null, null, null);
INSERT INTO `tbl_customer` VALUES ('b3065a3b168e4cd8be012f949a777c0d', '40f6cdea0bd34aceb77492a1656d9fb3', '南翔教育有限公司', 'niubi.com', '123456', '李四', '2021-07-20 16:55:18', null, null, '这条线索不能丢失 很重要', '2021-07-22', '这是一条好线索', '山东省');
INSERT INTO `tbl_customer` VALUES ('f91b8a2cc11445e6b2cde5b6bcb257f9', '06f5fc056eac41558a964f96daa7f27c', '百度集团', null, null, '李四', '2021-07-21 10:48:10', null, null, '123', '2021-07-31', null, null);

-- ----------------------------
-- Table structure for tbl_customer_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer_remark`;
CREATE TABLE `tbl_customer_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customer_remark
-- ----------------------------
INSERT INTO `tbl_customer_remark` VALUES ('19a1da9fed194f4287a6c07af037dd3f', '学姐备注1', '李四', '2021-07-20 16:55:18', null, null, '0', 'b3065a3b168e4cd8be012f949a777c0d');
INSERT INTO `tbl_customer_remark` VALUES ('1ce9b7820cf04b0fa4e7e646bc248d76', '老干妈备注1', '李四', '2021-07-21 09:38:47', null, null, '0', '0fcb9dce67fc4fedb3cf8ad9229a30dc');
INSERT INTO `tbl_customer_remark` VALUES ('81e77038e80f41398ce12b01fad14f98', '学姐备注2', '李四', '2021-07-20 16:55:18', null, null, '0', 'b3065a3b168e4cd8be012f949a777c0d');
INSERT INTO `tbl_customer_remark` VALUES ('d562452b33784901b7b72d794af7c75f', '学姐备注3', '李四', '2021-07-20 16:55:18', null, null, '0', 'b3065a3b168e4cd8be012f949a777c0d');

-- ----------------------------
-- Table structure for tbl_dic_type
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_type`;
CREATE TABLE `tbl_dic_type` (
  `code` varchar(255) NOT NULL COMMENT '编码是主键，不能为空，不能含有中文。',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dic_type
-- ----------------------------
INSERT INTO `tbl_dic_type` VALUES ('appellation', '称呼', '');
INSERT INTO `tbl_dic_type` VALUES ('clueState', '线索状态', '');
INSERT INTO `tbl_dic_type` VALUES ('returnPriority', '回访优先级', '');
INSERT INTO `tbl_dic_type` VALUES ('returnState', '回访状态', '');
INSERT INTO `tbl_dic_type` VALUES ('source', '来源', '');
INSERT INTO `tbl_dic_type` VALUES ('stage', '阶段', '');
INSERT INTO `tbl_dic_type` VALUES ('transactionType', '交易类型', '');

-- ----------------------------
-- Table structure for tbl_dic_value
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_value`;
CREATE TABLE `tbl_dic_value` (
  `id` char(32) NOT NULL COMMENT '主键，采用UUID',
  `value` varchar(255) DEFAULT NULL COMMENT '不能为空，并且要求同一个字典类型下字典值不能重复，具有唯一性。',
  `text` varchar(255) DEFAULT NULL COMMENT '可以为空',
  `orderNo` varchar(255) DEFAULT NULL COMMENT '可以为空，但不为空的时候，要求必须是正整数',
  `typeCode` varchar(255) DEFAULT NULL COMMENT '外键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dic_value
-- ----------------------------
INSERT INTO `tbl_dic_value` VALUES ('06e3cbdf10a44eca8511dddfc6896c55', '虚假线索', '虚假线索', '4', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('0fe33840c6d84bf78df55d49b169a894', '销售邮件', '销售邮件', '8', 'source');
INSERT INTO `tbl_dic_value` VALUES ('12302fd42bd349c1bb768b19600e6b20', '交易会', '交易会', '11', 'source');
INSERT INTO `tbl_dic_value` VALUES ('1615f0bb3e604552a86cde9a2ad45bea', '最高', '最高', '2', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('176039d2a90e4b1a81c5ab8707268636', '教授', '教授', '5', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('1e0bd307e6ee425599327447f8387285', '将来联系', '将来联系', '2', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2173663b40b949ce928db92607b5fe57', '丢失线索', '丢失线索', '5', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2876690b7e744333b7f1867102f91153', '未启动', '未启动', '1', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('29805c804dd94974b568cfc9017b2e4c', '07成交', '07成交', '7', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('310e6a49bd8a4962b3f95a1d92eb76f4', '试图联系', '试图联系', '1', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('31539e7ed8c848fc913e1c2c93d76fd1', '博士', '博士', '4', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('37ef211719134b009e10b7108194cf46', '01资质审查', '01资质审查', '1', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('391807b5324d4f16bd58c882750ee632', '08丢失的线索', '08丢失的线索', '8', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('3a39605d67da48f2a3ef52e19d243953', '聊天', '聊天', '14', 'source');
INSERT INTO `tbl_dic_value` VALUES ('474ab93e2e114816abf3ffc596b19131', '低', '低', '3', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('48512bfed26145d4a38d3616e2d2cf79', '广告', '广告', '1', 'source');
INSERT INTO `tbl_dic_value` VALUES ('4d03a42898684135809d380597ed3268', '合作伙伴研讨会', '合作伙伴研讨会', '9', 'source');
INSERT INTO `tbl_dic_value` VALUES ('59795c49896947e1ab61b7312bd0597c', '先生', '先生', '1', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('5c6e9e10ca414bd499c07b886f86202a', '高', '高', '1', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('67165c27076e4c8599f42de57850e39c', '夫人', '夫人', '2', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('68a1b1e814d5497a999b8f1298ace62b', '09因竞争丢失关闭', '09因竞争丢失关闭', '9', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('6b86f215e69f4dbd8a2daa22efccf0cf', 'web调研', 'web调研', '13', 'source');
INSERT INTO `tbl_dic_value` VALUES ('72f13af8f5d34134b5b3f42c5d477510', '合作伙伴', '合作伙伴', '6', 'source');
INSERT INTO `tbl_dic_value` VALUES ('7c07db3146794c60bf975749952176df', '未联系', '未联系', '6', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('86c56aca9eef49058145ec20d5466c17', '内部研讨会', '内部研讨会', '10', 'source');
INSERT INTO `tbl_dic_value` VALUES ('9095bda1f9c34f098d5b92fb870eba17', '进行中', '进行中', '3', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('954b410341e7433faa468d3c4f7cf0d2', '已有业务', '已有业务', '1', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('966170ead6fa481284b7d21f90364984', '已联系', '已联系', '3', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('96b03f65dec748caa3f0b6284b19ef2f', '推迟', '推迟', '2', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('97d1128f70294f0aac49e996ced28c8a', '新业务', '新业务', '2', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('9ca96290352c40688de6596596565c12', '完成', '完成', '4', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('9e6d6e15232549af853e22e703f3e015', '需要条件', '需要条件', '7', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('9ff57750fac04f15b10ce1bbb5bb8bab', '02需求分析', '02需求分析', '2', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('a70dc4b4523040c696f4421462be8b2f', '等待某人', '等待某人', '5', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('a83e75ced129421dbf11fab1f05cf8b4', '推销电话', '推销电话', '2', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ab8472aab5de4ae9b388b2f1409441c1', '常规', '常规', '5', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('ab8c2a3dc05f4e3dbc7a0405f721b040', '05提案/报价', '05提案/报价', '5', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('b924d911426f4bc5ae3876038bc7e0ad', 'web下载', 'web下载', '12', 'source');
INSERT INTO `tbl_dic_value` VALUES ('c13ad8f9e2f74d5aa84697bb243be3bb', '03价值建议', '03价值建议', '3', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('c83c0be184bc40708fd7b361b6f36345', '最低', '最低', '4', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('db867ea866bc44678ac20c8a4a8bfefb', '员工介绍', '员工介绍', '3', 'source');
INSERT INTO `tbl_dic_value` VALUES ('e44be1d99158476e8e44778ed36f4355', '04确定决策者', '04确定决策者', '4', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('e5f383d2622b4fc0959f4fe131dafc80', '女士', '女士', '3', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('e81577d9458f4e4192a44650a3a3692b', '06谈判/复审', '06谈判/复审', '6', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('fb65d7fdb9c6483db02713e6bc05dd19', '在线商场', '在线商场', '5', 'source');
INSERT INTO `tbl_dic_value` VALUES ('fd677cc3b5d047d994e16f6ece4d3d45', '公开媒介', '公开媒介', '7', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ff802a03ccea4ded8731427055681d48', '外部介绍', '外部介绍', '4', 'source');

-- ----------------------------
-- Table structure for tbl_tran
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran`;
CREATE TABLE `tbl_tran` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran
-- ----------------------------
INSERT INTO `tbl_tran` VALUES ('8ec0c7d1e64a46a7ae6cdaeb343e8ee9', '06f5fc056eac41558a964f96daa7f27c', '50000', '收购山东南翔', '2021-07-23', '246ccc7034a947ffbdcd60507fb014d7', '09因竞争丢失关闭', '新业务', '聊天', '26d880d7b35e4793b799334e95cc9e04', '5fd72f68683a442a8c57becaf0ce1d77', '李四', '2021-07-21 09:35:56', '李四', '2021-07-21 21:43:18', '阿里巴巴收购南翔', '可能性很大', '2021-07-23');
INSERT INTO `tbl_tran` VALUES ('a1f80832a8e04b97b96edf7f973a7603', '06f5fc056eac41558a964f96daa7f27c', '6666666', '收购老干妈', '2021-07-23', 'f91b8a2cc11445e6b2cde5b6bcb257f9', '04确定决策者', '新业务', '广告', '26d880d7b35e4793b799334e95cc9e04', 'c46eb7bb3cfb4f06a86e1d6edad93540', '李四', '2021-07-21 10:48:10', '李四', '2021-07-21 21:43:12', '123', '123', '2021-07-31');
INSERT INTO `tbl_tran` VALUES ('a1f80832a8e04b97b96edf7f973a7604', null, null, null, null, null, '05提案/报价', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_tran` VALUES ('a1f80832a8e04b97b96edf7f973a7605', null, null, null, null, null, '01资质审查', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_tran` VALUES ('a1f80832a8e04b97b96edf7f973a7606', null, null, null, null, null, '07成交', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_tran` VALUES ('a1f80832a8e04b97b96edf7f973a7607', null, null, null, null, null, '07成交', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_tran` VALUES ('a1f80832a8e04b97b96edf7f973a7608', null, null, null, null, null, '02需求分析', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_tran` VALUES ('a1f80832a8e04b97b96edf7f973a7609', null, null, null, null, null, '03价值建议', null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for tbl_tran_history
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_history`;
CREATE TABLE `tbl_tran_history` (
  `id` char(32) NOT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran_history
-- ----------------------------
INSERT INTO `tbl_tran_history` VALUES ('1f865d9e480f4b59807aaac98a53ffb3', '09因竞争丢失关闭', '50000', '2021-07-23', '2021-07-21 21:43:18', '李四', '8ec0c7d1e64a46a7ae6cdaeb343e8ee9');
INSERT INTO `tbl_tran_history` VALUES ('235b5272adc04ab8a4dddb0d0e500c5a', '03价值建议', '6666666', '2021-07-23', '2021-07-21 10:48:10', '李四', 'a1f80832a8e04b97b96edf7f973a7603');
INSERT INTO `tbl_tran_history` VALUES ('36adacf322864441a2374963f3d2c426', '07成交', '6666666', '2021-07-23', '2021-07-21 21:43:02', '李四', 'a1f80832a8e04b97b96edf7f973a7603');
INSERT INTO `tbl_tran_history` VALUES ('67dc94ae6c63475d88888456d616e5fa', '03价值建议', '6666666', '2021-07-23', '2021-07-21 21:42:55', '李四', 'a1f80832a8e04b97b96edf7f973a7603');
INSERT INTO `tbl_tran_history` VALUES ('76f6e68c50514b03b4d6377f6b3b8cee', '09因竞争丢失关闭', '6666666', '2021-07-23', '2021-07-21 21:43:10', '李四', 'a1f80832a8e04b97b96edf7f973a7603');
INSERT INTO `tbl_tran_history` VALUES ('8e369e6994b342538a0663144d89a148', '07成交', '50000', '2021-07-23', '2021-07-21 20:50:33', '李四', '8ec0c7d1e64a46a7ae6cdaeb343e8ee9');
INSERT INTO `tbl_tran_history` VALUES ('8ec0c7d1e64a46a7ae6cdaeb343e8ee8', '03价值建议', '100560', '2021-07-29', '2021-07-30 12:30:39', '张三', '8ec0c7d1e64a46a7ae6cdaeb343e8ee9');
INSERT INTO `tbl_tran_history` VALUES ('a1f80832a8e04b97b96edf7f973a7604', '05提案/报价', '22200', '2021-07-24', '2021-07-28 17:49:20', '张三', 'a1f80832a8e04b97b96edf7f973a7603');
INSERT INTO `tbl_tran_history` VALUES ('e2ab6344594e480089de261d143dc90d', '04确定决策者', '6666666', '2021-07-23', '2021-07-21 21:43:12', '李四', 'a1f80832a8e04b97b96edf7f973a7603');
INSERT INTO `tbl_tran_history` VALUES ('ee4ebe021f0d494fbf4cd9a859edfcb1', '08丢失的线索', '6666666', '2021-07-23', '2021-07-21 21:43:07', '李四', 'a1f80832a8e04b97b96edf7f973a7603');

-- ----------------------------
-- Table structure for tbl_tran_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_remark`;
CREATE TABLE `tbl_tran_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran_remark
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `id` char(32) NOT NULL COMMENT 'uuid ',
  `loginAct` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL COMMENT '密码不能采用明文存储，采用密文，MD5加密之后的数据',
  `email` varchar(255) DEFAULT NULL,
  `expireTime` char(19) DEFAULT NULL COMMENT '失效时间为空的时候表示永不失效，失效时间为2018-10-10 10:10:10，则表示在该时间之前该账户可用。',
  `lockState` char(1) DEFAULT NULL COMMENT '锁定状态为空时表示启用，为0时表示锁定，为1时表示启用。',
  `deptno` char(4) DEFAULT NULL,
  `allowIps` varchar(255) DEFAULT NULL COMMENT '允许访问的IP为空时表示IP地址永不受限，允许访问的IP可以是一个，也可以是多个，当多个IP地址的时候，采用半角逗号分隔。允许IP是192.168.100.2，表示该用户只能在IP地址为192.168.100.2的机器上使用。',
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES ('06f5fc056eac41558a964f96daa7f27c', 'ls', '李四', '202cb962ac59075b964b07152d234b70', 'ls@163.com', '2022-11-27 21:50:05', '1', 'A001', '192.168.1.1,127.0.0.1', '2018-11-22 12:11:40', '李四', null, null);
INSERT INTO `tbl_user` VALUES ('40f6cdea0bd34aceb77492a1656d9fb3', 'zs', '张三', '202cb962ac59075b964b07152d234b70', 'zs@qq.com', '2021-11-30 23:50:55', '0', 'A001', '192.168.1.1,192.168.1.2,127.0.0.1', '2018-11-22 11:37:34', '张三', null, null);
