-- MySQL dump 10.13  Distrib 5.7.44, for Linux (x86_64)
--
-- Host: localhost    Database: ry-wvp
-- ------------------------------------------------------
-- Server version	5.7.44-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_table` (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) COLLATE utf8_bin DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) COLLATE utf8_bin DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) COLLATE utf8_bin DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) COLLATE utf8_bin DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) COLLATE utf8_bin DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) COLLATE utf8_bin DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
INSERT INTO `gen_table` VALUES (1,'wvp_media_server','媒体服务器表','','','WvpMediaServer','tree','element-plus','com.ruoyi.wvp','wvp','wvpMediaServer','媒体服务器','fengcheng','0','/','{\"treeCode\":\"id\",\"treeName\":\"id\",\"treeParentCode\":\"id\",\"parentMenuId\":2000}','admin','2025-04-03 09:20:02','','2025-04-10 16:54:24',NULL),(2,'onvif_device','onvif 设备表',NULL,NULL,'OnvifDevice','crud','element-plus','com.ruoyi.onvif ','onvif ','device','onvif 设备','陈江灿','0','/','{\"parentMenuId\":2001}','admin','2025-04-10 08:59:38','','2025-04-10 09:00:51',NULL);
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_table_column` (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint(20) DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) COLLATE utf8_bin DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) COLLATE utf8_bin DEFAULT '' COMMENT '字典类型',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
INSERT INTO `gen_table_column` VALUES (1,1,'id','记录的唯一标识符','varchar(255)','String','id','1','0','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(2,1,'ip','服务器绑定的 IP 地址','varchar(50)','String','ip','0','0','1','1','1','1','1','EQ','input','',2,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(3,1,'hook_ip','接收回调通知的 IP 地址','varchar(50)','String','hookIp','0','0','1','1','1','1','1','EQ','input','',3,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(4,1,'sdp_ip','SDP 协议使用的 IP 地址','varchar(50)','String','sdpIp','0','0','0','1','1','1','1','EQ','input','',4,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(5,1,'stream_ip','流媒体传输的 IP 地址','varchar(50)','String','streamIp','0','0','0','1','1','1','1','EQ','input','',5,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(6,1,'http_port','HTTP 协议端口','int(11)','Long','httpPort','0','0','0','1','1','1','1','EQ','input','',6,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(7,1,'http_ssl_port','HTTPS 协议端口','int(11)','Long','httpSslPort','0','0','0','1','1','1','1','EQ','input','',7,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(8,1,'rtmp_port','RTMP 协议端口','int(11)','Long','rtmpPort','0','0','0','1','1','1','1','EQ','input','',8,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(9,1,'rtmp_ssl_port','加密 RTMP 协议端口','int(11)','Long','rtmpSslPort','0','0','0','1','1','1','1','EQ','input','',9,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(10,1,'rtp_proxy_port','RTP 代理端口','int(11)','Long','rtpProxyPort','0','0','0','1','1','1','1','EQ','input','',10,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(11,1,'rtsp_port','RTSP 协议端口','int(11)','Long','rtspPort','0','0','0','1','1','1','1','EQ','input','',11,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(12,1,'rtsp_ssl_port','加密 RTSP 协议端口','int(11)','Long','rtspSslPort','0','0','0','1','1','1','1','EQ','input','',12,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(13,1,'flv_port','FLV 协议端口','int(11)','Long','flvPort','0','0','0','1','1','1','1','EQ','input','',13,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(14,1,'flv_ssl_port','加密 FLV 协议端口','int(11)','Long','flvSslPort','0','0','0','1','1','1','1','EQ','input','',14,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(15,1,'ws_flv_port','WebSocket FLV 协议端口','int(11)','Long','wsFlvPort','0','0','0','1','1','1','1','EQ','input','',15,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(16,1,'ws_flv_ssl_port','加密 WebSocket FLV 协议端口','int(11)','Long','wsFlvSslPort','0','0','0','1','1','1','1','EQ','input','',16,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(17,1,'auto_config','是否启用自动配置','tinyint(1)','Integer','autoConfig','0','0','0','1','1','1','1','EQ','input','',17,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(18,1,'secret','密钥，用于鉴权或加密','varchar(50)','String','secret','0','0','0','1','1','1','1','EQ','input','',18,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(19,1,'type','流媒体配置类型','varchar(50)','String','type','0','0','0','1','1','1','1','EQ','select','',19,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(20,1,'rtp_enable','是否启用 RTP 协议','tinyint(1)','Integer','rtpEnable','0','0','0','1','1','1','1','EQ','input','',20,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(21,1,'rtp_port_range','RTP 端口范围','varchar(50)','String','rtpPortRange','0','0','0','1','1','1','1','EQ','input','',21,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(22,1,'send_rtp_port_range','发送 RTP 数据的端口范围','varchar(50)','String','sendRtpPortRange','0','0','0','1','1','1','1','EQ','input','',22,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(23,1,'record_assist_port','录制辅助端口','int(11)','Long','recordAssistPort','0','0','0','1','1','1','1','EQ','input','',23,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(24,1,'default_server','是否为默认服务器','tinyint(1)','Integer','defaultServer','0','0','0','1','1','1','1','EQ','input','',24,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(25,1,'create_time','记录创建时间','varchar(50)','Date','createTime','0','0','0','1',NULL,NULL,NULL,'BETWEEN','datetime','',25,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(26,1,'update_time','记录最后更新时间','varchar(50)','Date','updateTime','0','0','0','1','1',NULL,NULL,'BETWEEN','datetime','',26,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(27,1,'hook_alive_interval','回调存活检查间隔','int(11)','Long','hookAliveInterval','0','0','0','1','1','1','1','EQ','input','',27,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(28,1,'record_path','录像文件存储路径','varchar(255)','String','recordPath','0','0','0','1','1','1','1','EQ','input','',28,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(29,1,'record_day','录像保存天数','int(11)','Long','recordDay','0','0','0','1','1','1','1','EQ','input','',29,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(30,1,'transcode_suffix','转码文件的后缀名','varchar(255)','String','transcodeSuffix','0','0','0','1','1','1','1','EQ','input','',30,'admin','2025-04-03 09:20:02','','2025-04-10 16:54:24'),(31,2,'id','id','bigint(20)','Long','id','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-04-10 08:59:38','','2025-04-10 10:29:30'),(32,2,'ip','ip','varchar(50)','String','ip','0','0','0','1','1','1','1','EQ','input','',2,'admin','2025-04-10 08:59:38','','2025-04-10 10:29:30'),(33,2,'url','默认直播流播放地址','varchar(255)','String','url','0','0','0','1','1','1','1','EQ','input','',6,'admin','2025-04-10 08:59:38','','2025-04-10 10:29:30'),(34,2,'firm','设备厂商','varchar(30)','String','firm','0','0','0','1','1','1','1','EQ','input','',7,'admin','2025-04-10 08:59:38','','2025-04-10 10:29:30'),(35,2,'model','设备型号','varchar(20)','String','model','0','0','0','1','1','1','1','EQ','input','',8,'admin','2025-04-10 08:59:38','','2025-04-10 10:29:30'),(36,2,'firmware_version','固件版本','varchar(100)','String','firmwareVersion','0','0','0','1','1','1','1','EQ','input','',9,'admin','2025-04-10 08:59:38','','2025-04-10 10:29:30'),(37,2,'stream_uris','球机多条播放','json','String','streamUris','0','0','0','1','1','1','1','EQ','select','',10,'admin','2025-04-10 08:59:38','','2025-04-10 10:29:30'),(38,2,'create_by','创建者','varchar(64)','String','createBy','0','0','0','1',NULL,NULL,NULL,'EQ','input','',11,'admin','2025-04-10 08:59:38','','2025-04-10 10:29:30'),(39,2,'create_time','创建时间','datetime','Date','createTime','0','0','0','1',NULL,NULL,NULL,'EQ','datetime','',12,'admin','2025-04-10 08:59:38','','2025-04-10 10:29:30'),(40,2,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','1','1',NULL,NULL,'EQ','input','',13,'admin','2025-04-10 08:59:38','','2025-04-10 10:29:30'),(41,2,'update_time','更新时间','datetime','Date','updateTime','0','0','0','1','1',NULL,NULL,'EQ','datetime','',14,'admin','2025-04-10 08:59:38','','2025-04-10 10:29:30'),(42,2,'remark','备注','varchar(500)','String','remark','0','0','0','1','1','1',NULL,'EQ','textarea','',15,'admin','2025-04-10 08:59:38','','2025-04-10 10:29:30'),(43,2,'user_name','用户名','varchar(20)','String','userName','0','0','0','1','1','1','1','LIKE','input','',4,'','2025-04-10 09:18:46','','2025-04-10 10:29:30'),(44,2,'password','密码','varchar(50)','String','password','0','0','0','1','1','1','1','EQ','input','',5,'','2025-04-10 09:18:46','','2025-04-10 10:29:30'),(45,2,'name','摄像头名称','varchar(30)','String','name','0','0','0','1','1','1','1','LIKE','input','',3,'','2025-04-10 10:29:30','',NULL);
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `onvif_device`
--

DROP TABLE IF EXISTS `onvif_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `onvif_device` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ip` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'ip',
  `name` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '摄像头名称',
  `user_name` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '密码',
  `url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '默认直播流播放地址',
  `firm` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '设备厂商',
  `model` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '设备型号',
  `firmware_version` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '固件版本',
  `stream_uris` json DEFAULT NULL COMMENT '球机多条播放',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='onvif 设备表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `onvif_device`
--

LOCK TABLES `onvif_device` WRITE;
/*!40000 ALTER TABLE `onvif_device` DISABLE KEYS */;
INSERT INTO `onvif_device` VALUES (2,'192.168.158.63','大华球机','admin','admin123','rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif','Dahua','DH-IPC-HDP2230C-ST','2.820.0000000.65.R, Build Date 2025-01-21','{\"MediaProfile_Channel1_MainStream\": \"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\", \"MediaProfile_Channel1_SubStream1\": \"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\"}','','2025-04-10 09:47:55','','2025-04-12 14:59:36',NULL),(5,'192.168.158.189','haikang球机','admin','hx147258','rtsp://192.168.212.189:554/Streaming/Channels/102?transportmode=unicast&profile=Profile_102','HIKVISION','DS-2DE3Q144MY-T/GLSE','V5.8.3','{\"Stream_101\": \"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\", \"Stream_102\": \"rtsp://192.168.212.189:554/Streaming/Channels/102?transportmode=unicast&profile=Profile_102\", \"Stream_201\": \"rtsp://192.168.212.189:554/Streaming/Channels/201?transportmode=unicast&profile=Profile_201\", \"Stream_202\": \"rtsp://192.168.212.189:554/Streaming/Channels/202?transportmode=unicast&profile=Profile_202\"}','','2025-04-10 17:19:10','','2025-04-17 14:37:08',NULL),(6,'192.168.158.62','办公室大华','admin','admin123','rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif','Dahua','DH-IPC-HDP2230C-ST','2.820.0000000.65.R, Build Date 2025-01-21','{\"MediaProfile_Channel1_MainStream\": \"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\", \"MediaProfile_Channel1_SubStream1\": \"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\"}','','2025-04-11 09:31:50','','2025-04-14 11:41:52',NULL),(7,'192.168.158.200','球机','admin','admin','rtsp://192.168.158.200/media/video2','UNIVIEW','IPC-S360','IPC_Q1201-B5022P30D1711C31','{\"media_profile1\": \"rtsp://192.168.158.200/media/video1\", \"media_profile2\": \"rtsp://192.168.158.200/media/video2\", \"media_profile3\": \"rtsp://192.168.158.200/media/video3\"}','','2025-04-17 14:25:41','',NULL,NULL);
/*!40000 ALTER TABLE `onvif_device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_blob_triggers`
--

DROP TABLE IF EXISTS `qrtz_blob_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='Blob类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_blob_triggers`
--

LOCK TABLES `qrtz_blob_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_calendars`
--

DROP TABLE IF EXISTS `qrtz_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='日历信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_calendars`
--

LOCK TABLES `qrtz_calendars` WRITE;
/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_cron_triggers`
--

DROP TABLE IF EXISTS `qrtz_cron_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) COLLATE utf8_bin NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='Cron类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_cron_triggers`
--

LOCK TABLES `qrtz_cron_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_fired_triggers`
--

DROP TABLE IF EXISTS `qrtz_fired_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) COLLATE utf8_bin NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) COLLATE utf8_bin NOT NULL COMMENT '状态',
  `job_name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`,`entry_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='已触发的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_fired_triggers`
--

LOCK TABLES `qrtz_fired_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_job_details`
--

DROP TABLE IF EXISTS `qrtz_job_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '任务组名',
  `description` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) COLLATE utf8_bin NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) COLLATE utf8_bin NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) COLLATE utf8_bin NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) COLLATE utf8_bin NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) COLLATE utf8_bin NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='任务详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_job_details`
--

LOCK TABLES `qrtz_job_details` WRITE;
/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_locks`
--

DROP TABLE IF EXISTS `qrtz_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) COLLATE utf8_bin NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='存储的悲观锁信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_locks`
--

LOCK TABLES `qrtz_locks` WRITE;
/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_paused_trigger_grps`
--

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='暂停的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_paused_trigger_grps`
--

LOCK TABLES `qrtz_paused_trigger_grps` WRITE;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_scheduler_state`
--

DROP TABLE IF EXISTS `qrtz_scheduler_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='调度器状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_scheduler_state`
--

LOCK TABLES `qrtz_scheduler_state` WRITE;
/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simple_triggers`
--

DROP TABLE IF EXISTS `qrtz_simple_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='简单触发器的信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simple_triggers`
--

LOCK TABLES `qrtz_simple_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simprop_triggers`
--

DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='同步机制的行锁表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simprop_triggers`
--

LOCK TABLES `qrtz_simprop_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_triggers`
--

DROP TABLE IF EXISTS `qrtz_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) COLLATE utf8_bin NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) COLLATE utf8_bin NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) COLLATE utf8_bin NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) COLLATE utf8_bin NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='触发器详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_triggers`
--

