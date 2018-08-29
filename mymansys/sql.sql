-- MySQL dump 10.13  Distrib 5.5.20, for Win32 (x86)
--
-- Host: localhost    Database: stu
-- ------------------------------------------------------
-- Server version	5.5.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class` (
  `cid` int(255) NOT NULL AUTO_INCREMENT,
  `cname` varchar(255) NOT NULL,
  `gid` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (68,'201','2'),(69,'101','1'),(70,'303','3'),(71,'406','4'),(72,'503','5');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `demo`
--

DROP TABLE IF EXISTS `demo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demo` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `user` varchar(255) DEFAULT NULL,
  `pass` varchar(32) DEFAULT NULL,
  `sign` int(10) DEFAULT NULL,
  `save` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `demo`
--

LOCK TABLES `demo` WRITE;
/*!40000 ALTER TABLE `demo` DISABLE KEYS */;
INSERT INTO `demo` VALUES (5,'li123','e10adc3949ba59abbe56e057f20f883e',0,NULL);
/*!40000 ALTER TABLE `demo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-07-23 01:16:35'),(2,'auth','0001_initial','2018-07-23 01:16:35'),(3,'admin','0001_initial','2018-07-23 01:16:35'),(4,'admin','0002_logentry_remove_auto_add','2018-07-23 01:16:35'),(5,'contenttypes','0002_remove_content_type_name','2018-07-23 01:16:35'),(6,'auth','0002_alter_permission_name_max_length','2018-07-23 01:16:35'),(7,'auth','0003_alter_user_email_max_length','2018-07-23 01:16:35'),(8,'auth','0004_alter_user_username_opts','2018-07-23 01:16:35'),(9,'auth','0005_alter_user_last_login_null','2018-07-23 01:16:35'),(10,'auth','0006_require_contenttypes_0002','2018-07-23 01:16:35'),(11,'auth','0007_alter_validators_add_error_messages','2018-07-23 01:16:35'),(12,'auth','0008_alter_user_username_max_length','2018-07-23 01:16:35'),(13,'auth','0009_alter_user_last_name_max_length','2018-07-23 01:16:35'),(14,'sessions','0001_initial','2018-07-23 01:16:36');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('167olvc8rskut215ayn17wjxnk878fke','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-20 07:40:33'),('1qwuo53ec9nkc1l93fu71q1jxgzrqm1k','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-13 13:33:28'),('2wei4i8iiaxfva0voyuazec6hfcg32wy','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-08 06:53:45'),('5ukcj9jg7kmlgdy38r843nyw0wx3wyvf','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-16 14:01:19'),('79zq5jxumirgi4c2qklvjcfzrvocgyx6','M2NmYjJmN2Y0YzlkNDRkMzU3ODM2NzZhN2Y2MDFlZjczZGNiNDUzMzp7ImxvZ2luIjoieWVzIiwiX3Nlc3Npb25fZXhwaXJ5IjozfQ==','2018-07-24 07:06:52'),('adasswzou25x0qszm9ajkub9srpmln5e','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-14 07:09:01'),('deo34ycvf24kvz7azbzpydwo116yjzpz','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-07 14:16:16'),('dh7zra3fico7umk7ud9irezq2u5ht2bo','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-07 14:45:08'),('dwsi1m1q1i0pfnivew65x2a5tw8xyn0y','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-08 11:27:01'),('ez983c5hw72xc8svxzcakok847andstu','OTUzZmJmOGZhNzlkMzU1YjVlMGI5OWE5YmVhNGM1Mjc4M2Q4NTExMTp7ImxvZ2luIjoieWVzIiwiX3Nlc3Npb25fZXhwaXJ5Ijo2MDB9','2018-07-24 07:20:05'),('fhvphmg8390qn357x6fm8e2pgox40w4d','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-12 09:38:31'),('ftofl9ou0dqhqgwkz1jc346gmsmspf8i','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-19 09:54:42'),('jg3l9hcgq2tys59ly4scxayite6h7eby','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-21 00:35:41'),('kxspy5bdytyhqg1y9yhtnq6aeqd0b8db','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-11 03:34:22'),('l0npyhu91i3seesdjp1wwamkt90fp9if','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-18 00:26:29'),('n5r0cya8swd263ebovynwa1nvdgdg191','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-08 14:21:28'),('oiihmy5wjs7cdzbtjfznjqo71aezi220','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-14 14:04:12'),('oo7whmu234viykmkae9pudkgqcgfm87l','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-21 00:31:04'),('pmibnypvs5r80jqx4tjpg4y6qaqx3nuh','OTUzZmJmOGZhNzlkMzU1YjVlMGI5OWE5YmVhNGM1Mjc4M2Q4NTExMTp7ImxvZ2luIjoieWVzIiwiX3Nlc3Npb25fZXhwaXJ5Ijo2MDB9','2018-07-24 07:37:46'),('q3rnn07y1ee2m4trywpgdf5gohwubpdq','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-20 09:38:04'),('qc7qh6dbfnp2iafvwqvtv7o6vegt3rbo','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-20 00:26:30'),('t0lnsps5t8md26xosjr0ol76tnm263z0','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-19 09:54:42'),('tjqdhgile18wjsj6nuyeyhlcr7lx0bu6','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-09 11:38:00'),('tuqb25mkvhvffye9ckwxfj5cmtg9hdiz','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-09 13:44:02'),('tx0zygr2nnuhz9bdh6uog7qs65z5654n','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-13 11:05:07'),('uz5dww5yhar80buua07t1ba5elq217u8','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-17 06:05:54'),('vr5bixcrg8lbyokvookrygg25j6m345q','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-15 14:38:33'),('whqhywxespq0i6jqmyj3pr07rpko8zqm','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-20 13:13:13'),('xx437arjkkx1ongwg03whunud3d13yt1','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-15 00:25:07'),('yxl7b7arrhylroq0ak7qrdi6nmevs1yw','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-16 00:33:39'),('zudw26w7hq8c3je8xweldrpwdvv8mo8l','ZDJhODhjM2JhOTQ0N2Q1NWE4MjAxOTk4YmJiYTk5YjMzNTk5YjZmYTp7ImxvZ2luIjoieWVzIiwibmFtZSI6ImxpMTIzIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2018-08-10 00:29:53');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grade`
--

