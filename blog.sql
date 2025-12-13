/*
 Navicat Premium Dump SQL

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80403 (8.4.3)
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 80403 (8.4.3)
 File Encoding         : 65001

 Date: 30/04/2025 19:10:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `images` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `user_id` int DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `count` int DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of blog
-- ----------------------------
BEGIN;
INSERT INTO `blog` (`id`, `images`, `title`, `content`, `user_id`, `username`, `create_time`, `count`, `type`) VALUES (31, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png,http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '测试一下', '<p>测试一下</p>', 2, 'user', '2025-04-26 17:19:59', 1, 'java');
INSERT INTO `blog` (`id`, `images`, `title`, `content`, `user_id`, `username`, `create_time`, `count`, `type`) VALUES (32, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png,http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png,http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', '测试一下', '<p>测试一下<span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span><span style=\"text-wrap-mode: wrap;\">测试一下</span></p>', 2, 'user', '2025-04-26 20:21:56', 1, 'java');
INSERT INTO `blog` (`id`, `images`, `title`, `content`, `user_id`, `username`, `create_time`, `count`, `type`) VALUES (34, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '测试测试', '<p>测试</p>', 2, 'user', '2025-04-26 21:56:57', 0, 'jsp');
COMMIT;

-- ----------------------------
-- Table structure for blog_file
-- ----------------------------
DROP TABLE IF EXISTS `blog_file`;
CREATE TABLE `blog_file` (
  `id` int NOT NULL AUTO_INCREMENT,
  `blog_id` int NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of blog_file
-- ----------------------------
BEGIN;
INSERT INTO `blog_file` (`id`, `blog_id`, `image_url`, `type`) VALUES (104, 31, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'img');
INSERT INTO `blog_file` (`id`, `blog_id`, `image_url`, `type`) VALUES (105, 31, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', 'img');
INSERT INTO `blog_file` (`id`, `blog_id`, `image_url`, `type`) VALUES (106, 31, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', 'video');
INSERT INTO `blog_file` (`id`, `blog_id`, `image_url`, `type`) VALUES (107, 31, 'http://localhost:8080/file/3faf7a66e3ec47cfb2084397b066f14a.txt', 'doc');
INSERT INTO `blog_file` (`id`, `blog_id`, `image_url`, `type`) VALUES (108, 32, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'img');
INSERT INTO `blog_file` (`id`, `blog_id`, `image_url`, `type`) VALUES (109, 32, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'img');
INSERT INTO `blog_file` (`id`, `blog_id`, `image_url`, `type`) VALUES (110, 32, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'img');
INSERT INTO `blog_file` (`id`, `blog_id`, `image_url`, `type`) VALUES (111, 32, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', 'video');
INSERT INTO `blog_file` (`id`, `blog_id`, `image_url`, `type`) VALUES (112, 32, 'http://localhost:8080/file/3faf7a66e3ec47cfb2084397b066f14a.txt', 'doc');
INSERT INTO `blog_file` (`id`, `blog_id`, `image_url`, `type`) VALUES (113, 34, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', 'img');
COMMIT;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `blog_id` int DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of comment
-- ----------------------------
BEGIN;
INSERT INTO `comment` (`id`, `user_id`, `username`, `blog_id`, `content`, `create_time`) VALUES (3, 2, 'user', 24, '你写的真不错', NULL);
INSERT INTO `comment` (`id`, `user_id`, `username`, `blog_id`, `content`, `create_time`) VALUES (5, 2, 'user', 24, '1111', '2025-04-15 12:23:44');
INSERT INTO `comment` (`id`, `user_id`, `username`, `blog_id`, `content`, `create_time`) VALUES (6, 2, 'user', 24, '222', '2025-04-15 12:23:49');
INSERT INTO `comment` (`id`, `user_id`, `username`, `blog_id`, `content`, `create_time`) VALUES (7, 2, 'user', 24, '不错误', '2025-04-15 12:24:02');
INSERT INTO `comment` (`id`, `user_id`, `username`, `blog_id`, `content`, `create_time`) VALUES (8, 2, 'user', 32, '2', '2025-04-26 13:47:22');
COMMIT;

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `size` bigint DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `md5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_delete` tinyint(1) DEFAULT NULL,
  `enable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=295 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of file
-- ----------------------------
BEGIN;
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (226, 'u=827995434,2519090319&fm=253&app=120&f=JPEG.jpeg', 'jpeg', 54, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '4ded01dd631d60fd064f5a29bbb658a3', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (227, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (228, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8082/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (229, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8082/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (230, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (231, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (232, 'u=827995434,2519090319&fm=253&app=120&f=JPEG.jpeg', 'jpeg', 54, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '4ded01dd631d60fd064f5a29bbb658a3', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (233, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (234, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (235, 'u=827995434,2519090319&fm=253&app=120&f=JPEG.jpeg', 'jpeg', 54, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '4ded01dd631d60fd064f5a29bbb658a3', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (236, 'u=827995434,2519090319&fm=253&app=120&f=JPEG.jpeg', 'jpeg', 54, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '4ded01dd631d60fd064f5a29bbb658a3', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (237, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (238, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (239, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (240, 'u=827995434,2519090319&fm=253&app=120&f=JPEG.jpeg', 'jpeg', 54, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '4ded01dd631d60fd064f5a29bbb658a3', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (241, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (242, 'u=827995434,2519090319&fm=253&app=120&f=JPEG.jpeg', 'jpeg', 54, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '4ded01dd631d60fd064f5a29bbb658a3', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (243, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (244, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (245, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (246, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (247, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (248, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (249, 'u=827995434,2519090319&fm=253&app=120&f=JPEG.jpeg', 'jpeg', 54, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '4ded01dd631d60fd064f5a29bbb658a3', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (250, 'u=827995434,2519090319&fm=253&app=120&f=JPEG.jpeg', 'jpeg', 54, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '4ded01dd631d60fd064f5a29bbb658a3', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (251, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (252, 'u=827995434,2519090319&fm=253&app=120&f=JPEG.jpeg', 'jpeg', 54, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '4ded01dd631d60fd064f5a29bbb658a3', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (253, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (254, 'u=827995434,2519090319&fm=253&app=120&f=JPEG.jpeg', 'jpeg', 54, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '4ded01dd631d60fd064f5a29bbb658a3', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (255, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (256, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (257, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (258, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (259, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (260, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (261, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (262, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (263, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (264, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (265, 'u=1596905743,641508503&fm=253&fmt=auto&app=138&f=GIF.gif', 'gif', 6, 'http://localhost:8080/file/c9348277a83a48ebb4bc82be2fd51e9a.gif', '0ede4c30ca30b94aed64a00e93d1ebfb', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (266, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (267, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (268, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (269, '带你入门MCP技术.pdf', 'pdf', 2495, 'http://localhost:8080/file/8bec639c914f47ee9a5cabe8da3066d3.pdf', 'fc662a1d3295f45c8e1c0ae9205c30cf', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (270, '带你入门MCP技术.pdf', 'pdf', 2495, 'http://localhost:8080/file/8bec639c914f47ee9a5cabe8da3066d3.pdf', 'fc662a1d3295f45c8e1c0ae9205c30cf', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (271, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (272, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (273, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (274, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (275, 'blog_副本.txt', 'txt', 4, 'http://localhost:8080/file/3faf7a66e3ec47cfb2084397b066f14a.txt', '32bcf7b95c5b54f5851fc302b1c33c08', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (276, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (277, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (278, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (279, 'blog_副本.txt', 'txt', 4, 'http://localhost:8080/file/3faf7a66e3ec47cfb2084397b066f14a.txt', '32bcf7b95c5b54f5851fc302b1c33c08', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (280, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (281, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (282, 'blog_副本.txt', 'txt', 4, 'http://localhost:8080/file/3faf7a66e3ec47cfb2084397b066f14a.txt', '32bcf7b95c5b54f5851fc302b1c33c08', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (283, 'blog_副本.txt', 'txt', 4, 'http://localhost:8080/file/3faf7a66e3ec47cfb2084397b066f14a.txt', '32bcf7b95c5b54f5851fc302b1c33c08', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (284, 'blog_副本.txt', 'txt', 4, 'http://localhost:8080/file/3faf7a66e3ec47cfb2084397b066f14a.txt', '32bcf7b95c5b54f5851fc302b1c33c08', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (285, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (286, 'u=827995434,2519090319&fm=253&app=120&f=JPEG.jpeg', 'jpeg', 54, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '4ded01dd631d60fd064f5a29bbb658a3', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (287, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (288, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (289, 'blog_副本.txt', 'txt', 4, 'http://localhost:8080/file/3faf7a66e3ec47cfb2084397b066f14a.txt', '32bcf7b95c5b54f5851fc302b1c33c08', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (290, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (291, 'd0c8a786c9177f3e8da0098d62cf3bc79e3d569e.png', 'png', 4986, 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', 'd4c1335580e70244ca1a0c2cff41c2aa', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (292, 'Screen-2025-04-26-173736.mp4', 'mp4', 946, 'http://localhost:8080/file/da3fd4fe50ff4dcbbe30545dc15a1435.mp4', '10e7bffffb50533e9c01ca3e5e1a8550', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (293, 'u=827995434,2519090319&fm=253&app=120&f=JPEG.jpeg', 'jpeg', 54, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '4ded01dd631d60fd064f5a29bbb658a3', 1, 2);
INSERT INTO `file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (294, 'u=827995434,2519090319&fm=253&app=120&f=JPEG.jpeg', 'jpeg', 54, 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '4ded01dd631d60fd064f5a29bbb658a3', 1, 2);
COMMIT;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text COLLATE utf8mb4_general_ci,
  `session_id` int DEFAULT NULL,
  `message_user_id` int DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of message
-- ----------------------------
BEGIN;
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (1, '测试一下收到了吗！', 1, 1, '2025-04-28 20:29:07');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (2, '收到了', 1, 2, '2025-04-28 20:29:41');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (3, '222', 1, 2, '2025-04-28 13:04:57');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (4, '1111', 1, 2, '2025-04-28 13:05:16');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (5, '22222', 1, 2, '2025-04-28 13:06:16');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (6, '33333', 1, 2, '2025-04-28 13:06:19');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (7, '你好\n', 2, 13, '2025-04-28 13:07:45');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (8, '你好呀\n', 2, 2, '2025-04-28 13:07:54');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (9, '我操\n', 2, 13, '2025-04-28 13:07:59');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (10, '你牛逼', 2, 2, '2025-04-28 13:08:22');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (11, '我不牛逼\n', 2, 13, '2025-04-28 13:08:25');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (12, '你真的很牛逼\n', 2, 2, '2025-04-28 13:08:48');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (13, '我还行吧\n', 2, 13, '2025-04-28 13:08:52');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (14, '谦虚了\n', 2, 2, '2025-04-28 13:08:55');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (15, '没有没有\n', 2, 13, '2025-04-28 13:08:59');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (16, '你真骚\n', 2, 2, '2025-04-28 13:12:41');
INSERT INTO `message` (`id`, `content`, `session_id`, `message_user_id`, `create_time`) VALUES (17, '你才骚\n', 2, 13, '2025-04-28 13:12:47');
COMMIT;

-- ----------------------------
-- Table structure for operation
-- ----------------------------
DROP TABLE IF EXISTS `operation`;
CREATE TABLE `operation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` int DEFAULT NULL,
  `blog_id` int DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of operation
-- ----------------------------
BEGIN;
INSERT INTO `operation` (`id`, `type`, `blog_id`, `title`, `user_id`, `username`) VALUES (1, 2, 24, '测试文章2', 2, 'user');
INSERT INTO `operation` (`id`, `type`, `blog_id`, `title`, `user_id`, `username`) VALUES (2, 2, 23, '测试文章发布', 2, 'user');
INSERT INTO `operation` (`id`, `type`, `blog_id`, `title`, `user_id`, `username`) VALUES (5, 1, 24, '测试文章2', 2, 'user');
INSERT INTO `operation` (`id`, `type`, `blog_id`, `title`, `user_id`, `username`) VALUES (6, 1, 23, '测试文章发布', 2, 'user');
INSERT INTO `operation` (`id`, `type`, `blog_id`, `title`, `user_id`, `username`) VALUES (7, 2, 32, '测试一下', 2, 'user');
INSERT INTO `operation` (`id`, `type`, `blog_id`, `title`, `user_id`, `username`) VALUES (8, 1, 32, '测试一下', 2, 'user');
INSERT INTO `operation` (`id`, `type`, `blog_id`, `title`, `user_id`, `username`) VALUES (9, 2, 31, '测试一下', 2, 'user');
INSERT INTO `operation` (`id`, `type`, `blog_id`, `title`, `user_id`, `username`) VALUES (10, 1, 31, '测试一下', 2, 'user');
INSERT INTO `operation` (`id`, `type`, `blog_id`, `title`, `user_id`, `username`) VALUES (11, 2, 33, '测试一下', 2, 'user');
COMMIT;

-- ----------------------------
-- Table structure for session
-- ----------------------------
DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user1_id` int DEFAULT NULL,
  `user2_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of session
-- ----------------------------
BEGIN;
INSERT INTO `session` (`id`, `user1_id`, `user2_id`) VALUES (1, 2, 1);
INSERT INTO `session` (`id`, `user1_id`, `user2_id`) VALUES (2, 13, 2);
COMMIT;

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of type
-- ----------------------------
BEGIN;
INSERT INTO `type` (`id`, `name`) VALUES (3, 'java');
INSERT INTO `type` (`id`, `name`) VALUES (4, 'jsp');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `realname` varchar(255) DEFAULT NULL,
  `user_pwd` varchar(255) NOT NULL,
  `avator` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `role` varchar(20) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `deleted` int DEFAULT '0',
  PRIMARY KEY (`user_id`,`email`,`user_name`) USING BTREE,
  KEY `user_name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`user_id`, `email`, `user_name`, `realname`, `user_pwd`, `avator`, `address`, `tel`, `role`, `create_time`, `update_time`, `deleted`) VALUES (1, 'admin@qq.com', 'admin', '艾德明', 'admin', 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', '上海2', '17856006425', '管理员', '2024-05-31 16:48:00', '2024-06-01 14:31:03', 0);
INSERT INTO `user` (`user_id`, `email`, `user_name`, `realname`, `user_pwd`, `avator`, `address`, `tel`, `role`, `create_time`, `update_time`, `deleted`) VALUES (2, 'user@qq.com', 'user', '王小明', 'user', 'http://localhost:8080/file/a88c3ea304a842e48558030e9155ea4e.jpeg', '北京', '1785600xxxx', '普通用户', '2024-05-31 16:48:00', '2025-04-26 16:15:15', 0);
INSERT INTO `user` (`user_id`, `email`, `user_name`, `realname`, `user_pwd`, `avator`, `address`, `tel`, `role`, `create_time`, `update_time`, `deleted`) VALUES (13, 'test', 'test', '测试用户', 'test', 'http://localhost:8080/file/dd691a09be4f45faadc20270db1fd3f8.png', '1', '1', '普通用户', '2024-06-01 14:30:16', '2024-06-01 14:30:16', 0);
COMMIT;

-- ----------------------------
-- Table structure for user_follow
-- ----------------------------
DROP TABLE IF EXISTS `user_follow`;
CREATE TABLE `user_follow` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `follow_user_id` int DEFAULT NULL,
  `follow_user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of user_follow
-- ----------------------------
BEGIN;
INSERT INTO `user_follow` (`id`, `user_id`, `follow_user_id`, `follow_user_name`, `create_time`) VALUES (9, 2, 2, 'user', '2025-04-27 12:27:11');
INSERT INTO `user_follow` (`id`, `user_id`, `follow_user_id`, `follow_user_name`, `create_time`) VALUES (10, 13, 2, 'user', '2025-04-28 13:07:34');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