LOCK TABLES `qrtz_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_config` (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) COLLATE utf8_bin DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) COLLATE utf8_bin DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) COLLATE utf8_bin DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) COLLATE utf8_bin DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2025-04-03 09:03:39','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2025-04-03 09:03:39','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2025-04-03 09:03:39','',NULL,'深色主题theme-dark，浅色主题theme-light'),(4,'账号自助-验证码开关','sys.account.captchaEnabled','true','Y','admin','2025-04-03 09:03:39','admin','2025-04-17 09:24:24','是否开启验证码功能（true开启，false关闭）'),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y','admin','2025-04-03 09:03:39','',NULL,'是否开启注册用户功能（true开启，false关闭）'),(6,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2025-04-03 09:03:39','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) COLLATE utf8_bin DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) COLLATE utf8_bin DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) COLLATE utf8_bin DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `status` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','ry-wvp',0,'ry-wvp','15888888888','ry-wvp@qq.com','0','0','admin','2025-04-03 09:03:39','admin','2025-04-18 10:55:40'),(101,100,'0,100','广州总公司',1,'ry-wvp','15888888888','ry-wvp@qq.com','0','0','admin','2025-04-03 09:03:39','admin','2025-04-18 10:56:23'),(102,100,'0,100','长沙分公司',2,'若依','15888888888','ry@qq.com','0','2','admin','2025-04-03 09:03:39','',NULL),(103,101,'0,100,101','研发部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2025-04-03 09:03:39','',NULL),(104,101,'0,100,101','市场部门',2,'若依','15888888888','ry@qq.com','0','2','admin','2025-04-03 09:03:39','',NULL),(105,101,'0,100,101','测试部门',3,'若依','15888888888','ry@qq.com','0','0','admin','2025-04-03 09:03:39','',NULL),(106,101,'0,100,101','财务部门',4,'若依','15888888888','ry@qq.com','0','2','admin','2025-04-03 09:03:39','',NULL),(107,101,'0,100,101','运维部门',5,'若依','15888888888','ry@qq.com','0','2','admin','2025-04-03 09:03:39','',NULL),(108,102,'0,100,102','市场部门',1,'若依','15888888888','ry@qq.com','0','2','admin','2025-04-03 09:03:39','',NULL),(109,102,'0,100,102','财务部门',2,'若依','15888888888','ry@qq.com','0','2','admin','2025-04-03 09:03:39','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) COLLATE utf8_bin DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) COLLATE utf8_bin DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) COLLATE utf8_bin DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) COLLATE utf8_bin DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2025-04-03 09:03:39','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2025-04-03 09:03:39','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2025-04-03 09:03:39','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2025-04-03 09:03:39','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2025-04-03 09:03:39','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2025-04-03 09:03:39','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2025-04-03 09:03:39','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2025-04-03 09:03:39','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2025-04-03 09:03:39','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2025-04-03 09:03:39','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2025-04-03 09:03:39','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2025-04-03 09:03:39','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2025-04-03 09:03:39','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2025-04-03 09:03:39','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2025-04-03 09:03:39','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2025-04-03 09:03:39','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2025-04-03 09:03:39','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2025-04-03 09:03:39','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2025-04-03 09:03:39','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2025-04-03 09:03:39','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2025-04-03 09:03:39','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2025-04-03 09:03:39','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2025-04-03 09:03:39','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2025-04-03 09:03:39','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2025-04-03 09:03:39','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2025-04-03 09:03:39','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2025-04-03 09:03:39','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2025-04-03 09:03:39','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2025-04-03 09:03:39','',NULL,'停用状态');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) COLLATE utf8_bin DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) COLLATE utf8_bin DEFAULT '' COMMENT '字典类型',
  `status` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE KEY `dict_type` (`dict_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2025-04-03 09:03:39','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2025-04-03 09:03:39','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2025-04-03 09:03:39','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2025-04-03 09:03:39','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2025-04-03 09:03:39','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2025-04-03 09:03:39','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2025-04-03 09:03:39','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2025-04-03 09:03:39','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2025-04-03 09:03:39','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2025-04-03 09:03:39','',NULL,'登录状态列表');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) COLLATE utf8_bin NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) COLLATE utf8_bin DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8_bin DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='定时任务调度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES (1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2025-04-03 09:03:39','',NULL,''),(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2025-04-03 09:03:39','',NULL,''),(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2025-04-03 09:03:39','',NULL,'');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) COLLATE utf8_bin NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '日志信息',
  `status` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) COLLATE utf8_bin DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='定时任务调度日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job_log`
--

LOCK TABLES `sys_job_log` WRITE;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) COLLATE utf8_bin DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) COLLATE utf8_bin DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) COLLATE utf8_bin DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) COLLATE utf8_bin DEFAULT '' COMMENT '操作系统',
  `status` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  KEY `idx_sys_logininfor_s` (`status`) USING BTREE,
  KEY `idx_sys_logininfor_lt` (`login_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=275 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (100,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-03 09:06:14'),(101,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-03 09:06:20'),(102,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-03 09:06:23'),(103,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-07 15:12:26'),(104,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-07 15:12:40'),(105,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-07 15:14:33'),(106,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-07 15:15:46'),(107,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-07 15:16:58'),(108,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-07 15:18:09'),(109,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-07 15:19:10'),(110,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-07 15:19:42'),(111,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-07 15:46:23'),(112,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-07 15:47:23'),(113,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-07 15:47:23'),(114,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-07 15:48:36'),(115,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-07 15:48:36'),(116,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-07 15:59:27'),(117,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-04-09 14:28:26'),(118,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','退出成功','2025-04-09 14:28:44'),(119,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-04-09 14:28:46'),(120,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-09 14:39:49'),(121,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-09 14:53:33'),(122,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-09 15:57:20'),(123,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-04-09 16:48:00'),(124,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-10 08:53:43'),(125,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-04-10 08:56:26'),(126,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-10 11:00:00'),(127,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-04-10 11:25:15'),(128,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-10 12:01:42'),(129,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-10 13:57:12'),(130,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-04-10 14:12:43'),(131,'admin','127.0.0.1','内网IP','Chrome 9','Windows 10','0','登录成功','2025-04-10 14:29:43'),(132,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-10 14:31:16'),(133,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-04-10 15:12:49'),(134,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-04-10 15:17:32'),(135,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-10 16:20:05'),(136,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-10 17:46:32'),(137,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-04-10 17:50:01'),(138,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-10 18:06:27'),(139,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-11 08:53:39'),(140,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-11 08:56:52'),(141,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-11 10:35:07'),(142,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-04-11 10:49:21'),(143,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-11 11:32:21'),(144,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-11 13:52:29'),(145,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-11 13:55:31'),(146,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-11 15:07:58'),(147,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-11 15:31:31'),(148,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-11 17:19:27'),(149,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-12 08:51:13'),(150,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-12 08:52:04'),(151,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-12 11:54:47'),(152,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-12 14:02:38'),(153,'admin','127.0.0.1','内网IP','Chrome 9','Windows 10','0','登录成功','2025-04-12 14:02:51'),(154,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-12 15:30:22'),(155,'admin','127.0.0.1','内网IP','Chrome 9','Windows 10','0','登录成功','2025-04-12 16:23:05'),(156,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-12 16:24:44'),(157,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-12 16:58:12'),(158,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-12 17:02:54'),(159,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-04-12 17:21:01'),(160,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-14 08:54:57'),(161,'admin','127.0.0.1','内网IP','Chrome 9','Windows 10','0','登录成功','2025-04-14 10:56:53'),(162,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-14 11:08:51'),(163,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-14 11:41:41'),(164,'admin','127.0.0.1','内网IP','Chrome 9','Windows 10','0','登录成功','2025-04-14 11:45:58'),(165,'admin','127.0.0.1','内网IP','Chrome 9','Windows 10','0','登录成功','2025-04-14 14:51:08'),(166,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-14 15:02:29'),(167,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-14 15:23:41'),(168,'admin','127.0.0.1','内网IP','Chrome 9','Windows 10','0','登录成功','2025-04-14 16:17:02'),(169,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-14 16:37:52'),(170,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-14 17:50:40'),(171,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-15 08:58:52'),(172,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-15 09:28:56'),(173,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-16 08:51:38'),(174,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-16 08:53:48'),(175,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-16 14:01:26'),(176,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-16 14:03:46'),(177,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-16 17:39:24'),(178,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-16 17:48:30'),(179,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-17 09:01:53'),(180,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-17 09:15:38'),(181,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-17 09:24:00'),(182,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-17 09:24:08'),(183,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-17 09:24:29'),(184,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码已失效','2025-04-17 09:42:41'),(185,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-17 09:42:45'),(186,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-17 10:04:37'),(187,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-17 10:05:36'),(188,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-17 10:45:40'),(189,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-17 11:22:05'),(190,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-17 14:03:07'),(191,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-17 14:05:17'),(192,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-17 14:51:51'),(193,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-17 16:09:15'),(194,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-18 08:53:01'),(195,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-18 08:59:54'),(196,'admin','127.0.0.1','内网IP','Chrome 9','Windows 10','0','登录成功','2025-04-18 09:27:42'),(197,'admin','127.0.0.1','内网IP','Chrome 9','Windows 10','0','退出成功','2025-04-18 09:27:50'),(198,'ry','127.0.0.1','内网IP','Chrome 9','Windows 10','0','登录成功','2025-04-18 09:27:58'),(199,'ry','127.0.0.1','内网IP','Chrome 9','Windows 10','0','退出成功','2025-04-18 09:28:44'),(200,'ry','127.0.0.1','内网IP','Chrome 9','Windows 10','0','登录成功','2025-04-18 09:29:01'),(201,'ry','127.0.0.1','内网IP','Chrome 9','Windows 10','0','登录成功','2025-04-18 10:28:23'),(202,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码已失效','2025-04-18 10:29:13'),(203,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-18 10:29:16'),(204,'ry','127.0.0.1','内网IP','Chrome 9','Windows 10','0','退出成功','2025-04-18 10:30:20'),(205,'ry','127.0.0.1','内网IP','Chrome 9','Windows 10','1','验证码错误','2025-04-18 10:30:24'),(206,'ry','127.0.0.1','内网IP','Chrome 9','Windows 10','0','登录成功','2025-04-18 10:30:27'),(207,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-18 10:33:47'),(208,'ry','127.0.0.1','内网IP','Chrome 9','Windows 10','0','退出成功','2025-04-18 10:47:06'),(209,'ry','127.0.0.1','内网IP','Chrome 9','Windows 10','0','登录成功','2025-04-18 10:47:10'),(210,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码错误','2025-04-18 10:54:46'),(211,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-18 10:54:50'),(212,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-18 10:57:14'),(213,'ry-wvp','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-18 10:57:21'),(214,'ry-wvp','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-18 11:07:32'),(215,'ry-wvp','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-18 11:08:17'),(216,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-18 11:08:35'),(217,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2025-04-18 11:20:15'),(218,'ry-wvp','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-18 11:20:20'),(219,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-04-18 11:21:05'),(220,'ry','127.0.0.1','内网IP','Chrome 9','Windows 10','0','退出成功','2025-04-18 11:52:27'),(221,'ry','127.0.0.1','内网IP','Chrome 9','Windows 10','1','验证码错误','2025-04-18 11:52:33'),(222,'ry','127.0.0.1','内网IP','Chrome 9','Windows 10','0','登录成功','2025-04-18 11:52:37'),(223,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','登录成功','2025-04-18 11:57:28'),(224,'admin','127.0.0.1','内网IP','Chrome 11','Windows 10','0','退出成功','2025-04-18 12:01:06'),(225,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2025-04-18 14:04:05'),(226,'admin','14.19.37.18','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 07:22:07'),(227,'admin','14.19.37.18','XX XX','Chrome 12','Windows 10','0','登录成功','2025-04-18 07:25:17'),(228,'admin','14.19.37.18','XX XX','Chrome 13','Windows 10','0','退出成功','2025-04-18 07:25:46'),(229,'admin','14.19.37.18','XX XX','Chrome 13','Windows 10','1','验证码错误','2025-04-18 07:25:52'),(230,'ry','14.19.37.18','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 07:26:40'),(231,'ry','14.19.37.18','XX XX','Chrome 13','Windows 10','0','退出成功','2025-04-18 07:27:12'),(232,'admin','14.19.37.18','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 07:27:22'),(233,'admin','14.19.37.18','XX XX','Chrome 13','Windows 10','0','退出成功','2025-04-18 07:27:41'),(234,'admin','14.19.37.18','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 07:27:48'),(235,'admin','14.19.37.18','XX XX','Chrome 13','Windows 10','0','退出成功','2025-04-18 07:30:37'),(236,'admin','14.19.37.18','XX XX','Chrome 13','Windows 10','1','验证码已失效','2025-04-18 07:36:36'),(237,'admin','14.19.37.18','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 07:36:39'),(238,'admin','14.19.37.18','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 09:40:42'),(239,'ry','14.19.51.244','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 10:24:46'),(240,'ry','14.19.51.244','XX XX','Chrome 13','Windows 10','0','退出成功','2025-04-18 10:26:23'),(241,'admin','14.19.51.244','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 10:26:33'),(242,'admin','14.19.51.244','XX XX','Chrome 13','Windows 10','0','退出成功','2025-04-18 10:28:08'),(243,'ry','14.19.51.244','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 10:28:23'),(244,'ry','14.19.51.244','XX XX','Chrome 13','Linux','0','登录成功','2025-04-18 10:32:56'),(245,'ry','113.65.230.228','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 10:45:38'),(246,'ry','113.65.230.228','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 10:54:02'),(247,'ry','111.181.49.207','XX XX','Chrome 11','Unknown mobile','0','登录成功','2025-04-18 11:12:45'),(248,'ry','14.19.199.129','XX XX','Chrome Mobile','Android 1.x','0','登录成功','2025-04-18 11:18:14'),(249,'ry','14.19.51.244','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 11:19:35'),(250,'ry','14.19.51.244','XX XX','Chrome 13','Windows 10','0','退出成功','2025-04-18 11:20:37'),(251,'ry','14.151.64.143','XX XX','Chrome 13','Windows 10','1','验证码错误','2025-04-18 11:20:40'),(252,'ry','14.151.64.143','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 11:20:45'),(253,'admin','14.19.51.244','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 11:20:46'),(254,'ry','106.224.83.208','XX XX','Chrome Mobile','Android 1.x','0','登录成功','2025-04-18 12:57:28'),(255,'ry','116.78.104.206','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 12:59:21'),(256,'ry','110.53.200.38','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 13:45:49'),(257,'ry','110.53.200.38','XX XX','Chrome 13','Windows 10','0','退出成功','2025-04-18 13:46:15'),(258,'ryadmin','121.226.169.51','XX XX','Chrome Mobile','Android 1.x','1','用户不存在/密码错误','2025-04-18 13:47:35'),(259,'ry','218.12.16.102','XX XX','Chrome Mobile','Android 1.x','0','登录成功','2025-04-18 13:48:15'),(260,'ry','89.185.24.37','XX XX','Apple WebKit','Mac OS X (iPhone)','0','登录成功','2025-04-18 13:48:49'),(261,'ry','171.213.183.170','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-18 13:52:31'),(262,'ry','113.128.48.68','XX XX','Chrome Mobile','Android 1.x','0','登录成功','2025-04-18 13:57:01'),(263,'ry','203.160.68.129','XX XX','Apple WebKit','Mac OS X (iPhone)','0','登录成功','2025-04-18 14:31:53'),(264,'ry','118.250.120.41','XX XX','Chrome 12','Windows 10','0','登录成功','2025-04-18 16:00:34'),(265,'ry','219.137.198.7','XX XX','Chrome Mobile','Android 1.x','0','登录成功','2025-04-18 17:30:28'),(266,'ry','112.119.92.237','XX XX','Chrome 13','Mac OS X','0','登录成功','2025-04-19 00:35:28'),(267,'ry','106.114.72.84','XX XX','Chrome 11','Windows 10','0','登录成功','2025-04-19 00:37:38'),(268,'ry','180.124.148.29','XX XX','Chrome 9','Mac OS X','0','登录成功','2025-04-19 00:52:05'),(269,'ry','14.19.63.87','XX XX','Chrome 12','Windows 10','1','验证码已失效','2025-04-19 00:56:03'),(270,'ry','14.19.63.87','XX XX','Chrome 12','Windows 10','0','登录成功','2025-04-19 00:56:07'),(271,'admin','14.19.63.87','XX XX','Chrome 13','Windows 10','1','验证码错误','2025-04-19 01:01:59'),(272,'admin','14.19.63.87','XX XX','Chrome 13','Windows 10','1','验证码错误','2025-04-19 01:02:04'),(273,'admin','14.19.63.87','XX XX','Chrome 13','Windows 10','0','登录成功','2025-04-19 01:02:08'),(274,'admin','14.19.63.87','XX XX','Chrome 13','Windows 10','0','退出成功','2025-04-19 01:02:29');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) COLLATE utf8_bin DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) COLLATE utf8_bin DEFAULT '' COMMENT '路由名称',
  `is_frame` int(1) DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) COLLATE utf8_bin DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) COLLATE utf8_bin DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8_bin DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2080 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,17,'system',NULL,'','',1,0,'M','0','0','','system','admin','2025-04-03 09:03:39','admin','2025-04-03 09:07:49','系统管理目录'),(2,'系统监控',0,18,'monitor',NULL,'','',1,0,'M','0','0','','monitor','admin','2025-04-03 09:03:39','admin','2025-04-03 09:07:45','系统监控目录'),(3,'系统工具',0,19,'tool',NULL,'','',1,0,'M','0','0','','tool','admin','2025-04-03 09:03:39','admin','2025-04-03 09:07:41','系统工具目录'),(100,'用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2025-04-03 09:03:39','',NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2025-04-03 09:03:39','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2025-04-03 09:03:39','',NULL,'菜单管理菜单'),(103,'部门管理',1,4,'dept','system/dept/index','','',1,0,'C','0','0','system:dept:list','tree','admin','2025-04-03 09:03:39','',NULL,'部门管理菜单'),(104,'岗位管理',1,5,'post','system/post/index','','',1,0,'C','0','0','system:post:list','post','admin','2025-04-03 09:03:39','',NULL,'岗位管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','','',1,0,'C','0','0','system:dict:list','dict','admin','2025-04-03 09:03:39','',NULL,'字典管理菜单'),(106,'参数设置',1,7,'config','system/config/index','','',1,0,'C','0','0','system:config:list','edit','admin','2025-04-03 09:03:39','',NULL,'参数设置菜单'),(107,'通知公告',1,8,'notice','system/notice/index','','',1,0,'C','0','0','system:notice:list','message','admin','2025-04-03 09:03:39','',NULL,'通知公告菜单'),(108,'日志管理',1,9,'log','','','',1,0,'M','0','0','','log','admin','2025-04-03 09:03:39','',NULL,'日志管理菜单'),(109,'在线用户',2,1,'online','monitor/online/index','','',1,0,'C','0','0','monitor:online:list','online','admin','2025-04-03 09:03:39','',NULL,'在线用户菜单'),(110,'定时任务',2,2,'job','monitor/job/index','','',1,0,'C','0','0','monitor:job:list','job','admin','2025-04-03 09:03:39','',NULL,'定时任务菜单'),(111,'数据监控',2,3,'druid','monitor/druid/index','','',1,0,'C','0','0','monitor:druid:list','druid','admin','2025-04-03 09:03:39','',NULL,'数据监控菜单'),(112,'服务监控',2,4,'server','monitor/server/index','','',1,0,'C','0','0','monitor:server:list','server','admin','2025-04-03 09:03:39','',NULL,'服务监控菜单'),(113,'缓存监控',2,5,'cache','monitor/cache/index','','',1,0,'C','0','0','monitor:cache:list','redis','admin','2025-04-03 09:03:39','',NULL,'缓存监控菜单'),(114,'缓存列表',2,6,'cacheList','monitor/cache/list','','',1,0,'C','0','0','monitor:cache:list','redis-list','admin','2025-04-03 09:03:39','',NULL,'缓存列表菜单'),(115,'表单构建',3,1,'build','tool/build/index','','',1,0,'C','0','0','tool:build:list','build','admin','2025-04-03 09:03:39','',NULL,'表单构建菜单'),(116,'代码生成',3,2,'gen','tool/gen/index','','',1,0,'C','0','0','tool:gen:list','code','admin','2025-04-03 09:03:39','',NULL,'代码生成菜单'),(117,'系统接口',3,3,'swagger','tool/swagger/index','','',1,0,'C','0','0','tool:swagger:list','swagger','admin','2025-04-03 09:03:39','',NULL,'系统接口菜单'),(500,'操作日志',108,1,'operlog','monitor/operlog/index','','',1,0,'C','0','0','monitor:operlog:list','form','admin','2025-04-03 09:03:39','',NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2025-04-03 09:03:39','',NULL,'登录日志菜单'),(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2025-04-03 09:03:39','',NULL,''),(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2025-04-03 09:03:39','',NULL,''),(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2025-04-03 09:03:39','',NULL,''),(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2025-04-03 09:03:39','',NULL,''),(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2025-04-03 09:03:39','',NULL,''),(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2025-04-03 09:03:39','',NULL,''),(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2025-04-03 09:03:39','',NULL,''),(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2025-04-03 09:03:39','',NULL,''),(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2025-04-03 09:03:39','',NULL,''),(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2025-04-03 09:03:39','',NULL,''),(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2025-04-03 09:03:39','',NULL,''),(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2025-04-03 09:03:39','',NULL,''),(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2025-04-03 09:03:39','',NULL,''),(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2025-04-03 09:03:39','',NULL,''),(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2025-04-03 09:03:39','',NULL,''),(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2025-04-03 09:03:39','',NULL,''),(1016,'部门查询',103,1,'','','','',1,0,'F','0','0','system:dept:query','#','admin','2025-04-03 09:03:39','',NULL,''),(1017,'部门新增',103,2,'','','','',1,0,'F','0','0','system:dept:add','#','admin','2025-04-03 09:03:39','',NULL,''),(1018,'部门修改',103,3,'','','','',1,0,'F','0','0','system:dept:edit','#','admin','2025-04-03 09:03:39','',NULL,''),(1019,'部门删除',103,4,'','','','',1,0,'F','0','0','system:dept:remove','#','admin','2025-04-03 09:03:39','',NULL,''),(1020,'岗位查询',104,1,'','','','',1,0,'F','0','0','system:post:query','#','admin','2025-04-03 09:03:39','',NULL,''),(1021,'岗位新增',104,2,'','','','',1,0,'F','0','0','system:post:add','#','admin','2025-04-03 09:03:39','',NULL,''),(1022,'岗位修改',104,3,'','','','',1,0,'F','0','0','system:post:edit','#','admin','2025-04-03 09:03:39','',NULL,''),(1023,'岗位删除',104,4,'','','','',1,0,'F','0','0','system:post:remove','#','admin','2025-04-03 09:03:39','',NULL,''),(1024,'岗位导出',104,5,'','','','',1,0,'F','0','0','system:post:export','#','admin','2025-04-03 09:03:39','',NULL,''),(1025,'字典查询',105,1,'#','','','',1,0,'F','0','0','system:dict:query','#','admin','2025-04-03 09:03:39','',NULL,''),(1026,'字典新增',105,2,'#','','','',1,0,'F','0','0','system:dict:add','#','admin','2025-04-03 09:03:39','',NULL,''),(1027,'字典修改',105,3,'#','','','',1,0,'F','0','0','system:dict:edit','#','admin','2025-04-03 09:03:39','',NULL,''),(1028,'字典删除',105,4,'#','','','',1,0,'F','0','0','system:dict:remove','#','admin','2025-04-03 09:03:39','',NULL,''),(1029,'字典导出',105,5,'#','','','',1,0,'F','0','0','system:dict:export','#','admin','2025-04-03 09:03:39','',NULL,''),(1030,'参数查询',106,1,'#','','','',1,0,'F','0','0','system:config:query','#','admin','2025-04-03 09:03:39','',NULL,''),(1031,'参数新增',106,2,'#','','','',1,0,'F','0','0','system:config:add','#','admin','2025-04-03 09:03:39','',NULL,''),(1032,'参数修改',106,3,'#','','','',1,0,'F','0','0','system:config:edit','#','admin','2025-04-03 09:03:39','',NULL,''),(1033,'参数删除',106,4,'#','','','',1,0,'F','0','0','system:config:remove','#','admin','2025-04-03 09:03:39','',NULL,''),(1034,'参数导出',106,5,'#','','','',1,0,'F','0','0','system:config:export','#','admin','2025-04-03 09:03:39','',NULL,''),(1035,'公告查询',107,1,'#','','','',1,0,'F','0','0','system:notice:query','#','admin','2025-04-03 09:03:39','',NULL,''),(1036,'公告新增',107,2,'#','','','',1,0,'F','0','0','system:notice:add','#','admin','2025-04-03 09:03:39','',NULL,''),(1037,'公告修改',107,3,'#','','','',1,0,'F','0','0','system:notice:edit','#','admin','2025-04-03 09:03:39','',NULL,''),(1038,'公告删除',107,4,'#','','','',1,0,'F','0','0','system:notice:remove','#','admin','2025-04-03 09:03:39','',NULL,''),(1039,'操作查询',500,1,'#','','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2025-04-03 09:03:39','',NULL,''),(1040,'操作删除',500,2,'#','','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2025-04-03 09:03:39','',NULL,''),(1041,'日志导出',500,3,'#','','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2025-04-03 09:03:39','',NULL,''),(1042,'登录查询',501,1,'#','','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2025-04-03 09:03:39','',NULL,''),(1043,'登录删除',501,2,'#','','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2025-04-03 09:03:39','',NULL,''),(1044,'日志导出',501,3,'#','','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2025-04-03 09:03:39','',NULL,''),(1045,'账户解锁',501,4,'#','','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2025-04-03 09:03:39','',NULL,''),(1046,'在线查询',109,1,'#','','','',1,0,'F','0','0','monitor:online:query','#','admin','2025-04-03 09:03:39','',NULL,''),(1047,'批量强退',109,2,'#','','','',1,0,'F','0','0','monitor:online:batchLogout','#','admin','2025-04-03 09:03:39','',NULL,''),(1048,'单条强退',109,3,'#','','','',1,0,'F','0','0','monitor:online:forceLogout','#','admin','2025-04-03 09:03:39','',NULL,''),(1049,'任务查询',110,1,'#','','','',1,0,'F','0','0','monitor:job:query','#','admin','2025-04-03 09:03:39','',NULL,''),(1050,'任务新增',110,2,'#','','','',1,0,'F','0','0','monitor:job:add','#','admin','2025-04-03 09:03:39','',NULL,''),(1051,'任务修改',110,3,'#','','','',1,0,'F','0','0','monitor:job:edit','#','admin','2025-04-03 09:03:39','',NULL,''),(1052,'任务删除',110,4,'#','','','',1,0,'F','0','0','monitor:job:remove','#','admin','2025-04-03 09:03:39','',NULL,''),(1053,'状态修改',110,5,'#','','','',1,0,'F','0','0','monitor:job:changeStatus','#','admin','2025-04-03 09:03:39','',NULL,''),(1054,'任务导出',110,6,'#','','','',1,0,'F','0','0','monitor:job:export','#','admin','2025-04-03 09:03:39','',NULL,''),(1055,'生成查询',116,1,'#','','','',1,0,'F','0','0','tool:gen:query','#','admin','2025-04-03 09:03:39','',NULL,''),(1056,'生成修改',116,2,'#','','','',1,0,'F','0','0','tool:gen:edit','#','admin','2025-04-03 09:03:39','',NULL,''),(1057,'生成删除',116,3,'#','','','',1,0,'F','0','0','tool:gen:remove','#','admin','2025-04-03 09:03:39','',NULL,''),(1058,'导入代码',116,4,'#','','','',1,0,'F','0','0','tool:gen:import','#','admin','2025-04-03 09:03:39','',NULL,''),(1059,'预览代码',116,5,'#','','','',1,0,'F','0','0','tool:gen:preview','#','admin','2025-04-03 09:03:39','',NULL,''),(1060,'生成代码',116,6,'#','','','',1,0,'F','0','0','tool:gen:code','#','admin','2025-04-03 09:03:39','',NULL,''),(2000,'节点管理',2015,9,'node','wvp/mediaServer/index',NULL,'node',1,0,'C','0','0','wvp:server:list','list','admin','2025-04-03 09:08:16','admin','2025-04-18 11:58:06',''),(2001,'onvif',0,5,'onvif',NULL,NULL,'',1,0,'M','0','0','','onvif','admin','2025-04-09 14:29:15','admin','2025-04-12 10:22:44',''),(2002,'添加摄像头',2001,1,'addCamera','onvif/addCamera/index',NULL,'',1,0,'C','0','0','onvif:device:add','addCamera','admin','2025-04-09 14:37:45','admin','2025-04-18 11:18:24',''),(2003,'国标设备',2015,1,'device','wvp/device/index',NULL,'device',1,0,'C','0','0','wvp:device:list','drag','admin','2025-04-09 14:54:29','admin','2025-04-18 09:00:20',''),(2004,'摄像头管理',2001,2,'cameraManage','onvif/cameraManage/index',NULL,'cameraManage',1,0,'C','0','0','onvif:device:list','cameraManage','admin','2025-04-09 17:31:15','admin','2025-04-18 11:13:56',''),(2005,'Onvif播放',2001,3,'palyOnvif','onvif/palyOnvif/index',NULL,'palyOnvif',1,1,'C','1','0','','#','admin','2025-04-10 15:28:33','admin','2025-04-11 08:57:09',''),(2006,'云端录像',2015,2,'cloudRecord','wvp/cloudRecord/index',NULL,'cloudRecord',1,0,'C','0','0','wvp:record:list','skill','admin','2025-04-11 11:31:09','admin','2025-04-18 10:53:12',''),(2007,'推流列表',2015,3,'streamPush','wvp/streamPush/index',NULL,'streamPush',1,0,'C','0','0','wvp:push:list','sunny','admin','2025-04-11 14:53:58','admin','2025-04-18 10:58:01',''),(2008,'拉流列表',2015,4,'streamProxy','wvp/streamProxy/index',NULL,'streamProxy',1,1,'C','0','0','wvp:proxy:list','server','admin','2025-04-12 09:13:44','admin','2025-04-18 11:04:20',''),(2009,'行政分组',2015,7,'administrativeGrouping','wvp/administrativeGrouping/index',NULL,'administrativeGrouping',1,0,'C','0','0','wvp:administrativeGrouping:list','drag','admin','2025-04-12 10:23:03','admin','2025-04-18 11:32:35',''),(2010,'大华播放',2001,20,'daHuaPlay','onvif/palyOnvif/daHuaPlay',NULL,'daHuaPlay',1,1,'C','1','0','','#','admin','2025-04-12 14:15:37','admin','2025-04-16 16:06:12',''),(2011,'通道管理',2015,8,'thoroughfare','wvp/thoroughfare/index',NULL,'thoroughfare',1,0,'C','0','0','wvp:thoroughfare:list','guide','admin','2025-04-14 08:56:17','admin','2025-04-18 11:40:27',''),(2012,'录像计划',2015,6,'recordPlan','wvp/recordPlan/index',NULL,'recordPlan',1,0,'C','0','0','wvp:record:list','dict','admin','2025-04-14 11:02:38','admin','2025-04-18 11:22:40',''),(2013,'分屏监控',2015,10,'wvpLive','wvp/live/index',NULL,'wvpLive',1,0,'C','0','0','wvp:live:list','bug','admin','2025-04-14 11:03:37','admin','2025-04-18 12:00:58',''),(2014,'国标级联',2015,5,'platform','wvp/platform/index',NULL,'platform',1,0,'C','0','0','wvp:platform:list','date-range','admin','2025-04-16 10:06:03','admin','2025-04-18 11:11:47',''),(2015,'国标管理',0,6,'gbmanger',NULL,NULL,'',1,0,'M','0','0',NULL,'skill','admin','2025-04-16 14:05:21','',NULL,''),(2016,'删除设备',2003,1,'',NULL,NULL,'',1,0,'F','0','0','wvp:device:remove','#','admin','2025-04-18 09:01:18','',NULL,''),(2017,'同步设备',2003,2,'',NULL,NULL,'',1,0,'F','0','0','wvp:device:sync','#','admin','2025-04-18 09:02:25','',NULL,''),(2018,'查询设备',2003,3,'',NULL,NULL,'',1,0,'F','0','0','wvp:device:query','#','admin','2025-04-18 09:03:19','',NULL,''),(2019,'开启/关闭目录订阅',2003,4,'',NULL,NULL,'',1,0,'F','0','0','wvp:device:subscribeCatalog','#','admin','2025-04-18 09:04:43','',NULL,''),(2020,'开启/关闭移动位置订阅',2003,5,'',NULL,NULL,'',1,0,'F','0','0','wvp:device:subscribeMobilePosition','#','admin','2025-04-18 09:05:22','',NULL,''),(2022,'更新设备信息',2003,7,'',NULL,NULL,'',1,0,'F','0','0','wvp:device:edit','#','admin','2025-04-18 09:06:43','',NULL,''),(2023,'修改数据流传输模式',2003,8,'',NULL,NULL,'',1,0,'F','0','0','wvp:device:updateTransport','#','admin','2025-04-18 09:07:31','',NULL,''),(2024,'获取平台配置信息',2003,9,'',NULL,NULL,'',1,0,'F','0','0','wvp:server:configInfo','#','admin','2025-04-18 09:09:20','',NULL,''),(2025,'获取流媒体服务列表',2003,10,'',NULL,NULL,'',1,0,'F','0','0','wvp:server:listOnline','#','admin','2025-04-18 09:10:12','',NULL,''),(2026,'报警布防/撤防命令',2003,11,'',NULL,NULL,'',1,0,'F','0','0','wvp:control:guardApi','#','admin','2025-04-18 09:12:18','',NULL,''),(2027,'设备配置查询',2003,12,'',NULL,NULL,'',1,0,'F','0','0','wvp:config:cdownloadApi','#','admin','2025-04-18 09:13:55','',NULL,''),(2028,'通道列表',2003,13,'',NULL,NULL,'',1,0,'F','0','0','wvp:device:channels','#','admin','2025-04-18 10:29:46','',NULL,''),(2029,'修改通道码流',2003,14,'',NULL,NULL,'',1,0,'F','0','0','wvp:device:channelStreamIdentification','#','admin','2025-04-18 10:32:27','',NULL,''),(2030,'播放视频',2003,15,'',NULL,NULL,'',1,0,'F','0','0','wvp:play:start','#','admin','2025-04-18 10:39:05','',NULL,''),(2031,'停止播放',2003,16,'',NULL,NULL,'',1,0,'F','0','0','wvp:play:stop','#','admin','2025-04-18 10:40:21','',NULL,''),(2032,'查询通道',2003,17,'',NULL,NULL,'',1,0,'F','0','0','wvp:channel:query','#','admin','2025-04-18 10:42:04','',NULL,''),(2033,'修改通道',2003,18,'',NULL,NULL,'',1,0,'F','0','0','wvp:channel:edit','#','admin','2025-04-18 10:43:00','',NULL,''),(2034,'录像控制命令',2003,19,'',NULL,NULL,'',1,0,'F','0','0','wvp:control:recordApi','#','admin','2025-04-18 10:46:14','',NULL,''),(2035,'播放',2006,1,'',NULL,NULL,'',1,0,'F','0','0','wvp:record:play','#','admin','2025-04-18 10:54:11','',NULL,''),(2036,'下载',2006,2,'',NULL,NULL,'',1,0,'F','0','0','wvp:record:download','#','admin','2025-04-18 10:55:06','admin','2025-04-18 10:56:03',''),(2037,'新增',2007,1,'',NULL,NULL,'',1,0,'F','0','0','wvp:push:add','#','admin','2025-04-18 10:58:59','',NULL,''),(2038,'修改',2007,2,'',NULL,NULL,'',1,0,'F','0','0','wvp:push:edit','#','admin','2025-04-18 10:59:31','admin','2025-04-18 10:59:37',''),(2039,'删除',2007,3,'',NULL,NULL,'',1,0,'F','0','0','wvp:push:remove','#','admin','2025-04-18 11:00:31','',NULL,''),(2040,'播放',2007,4,'',NULL,NULL,'',1,0,'F','0','0','wvp:push:play','#','admin','2025-04-18 11:01:41','',NULL,''),(2041,'删除',2008,1,'',NULL,NULL,'',1,0,'F','0','0','wvp:proxy:delete','#','admin','2025-04-18 11:05:18','',NULL,''),(2042,'新增',2008,2,'',NULL,NULL,'',1,0,'F','0','0','wvp:proxy:add','#','admin','2025-04-18 11:08:59','',NULL,''),(2043,'修改',2008,3,'',NULL,NULL,'',1,0,'F','0','0','wvp:proxy:edit','#','admin','2025-04-18 11:09:18','',NULL,''),(2044,'播放',2008,3,'',NULL,NULL,'',1,0,'F','0','0','wvp:proxy:play','#','admin','2025-04-18 11:09:37','',NULL,''),(2045,'停止',2008,4,'',NULL,NULL,'',1,0,'F','0','0','wvp:proxy:stop','#','admin','2025-04-18 11:09:51','',NULL,''),(2046,'新增',2014,1,'',NULL,NULL,'',1,0,'F','0','0','wvp:platform:add','#','admin','2025-04-18 11:12:54','',NULL,''),(2047,'编辑',2014,2,'',NULL,NULL,'',1,0,'F','0','0','wvp:platform:edit','#','admin','2025-04-18 11:13:06','',NULL,''),(2048,'删除',2014,3,'',NULL,NULL,'',1,0,'F','0','0','wvp:platform:delete','#','admin','2025-04-18 11:13:22','',NULL,''),(2049,'导出',2004,1,'',NULL,NULL,'',1,0,'F','0','0','onvif:device:export','#','admin','2025-04-18 11:14:12','',NULL,''),(2051,'修改',2004,3,'',NULL,NULL,'',1,0,'F','0','0','onvif:device:edit','#','admin','2025-04-18 11:14:44','',NULL,''),(2052,'获取详情',2051,1,'',NULL,NULL,'',1,0,'F','0','0','onvif:device:query','#','admin','2025-04-18 11:15:02','',NULL,''),(2053,'推送通道',2014,4,'',NULL,NULL,'',1,0,'F','0','0','wvp:platform:push','#','admin','2025-04-18 11:15:03','',NULL,''),(2054,'播放',2004,4,'',NULL,NULL,'',1,0,'F','0','0','onvif:device:play','#','admin','2025-04-18 11:16:28','',NULL,''),(2055,'通道共享',2014,5,'',NULL,NULL,'',1,0,'F','0','0','wvp:platform:channelList','#','admin','2025-04-18 11:17:23','',NULL,''),(2056,'探测',2002,1,'',NULL,NULL,'',1,0,'F','0','0','onvif:service:getInfo','#','admin','2025-04-18 11:18:44','',NULL,''),(2057,'新增设备',2014,6,'',NULL,NULL,'',1,0,'F','0','0','wvp:platform:channelAdd','#','admin','2025-04-18 11:18:47','',NULL,''),(2058,'删除设备',2014,7,'',NULL,NULL,'',1,0,'F','0','0','wvp:platform:channelRemove','#','admin','2025-04-18 11:19:22','',NULL,''),(2059,'删除',2004,2,'',NULL,NULL,'',1,0,'F','0','0','onvif:device:remove','#','admin','2025-04-18 11:21:58','',NULL,''),(2060,'新塘',2012,1,'',NULL,NULL,'',1,0,'F','0','0','wvp:record:add','#','admin','2025-04-18 11:23:48','',NULL,''),(2061,'修改',2012,2,'',NULL,NULL,'',1,0,'F','0','0','wvp:record:edit','#','admin','2025-04-18 11:24:02','',NULL,''),(2062,'删除',2012,3,'',NULL,NULL,'',1,0,'F','0','0','wvp:record:delete','#','admin','2025-04-18 11:24:16','',NULL,''),(2063,'关联通道',2012,4,'',NULL,NULL,'',1,0,'F','0','0','wvp:record:channelList','#','admin','2025-04-18 11:27:25','',NULL,''),(2064,'新增通道关联',2012,5,'',NULL,NULL,'',1,0,'F','0','0','wvp:record:channelAdd','#','admin','2025-04-18 11:29:23','admin','2025-04-18 11:30:41',''),(2065,'删除通道关联',2012,6,'',NULL,NULL,'',1,0,'F','0','0','wvp:record:channelDelete','#','admin','2025-04-18 11:29:48','admin','2025-04-18 11:30:46',''),(2066,'查询区域',2009,1,'',NULL,NULL,'',1,0,'F','0','0','wvp:region:list','#','admin','2025-04-18 11:33:20','',NULL,''),(2067,'修改区域',2009,2,'',NULL,NULL,'',1,0,'F','0','0','wvp:region:edit','#','admin','2025-04-18 11:34:27','admin','2025-04-18 11:38:27',''),(2068,'新增区域',2009,3,'',NULL,NULL,'',1,0,'F','0','0','wvp:region:add','#','admin','2025-04-18 11:34:43','admin','2025-04-18 11:38:31',''),(2069,'删除区域',2009,4,'',NULL,NULL,'',1,0,'F','0','0','wvp:region:delete','#','admin','2025-04-18 11:34:54','admin','2025-04-18 11:38:34',''),(2070,'查询分组',2009,5,'',NULL,NULL,'',1,0,'F','0','0','wvp:group:list','#','admin','2025-04-18 11:37:06','',NULL,''),(2071,'新增分组',2009,6,'',NULL,NULL,'',1,0,'F','0','0','wvp:group:add','#','admin','2025-04-18 11:37:55','',NULL,''),(2072,'修改分组',2009,7,'',NULL,NULL,'',1,0,'F','0','0','wvp:group:edit','#','admin','2025-04-18 11:38:10','',NULL,''),(2073,'删除分组',2009,8,'',NULL,NULL,'',1,0,'F','0','0','wvp:group:delete','#','admin','2025-04-18 11:38:22','',NULL,''),(2074,'通道列表',2011,1,'',NULL,NULL,'',1,0,'F','0','0','wvp:channel:civilcodeList','#','admin','2025-04-18 11:41:43','admin','2025-04-18 11:46:46',''),(2075,'删除区域通道',2011,2,'',NULL,NULL,'',1,0,'F','0','0','wvp:channel:deleteRegionChannel','#','admin','2025-04-18 11:44:51','admin','2025-04-18 11:49:55',''),(2076,'新增区域通道',2011,3,'',NULL,NULL,'',1,0,'F','0','0','wvp:channel:addRegionChannel','#','admin','2025-04-18 11:45:39','admin','2025-04-18 11:49:49',''),(2077,'新增分组通道',2011,4,'',NULL,NULL,'',1,0,'F','0','0','wvp:channel:addGroupChannel','#','admin','2025-04-18 11:49:09','',NULL,''),(2078,'删除分组通道',2011,5,'',NULL,NULL,'',1,0,'F','0','0','wvp:channel:deleteGroupChannel','#','admin','2025-04-18 11:49:26','',NULL,''),(2079,'查看',2000,1,'',NULL,NULL,'',1,0,'F','0','0','wvp:wvpMediaServer:view','#','admin','2025-04-18 11:58:39','',NULL,'');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_notice` (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '公告标题',
  `notice_type` char(1) COLLATE utf8_bin NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (1,'温馨提醒：2018-07-01 若依新版本发布啦','2',_binary '新版本内容','0','admin','2025-04-03 09:03:39','',NULL,'管理员'),(2,'维护通知：2018-07-01 若依系统凌晨维护','1',_binary '维护内容','0','admin','2025-04-03 09:03:39','',NULL,'管理员');
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) COLLATE utf8_bin DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) COLLATE utf8_bin DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) COLLATE utf8_bin DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) COLLATE utf8_bin DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) COLLATE utf8_bin DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) COLLATE utf8_bin DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) COLLATE utf8_bin DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) COLLATE utf8_bin DEFAULT '' COMMENT '返回参数',
  `status` int(1) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) COLLATE utf8_bin DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  KEY `idx_sys_oper_log_bt` (`business_type`) USING BTREE,
  KEY `idx_sys_oper_log_s` (`status`) USING BTREE,
  KEY `idx_sys_oper_log_ot` (`oper_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=335 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (100,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2025-04-03 09:07:32',18),(101,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-03 09:03:39\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":20,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 09:07:37',20),(102,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-03 09:03:39\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":19,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 09:07:41',17),(103,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-03 09:03:39\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":18,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 09:07:45',13),(104,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-03 09:03:39\",\"icon\":\"system\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1,\"menuName\":\"系统管理\",\"menuType\":\"M\",\"orderNum\":17,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 09:07:49',11),(105,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"节点管理\",\"menuType\":\"C\",\"orderNum\":16,\"params\":{},\"parentId\":0,\"path\":\"node\",\"routeName\":\"node\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 09:08:16',11),(106,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"node/index\",\"createTime\":\"2025-04-03 09:08:16\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"节点管理\",\"menuType\":\"C\",\"orderNum\":16,\"params\":{},\"parentId\":0,\"path\":\"node\",\"perms\":\"\",\"routeName\":\"node\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 09:08:54',17),(107,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"wvp_media_server\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 09:20:02',150),(108,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"wvpMediaServer\",\"className\":\"WvpMediaServer\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"记录的唯一标识符\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Ip\",\"columnComment\":\"服务器绑定的 IP 地址\",\"columnId\":2,\"columnName\":\"ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"ip\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"HookIp\",\"columnComment\":\"接收回调通知的 IP 地址\",\"columnId\":3,\"columnName\":\"hook_ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"hookIp\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"SdpIp\",\"columnComment\":\"SDP 协议使用的 IP 地址\",\"columnId\":4,\"columnName\":\"sdp_ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRe','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 09:21:27',99),(109,'代码生成',2,'com.ruoyi.generator.controller.GenController.synchDb()','GET',1,'admin','研发部门','/tool/gen/synchDb/wvp_media_server','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 09:22:11',124),(110,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"wvpMediaServer\",\"className\":\"WvpMediaServer\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"记录的唯一标识符\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-03 09:22:11\",\"usableColumn\":false},{\"capJavaField\":\"Ip\",\"columnComment\":\"服务器绑定的 IP 地址\",\"columnId\":2,\"columnName\":\"ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"ip\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-03 09:22:11\",\"usableColumn\":false},{\"capJavaField\":\"HookIp\",\"columnComment\":\"接收回调通知的 IP 地址\",\"columnId\":3,\"columnName\":\"hook_ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"hookIp\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-03 09:22:11\",\"usableColumn\":false},{\"capJavaField\":\"SdpIp\",\"columnComment\":\"SDP 协议使用的 IP 地址\",\"columnId\":4,\"columnName\":\"sdp_ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":fals','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 09:22:26',83),(111,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"wvp_media_server\"}',NULL,0,NULL,'2025-04-03 09:22:30',641),(112,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/wvpMediaServer/index\",\"createTime\":\"2025-04-03 09:08:16\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"节点管理\",\"menuType\":\"C\",\"orderNum\":16,\"params\":{},\"parentId\":0,\"path\":\"node\",\"perms\":\"\",\"routeName\":\"node\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 09:26:05',25),(113,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"wvpMediaServer\",\"className\":\"WvpMediaServer\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"记录的唯一标识符\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-03 09:22:26\",\"usableColumn\":false},{\"capJavaField\":\"Ip\",\"columnComment\":\"服务器绑定的 IP 地址\",\"columnId\":2,\"columnName\":\"ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"ip\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-03 09:22:26\",\"usableColumn\":false},{\"capJavaField\":\"HookIp\",\"columnComment\":\"接收回调通知的 IP 地址\",\"columnId\":3,\"columnName\":\"hook_ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"hookIp\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-03 09:22:26\",\"usableColumn\":false},{\"capJavaField\":\"SdpIp\",\"columnComment\":\"SDP 协议使用的 IP 地址\",\"columnId\":4,\"columnName\":\"sdp_ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 10:36:50',185),(114,'媒体服务器',1,'com.ruoyi.web.controller.wvp.WvpMediaServerController.checkMediaServer()','POST',1,'admin','研发部门','/wvp/wvpMediaServer/checkMediaServer','127.0.0.1','内网IP','{\"httpPort\":8092,\"ip\":\"192.168.158.39\",\"params\":{},\"secret\":\"hxkj_zlm\",\"type\":\"zlm\"}',NULL,1,'此连接已存在','2025-04-03 11:46:46',23),(115,'媒体服务器',1,'com.ruoyi.web.controller.wvp.WvpMediaServerController.checkMediaServer()','POST',1,'admin','研发部门','/wvp/wvpMediaServer/checkMediaServer','127.0.0.1','内网IP','{\"httpPort\":8092,\"ip\":\"192.168.158.199\",\"params\":{},\"secret\":\"hxkj_zlm\",\"type\":\"zlm\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 11:46:59',5),(116,'媒体服务器',1,'com.ruoyi.web.controller.wvp.WvpMediaServerController.checkMediaServer()','POST',1,'admin','研发部门','/wvp/wvpMediaServer/checkMediaServer','127.0.0.1','内网IP','{\"httpPort\":8092,\"ip\":\"192.168.158.199\",\"params\":{},\"secret\":\"hxkj_zlm\",\"type\":\"zlm\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 11:49:24',8),(117,'媒体服务器',1,'com.ruoyi.web.controller.wvp.WvpMediaServerController.checkMediaServer()','POST',1,'admin','研发部门','/wvp/wvpMediaServer/checkMediaServer','127.0.0.1','内网IP','{\"httpPort\":8092,\"ip\":\"192.168.158.199\",\"params\":{},\"secret\":\"hxkj_zlm\",\"type\":\"zlm\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 11:49:42',7229),(118,'媒体服务器',1,'com.ruoyi.web.controller.wvp.WvpMediaServerController.checkMediaServer()','POST',1,'admin','研发部门','/wvp/wvpMediaServer/checkMediaServer','127.0.0.1','内网IP','{\"httpPort\":8092,\"ip\":\"192.168.158.199\",\"params\":{},\"secret\":\"hxkj_zlm\",\"type\":\"zlm\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 11:49:50',7),(119,'媒体服务器',1,'com.ruoyi.web.controller.wvp.WvpMediaServerController.checkMediaServer()','POST',1,'admin','研发部门','/wvp/wvpMediaServer/checkMediaServer','127.0.0.1','内网IP','{\"httpPort\":8092,\"ip\":\"192.168.158.199\",\"params\":{},\"secret\":\"hxkj_zlm\",\"type\":\"zlm\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-03 11:50:42',5612),(120,'参数管理',2,'com.ruoyi.web.controller.system.SysConfigController.edit()','PUT',1,'admin','研发部门','/system/config','127.0.0.1','内网IP','{\"configId\":4,\"configKey\":\"sys.account.captchaEnabled\",\"configName\":\"账号自助-验证码开关\",\"configType\":\"Y\",\"configValue\":\"false\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:03:39\",\"params\":{},\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-09 14:28:40',25),(121,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"onvif\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"onvif\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-09 14:29:15',20),(122,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"添加设备\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":2001,\"path\":\"addCamera\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-09 14:37:45',10),(123,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"onvif/addCamera/index\",\"createTime\":\"2025-04-09 14:37:45\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"添加设备\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2001,\"path\":\"addCamera\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-09 14:38:19',12),(124,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/wvpMediaServer/index\",\"createTime\":\"2025-04-03 09:08:16\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"节点管理\",\"menuType\":\"C\",\"orderNum\":16,\"params\":{},\"parentId\":0,\"path\":\"node\",\"perms\":\"onvif:service:getInfo\",\"routeName\":\"node\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-09 14:45:29',23),(125,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"onvif/addCamera/index\",\"createTime\":\"2025-04-09 14:37:45\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"添加设备\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2001,\"path\":\"addCamera\",\"perms\":\"onvif:service:getInfo\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-09 14:45:38',14),(126,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/wvpMediaServer/index\",\"createTime\":\"2025-04-03 09:08:16\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"节点管理\",\"menuType\":\"C\",\"orderNum\":16,\"params\":{},\"parentId\":0,\"path\":\"node\",\"perms\":\"\",\"routeName\":\"node\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-09 14:45:41',18),(127,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/mediaServer/index\",\"createTime\":\"2025-04-03 09:08:16\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"节点管理\",\"menuType\":\"C\",\"orderNum\":16,\"params\":{},\"parentId\":0,\"path\":\"node\",\"perms\":\"\",\"routeName\":\"node\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-09 14:53:51',10),(128,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"drag\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"国标设备\",\"menuType\":\"C\",\"orderNum\":15,\"params\":{},\"parentId\":0,\"path\":\"device\",\"routeName\":\"device\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-09 14:54:29',26),(129,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/device/index\",\"createTime\":\"2025-04-09 14:54:29\",\"icon\":\"drag\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"国标设备\",\"menuType\":\"C\",\"orderNum\":15,\"params\":{},\"parentId\":0,\"path\":\"device\",\"perms\":\"\",\"routeName\":\"device\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-09 14:54:41',19),(130,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"摄像头管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2001,\"path\":\"cameraManage\",\"routeName\":\"cameraManage\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-09 17:31:15',28),(131,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"onvif_device\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 08:59:39',127),(132,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"device\",\"className\":\"OnvifDevice\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":31,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-10 08:59:38\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Ip\",\"columnComment\":\"ip\",\"columnId\":32,\"columnName\":\"ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-10 08:59:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"ip\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Url\",\"columnComment\":\"默认直播流播放地址\",\"columnId\":33,\"columnName\":\"url\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-10 08:59:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"url\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Firm\",\"columnComment\":\"设备厂商\",\"columnId\":34,\"columnName\":\"firm\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-10 08:59:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"firm\",\"javaType\":\"String\",\"li','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 09:00:32',89),(133,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"device\",\"className\":\"OnvifDevice\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"id\",\"columnId\":31,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-10 08:59:38\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-04-10 09:00:32\",\"usableColumn\":false},{\"capJavaField\":\"Ip\",\"columnComment\":\"ip\",\"columnId\":32,\"columnName\":\"ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-10 08:59:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"ip\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-04-10 09:00:32\",\"usableColumn\":false},{\"capJavaField\":\"Url\",\"columnComment\":\"默认直播流播放地址\",\"columnId\":33,\"columnName\":\"url\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-10 08:59:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"url\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-04-10 09:00:32\",\"usableColumn\":false},{\"capJavaField\":\"Firm\",\"columnComment\":\"设备厂商\",\"columnId\":34,\"columnName\":\"firm\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-10 08:59:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInse','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 09:00:51',99),(134,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"onvif_device\"}',NULL,0,NULL,'2025-04-10 09:00:54',727),(135,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"onvif/cameraManage/index\",\"createTime\":\"2025-04-09 17:31:15\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"摄像头管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2001,\"path\":\"cameraManage\",\"perms\":\"\",\"routeName\":\"cameraManage\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 09:04:50',33),(136,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"onvif/addCamera/index\",\"createTime\":\"2025-04-09 14:37:45\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"添加摄像头\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2001,\"path\":\"addCamera\",\"perms\":\"onvif:service:getInfo\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 09:11:42',21),(137,'代码生成',2,'com.ruoyi.generator.controller.GenController.synchDb()','GET',1,'admin','研发部门','/tool/gen/synchDb/onvif_device','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 09:18:47',135),(138,'onvif 设备',1,'com.ruoyi.web.controller.onvif.OnvifDeviceController.add()','POST',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createTime\":\"2025-04-10 09:44:27\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"ip\":\"192.168.158.63\",\"model\":\"DH-IPC-HDP2230C-ST\",\"params\":{},\"streamUris\":{\"MediaProfile_Channel1_MainStream\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\",\"MediaProfile_Channel1_SubStream1\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\"},\"url\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\"}',NULL,1,'\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Cannot create a JSON value from a string with CHARACTER SET \'binary\'.\r\n### The error may exist in file [D:\\java\\iot\\ry\\RuoYi-Wvp\\ruoyi-onvif\\target\\classes\\mapper\\onvif\\OnvifDeviceMapper.xml]\r\n### The error may involve com.ruoyi.onvif.mapper.OnvifDeviceMapper.insertOnvifDevice-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into onvif_device          ( ip,                          password,             url,             firm,             model,             firmware_version,             stream_uris,                          create_time )           values ( ?,                          ?,             ?,             ?,             ?,             ?,             ?,                          ? )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Cannot create a JSON value from a string with CHARACTER SET \'binary\'.\n; Data truncation: Cannot create a JSON value from a string with CHARACTER SET \'binary\'.; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Cannot create a JSON value from a string with CHARACTER SET \'binary\'.','2025-04-10 09:44:29',95),(139,'onvif 设备',1,'com.ruoyi.web.controller.onvif.OnvifDeviceController.add()','POST',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createTime\":\"2025-04-10 09:44:51\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"ip\":\"192.168.158.63\",\"model\":\"DH-IPC-HDP2230C-ST\",\"params\":{},\"streamUris\":{\"MediaProfile_Channel1_MainStream\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\",\"MediaProfile_Channel1_SubStream1\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\"},\"url\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\"}',NULL,1,'\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Cannot create a JSON value from a string with CHARACTER SET \'binary\'.\r\n### The error may exist in file [D:\\java\\iot\\ry\\RuoYi-Wvp\\ruoyi-onvif\\target\\classes\\mapper\\onvif\\OnvifDeviceMapper.xml]\r\n### The error may involve com.ruoyi.onvif.mapper.OnvifDeviceMapper.insertOnvifDevice-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into onvif_device          ( ip,                          password,             url,             firm,             model,             firmware_version,             stream_uris,                          create_time )           values ( ?,                          ?,             ?,             ?,             ?,             ?,             ?,                          ? )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Cannot create a JSON value from a string with CHARACTER SET \'binary\'.\n; Data truncation: Cannot create a JSON value from a string with CHARACTER SET \'binary\'.; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Cannot create a JSON value from a string with CHARACTER SET \'binary\'.','2025-04-10 09:44:53',12863),(140,'onvif 设备',1,'com.ruoyi.web.controller.onvif.OnvifDeviceController.add()','POST',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createTime\":\"2025-04-10 09:46:47\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":1,\"ip\":\"192.168.158.63\",\"model\":\"DH-IPC-HDP2230C-ST\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"url\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 09:46:52',15386),(141,'onvif 设备',1,'com.ruoyi.web.controller.onvif.OnvifDeviceController.add()','POST',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createTime\":\"2025-04-10 09:47:55\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":2,\"ip\":\"192.168.158.63\",\"model\":\"DH-IPC-HDP2230C-ST\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"url\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 09:47:56',141),(142,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-10 09:47:55\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":2,\"ip\":\"192.168.158.63\",\"model\":\"DH-IPC-HDP2230C-ST\",\"params\":{},\"streamUris\":{\"MediaProfile_Channel1_MainStream\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\",\"MediaProfile_Channel1_SubStream1\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\"},\"updateBy\":\"\",\"updateTime\":\"2025-04-10 09:57:13\",\"url\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\",\"userName\":\"admin\"}',NULL,1,'\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Cannot create a JSON value from a string with CHARACTER SET \'binary\'.\r\n### The error may exist in file [D:\\java\\iot\\ry\\RuoYi-Wvp\\ruoyi-onvif\\target\\classes\\mapper\\onvif\\OnvifDeviceMapper.xml]\r\n### The error may involve com.ruoyi.onvif.mapper.OnvifDeviceMapper.updateOnvifDevice-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update onvif_device          SET ip = ?,             user_name = ?,             password = ?,             url = ?,             firm = ?,             model = ?,             firmware_version = ?,             stream_uris = ?,             create_by = ?,             create_time = ?,             update_by = ?,             update_time = ?          where id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Cannot create a JSON value from a string with CHARACTER SET \'binary\'.\n; Data truncation: Cannot create a JSON value from a string with CHARACTER SET \'binary\'.; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Cannot create a JSON value from a string with CHARACTER SET \'binary\'.','2025-04-10 09:57:15',53),(143,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-10 09:47:55\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":2,\"ip\":\"192.168.158.63\",\"model\":\"DH-IPC-HDP2230C-ST\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-10 09:57:55\",\"url\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 09:57:57',37),(144,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-09 14:29:15\",\"icon\":\"onvif\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"onvif\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"onvif\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 10:21:52',22),(145,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"onvif/addCamera/index\",\"createTime\":\"2025-04-09 14:37:45\",\"icon\":\"addCamera\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"添加摄像头\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2001,\"path\":\"addCamera\",\"perms\":\"onvif:service:getInfo\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 10:22:56',12),(146,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"onvif/cameraManage/index\",\"createTime\":\"2025-04-09 17:31:15\",\"icon\":\"cameraManage\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"摄像头管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2001,\"path\":\"cameraManage\",\"perms\":\"\",\"routeName\":\"cameraManage\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 10:23:54',30),(147,'代码生成',2,'com.ruoyi.generator.controller.GenController.synchDb()','GET',1,'admin','研发部门','/tool/gen/synchDb/onvif_device','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 10:29:30',134),(148,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-10 09:47:55\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":2,\"ip\":\"192.168.158.63\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"球机\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-10 10:55:52\",\"url\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 10:55:54',31),(149,'onvif 设备',1,'com.ruoyi.web.controller.onvif.OnvifDeviceController.add()','POST',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createTime\":\"2025-04-10 11:04:46\",\"firm\":\"HIKVISION\",\"firmwareVersion\":\"V5.8.3\",\"id\":3,\"ip\":\"192.168.212.189\",\"model\":\"DS-2DE3Q144MY-T/GLSE\",\"params\":{},\"streamUris\":\"{\\\"Stream_102\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/102?transportmode=unicast&profile=Profile_102\\\",\\\"Stream_101\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\\\"}\",\"url\":\"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 11:04:47',20),(150,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-10 09:47:55\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":2,\"ip\":\"192.168.158.63\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"球机\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-10 11:06:20\",\"url\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 11:06:22',11),(151,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"onvif/palyOnvif/index\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"Onvif播放\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2001,\"path\":\"palyOnvif\",\"routeName\":\"palyOnvif\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 15:28:34',158),(152,'onvif 设备',1,'com.ruoyi.web.controller.onvif.OnvifDeviceController.add()','POST',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createTime\":\"2025-04-10 15:50:07\",\"firm\":\"HIKVISION\",\"firmwareVersion\":\"V5.8.3\",\"id\":4,\"ip\":\"192.168.212.189\",\"model\":\"DS-2DE3Q144MY-T/GLSE\",\"params\":{},\"streamUris\":\"{\\\"Stream_202\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/202?transportmode=unicast&profile=Profile_202\\\",\\\"Stream_102\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/102?transportmode=unicast&profile=Profile_102\\\",\\\"Stream_201\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/201?transportmode=unicast&profile=Profile_201\\\",\\\"Stream_101\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\\\"}\",\"url\":\"rtsp://192.168.212.189:554/Streaming/Channels/201?transportmode=unicast&profile=Profile_201\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 15:50:09',47),(153,'onvif 设备',3,'com.ruoyi.web.controller.onvif.OnvifDeviceController.remove()','DELETE',1,'admin','研发部门','/onvif/device/3','127.0.0.1','内网IP','[3]','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 15:50:17',19),(154,'onvif 设备',3,'com.ruoyi.web.controller.onvif.OnvifDeviceController.remove()','DELETE',1,'admin','研发部门','/onvif/device/4','127.0.0.1','内网IP','[4]','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 15:50:20',230),(155,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"wvpMediaServer\",\"className\":\"WvpMediaServer\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"记录的唯一标识符\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-03 10:36:50\",\"usableColumn\":false},{\"capJavaField\":\"Ip\",\"columnComment\":\"服务器绑定的 IP 地址\",\"columnId\":2,\"columnName\":\"ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"ip\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-03 10:36:50\",\"usableColumn\":false},{\"capJavaField\":\"HookIp\",\"columnComment\":\"接收回调通知的 IP 地址\",\"columnId\":3,\"columnName\":\"hook_ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"hookIp\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-03 10:36:50\",\"usableColumn\":false},{\"capJavaField\":\"SdpIp\",\"columnComment\":\"SDP 协议使用的 IP 地址\",\"columnId\":4,\"columnName\":\"sdp_ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,',NULL,1,'树编码字段不能为空','2025-04-10 16:54:17',19),(156,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"wvpMediaServer\",\"className\":\"WvpMediaServer\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"记录的唯一标识符\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-03 10:36:50\",\"usableColumn\":false},{\"capJavaField\":\"Ip\",\"columnComment\":\"服务器绑定的 IP 地址\",\"columnId\":2,\"columnName\":\"ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"ip\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-03 10:36:50\",\"usableColumn\":false},{\"capJavaField\":\"HookIp\",\"columnComment\":\"接收回调通知的 IP 地址\",\"columnId\":3,\"columnName\":\"hook_ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"hookIp\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-03 10:36:50\",\"usableColumn\":false},{\"capJavaField\":\"SdpIp\",\"columnComment\":\"SDP 协议使用的 IP 地址\",\"columnId\":4,\"columnName\":\"sdp_ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,',NULL,1,'树父编码字段不能为空','2025-04-10 16:54:20',1),(157,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"wvpMediaServer\",\"className\":\"WvpMediaServer\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"记录的唯一标识符\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-03 10:36:50\",\"usableColumn\":false},{\"capJavaField\":\"Ip\",\"columnComment\":\"服务器绑定的 IP 地址\",\"columnId\":2,\"columnName\":\"ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"ip\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-03 10:36:50\",\"usableColumn\":false},{\"capJavaField\":\"HookIp\",\"columnComment\":\"接收回调通知的 IP 地址\",\"columnId\":3,\"columnName\":\"hook_ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"hookIp\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-04-03 10:36:50\",\"usableColumn\":false},{\"capJavaField\":\"SdpIp\",\"columnComment\":\"SDP 协议使用的 IP 地址\",\"columnId\":4,\"columnName\":\"sdp_ip\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:20:02\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 16:54:24',100),(158,'onvif 设备',1,'com.ruoyi.web.controller.onvif.OnvifDeviceController.add()','POST',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createTime\":\"2025-04-10 17:19:10\",\"firm\":\"HIKVISION\",\"firmwareVersion\":\"V5.8.3\",\"id\":5,\"ip\":\"192.168.212.189\",\"model\":\"DS-2DE3Q144MY-T/GLSE\",\"name\":\"球机\",\"params\":{},\"streamUris\":\"{\\\"Stream_202\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/202?transportmode=unicast&profile=Profile_202\\\",\\\"Stream_102\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/102?transportmode=unicast&profile=Profile_102\\\",\\\"Stream_201\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/201?transportmode=unicast&profile=Profile_201\\\",\\\"Stream_101\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\\\"}\",\"url\":\"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 17:19:12',42),(159,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-10 17:19:10\",\"firm\":\"HIKVISION\",\"firmwareVersion\":\"V5.8.3\",\"id\":5,\"ip\":\"192.168.212.189\",\"model\":\"DS-2DE3Q144MY-T/GLSE\",\"name\":\"haikang球机\",\"params\":{},\"streamUris\":\"{\\\"Stream_101\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\\\",\\\"Stream_102\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/102?transportmode=unicast&profile=Profile_102\\\",\\\"Stream_201\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/201?transportmode=unicast&profile=Profile_201\\\",\\\"Stream_202\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/202?transportmode=unicast&profile=Profile_202\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-10 17:20:04\",\"url\":\"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 17:20:06',14),(160,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-10 17:19:10\",\"firm\":\"HIKVISION\",\"firmwareVersion\":\"V5.8.3\",\"id\":5,\"ip\":\"192.168.212.189\",\"model\":\"DS-2DE3Q144MY-T/GLSE\",\"name\":\"haikang球机\",\"params\":{},\"streamUris\":\"{\\\"Stream_101\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\\\",\\\"Stream_102\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/102?transportmode=unicast&profile=Profile_102\\\",\\\"Stream_201\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/201?transportmode=unicast&profile=Profile_201\\\",\\\"Stream_202\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/202?transportmode=unicast&profile=Profile_202\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-10 17:22:20\",\"url\":\"rtsp://192.168.212.189:554/Streaming/Channels/102?transportmode=unicast&profile=Profile_102\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-10 17:22:22',20),(161,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"onvif/palyOnvif/index\",\"createTime\":\"2025-04-10 15:28:33\",\"icon\":\"#\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2005,\"menuName\":\"Onvif播放\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2001,\"path\":\"palyOnvif\",\"perms\":\"\",\"routeName\":\"palyOnvif\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-11 08:57:09',22),(162,'onvif 设备',1,'com.ruoyi.web.controller.onvif.OnvifDeviceController.add()','POST',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createTime\":\"2025-04-11 09:31:50\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":6,\"ip\":\"192.168.158.62\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"球机\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"url\":\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-11 09:31:50',17),(163,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-11 09:31:50\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":6,\"ip\":\"192.168.158.62\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"办公室大华\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-11 09:32:13\",\"url\":\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-11 09:32:13',74),(164,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4','{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}',0,NULL,'2025-04-11 11:23:21',20),(165,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-04-03 09:03:39\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-11 11:23:31',33),(166,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/4','127.0.0.1','内网IP','4','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-11 11:23:36',16),(167,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"skill\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"云端录像\",\"menuType\":\"C\",\"orderNum\":14,\"params\":{},\"parentId\":0,\"path\":\"cloudRecord\",\"routeName\":\"cloudRecord\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-11 11:31:09',19),(168,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/cloudRecord/index\",\"createTime\":\"2025-04-11 11:31:09\",\"icon\":\"skill\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"云端录像\",\"menuType\":\"C\",\"orderNum\":14,\"params\":{},\"parentId\":0,\"path\":\"cloudRecord\",\"perms\":\"\",\"routeName\":\"cloudRecord\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-11 11:31:17',18),(169,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"sunny\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"推流列表\",\"menuType\":\"C\",\"orderNum\":13,\"params\":{},\"parentId\":0,\"path\":\"streamPush\",\"routeName\":\"streamPush\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-11 14:53:58',28),(170,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/streamPush/index\",\"createTime\":\"2025-04-11 14:53:58\",\"icon\":\"sunny\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"推流列表\",\"menuType\":\"C\",\"orderNum\":13,\"params\":{},\"parentId\":0,\"path\":\"streamPush\",\"perms\":\"\",\"routeName\":\"streamPush\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-11 14:54:06',13),(171,'onvif 设备',1,'com.ruoyi.web.controller.onvif.OnvifDeviceController.add()','POST',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createTime\":\"2025-04-11 18:06:19\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":7,\"ip\":\"192.168.158.62\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"球机\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"url\":\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-11 18:06:19',27),(172,'onvif 设备',3,'com.ruoyi.web.controller.onvif.OnvifDeviceController.remove()','DELETE',1,'admin','研发部门','/onvif/device/7','127.0.0.1','内网IP','[7]','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 08:57:40',23),(173,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-11 09:31:50\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":6,\"ip\":\"192.168.158.62\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"办公室大华\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-12 09:01:05\",\"url\":\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 09:01:05',25),(174,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"拉流列表\",\"menuType\":\"C\",\"orderNum\":13,\"params\":{},\"parentId\":0,\"path\":\"streamProxy\",\"routeName\":\"streamProxy\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 09:13:44',27),(175,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-11 09:31:50\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":6,\"ip\":\"192.168.158.62\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"办公室大华\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-12 09:13:46\",\"url\":\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 09:13:46',11),(176,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-12 09:13:44\",\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2008,\"menuName\":\"拉流列表\",\"menuType\":\"C\",\"orderNum\":12,\"params\":{},\"parentId\":0,\"path\":\"streamProxy\",\"perms\":\"\",\"routeName\":\"streamProxy\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 09:13:50',9),(177,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/streamProxy/index\",\"createTime\":\"2025-04-12 09:13:44\",\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2008,\"menuName\":\"拉流列表\",\"menuType\":\"C\",\"orderNum\":12,\"params\":{},\"parentId\":0,\"path\":\"streamProxy\",\"perms\":\"\",\"routeName\":\"streamProxy\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 09:13:57',8),(178,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-10 17:19:10\",\"firm\":\"HIKVISION\",\"firmwareVersion\":\"V5.8.3\",\"id\":5,\"ip\":\"192.168.212.189\",\"model\":\"DS-2DE3Q144MY-T/GLSE\",\"name\":\"haikang球机\",\"params\":{},\"streamUris\":\"{\\\"Stream_101\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\\\",\\\"Stream_102\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/102?transportmode=unicast&profile=Profile_102\\\",\\\"Stream_201\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/201?transportmode=unicast&profile=Profile_201\\\",\\\"Stream_202\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/202?transportmode=unicast&profile=Profile_202\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-12 09:14:49\",\"url\":\"rtsp://192.168.212.189:554/Streaming/Channels/201?transportmode=unicast&profile=Profile_201\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 09:14:49',8),(179,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-10 17:19:10\",\"firm\":\"HIKVISION\",\"firmwareVersion\":\"V5.8.3\",\"id\":5,\"ip\":\"192.168.212.189\",\"model\":\"DS-2DE3Q144MY-T/GLSE\",\"name\":\"haikang球机\",\"params\":{},\"streamUris\":\"{\\\"Stream_101\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\\\",\\\"Stream_102\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/102?transportmode=unicast&profile=Profile_102\\\",\\\"Stream_201\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/201?transportmode=unicast&profile=Profile_201\\\",\\\"Stream_202\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/202?transportmode=unicast&profile=Profile_202\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-12 09:18:54\",\"url\":\"rtsp://192.168.212.189:554/Streaming/Channels/202?transportmode=unicast&profile=Profile_202\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 09:18:55',7),(180,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-11 09:31:50\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":6,\"ip\":\"192.168.158.62\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"办公室大华\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-12 09:31:30\",\"url\":\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 09:31:30',11),(181,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-11 09:31:50\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":6,\"ip\":\"192.168.158.62\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"办公室大华\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-12 09:31:34\",\"url\":\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 09:31:34',14),(182,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-09 14:29:15\",\"icon\":\"onvif\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"onvif\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"onvif\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 10:22:44',29),(183,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"drag\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"行政分组\",\"menuType\":\"C\",\"orderNum\":11,\"params\":{},\"parentId\":0,\"path\":\"administrativeGrouping\",\"routeName\":\"administrativeGrouping\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 10:23:03',17),(184,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/administrativeGrouping/index\",\"createTime\":\"2025-04-12 10:23:03\",\"icon\":\"drag\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2009,\"menuName\":\"行政分组\",\"menuType\":\"C\",\"orderNum\":11,\"params\":{},\"parentId\":0,\"path\":\"administrativeGrouping\",\"perms\":\"\",\"routeName\":\"administrativeGrouping\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 10:23:11',7),(185,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"onvif/palyOnvif/daHuaPlay\",\"createBy\":\"admin\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuName\":\"大华播放\",\"menuType\":\"C\",\"orderNum\":20,\"params\":{},\"parentId\":2001,\"path\":\"daHuaPlay\",\"routeName\":\"daHuaPlay\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 14:15:37',24),(186,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-11 09:31:50\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":6,\"ip\":\"192.168.158.62\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"办公室大华\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-12 14:58:11\",\"url\":\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 14:58:13',27),(187,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-11 09:31:50\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":6,\"ip\":\"192.168.158.62\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"办公室大华\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-12 14:58:33\",\"url\":\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 14:58:35',15),(188,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-11 09:31:50\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":6,\"ip\":\"192.168.158.62\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"办公室大华\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-12 14:59:12\",\"url\":\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 14:59:14',20),(189,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-10 09:47:55\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":2,\"ip\":\"192.168.158.63\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"大华球机\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-12 14:59:23\",\"url\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 14:59:25',14),(190,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-10 09:47:55\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":2,\"ip\":\"192.168.158.63\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"大华球机\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-12 14:59:36\",\"url\":\"rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 14:59:38',12),(191,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-11 09:31:50\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":6,\"ip\":\"192.168.158.62\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"办公室大华\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-12 14:59:39\",\"url\":\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 14:59:41',14),(192,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-10 17:19:10\",\"firm\":\"HIKVISION\",\"firmwareVersion\":\"V5.8.3\",\"id\":5,\"ip\":\"192.168.212.189\",\"model\":\"DS-2DE3Q144MY-T/GLSE\",\"name\":\"haikang球机\",\"params\":{},\"streamUris\":\"{\\\"Stream_101\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\\\",\\\"Stream_102\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/102?transportmode=unicast&profile=Profile_102\\\",\\\"Stream_201\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/201?transportmode=unicast&profile=Profile_201\\\",\\\"Stream_202\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/202?transportmode=unicast&profile=Profile_202\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-12 16:40:33\",\"url\":\"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 16:40:35',25),(193,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-10 17:19:10\",\"firm\":\"HIKVISION\",\"firmwareVersion\":\"V5.8.3\",\"id\":5,\"ip\":\"192.168.158.189\",\"model\":\"DS-2DE3Q144MY-T/GLSE\",\"name\":\"haikang球机\",\"params\":{},\"streamUris\":\"{\\\"Stream_101\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\\\",\\\"Stream_102\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/102?transportmode=unicast&profile=Profile_102\\\",\\\"Stream_201\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/201?transportmode=unicast&profile=Profile_201\\\",\\\"Stream_202\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/202?transportmode=unicast&profile=Profile_202\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-12 16:44:11\",\"url\":\"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-12 16:44:13',8),(194,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"通道管理\",\"menuType\":\"C\",\"orderNum\":11,\"params\":{},\"parentId\":0,\"path\":\"thoroughfare\",\"routeName\":\"thoroughfare\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-14 08:56:18',34),(195,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-14 08:56:17\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2011,\"menuName\":\"通道管理\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"thoroughfare\",\"perms\":\"\",\"routeName\":\"thoroughfare\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-14 08:56:25',15),(196,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/thoroughfare/index\",\"createTime\":\"2025-04-14 08:56:17\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2011,\"menuName\":\"通道管理\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"thoroughfare\",\"perms\":\"\",\"routeName\":\"thoroughfare\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-14 08:56:43',25),(197,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"录像计划\",\"menuType\":\"C\",\"orderNum\":9,\"params\":{},\"parentId\":0,\"path\":\"recordPlan\",\"routeName\":\"recordPlan\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-14 11:02:38',38),(198,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/recordPlan/index\",\"createTime\":\"2025-04-14 11:02:38\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2012,\"menuName\":\"录像计划\",\"menuType\":\"C\",\"orderNum\":9,\"params\":{},\"parentId\":0,\"path\":\"recordPlan\",\"perms\":\"\",\"routeName\":\"recordPlan\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-14 11:02:47',15),(199,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/live/index\",\"createBy\":\"admin\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"分屏监控\",\"menuType\":\"C\",\"orderNum\":9,\"params\":{},\"parentId\":0,\"path\":\"wvpLive\",\"routeName\":\"wvpLive\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-14 11:03:37',23),(200,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/live/index\",\"createTime\":\"2025-04-14 11:03:37\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"分屏监控\",\"menuType\":\"C\",\"orderNum\":8,\"params\":{},\"parentId\":0,\"path\":\"wvpLive\",\"perms\":\"\",\"routeName\":\"wvpLive\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-14 11:03:50',10),(201,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-11 09:31:50\",\"firm\":\"Dahua\",\"firmwareVersion\":\"2.820.0000000.65.R, Build Date 2025-01-21\",\"id\":6,\"ip\":\"192.168.158.62\",\"model\":\"DH-IPC-HDP2230C-ST\",\"name\":\"办公室大华\",\"params\":{},\"streamUris\":\"{\\\"MediaProfile_Channel1_MainStream\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif\\\",\\\"MediaProfile_Channel1_SubStream1\\\":\\\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-14 11:41:52\",\"url\":\"rtsp://192.168.158.62:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-14 11:41:51',22),(202,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"国标级联\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"platformList\",\"routeName\":\"platformList\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 10:06:03',27),(203,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/platformList/index\",\"createTime\":\"2025-04-16 10:06:03\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2014,\"menuName\":\"国标级联\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"platformList\",\"perms\":\"\",\"routeName\":\"platformList\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 10:06:16',17),(204,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/platform/index\",\"createTime\":\"2025-04-16 10:06:03\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2014,\"menuName\":\"国标级联\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"platform\",\"perms\":\"\",\"routeName\":\"platform\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 10:06:25',16),(205,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"skill\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"国标管理\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"gbmanger\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 14:05:21',24),(206,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/device/index\",\"createTime\":\"2025-04-09 14:54:29\",\"icon\":\"drag\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"国标设备\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2015,\"path\":\"device\",\"perms\":\"\",\"routeName\":\"device\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 14:05:35',16),(207,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/cloudRecord/index\",\"createTime\":\"2025-04-11 11:31:09\",\"icon\":\"skill\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"云端录像\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2015,\"path\":\"cloudRecord\",\"perms\":\"\",\"routeName\":\"cloudRecord\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 14:05:48',15),(208,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/streamPush/index\",\"createTime\":\"2025-04-11 14:53:58\",\"icon\":\"sunny\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"推流列表\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2015,\"path\":\"streamPush\",\"perms\":\"\",\"routeName\":\"streamPush\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 14:06:03',15),(209,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/streamProxy/index\",\"createTime\":\"2025-04-12 09:13:44\",\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2008,\"menuName\":\"拉流列表\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2015,\"path\":\"streamProxy\",\"perms\":\"\",\"routeName\":\"streamProxy\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 14:06:10',13),(210,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/platform/index\",\"createTime\":\"2025-04-16 10:06:03\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2014,\"menuName\":\"国标级联\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2015,\"path\":\"platform\",\"perms\":\"\",\"routeName\":\"platform\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 14:06:27',12),(211,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/recordPlan/index\",\"createTime\":\"2025-04-14 11:02:38\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2012,\"menuName\":\"录像计划\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2015,\"path\":\"recordPlan\",\"perms\":\"\",\"routeName\":\"recordPlan\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 14:06:37',16),(212,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/thoroughfare/index\",\"createTime\":\"2025-04-14 08:56:17\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2011,\"menuName\":\"通道管理\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2015,\"path\":\"thoroughfare\",\"perms\":\"\",\"routeName\":\"thoroughfare\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 14:06:54',28),(213,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/administrativeGrouping/index\",\"createTime\":\"2025-04-12 10:23:03\",\"icon\":\"drag\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2009,\"menuName\":\"行政分组\",\"menuType\":\"C\",\"orderNum\":8,\"params\":{},\"parentId\":2015,\"path\":\"administrativeGrouping\",\"perms\":\"\",\"routeName\":\"administrativeGrouping\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 14:07:06',12),(214,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/thoroughfare/index\",\"createTime\":\"2025-04-14 08:56:17\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2011,\"menuName\":\"通道管理\",\"menuType\":\"C\",\"orderNum\":8,\"params\":{},\"parentId\":2015,\"path\":\"thoroughfare\",\"perms\":\"\",\"routeName\":\"thoroughfare\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 14:07:10',15),(215,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/administrativeGrouping/index\",\"createTime\":\"2025-04-12 10:23:03\",\"icon\":\"drag\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2009,\"menuName\":\"行政分组\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2015,\"path\":\"administrativeGrouping\",\"perms\":\"\",\"routeName\":\"administrativeGrouping\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 14:07:14',23),(216,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/mediaServer/index\",\"createTime\":\"2025-04-03 09:08:16\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"节点管理\",\"menuType\":\"C\",\"orderNum\":9,\"params\":{},\"parentId\":2015,\"path\":\"node\",\"perms\":\"\",\"routeName\":\"node\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 14:07:24',15),(217,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/live/index\",\"createTime\":\"2025-04-14 11:03:37\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"分屏监控\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":2015,\"path\":\"wvpLive\",\"perms\":\"\",\"routeName\":\"wvpLive\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 14:07:31',13),(218,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/streamProxy/index\",\"createTime\":\"2025-04-12 09:13:44\",\"icon\":\"server\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2008,\"menuName\":\"拉流列表\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2015,\"path\":\"streamProxy\",\"perms\":\"\",\"routeName\":\"streamProxy\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 14:16:54',28),(219,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"onvif/palyOnvif/daHuaPlay\",\"createTime\":\"2025-04-12 14:15:37\",\"icon\":\"#\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"大华播放\",\"menuType\":\"C\",\"orderNum\":20,\"params\":{},\"parentId\":2001,\"path\":\"daHuaPlay\",\"perms\":\"\",\"routeName\":\"daHuaPlay\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-16 16:06:12',25),(220,'参数管理',2,'com.ruoyi.web.controller.system.SysConfigController.edit()','PUT',1,'admin','研发部门','/system/config','127.0.0.1','内网IP','{\"configId\":4,\"configKey\":\"sys.account.captchaEnabled\",\"configName\":\"账号自助-验证码开关\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 09:03:39\",\"params\":{},\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"updateBy\":\"admin\",\"updateTime\":\"2025-04-09 14:28:40\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-17 09:24:24',345),(221,'onvif 设备',1,'com.ruoyi.web.controller.onvif.OnvifDeviceController.add()','POST',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createTime\":\"2025-04-17 14:25:41\",\"firm\":\"UNIVIEW\",\"firmwareVersion\":\"IPC_Q1201-B5022P30D1711C31\",\"id\":7,\"ip\":\"192.168.158.200\",\"model\":\"IPC-S360\",\"name\":\"球机\",\"params\":{},\"streamUris\":\"{\\\"media_profile2\\\":\\\"rtsp://192.168.158.200/media/video2\\\",\\\"media_profile3\\\":\\\"rtsp://192.168.158.200/media/video3\\\",\\\"media_profile1\\\":\\\"rtsp://192.168.158.200/media/video1\\\"}\",\"url\":\"rtsp://192.168.158.200/media/video2\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-17 14:25:41',70),(222,'onvif 设备',2,'com.ruoyi.web.controller.onvif.OnvifDeviceController.edit()','PUT',1,'admin','研发部门','/onvif/device','127.0.0.1','内网IP','{\"createBy\":\"\",\"createTime\":\"2025-04-10 17:19:10\",\"firm\":\"HIKVISION\",\"firmwareVersion\":\"V5.8.3\",\"id\":5,\"ip\":\"192.168.158.189\",\"model\":\"DS-2DE3Q144MY-T/GLSE\",\"name\":\"haikang球机\",\"params\":{},\"streamUris\":\"{\\\"Stream_101\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_101\\\",\\\"Stream_102\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/102?transportmode=unicast&profile=Profile_102\\\",\\\"Stream_201\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/201?transportmode=unicast&profile=Profile_201\\\",\\\"Stream_202\\\":\\\"rtsp://192.168.212.189:554/Streaming/Channels/202?transportmode=unicast&profile=Profile_202\\\"}\",\"updateBy\":\"\",\"updateTime\":\"2025-04-17 14:37:08\",\"url\":\"rtsp://192.168.212.189:554/Streaming/Channels/102?transportmode=unicast&profile=Profile_102\",\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-17 14:37:08',14),(223,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/device/index\",\"createTime\":\"2025-04-09 14:54:29\",\"icon\":\"drag\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"国标设备\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2015,\"path\":\"device\",\"perms\":\"wvp:device:list\",\"routeName\":\"device\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:00:20',22),(224,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"删除设备\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:device:remove\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:01:18',15),(225,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"同步设备\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:device:sync\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:02:25',12),(226,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"查询设备\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:device:query\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:03:19',14),(227,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"开启/关闭目录订阅\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:device:subscribeCatalog\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:04:43',19),(228,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"开启/关闭移动位置订阅\",\"menuType\":\"F\",\"orderNum\":5,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:device:subscribeMobilePosition\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:05:22',18),(229,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"同步进度查询\",\"menuType\":\"F\",\"orderNum\":6,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:device:syncStatus\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:06:14',17),(230,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"更新设备信息\",\"menuType\":\"F\",\"orderNum\":7,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:device:edit\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:06:43',16),(231,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"修改数据流传输模式\",\"menuType\":\"F\",\"orderNum\":8,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:device:updateTransport\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:07:31',12),(232,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"获取平台配置信息\",\"menuType\":\"F\",\"orderNum\":9,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:server:configInfo\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:09:20',9),(233,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"获取流媒体服务列表\",\"menuType\":\"F\",\"orderNum\":10,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:server:listOnline\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:10:12',13),(234,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"报警布防/撤防命令\",\"menuType\":\"F\",\"orderNum\":11,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:control:guardApi\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:12:18',12),(235,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"设备配置查询\",\"menuType\":\"F\",\"orderNum\":12,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:config:cdownloadApi\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:13:55',7),(236,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-04-03 09:03:39\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2001,2002,2004,2005,2010,2015,2003,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2006,2007,2008,2014,2012,2009,2011,2000,2013,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:27:12',40),(237,'用户管理',2,'com.ruoyi.web.controller.system.SysUserController.resetPwd()','PUT',1,'admin','研发部门','/system/user/resetPwd','127.0.0.1','内网IP','{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":2}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:27:20',82),(238,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-04-03 09:03:39\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[2015,2001,2002,2004,2005,2010,2003,2006,2007,2008,2014,2012,2009,2011,2000,2013,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:28:38',21),(239,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2021','127.0.0.1','内网IP','2021','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 09:31:01',20),(240,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"通道列表\",\"menuType\":\"F\",\"orderNum\":13,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:device:channels\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:29:46',34),(241,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-04-03 09:03:39\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2001,2002,2004,2005,2010,2015,2003,2016,2017,2018,2019,2020,2022,2023,2024,2025,2026,2027,2028,2006,2007,2008,2014,2012,2009,2011,2000,2013,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:30:14',36),(242,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"修改通道码流\",\"menuType\":\"F\",\"orderNum\":14,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:device:channelStreamIdentification\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:32:27',15),(243,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"播放视频\",\"menuType\":\"F\",\"orderNum\":15,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:play:start\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:39:05',14),(244,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"停止播放\",\"menuType\":\"F\",\"orderNum\":16,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:play:stop\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:40:21',15),(245,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"查询通道\",\"menuType\":\"F\",\"orderNum\":17,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:channel:query\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:42:04',14),(246,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"修改通道\",\"menuType\":\"F\",\"orderNum\":18,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:channel:edit\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:43:00',14),(247,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"录像控制命令\",\"menuType\":\"F\",\"orderNum\":19,\"params\":{},\"parentId\":2003,\"perms\":\"wvp:control:recordApi\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:46:15',18),(248,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-04-03 09:03:39\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2001,2002,2004,2005,2010,2015,2003,2016,2017,2018,2019,2020,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2006,2007,2008,2014,2012,2009,2011,2000,2013,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:47:00',18),(249,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/cloudRecord/index\",\"createTime\":\"2025-04-11 11:31:09\",\"icon\":\"skill\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"云端录像\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2015,\"path\":\"cloudRecord\",\"perms\":\"wvp:record:list\",\"routeName\":\"cloudRecord\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:53:12',14),(250,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"播放\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"perms\":\"wvp:record:play\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:54:11',11),(251,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"下载\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2006,\"perms\":\"wvp:record:download\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:55:06',12),(252,'部门管理',2,'com.ruoyi.web.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"ry-wvp\",\"email\":\"ry@qq.com\",\"leader\":\"ry-wvp\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:55:37',26),(253,'部门管理',2,'com.ruoyi.web.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"ry-wvp\",\"email\":\"ry-wvp@qq.com\",\"leader\":\"ry-wvp\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:55:40',21),(254,'部门管理',3,'com.ruoyi.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/102','127.0.0.1','内网IP','102','{\"msg\":\"存在下级部门,不允许删除\",\"code\":601}',0,NULL,'2025-04-18 10:55:46',46),(255,'部门管理',3,'com.ruoyi.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/109','127.0.0.1','内网IP','109','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:55:48',19),(256,'部门管理',3,'com.ruoyi.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/108','127.0.0.1','内网IP','108','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:55:49',16),(257,'部门管理',3,'com.ruoyi.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/102','127.0.0.1','内网IP','102','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:55:51',17),(258,'部门管理',3,'com.ruoyi.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/107','127.0.0.1','内网IP','107','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:55:53',18),(259,'部门管理',3,'com.ruoyi.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/106','127.0.0.1','内网IP','106','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:55:55',48),(260,'部门管理',3,'com.ruoyi.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/105','127.0.0.1','内网IP','105','{\"msg\":\"部门存在用户,不允许删除\",\"code\":601}',0,NULL,'2025-04-18 10:55:57',75),(261,'部门管理',3,'com.ruoyi.web.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/104','127.0.0.1','内网IP','104','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:55:59',16),(262,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-18 10:55:06\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2036,\"menuName\":\"下载\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2006,\"path\":\"\",\"perms\":\"wvp:record:download\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:56:03',18),(263,'部门管理',2,'com.ruoyi.web.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"广州总公司\",\"email\":\"ry-wvp@qq.com\",\"leader\":\"ry-wvp\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"ry-wvp\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:56:23',37),(264,'用户管理',1,'com.ruoyi.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"deptId\":100,\"nickName\":\"ry-wvp\",\"params\":{},\"postIds\":[4],\"roleIds\":[2],\"sex\":\"2\",\"status\":\"0\",\"userId\":3,\"userName\":\"ry-wvp\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:57:08',151),(265,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/streamPush/index\",\"createTime\":\"2025-04-11 14:53:58\",\"icon\":\"sunny\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"推流列表\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2015,\"path\":\"streamPush\",\"perms\":\"wvp:push:list\",\"routeName\":\"streamPush\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:58:01',11),(266,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"新增\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2007,\"perms\":\"wvp:push:add\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:58:59',14),(267,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"wvp:push:edit\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2007,\"perms\":\"修改\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:59:31',9),(268,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-18 10:59:31\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2038,\"menuName\":\"修改\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2007,\"path\":\"\",\"perms\":\"wvp:push:edit\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 10:59:37',16),(269,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"删除\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2007,\"perms\":\"wvp:push:remove\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:00:31',17),(270,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"播放\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2007,\"perms\":\"wvp:push:play\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:01:41',12),(271,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/streamProxy/index\",\"createTime\":\"2025-04-12 09:13:44\",\"icon\":\"server\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2008,\"menuName\":\"拉流列表\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2015,\"path\":\"streamProxy\",\"perms\":\"wvp:proxy:list\",\"routeName\":\"streamProxy\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:04:20',12),(272,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"删除\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2008,\"perms\":\"wvp:proxy:delete\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:05:18',13),(273,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"新增\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2008,\"perms\":\"wvp:proxy:add\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:08:59',11),(274,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"修改\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2008,\"perms\":\"wvp:proxy:edit\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:09:18',7),(275,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"播放\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2008,\"perms\":\"wvp:proxy:play\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:09:37',11),(276,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"停止\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2008,\"perms\":\"wvp:proxy:stop\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:09:51',14),(277,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/platform/index\",\"createTime\":\"2025-04-16 10:06:03\",\"icon\":\"date-range\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2014,\"menuName\":\"国标级联\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2015,\"path\":\"platform\",\"perms\":\"wvp:platform:list\",\"routeName\":\"platform\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:11:47',14),(278,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"新增\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2014,\"perms\":\"wvp:platform:add\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:12:54',16),(279,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"编辑\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2014,\"perms\":\"wvp:platform:edit\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:13:06',13),(280,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"删除\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2014,\"perms\":\"wvp:platform:delete\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:13:22',12),(281,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"onvif/cameraManage/index\",\"createTime\":\"2025-04-09 17:31:15\",\"icon\":\"cameraManage\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"摄像头管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2001,\"path\":\"cameraManage\",\"perms\":\"onvif:device:list\",\"routeName\":\"cameraManage\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:13:56',19),(282,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"导出\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2004,\"perms\":\"onvif:device:export\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:14:12',18),(283,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"新增\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2004,\"perms\":\"onvif:device:add\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:14:27',15),(284,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"修改\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2004,\"perms\":\"onvif:device:edit\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:14:44',14),(285,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"获取详情\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2051,\"perms\":\"onvif:device:query\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:15:02',9),(286,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"推送通道\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2014,\"perms\":\"wvp:platform:push\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:15:03',18),(287,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"播放\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2004,\"perms\":\"onvif:device:play\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:16:28',13),(288,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"通道共享\",\"menuType\":\"F\",\"orderNum\":5,\"params\":{},\"parentId\":2014,\"perms\":\"wvp:platform:channelList\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:17:23',12),(289,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"onvif/addCamera/index\",\"createTime\":\"2025-04-09 14:37:45\",\"icon\":\"addCamera\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"添加摄像头\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2001,\"path\":\"addCamera\",\"perms\":\"onvif:device:add\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:18:24',15),(290,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2050','127.0.0.1','内网IP','2050','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:18:27',63),(291,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"探测\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2002,\"perms\":\"onvif:service:getInfo\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:18:44',15),(292,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"新增设备\",\"menuType\":\"F\",\"orderNum\":6,\"params\":{},\"parentId\":2014,\"perms\":\"wvp:platform:channelAdd\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:18:47',14),(293,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"删除设备\",\"menuType\":\"F\",\"orderNum\":7,\"params\":{},\"parentId\":2014,\"perms\":\"wvp:platform:channelRemove\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:19:22',15),(294,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-04-03 09:03:39\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2001,2002,2056,2004,2049,2051,2052,2054,2015,2003,2016,2017,2018,2019,2020,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2006,2007,2008,2014,2012,2009,2011,2000,2013,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:20:04',32),(295,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"删除\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2004,\"perms\":\"onvif:device:remove\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:21:58',12),(296,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/recordPlan/index\",\"createTime\":\"2025-04-14 11:02:38\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2012,\"menuName\":\"录像计划\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2015,\"path\":\"recordPlan\",\"perms\":\"wvp:record:list\",\"routeName\":\"recordPlan\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:22:40',9),(297,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"新塘\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2012,\"perms\":\"wvp:record:add\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:23:48',15),(298,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"修改\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2012,\"perms\":\"wvp:record:edit\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:24:02',6),(299,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"删除\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2012,\"perms\":\"wvp:record:delete\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:24:16',13),(300,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"关联通道\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2012,\"perms\":\"wvp:record:channelList\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:27:26',12),(301,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"新增通道关联\",\"menuType\":\"F\",\"orderNum\":5,\"params\":{},\"parentId\":2012,\"perms\":\"wvp:record:add\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:29:23',14),(302,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"删除通道关联\",\"menuType\":\"F\",\"orderNum\":6,\"params\":{},\"parentId\":2012,\"perms\":\"wvp:record:delete\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:29:48',13),(303,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-18 11:29:23\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2064,\"menuName\":\"新增通道关联\",\"menuType\":\"F\",\"orderNum\":5,\"params\":{},\"parentId\":2012,\"path\":\"\",\"perms\":\"wvp:record:channelAdd\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:30:41',14),(304,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-18 11:29:48\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2065,\"menuName\":\"删除通道关联\",\"menuType\":\"F\",\"orderNum\":6,\"params\":{},\"parentId\":2012,\"path\":\"\",\"perms\":\"wvp:record:channelDelete\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:30:46',21),(305,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/administrativeGrouping/index\",\"createTime\":\"2025-04-12 10:23:03\",\"icon\":\"drag\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2009,\"menuName\":\"行政分组\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":2015,\"path\":\"administrativeGrouping\",\"perms\":\"wvp:administrativeGrouping:list\",\"routeName\":\"administrativeGrouping\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:32:35',12),(306,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"查询区域\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2009,\"perms\":\"wvp:region:list\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:33:20',15),(307,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"修改\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2009,\"perms\":\"wvp:region:edit\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:34:27',12),(308,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"新增\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2009,\"perms\":\"wvp:region:add\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:34:43',13),(309,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"删除\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2009,\"perms\":\"wvp:region:delete\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:34:54',17),(310,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"查询分组\",\"menuType\":\"F\",\"orderNum\":5,\"params\":{},\"parentId\":2009,\"perms\":\"wvp:group:list\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:37:06',7),(311,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"新增分组\",\"menuType\":\"F\",\"orderNum\":6,\"params\":{},\"parentId\":2009,\"perms\":\"wvp:group:add\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:37:55',8),(312,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"修改分组\",\"menuType\":\"F\",\"orderNum\":7,\"params\":{},\"parentId\":2009,\"perms\":\"wvp:group:edit\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:38:10',7),(313,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"删除分组\",\"menuType\":\"F\",\"orderNum\":8,\"params\":{},\"parentId\":2009,\"perms\":\"wvp:group:delete\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:38:22',12),(314,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-18 11:34:27\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2067,\"menuName\":\"修改区域\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2009,\"path\":\"\",\"perms\":\"wvp:region:edit\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:38:28',11),(315,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-18 11:34:43\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2068,\"menuName\":\"新增区域\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2009,\"path\":\"\",\"perms\":\"wvp:region:add\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:38:31',13),(316,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-18 11:34:54\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2069,\"menuName\":\"删除区域\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2009,\"path\":\"\",\"perms\":\"wvp:region:delete\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:38:34',14),(317,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/thoroughfare/index\",\"createTime\":\"2025-04-14 08:56:17\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2011,\"menuName\":\"通道管理\",\"menuType\":\"C\",\"orderNum\":8,\"params\":{},\"parentId\":2015,\"path\":\"thoroughfare\",\"perms\":\"wvp:thoroughfare:list\",\"routeName\":\"thoroughfare\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:40:27',14),(318,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"区域通道列表\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2011,\"perms\":\"wvp:channel:civilcodeList\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:41:44',173),(319,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-18 11:41:43\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"区域通道列表\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2011,\"path\":\"\",\"perms\":\"wvp:channel:regionCivilcodeList\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:42:28',14),(320,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"删除通道\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2011,\"perms\":\"wvp:channel:deleteChannel\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:44:51',6),(321,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"新增通道\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2011,\"perms\":\"wvp:channel:addChannel\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:45:39',7),(322,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-18 11:41:43\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2074,\"menuName\":\"通道列表\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2011,\"path\":\"\",\"perms\":\"wvp:channel:civilcodeList\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:46:46',11),(323,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-18 11:44:51\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2075,\"menuName\":\"删除区域通道\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2011,\"path\":\"\",\"perms\":\"wvp:channel:deleteChannel\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:48:35',14),(324,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-18 11:45:39\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2076,\"menuName\":\"新增区域通道\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2011,\"path\":\"\",\"perms\":\"wvp:channel:addChannel\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:48:42',14),(325,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"新增分组通道\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2011,\"perms\":\"wvp:channel:addGroupChannel\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:49:09',15),(326,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"删除分组通道\",\"menuType\":\"F\",\"orderNum\":5,\"params\":{},\"parentId\":2011,\"perms\":\"wvp:channel:deleteGroupChannel\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:49:26',8),(327,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-18 11:45:39\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2076,\"menuName\":\"新增区域通道\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2011,\"path\":\"\",\"perms\":\"wvp:channel:addRegionChannel\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:49:49',15),(328,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2025-04-18 11:44:51\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2075,\"menuName\":\"删除区域通道\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2011,\"path\":\"\",\"perms\":\"wvp:channel:deleteRegionChannel\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:49:55',13),(329,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-04-03 09:03:39\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2001,2002,2056,2004,2049,2059,2051,2052,2054,2005,2010,2015,2003,2016,2017,2018,2019,2020,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2006,2035,2036,2007,2037,2038,2039,2040,2008,2041,2042,2043,2044,2045,2014,2046,2047,2048,2053,2055,2057,2058,2012,2060,2061,2062,2063,2064,2065,2009,2066,2067,2068,2069,2070,2071,2072,2073,2011,2074,2075,2076,2077,2078,2000,2013,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:52:24',323),(330,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/mediaServer/index\",\"createTime\":\"2025-04-03 09:08:16\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"节点管理\",\"menuType\":\"C\",\"orderNum\":9,\"params\":{},\"parentId\":2015,\"path\":\"node\",\"perms\":\"wvp:server:list\",\"routeName\":\"node\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:58:06',25),(331,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"查看\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"perms\":\"wvp:wvpMediaServer:view\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 11:58:39',21),(332,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"wvp/live/index\",\"createTime\":\"2025-04-14 11:03:37\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"分屏监控\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":2015,\"path\":\"wvpLive\",\"perms\":\"wvp:live:list\",\"routeName\":\"wvpLive\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 12:00:58',24),(333,'用户管理',2,'com.ruoyi.web.controller.system.SysUserController.resetPwd()','PUT',1,'admin','研发部门','/system/user/resetPwd','127.0.0.1','内网IP','{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":2}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 14:07:44',86),(334,'用户管理',2,'com.ruoyi.web.controller.system.SysUserController.resetPwd()','PUT',1,'admin','研发部门','/system/user/resetPwd','14.19.37.18','XX XX','{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":2}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-04-18 07:27:34',105);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) COLLATE utf8_bin NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2025-04-03 09:03:39','',NULL,''),(2,'se','项目经理',2,'0','admin','2025-04-03 09:03:39','',NULL,''),(3,'hr','人力资源',3,'0','admin','2025-04-03 09:03:39','',NULL,''),(4,'user','普通员工',4,'0','admin','2025-04-03 09:03:39','',NULL,'');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) COLLATE utf8_bin NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2025-04-03 09:03:39','',NULL,'超级管理员'),(2,'普通角色','common',2,'2',1,1,'0','0','admin','2025-04-03 09:03:39','admin','2025-04-18 11:52:24','普通角色');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` VALUES (2,100),(2,101),(2,105);
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (2,1),(2,2),(2,3),(2,100),(2,101),(2,102),(2,103),(2,104),(2,105),(2,106),(2,107),(2,108),(2,109),(2,110),(2,111),(2,112),(2,113),(2,114),(2,115),(2,116),(2,117),(2,500),(2,501),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),(2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),(2,1013),(2,1014),(2,1015),(2,1016),(2,1017),(2,1018),(2,1019),(2,1020),(2,1021),(2,1022),(2,1023),(2,1024),(2,1025),(2,1026),(2,1027),(2,1028),(2,1029),(2,1030),(2,1031),(2,1032),(2,1033),(2,1034),(2,1035),(2,1036),(2,1037),(2,1038),(2,1039),(2,1040),(2,1041),(2,1042),(2,1043),(2,1044),(2,1045),(2,1046),(2,1047),(2,1048),(2,1049),(2,1050),(2,1051),(2,1052),(2,1053),(2,1054),(2,1055),(2,1056),(2,1057),(2,1058),(2,1059),(2,1060),(2,2000),(2,2001),(2,2002),(2,2003),(2,2004),(2,2005),(2,2006),(2,2007),(2,2008),(2,2009),(2,2010),(2,2011),(2,2012),(2,2013),(2,2014),(2,2015),(2,2016),(2,2017),(2,2018),(2,2019),(2,2020),(2,2022),(2,2023),(2,2024),(2,2025),(2,2026),(2,2027),(2,2028),(2,2029),(2,2030),(2,2031),(2,2032),(2,2033),(2,2034),(2,2035),(2,2036),(2,2037),(2,2038),(2,2039),(2,2040),(2,2041),(2,2042),(2,2043),(2,2044),(2,2045),(2,2046),(2,2047),(2,2048),(2,2049),(2,2051),(2,2052),(2,2053),(2,2054),(2,2055),(2,2056),(2,2057),(2,2058),(2,2059),(2,2060),(2,2061),(2,2062),(2,2063),(2,2064),(2,2065),(2,2066),(2,2067),(2,2068),(2,2069),(2,2070),(2,2071),(2,2072),(2,2073),(2,2074),(2,2075),(2,2076),(2,2077),(2,2078);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) COLLATE utf8_bin DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) COLLATE utf8_bin DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) COLLATE utf8_bin DEFAULT '' COMMENT '手机号码',
  `sex` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) COLLATE utf8_bin DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) COLLATE utf8_bin DEFAULT '' COMMENT '密码',
  `status` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) COLLATE utf8_bin DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `push_key` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','若依','00','ry@163.com','15888888888','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','14.19.63.87','2025-04-19 09:02:09','3e80d1762a324d5b0ff636e0bd16f1e3','admin','2025-04-03 09:03:39','','2025-04-19 01:02:08','管理员'),(2,105,'ry','若依','00','ry@qq.com','15666666666','1','','$2a$10$fVU9rE/8SmZAnCy.XfpekuaCzl8OPBt3qDyBeHgtnZww1vtwCDDou','0','0','14.19.63.87','2025-04-19 08:56:07',NULL,'admin','2025-04-03 09:03:39','admin','2025-04-19 00:56:07','测试员'),(3,100,'ry-wvp','ry-wvp','00','','','2','','$2a$10$eNWt0Hk7xN/TssYt2fiNJOMOdRniky7I786vFes5Z7ny1NJM6sPri','0','0','127.0.0.1','2025-04-18 11:20:20',NULL,'admin','2025-04-18 10:57:08','','2025-04-18 11:20:20',NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1),(2,2),(3,4);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,2),(3,2);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_cloud_record`