DROP TABLE IF EXISTS `grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grade` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `gname` varchar(255) DEFAULT NULL,
  `gid` tinyint(4) DEFAULT NULL,
  `pid` varchar(255) DEFAULT NULL COMMENT '阶段的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grade`
--

LOCK TABLES `grade` WRITE;
/*!40000 ALTER TABLE `grade` DISABLE KEYS */;
INSERT INTO `grade` VALUES (15,'三年级',3,'1,2,3,4'),(16,'四年级',4,'1,2,3,4,5,6'),(17,'五年级',5,'1,2,3,4,5'),(19,'一年级',1,'1,2'),(20,'二年级',2,'1,2,3');
/*!40000 ALTER TABLE `grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `part`
--

DROP TABLE IF EXISTS `part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `part` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `pname` varchar(255) DEFAULT NULL,
  `pid` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `part`
--

LOCK TABLES `part` WRITE;
/*!40000 ALTER TABLE `part` DISABLE KEYS */;
INSERT INTO `part` VALUES (1,'语文',1),(3,'数学',2),(4,'英语',3),(9,'音乐',4),(13,'自然',5),(14,'思想品德',6);
/*!40000 ALTER TABLE `part` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scores`
--

DROP TABLE IF EXISTS `scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scores` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `zid` tinyint(4) DEFAULT NULL,
  `score` varchar(255) DEFAULT NULL,
  `errors` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scores`
--

LOCK TABLES `scores` WRITE;
/*!40000 ALTER TABLE `scores` DISABLE KEYS */;
/*!40000 ALTER TABLE `scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu`
--

DROP TABLE IF EXISTS `stu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stu` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `sex` varchar(255) NOT NULL,
  `age` int(50) NOT NULL,
  `cid` char(50) NOT NULL,
  `sid` char(50) NOT NULL,
  `spass` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu`
--

LOCK TABLES `stu` WRITE;
/*!40000 ALTER TABLE `stu` DISABLE KEYS */;
INSERT INTO `stu` VALUES (40,'王五','0',5,'68','180-001',NULL);
/*!40000 ALTER TABLE `stu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tea_class`
--

DROP TABLE IF EXISTS `tea_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tea_class` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `tid` int(50) NOT NULL,
  `cid` int(50) NOT NULL,
  `pid` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tea_class`
--

LOCK TABLES `tea_class` WRITE;
/*!40000 ALTER TABLE `tea_class` DISABLE KEYS */;
INSERT INTO `tea_class` VALUES (274,61,69,1),(275,59,69,2),(276,60,68,2),(277,69,68,3),(278,53,70,1),(279,59,70,2),(280,60,70,3),(281,69,70,4),(282,61,71,1),(283,59,71,2),(284,56,71,5),(285,61,71,6),(286,59,72,1),(287,61,72,3),(288,56,72,5);
/*!40000 ALTER TABLE `tea_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher` (
  `tid` int(50) NOT NULL AUTO_INCREMENT,
  `tname` varchar(255) NOT NULL,
  `tsex` varchar(255) NOT NULL,
  `tnum` varchar(20) NOT NULL,
  `pid` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (53,'齐小七','0','zh-0003','1,2,3'),(56,'王德拉','0','zh-0004','3,4,5'),(59,'张小小','0','zh-0005','1,3,4,5'),(60,'张青蔷','1','zh-0001','2,3'),(61,'徐小明','0','zh-0006','1,4,5'),(69,'吴军军','0','zh-0007','1,2,3');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests` (
  `id` tinyint(8) NOT NULL AUTO_INCREMENT,
  `gid` tinyint(8) DEFAULT NULL COMMENT '年纪的id',
  `tid` tinyint(8) DEFAULT NULL COMMENT '试题的id',
  `pid` tinyint(8) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `opts` varchar(400) DEFAULT NULL,
  `result` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests`
--

LOCK TABLES `tests` WRITE;
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
INSERT INTO `tests` VALUES (29,1,1,1,'1','1|1|1|1','1'),(37,2,1,2,'1+1','1|2|3|4','2'),(38,1,1,2,'2','1|1|1|1','1'),(58,1,1,1,'aaaaaaaaa','1.第一选项|2.第二选项|3.第三选项|4.第四选项','4'),(59,1,1,1,'bbbbbbbb','1.第一选项|2.第二选项|3.第三选项|4.第四选项','2'),(60,1,1,1,'cccccccccc','1.第一选项|2.第二选项|3.第三选项|4.第四选项','3'),(61,1,1,1,'dddddddddd','1.第一选项|2.第二选项|3.第三选项|4.第四选项','4'),(62,1,1,1,'eeeeeeee','1.第一选项|2.第二选项|3.第三选项|4.第四选项','2'),(64,1,1,1,'gggggggggg','1.第一选项|2.第二选项|3.第三选项|4.第四选项','2');
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `tname` varchar(255) DEFAULT NULL,
  `tid` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES (1,'单选题',1),(2,'多选题',2),(3,'简答题',3);
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zuti`
--

DROP TABLE IF EXISTS `zuti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zuti` (
  `id` tinyint(10) NOT NULL AUTO_INCREMENT,
  `info` varchar(500) DEFAULT NULL,
  `gid` tinyint(4) DEFAULT NULL,
  `pid` tinyint(3) DEFAULT NULL,
  `cid` tinyint(4) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `finish` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zuti`
--

LOCK TABLES `zuti` WRITE;
/*!40000 ALTER TABLE `zuti` DISABLE KEYS */;
/*!40000 ALTER TABLE `zuti` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-22 15:44:07
