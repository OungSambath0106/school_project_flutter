/*
 Navicat Premium Dump SQL

 Source Server         : Localhost
 Source Server Type    : MySQL
 Source Server Version : 80300 (8.3.0)
 Source Host           : localhost:3306
 Source Schema         : bbusrd106d2p20

 Target Server Type    : MySQL
 Target Server Version : 80300 (8.3.0)
 File Encoding         : 65001

 Date: 11/01/2025 11:48:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbluser
-- ----------------------------
DROP TABLE IF EXISTS `tbluser`;
CREATE TABLE `tbluser`  (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `UserPassword` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `UserType` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'user',
  `UserImage` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'default.png',
  `UserEmail` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `FullName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `PhoneNumber` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`UserID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbluser
-- ----------------------------
INSERT INTO `tbluser` VALUES (1, 'johndoe', '202cb962ac59075b964b07152d234b70', 'user', 'default.png', 'johndoe@example.com', 'John Doe', '1234567890');
INSERT INTO `tbluser` VALUES (2, 'bbuadmin', 'e10adc3949ba59abbe56e057f20f883e', 'user', 'default.png', NULL, 'BBU Admin', NULL);
INSERT INTO `tbluser` VALUES (3, 'China', 'b59c67bf196a4758191e42f76670ceba', 'user', 'default.png', NULL, 'China', NULL);
INSERT INTO `tbluser` VALUES (4, 'azula', '202cb962ac59075b964b07152d234b70', 'user', 'default.png', NULL, 'Azula', NULL);
INSERT INTO `tbluser` VALUES (6, 'makara', '827ccb0eea8a706c4c34a16891f84e7b', 'user', 'default.png', NULL, 'Thoeun Makara', NULL);
INSERT INTO `tbluser` VALUES (7, 'china', '202cb962ac59075b964b07152d234b70', 'user', 'default.png', NULL, 'China', NULL);
INSERT INTO `tbluser` VALUES (8, 'bath', '202cb962ac59075b964b07152d234b70', 'user', 'default.png', NULL, 'SomBath', NULL);
INSERT INTO `tbluser` VALUES (9, 'aaa', '698d51a19d8a121ce581499d7b701668', 'user', 'default.png', NULL, 'aaa', NULL);
INSERT INTO `tbluser` VALUES (10, 'azula', '827ccb0eea8a706c4c34a16891f84e7b', 'user', 'azula.jpg', 'azula123@gmail.com', 'Princess Azula', '09876543');
INSERT INTO `tbluser` VALUES (11, 'Thon Sotheavann', '25d55ad283aa400af464c76d713c07ad', 'user', 'default.png', 'theavann@gmail.com', 'Sotheavann', '012345678');

SET FOREIGN_KEY_CHECKS = 1;