--

DROP TABLE IF EXISTS `wvp_cloud_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_cloud_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `stream` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `call_id` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `start_time` bigint(20) DEFAULT NULL,
  `end_time` bigint(20) DEFAULT NULL,
  `media_server_id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `file_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `folder` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `file_path` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `collect` tinyint(1) DEFAULT '0',
  `file_size` bigint(20) DEFAULT NULL,
  `time_len` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_cloud_record`
--

LOCK TABLES `wvp_cloud_record` WRITE;
/*!40000 ALTER TABLE `wvp_cloud_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `wvp_cloud_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_common_group`
--

DROP TABLE IF EXISTS `wvp_common_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_common_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` varchar(50) COLLATE utf8_bin NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `parent_device_id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `business_group` varchar(50) COLLATE utf8_bin NOT NULL,
  `create_time` varchar(50) COLLATE utf8_bin NOT NULL,
  `update_time` varchar(50) COLLATE utf8_bin NOT NULL,
  `civil_code` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  UNIQUE KEY `uk_common_group_device_platform` (`device_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_common_group`
--

LOCK TABLES `wvp_common_group` WRITE;
/*!40000 ALTER TABLE `wvp_common_group` DISABLE KEYS */;
INSERT INTO `wvp_common_group` VALUES (4,'11010101002157000001','测试',NULL,NULL,'11010101002157000001','2025-04-18 11:26:34','2025-04-18 11:26:34','44011801');
/*!40000 ALTER TABLE `wvp_common_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_common_region`
--

DROP TABLE IF EXISTS `wvp_common_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_common_region` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` varchar(50) COLLATE utf8_bin NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `parent_device_id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `create_time` varchar(50) COLLATE utf8_bin NOT NULL,
  `update_time` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  UNIQUE KEY `uk_common_region_device_id` (`device_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_common_region`
--

LOCK TABLES `wvp_common_region` WRITE;
/*!40000 ALTER TABLE `wvp_common_region` DISABLE KEYS */;
INSERT INTO `wvp_common_region` VALUES (6,'44011801','测试门口',NULL,NULL,'2025-04-18 11:23:40','2025-04-18 11:23:40');
/*!40000 ALTER TABLE `wvp_common_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_device`
--

DROP TABLE IF EXISTS `wvp_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_device` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` varchar(50) COLLATE utf8_bin NOT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `manufacturer` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `model` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `firmware` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `transport` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `stream_mode` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `on_line` tinyint(1) DEFAULT '0',
  `register_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `keepalive_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `ip` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `create_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `update_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `expires` int(11) DEFAULT NULL,
  `subscribe_cycle_for_catalog` int(11) DEFAULT '0',
  `subscribe_cycle_for_mobile_position` int(11) DEFAULT '0',
  `mobile_position_submission_interval` int(11) DEFAULT '5',
  `subscribe_cycle_for_alarm` int(11) DEFAULT '0',
  `host_address` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `charset` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `ssrc_check` tinyint(1) DEFAULT '0',
  `geo_coord_sys` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `media_server_id` varchar(50) COLLATE utf8_bin DEFAULT 'auto',
  `custom_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `sdp_ip` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `local_ip` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `as_message_channel` tinyint(1) DEFAULT '0',
  `heart_beat_interval` int(11) DEFAULT NULL,
  `heart_beat_count` int(11) DEFAULT NULL,
  `position_capability` int(11) DEFAULT NULL,
  `broadcast_push_after_ack` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  UNIQUE KEY `uk_device_device` (`device_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_device`
--

LOCK TABLES `wvp_device` WRITE;
/*!40000 ALTER TABLE `wvp_device` DISABLE KEYS */;
INSERT INTO `wvp_device` VALUES (17,'34020000001320000001',NULL,'Hikvision','DS-2CD2110FDV2-IS','V5.5.92','UDP','UDP',1,'2025-04-19 00:56:02','2025-04-19 01:03:53','14.19.51.244','2025-04-18 10:25:34','2025-04-19 01:03:53',56138,3600,0,0,5,0,'14.19.51.244:56138','GB2312',0,'WGS84','auto',NULL,NULL,'0.0.0.0',NULL,0,60,3,0,0);
/*!40000 ALTER TABLE `wvp_device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_device_alarm`
--

DROP TABLE IF EXISTS `wvp_device_alarm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_device_alarm` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` varchar(50) COLLATE utf8_bin NOT NULL,
  `channel_id` varchar(50) COLLATE utf8_bin NOT NULL,
  `alarm_priority` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `alarm_method` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `alarm_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `alarm_description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `alarm_type` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `create_time` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_device_alarm`
--

LOCK TABLES `wvp_device_alarm` WRITE;
/*!40000 ALTER TABLE `wvp_device_alarm` DISABLE KEYS */;
/*!40000 ALTER TABLE `wvp_device_alarm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_device_channel`
--

DROP TABLE IF EXISTS `wvp_device_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_device_channel` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `manufacturer` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `model` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `owner` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `civil_code` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `block` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `address` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `parental` int(11) DEFAULT NULL,
  `parent_id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `safety_way` int(11) DEFAULT NULL,
  `register_way` int(11) DEFAULT NULL,
  `cert_num` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `certifiable` int(11) DEFAULT NULL,
  `err_code` int(11) DEFAULT NULL,
  `end_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `secrecy` int(11) DEFAULT NULL,
  `ip_address` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `status` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `ptz_type` int(11) DEFAULT NULL,
  `position_type` int(11) DEFAULT NULL,
  `room_type` int(11) DEFAULT NULL,
  `use_type` int(11) DEFAULT NULL,
  `supply_light_type` int(11) DEFAULT NULL,
  `direction_type` int(11) DEFAULT NULL,
  `resolution` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `business_group_id` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `download_speed` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `svc_space_support_mod` int(11) DEFAULT NULL,
  `svc_time_support_mode` int(11) DEFAULT NULL,
  `create_time` varchar(50) COLLATE utf8_bin NOT NULL,
  `update_time` varchar(50) COLLATE utf8_bin NOT NULL,
  `sub_count` int(11) DEFAULT NULL,
  `stream_id` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `has_audio` tinyint(1) DEFAULT '0',
  `gps_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `stream_identification` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `channel_type` int(11) NOT NULL DEFAULT '0',
  `gb_device_id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `gb_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `gb_manufacturer` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `gb_model` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `gb_owner` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `gb_civil_code` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `gb_block` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `gb_address` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `gb_parental` int(11) DEFAULT NULL,
  `gb_parent_id` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `gb_safety_way` int(11) DEFAULT NULL,
  `gb_register_way` int(11) DEFAULT NULL,
  `gb_cert_num` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `gb_certifiable` int(11) DEFAULT NULL,
  `gb_err_code` int(11) DEFAULT NULL,
  `gb_end_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `gb_secrecy` int(11) DEFAULT NULL,
  `gb_ip_address` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `gb_port` int(11) DEFAULT NULL,
  `gb_password` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `gb_status` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `gb_longitude` double DEFAULT NULL,
  `gb_latitude` double DEFAULT NULL,
  `gb_business_group_id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `gb_ptz_type` int(11) DEFAULT NULL,
  `gb_position_type` int(11) DEFAULT NULL,
  `gb_room_type` int(11) DEFAULT NULL,
  `gb_use_type` int(11) DEFAULT NULL,
  `gb_supply_light_type` int(11) DEFAULT NULL,
  `gb_direction_type` int(11) DEFAULT NULL,
  `gb_resolution` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `gb_download_speed` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `gb_svc_space_support_mod` int(11) DEFAULT NULL,
  `gb_svc_time_support_mode` int(11) DEFAULT NULL,
  `record_plan_id` int(11) DEFAULT NULL,
  `data_type` int(11) NOT NULL,
  `data_device_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  UNIQUE KEY `uk_wvp_unique_channel` (`gb_device_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_device_channel`
--

LOCK TABLES `wvp_device_channel` WRITE;
/*!40000 ALTER TABLE `wvp_device_channel` DISABLE KEYS */;
INSERT INTO `wvp_device_channel` VALUES (29,'34020000001320000001','Camera 01','Hikvision','IP Camera','Owner',NULL,NULL,'Address',0,NULL,0,1,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'ON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-04-18 10:25:36','2025-04-18 11:25:48',0,NULL,0,NULL,NULL,0,'34020000001320000001','Camera 01','Hikvision','IP Camera','Owner','44011801',NULL,'Address',0,'11010101002157000001',0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ON',NULL,NULL,'11010101002157000001',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,1,17);
/*!40000 ALTER TABLE `wvp_device_channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_device_mobile_position`
--

DROP TABLE IF EXISTS `wvp_device_mobile_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_device_mobile_position` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` varchar(50) COLLATE utf8_bin NOT NULL,
  `channel_id` varchar(50) COLLATE utf8_bin NOT NULL,
  `device_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `altitude` double DEFAULT NULL,
  `speed` double DEFAULT NULL,
  `direction` double DEFAULT NULL,
  `report_source` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `create_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_device_mobile_position`
--

LOCK TABLES `wvp_device_mobile_position` WRITE;
/*!40000 ALTER TABLE `wvp_device_mobile_position` DISABLE KEYS */;
/*!40000 ALTER TABLE `wvp_device_mobile_position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_media_server`
--

DROP TABLE IF EXISTS `wvp_media_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_media_server` (
  `id` varchar(255) COLLATE utf8_bin NOT NULL,
  `ip` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `hook_ip` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `sdp_ip` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `stream_ip` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `http_port` int(11) DEFAULT NULL,
  `http_ssl_port` int(11) DEFAULT NULL,
  `rtmp_port` int(11) DEFAULT NULL,
  `rtmp_ssl_port` int(11) DEFAULT NULL,
  `rtp_proxy_port` int(11) DEFAULT NULL,
  `rtsp_port` int(11) DEFAULT NULL,
  `rtsp_ssl_port` int(11) DEFAULT NULL,
  `flv_port` int(11) DEFAULT NULL,
  `flv_ssl_port` int(11) DEFAULT NULL,
  `ws_flv_port` int(11) DEFAULT NULL,
  `ws_flv_ssl_port` int(11) DEFAULT NULL,
  `auto_config` tinyint(1) DEFAULT '0',
  `secret` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `type` varchar(50) COLLATE utf8_bin DEFAULT 'zlm',
  `rtp_enable` tinyint(1) DEFAULT '0',
  `rtp_port_range` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `send_rtp_port_range` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `record_assist_port` int(11) DEFAULT NULL,
  `default_server` tinyint(1) DEFAULT '0',
  `create_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `update_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `hook_alive_interval` int(11) DEFAULT NULL,
  `record_path` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `record_day` int(11) DEFAULT '7',
  `transcode_suffix` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_media_server_unique_ip_http_port` (`ip`,`http_port`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_media_server`
--

LOCK TABLES `wvp_media_server` WRITE;
/*!40000 ALTER TABLE `wvp_media_server` DISABLE KEYS */;
INSERT INTO `wvp_media_server` VALUES ('haoxin-zlm-1','45.207.208.187','45.207.208.187','45.207.208.187','45.207.208.187',8092,1443,1935,0,10000,554,0,8092,1443,8092,1443,1,'haoxin','zlm',1,'30000-30100','30000-30100',0,1,'2025-04-18 06:53:18','2025-04-18 09:59:29',10,'',7,NULL);
/*!40000 ALTER TABLE `wvp_media_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_platform`
--

DROP TABLE IF EXISTS `wvp_platform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_platform` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `enable` tinyint(1) DEFAULT '0',
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `server_gb_id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `server_gb_domain` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `server_ip` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `server_port` int(11) DEFAULT NULL,
  `device_gb_id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `device_ip` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `device_port` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `expires` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `keep_timeout` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `transport` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `civil_code` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `manufacturer` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `model` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `character_set` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `ptz` tinyint(1) DEFAULT '0',
  `rtcp` tinyint(1) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0',
  `catalog_group` int(11) DEFAULT NULL,
  `register_way` int(11) DEFAULT NULL,
  `secrecy` int(11) DEFAULT NULL,
  `create_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `update_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `as_message_channel` tinyint(1) DEFAULT '0',
  `catalog_with_platform` int(11) DEFAULT '1',
  `catalog_with_group` int(11) DEFAULT '1',
  `catalog_with_region` int(11) DEFAULT '1',
  `auto_push_channel` tinyint(1) DEFAULT '1',
  `send_stream_ip` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  UNIQUE KEY `uk_platform_unique_server_gb_id` (`server_gb_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_platform`
--

LOCK TABLES `wvp_platform` WRITE;
/*!40000 ALTER TABLE `wvp_platform` DISABLE KEYS */;
/*!40000 ALTER TABLE `wvp_platform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_platform_channel`
--

DROP TABLE IF EXISTS `wvp_platform_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_platform_channel` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `platform_id` int(11) DEFAULT NULL,
  `device_channel_id` int(11) DEFAULT NULL,
  `custom_device_id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `custom_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `custom_manufacturer` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `custom_model` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `custom_owner` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `custom_civil_code` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `custom_block` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `custom_address` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `custom_parental` int(11) DEFAULT NULL,
  `custom_parent_id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `custom_safety_way` int(11) DEFAULT NULL,
  `custom_register_way` int(11) DEFAULT NULL,
  `custom_cert_num` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `custom_certifiable` int(11) DEFAULT NULL,
  `custom_err_code` int(11) DEFAULT NULL,
  `custom_end_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `custom_secrecy` int(11) DEFAULT NULL,
  `custom_ip_address` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `custom_port` int(11) DEFAULT NULL,
  `custom_password` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `custom_status` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `custom_longitude` double DEFAULT NULL,
  `custom_latitude` double DEFAULT NULL,
  `custom_ptz_type` int(11) DEFAULT NULL,
  `custom_position_type` int(11) DEFAULT NULL,
  `custom_room_type` int(11) DEFAULT NULL,
  `custom_use_type` int(11) DEFAULT NULL,
  `custom_supply_light_type` int(11) DEFAULT NULL,
  `custom_direction_type` int(11) DEFAULT NULL,
  `custom_resolution` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `custom_business_group_id` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `custom_download_speed` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `custom_svc_space_support_mod` int(11) DEFAULT NULL,
  `custom_svc_time_support_mode` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  UNIQUE KEY `uk_platform_gb_channel_platform_id_catalog_id_device_channel_id` (`platform_id`,`device_channel_id`) USING BTREE,
  UNIQUE KEY `uk_platform_gb_channel_device_id` (`custom_device_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_platform_channel`
--

LOCK TABLES `wvp_platform_channel` WRITE;
/*!40000 ALTER TABLE `wvp_platform_channel` DISABLE KEYS */;
/*!40000 ALTER TABLE `wvp_platform_channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_platform_group`
--

DROP TABLE IF EXISTS `wvp_platform_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_platform_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `platform_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  UNIQUE KEY `uk_wvp_platform_group_platform_id_group_id` (`platform_id`,`group_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_platform_group`
--

LOCK TABLES `wvp_platform_group` WRITE;
/*!40000 ALTER TABLE `wvp_platform_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `wvp_platform_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_platform_region`
--

DROP TABLE IF EXISTS `wvp_platform_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_platform_region` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `platform_id` int(11) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  UNIQUE KEY `uk_wvp_platform_region_platform_id_group_id` (`platform_id`,`region_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_platform_region`
--

LOCK TABLES `wvp_platform_region` WRITE;
/*!40000 ALTER TABLE `wvp_platform_region` DISABLE KEYS */;
/*!40000 ALTER TABLE `wvp_platform_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_record_plan`
--

DROP TABLE IF EXISTS `wvp_record_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_record_plan` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `snap` tinyint(1) DEFAULT '0',
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `create_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `update_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_record_plan`
--

LOCK TABLES `wvp_record_plan` WRITE;
/*!40000 ALTER TABLE `wvp_record_plan` DISABLE KEYS */;
/*!40000 ALTER TABLE `wvp_record_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_record_plan_item`
--

DROP TABLE IF EXISTS `wvp_record_plan_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_record_plan_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `start` int(11) DEFAULT NULL,
  `stop` int(11) DEFAULT NULL,
  `week_day` int(11) DEFAULT NULL,
  `plan_id` int(11) DEFAULT NULL,
  `create_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `update_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_record_plan_item`
--

LOCK TABLES `wvp_record_plan_item` WRITE;
/*!40000 ALTER TABLE `wvp_record_plan_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `wvp_record_plan_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_resources_tree`
--

DROP TABLE IF EXISTS `wvp_resources_tree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_resources_tree` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `is_catalog` tinyint(1) DEFAULT '1',
  `device_channel_id` int(11) DEFAULT NULL,
  `gb_stream_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `path` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_resources_tree`
--

LOCK TABLES `wvp_resources_tree` WRITE;
/*!40000 ALTER TABLE `wvp_resources_tree` DISABLE KEYS */;
/*!40000 ALTER TABLE `wvp_resources_tree` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_stream_proxy`
--

DROP TABLE IF EXISTS `wvp_stream_proxy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_stream_proxy` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `app` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `stream` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `src_url` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `timeout` int(11) DEFAULT NULL,
  `ffmpeg_cmd_key` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rtsp_type` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `media_server_id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `enable_audio` tinyint(1) DEFAULT '0',
  `enable_mp4` tinyint(1) DEFAULT '0',
  `pulling` tinyint(1) DEFAULT '0',
  `enable` tinyint(1) DEFAULT '0',
  `enable_remove_none_reader` tinyint(1) DEFAULT '0',
  `create_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `update_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `stream_key` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `enable_disable_none_reader` tinyint(1) DEFAULT '0',
  `relates_media_server_id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  UNIQUE KEY `uk_stream_proxy_app_stream` (`app`,`stream`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_stream_proxy`
--

LOCK TABLES `wvp_stream_proxy` WRITE;
/*!40000 ALTER TABLE `wvp_stream_proxy` DISABLE KEYS */;
/*!40000 ALTER TABLE `wvp_stream_proxy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_stream_push`
--

DROP TABLE IF EXISTS `wvp_stream_push`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_stream_push` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `stream` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `create_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `media_server_id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `server_id` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `push_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `update_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `pushing` tinyint(1) DEFAULT '0',
  `self` tinyint(1) DEFAULT '0',
  `start_offline_push` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  UNIQUE KEY `uk_stream_push_app_stream` (`app`,`stream`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_stream_push`
--

LOCK TABLES `wvp_stream_push` WRITE;
/*!40000 ALTER TABLE `wvp_stream_push` DISABLE KEYS */;
/*!40000 ALTER TABLE `wvp_stream_push` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wvp_user_api_key`
--

DROP TABLE IF EXISTS `wvp_user_api_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wvp_user_api_key` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `app` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `api_key` text COLLATE utf8_bin,
  `expired_at` bigint(20) DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `enable` tinyint(1) DEFAULT '1',
  `create_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `update_time` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wvp_user_api_key`
--

LOCK TABLES `wvp_user_api_key` WRITE;
/*!40000 ALTER TABLE `wvp_user_api_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `wvp_user_api_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ry-wvp'
--

--
-- Dumping routines for database 'ry-wvp'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-19  1:04:30
