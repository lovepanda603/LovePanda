/*
SQLyog Trial v12.03 (64 bit)
MySQL - 5.5.28-log : Database - lovepandaj
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`lovepandaj` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `lovepandaj`;

/*Table structure for table `advice` */

DROP TABLE IF EXISTS `advice`;

CREATE TABLE `advice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `content` longtext COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isread` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `advice_userid_foregignkey` (`user_id`),
  CONSTRAINT `advice_userid_foregignkey` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `advice` */

/*Table structure for table `beauty` */

DROP TABLE IF EXISTS `beauty`;

CREATE TABLE `beauty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `img` text COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `view` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0',
  `keyword` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `beauty` */

/*Table structure for table `blog` */

DROP TABLE IF EXISTS `blog`;

CREATE TABLE `blog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8_unicode_ci NOT NULL,
  `content_show` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `keyword` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ispublic` int(11) NOT NULL,
  `deleted` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  `view` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `zhuanzai` int(11) NOT NULL DEFAULT '0',
  `zhuanzaiurl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `editortype` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0',
  `showside` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `blog_userid_foregignkey` (`user_id`),
  KEY `blog_category_foregignkey` (`category`),
  CONSTRAINT `blog_category_foregignkey` FOREIGN KEY (`category`) REFERENCES `blogcategory` (`id`),
  CONSTRAINT `blog_userid_foregignkey` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `blog` */

insert  into `blog`(`id`,`user_id`,`title`,`content`,`content_show`,`keyword`,`ispublic`,`deleted`,`category`,`view`,`type`,`image`,`create_time`,`zhuanzai`,`zhuanzaiurl`,`editortype`,`level`,`showside`) values (1,1,'欢迎使用lovepanda博客','欢迎大家使用lovepanda博客，如果您看的这篇博客的话说明您已经差不多部署成功了。','欢迎大家使用lovepanda博客，如果您看的这篇博客的话说明您已经差不多部署成功了。','lovepanda 博客',1,0,1,1,0,NULL,'2016-01-12 11:01:54',0,NULL,0,3,1);

/*Table structure for table `blogcategory` */

DROP TABLE IF EXISTS `blogcategory`;

CREATE TABLE `blogcategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `blogcategory` */

insert  into `blogcategory`(`id`,`category`) values (1,'Java综合'),(2,'JavaSE'),(3,'JavaEE'),(4,'JavaME'),(5,'Python'),(6,'C语言'),(7,'C++'),(8,'C#'),(9,'MySQL'),(10,'oracle'),(11,'MSSQL'),(12,'JavaScript'),(13,'jQuery'),(14,'EasyUI'),(15,'HTML'),(16,'HTML5'),(17,'CSS'),(18,'PHP'),(19,'Windows'),(20,'Linux'),(21,'Unix'),(22,'笔记'),(23,'随笔'),(24,'娱乐'),(25,'搞笑'),(26,'程序猿'),(27,'其他');

/*Table structure for table `gonggao` */

DROP TABLE IF EXISTS `gonggao`;

CREATE TABLE `gonggao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '0',
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` int(11) NOT NULL DEFAULT '0',
  `sn` int(11) NOT NULL DEFAULT '1',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `gonggao` */

/*Table structure for table `iplog` */

DROP TABLE IF EXISTS `iplog`;

CREATE TABLE `iplog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `params` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `iplog` */

/*Table structure for table `link` */

DROP TABLE IF EXISTS `link`;

CREATE TABLE `link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `sn` int(11) NOT NULL DEFAULT '1',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `link` */

insert  into `link`(`id`,`title`,`url`,`sn`,`create_time`) values (1,'LovePanda博客','http://www.liuyunfei.cn/',1,'2015-12-03 15:49:41'),(2,'JFinal社区','http://jfbbs.tomoya.cn/',2,'2015-12-03 15:50:10'),(3,'JFinal官网','http://www.jfinal.com/',3,'2015-12-03 15:50:54'),(4,'Amaze UI','http://amazeui.org/',4,'2015-12-03 15:51:23'),(5,'Layer','http://layer.layui.com/',5,'2015-12-03 15:51:50'),(6,'开源中国','http://www.oschina.net/',6,'2015-12-03 15:53:53'),(7,'GIT@OSC','http://git.oschina.net/',7,'2015-12-03 15:54:29');

/*Table structure for table `picrecommend` */

DROP TABLE IF EXISTS `picrecommend`;

CREATE TABLE `picrecommend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sn` int(11) DEFAULT NULL,
  `deleted` int(11) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `picrecommend` */

insert  into `picrecommend`(`id`,`title`,`image`,`url`,`sn`,`deleted`,`create_time`) values (1,'欢迎使用lovepanda博客','fa9981d036cf4dd0874513e9fa818f0c.jpg','http://localhost/LovePanda/blog/detail/1',1,0,'2016-01-12 11:05:16');

/*Table structure for table `qquser` */

DROP TABLE IF EXISTS `qquser`;

CREATE TABLE `qquser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `qquser_userid_foregignkey` (`user_id`),
  CONSTRAINT `qquser_userid_foregignkey` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `qquser` */

/*Table structure for table `resourceslog` */

DROP TABLE IF EXISTS `resourceslog`;

CREATE TABLE `resourceslog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `osname` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hostname` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cpunumber` bigint(20) DEFAULT NULL,
  `cpuratio` decimal(22,2) DEFAULT NULL,
  `phymemory` bigint(20) DEFAULT NULL,
  `phyfreememory` bigint(20) DEFAULT NULL,
  `diskmemory` bigint(20) DEFAULT NULL,
  `diskfreememory` bigint(20) DEFAULT NULL,
  `jvmtotalmemory` bigint(20) DEFAULT NULL,
  `jvmfreememory` bigint(20) DEFAULT NULL,
  `jvmmaxmemory` bigint(20) DEFAULT NULL,
  `gccount` bigint(20) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `resourceslog` */

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `role_permission` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `role` */

insert  into `role`(`id`,`role_name`,`role_permission`,`create_time`) values (1,'administrator','超级管理员','2015-07-18 18:14:24'),(2,'user','除管理员权限和其他具有特殊权限的模块外才能访问,即普通用户','2015-09-24 12:46:01');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `realname` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uuid` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `password` char(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `folk` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qq` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `job` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `login_time` datetime DEFAULT NULL,
  `deleted` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_username_uniquekey` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`realname`,`uuid`,`password`,`avatar`,`sex`,`folk`,`mail`,`mobile`,`qq`,`address`,`job`,`create_time`,`login_time`,`deleted`,`type`,`age`) values (1,'admin','超级管理员','db2ec2f146de4baba94142c3597da4d2','9a5d81293cb5b17fc5ed311f8d471aa8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2016-01-12 10:47:38','2016-01-12 11:09:21',0,0,NULL);

/*Table structure for table `userlogininfo` */

DROP TABLE IF EXISTS `userlogininfo`;

CREATE TABLE `userlogininfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `login_time` datetime DEFAULT NULL,
  `login_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userlogininfo_userid_foregignkey` (`user_id`),
  CONSTRAINT `userlogininfo_userid_foregignkey` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `userlogininfo` */

insert  into `userlogininfo`(`id`,`user_id`,`login_time`,`login_ip`) values (1,1,'2016-01-12 10:48:28','0:0:0:0:0:0:0:1'),(2,1,'2016-01-12 10:49:01','0:0:0:0:0:0:0:1'),(3,1,'2016-01-12 10:54:49','0:0:0:0:0:0:0:1'),(4,1,'2016-01-12 10:59:47','0:0:0:0:0:0:0:1'),(5,1,'2016-01-12 11:09:21','0:0:0:0:0:0:0:1');

/*Table structure for table `userrole` */

DROP TABLE IF EXISTS `userrole`;

CREATE TABLE `userrole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userrole_userid_foregignkey` (`user_id`),
  KEY `userrole_roleid` (`role_id`),
  CONSTRAINT `userrole_roleid` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `userrole_userid_foregignkey` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `userrole` */

insert  into `userrole`(`id`,`user_id`,`role_id`,`create_time`) values (1,1,1,'2016-01-12 10:48:11');

/*Table structure for table `video` */

DROP TABLE IF EXISTS `video`;

CREATE TABLE `video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pre` text COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `keyword` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT '0',
  `view` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `video` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
