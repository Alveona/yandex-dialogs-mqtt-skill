-- MySQL dump 10.13  Distrib 8.0.16, for osx10.12 (x86_64)
--
-- Host: localhost    Database: alice_wb_database1
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add command',7,'add_command'),(26,'Can change command',7,'change_command'),(27,'Can delete command',7,'delete_command'),(28,'Can view command',7,'view_command'),(29,'Can add scene',8,'add_scene'),(30,'Can change scene',8,'change_scene'),(31,'Can delete scene',8,'delete_scene'),(32,'Can view scene',8,'view_scene'),(33,'Can add phrase',9,'add_phrase'),(34,'Can change phrase',9,'change_phrase'),(35,'Can delete phrase',9,'delete_phrase'),(36,'Can view phrase',9,'view_phrase'),(37,'Can add device',10,'add_device'),(38,'Can change device',10,'change_device'),(39,'Can delete device',10,'delete_device'),(40,'Can view device',10,'view_device'),(41,'Can add session',11,'add_session'),(42,'Can change session',11,'change_session'),(43,'Can delete session',11,'delete_session'),(44,'Can view session',11,'view_session'),(45,'Can add usual phrase',12,'add_usualphrase'),(46,'Can change usual phrase',12,'change_usualphrase'),(47,'Can delete usual phrase',12,'delete_usualphrase'),(48,'Can view usual phrase',12,'view_usualphrase');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$150000$5afiZmLXGJQO$3DgUfqYS4X14jw47oMAzaqZMF077xdrTzOjr9U/6q9g=','2019-08-01 15:59:17.310474',1,'admin','','','',1,1,'2019-07-25 12:18:54.950601'),(2,'pbkdf2_sha256$150000$6RLXakg9VpBB$H58tLyRah28DMLOMmYIVoStqX0s+Yo9ilx2qQA/qhEQ=','2019-07-25 14:29:23.039704',0,'user','','','',1,1,'2019-07-25 12:19:45.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_general_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2019-07-25 12:19:46.025355','2','user',1,'[{\"added\": {}}]',4,1),(2,'2019-07-25 12:19:52.721099','2','user',2,'[{\"changed\": {\"fields\": [\"is_staff\"]}}]',4,1),(3,'2019-07-25 12:20:06.047135','1','Комната с Wiren Board',1,'[{\"added\": {}}]',8,1),(4,'2019-07-25 12:21:41.029007','1','Переключатель; id: 1',1,'[{\"added\": {}}]',10,1),(5,'2019-07-25 12:21:59.033738','2','Диммер; id: 2',1,'[{\"added\": {}}]',10,1),(6,'2019-07-25 12:22:17.633904','1','enable switch; id: 1',1,'[{\"added\": {}}]',7,1),(7,'2019-07-25 12:22:27.823778','2','disable switch; id: 2',1,'[{\"added\": {}}]',7,1),(8,'2019-07-25 12:22:38.025993','3','change value on dimmer; id: 3',1,'[{\"added\": {}}]',7,1),(9,'2019-07-25 12:23:07.447564','1','кондиционер',1,'[{\"added\": {}}]',9,1),(10,'2019-07-25 12:23:39.094506','2','Поставь кондиционер на',1,'[{\"added\": {}}]',9,1),(11,'2019-07-25 12:24:02.034109','3','Включи кондиционер на',1,'[{\"added\": {}}]',9,1),(12,'2019-07-25 12:24:26.410802','4','Включить кондиционер на',1,'[{\"added\": {}}]',9,1),(13,'2019-07-25 12:24:59.041928','5','Включи свет',1,'[{\"added\": {}}]',9,1),(14,'2019-07-25 12:25:18.778522','6','Включить свет',1,'[{\"added\": {}}]',9,1),(15,'2019-07-25 12:25:37.270956','7','Выключи свет',1,'[{\"added\": {}}]',9,1),(16,'2019-07-25 12:26:06.478478','8','Выключить свет',1,'[{\"added\": {}}]',9,1),(17,'2019-07-25 12:26:34.225051','9','верхний свет',1,'[{\"added\": {}}]',9,1),(18,'2019-07-25 14:11:28.390146','2','Диммер; id: 2',2,'[{\"changed\": {\"fields\": [\"max_value\"]}}]',10,1),(19,'2019-07-29 12:18:54.690637','10','кондиционер на',1,'[{\"added\": {}}]',9,1),(20,'2019-07-31 11:00:55.792346','2','Диммер; id: 2',2,'[{\"changed\": {\"fields\": [\"connection\"]}}]',10,1),(21,'2019-07-31 11:01:33.337181','2','Диммер; id: 2',2,'[{\"changed\": {\"fields\": [\"connection\"]}}]',10,1),(22,'2019-07-31 11:01:49.331983','2','Диммер; id: 2',2,'[{\"changed\": {\"fields\": [\"connection\"]}}]',10,1),(23,'2019-07-31 11:02:06.157821','2','Диммер; id: 2',2,'[{\"changed\": {\"fields\": [\"connection\"]}}]',10,1),(24,'2019-07-31 12:32:03.334148','3','change value on dimmer; id: 3',2,'[{\"changed\": {\"fields\": [\"value_to_set\", \"get_value\"]}}]',7,1),(25,'2019-07-31 12:32:45.239607','3','change value on dimmer; id: 3',2,'[{\"changed\": {\"fields\": [\"value_to_set\", \"get_value\"]}}]',7,1),(26,'2019-07-31 12:32:55.790088','4','get value from dimmer; id: 4',1,'[{\"added\": {}}]',7,1),(27,'2019-07-31 12:47:49.386449','11','какая температура',1,'[{\"added\": {}}]',9,1),(28,'2019-08-01 09:24:18.504255','3','Кнопка; id: 3',1,'[{\"added\": {}}]',10,1),(29,'2019-08-01 09:24:43.151348','5','change current state on dimmer; id: 5',1,'[{\"added\": {}}]',7,1),(30,'2019-08-01 09:24:58.353390','9','верхний свет',2,'[{\"changed\": {\"fields\": [\"command\"]}}]',9,1),(31,'2019-08-01 09:30:15.354887','11','какая температура',2,'[{\"changed\": {\"fields\": [\"success_response\"]}}]',9,1),(32,'2019-08-01 09:33:37.482631','11','какая температура',2,'[]',9,1),(33,'2019-08-01 10:22:10.911629','2','Диммер; id: 2',2,'[{\"changed\": {\"fields\": [\"percent\"]}}]',10,1),(34,'2019-08-01 10:23:57.302464','9','люстра',2,'[{\"changed\": {\"fields\": [\"phrase\"]}}]',9,1),(35,'2019-08-01 10:28:48.351193','2','Диммер; id: 2',2,'[{\"changed\": {\"fields\": [\"percent\"]}}]',10,1),(36,'2019-08-01 10:29:10.995329','2','Диммер; id: 2',2,'[{\"changed\": {\"fields\": [\"percent\"]}}]',10,1),(37,'2019-08-01 12:46:46.235317','1','Комната с Wiren Board',2,'[{\"changed\": {\"fields\": [\"activation\"]}}]',8,1),(38,'2019-08-01 15:12:57.640923','1','UsualPhrase object (1)',1,'[{\"added\": {}}]',12,1),(39,'2019-08-01 15:47:56.454874','1','Привет',2,'[{\"changed\": {\"fields\": [\"success_response\"]}}]',12,1),(40,'2019-08-01 15:48:09.344956','1','Привет',2,'[]',12,1),(41,'2019-08-01 15:48:12.918339','1','Привет',2,'[]',12,1),(42,'2019-08-02 07:01:42.923648','2','Помощь',1,'[{\"added\": {}}]',12,1),(43,'2019-08-02 07:03:50.122418','2','Помощь',2,'[{\"changed\": {\"fields\": [\"success_response\"]}}]',12,1),(44,'2019-08-02 09:13:52.784119','1','Спальня',2,'[{\"changed\": {\"fields\": [\"title\"]}}]',8,1),(45,'2019-08-02 09:14:05.475088','2','Коридор',1,'[{\"added\": {}}]',8,1),(46,'2019-08-02 09:14:33.913277','3','Кнопка; id: 3',2,'[{\"changed\": {\"fields\": [\"scene\"]}}]',10,1),(47,'2019-08-02 09:17:19.715767','6','disable dimmer; id: 6',1,'[{\"added\": {}}]',7,1),(48,'2019-08-02 09:17:47.885208','12','Выключить кондиционер',1,'[{\"added\": {}}]',9,1),(49,'2019-08-02 09:18:00.856753','12','Выключи кондиционер',2,'[{\"changed\": {\"fields\": [\"phrase\"]}}]',9,1),(50,'2019-08-02 09:25:12.159990','4','Диммер; id: 4',1,'[{\"added\": {}}]',10,1),(51,'2019-08-02 09:25:31.806465','5','Диммер; id: 5',1,'[{\"added\": {}}]',10,1),(52,'2019-08-02 09:26:25.272258','7','read value from thermo; id: 7',1,'[{\"added\": {}}]',7,1),(53,'2019-08-02 09:26:49.353743','8','read value from thermo setpoint; id: 8',1,'[{\"added\": {}}]',7,1),(54,'2019-08-02 09:27:03.504811','9','set value to thermo setpoint; id: 9',1,'[{\"added\": {}}]',7,1),(55,'2019-08-02 09:28:08.652104','13','Какая уставка',1,'[{\"added\": {}}]',9,1),(56,'2019-08-02 09:28:36.403015','14','Текущая температура',1,'[{\"added\": {}}]',9,1),(57,'2019-08-02 09:28:51.855257','15','Поставь температуру',1,'[{\"added\": {}}]',9,1),(58,'2019-08-02 09:30:55.797746','5','Диммер; id: 5',2,'[{\"changed\": {\"fields\": [\"connection\"]}}]',10,1),(59,'2019-08-02 10:06:21.702949','4','Диммер; id: 4',2,'[{\"changed\": {\"fields\": [\"connection\"]}}]',10,1),(60,'2019-08-02 10:19:20.773091','5','Диммер; id: 5',2,'[{\"changed\": {\"fields\": [\"connection_read\"]}}]',10,1),(61,'2019-08-02 10:19:31.646305','4','Диммер; id: 4',2,'[{\"changed\": {\"fields\": [\"connection_read\"]}}]',10,1),(62,'2019-08-02 10:20:21.239216','4','Диммер; id: 4',2,'[{\"changed\": {\"fields\": [\"connection_read\"]}}]',10,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(7,'webhook','command'),(10,'webhook','device'),(9,'webhook','phrase'),(8,'webhook','scene'),(11,'webhook','session'),(12,'webhook','usualphrase');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-07-25 12:18:11.813131'),(2,'auth','0001_initial','2019-07-25 12:18:11.926228'),(3,'admin','0001_initial','2019-07-25 12:18:12.181841'),(4,'admin','0002_logentry_remove_auto_add','2019-07-25 12:18:12.261702'),(5,'admin','0003_logentry_add_action_flag_choices','2019-07-25 12:18:12.278843'),(6,'contenttypes','0002_remove_content_type_name','2019-07-25 12:18:12.361642'),(7,'auth','0002_alter_permission_name_max_length','2019-07-25 12:18:12.400647'),(8,'auth','0003_alter_user_email_max_length','2019-07-25 12:18:12.435499'),(9,'auth','0004_alter_user_username_opts','2019-07-25 12:18:12.448228'),(10,'auth','0005_alter_user_last_login_null','2019-07-25 12:18:12.499525'),(11,'auth','0006_require_contenttypes_0002','2019-07-25 12:18:12.503326'),(12,'auth','0007_alter_validators_add_error_messages','2019-07-25 12:18:12.516578'),(13,'auth','0008_alter_user_username_max_length','2019-07-25 12:18:12.568742'),(14,'auth','0009_alter_user_last_name_max_length','2019-07-25 12:18:12.622943'),(15,'auth','0010_alter_group_name_max_length','2019-07-25 12:18:12.650078'),(16,'auth','0011_update_proxy_permissions','2019-07-25 12:18:12.672903'),(17,'sessions','0001_initial','2019-07-25 12:18:12.693739'),(18,'webhook','0001_initial','2019-07-25 12:18:12.790490'),(19,'webhook','0002_auto_20190725_1410','2019-07-25 14:11:03.082986'),(20,'webhook','0003_command_get_value','2019-07-31 10:12:32.822321'),(21,'webhook','0004_auto_20190801_1014','2019-08-01 10:15:22.368672'),(22,'webhook','0005_auto_20190801_1021','2019-08-01 10:21:50.645651'),(23,'webhook','0006_auto_20190801_1154','2019-08-01 11:54:47.416629'),(24,'webhook','0007_usualphrase','2019-08-01 15:11:35.349875'),(25,'webhook','0008_auto_20190802_1017','2019-08-02 10:17:38.365437');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('8bvz1ldms9hdawi0plnjtxf4qm2zidb1','Mjg2YTYzOWMxODJiMWE3ZDk0NGY0YWY5ZTBiZDI4YzYwY2M0OWYwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxYWIwNGYzMTZkZDIxMmFjYjg3ODFmYzI1ZGM5ZjBhN2I3ZDJjZDYzIn0=','2019-08-08 14:29:40.824780'),('ypxade34sef8qhi3nqjlru1bvdo2eln3','Mjg2YTYzOWMxODJiMWE3ZDk0NGY0YWY5ZTBiZDI4YzYwY2M0OWYwMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxYWIwNGYzMTZkZDIxMmFjYjg3ODFmYzI1ZGM5ZjBhN2I3ZDJjZDYzIn0=','2019-08-15 15:59:17.314193');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook_command`
--

DROP TABLE IF EXISTS `webhook_command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `webhook_command` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `value_to_set` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `device_id` int(11) DEFAULT NULL,
  `get_value` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webhook_command_device_id_1b683a0a_fk_webhook_device_id` (`device_id`),
  CONSTRAINT `webhook_command_device_id_1b683a0a_fk_webhook_device_id` FOREIGN KEY (`device_id`) REFERENCES `webhook_device` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_command`
--

LOCK TABLES `webhook_command` WRITE;
/*!40000 ALTER TABLE `webhook_command` DISABLE KEYS */;
INSERT INTO `webhook_command` VALUES (1,'enable switch','1',1,0),(2,'disable switch','0',1,0),(3,'change value on dimmer','-1',2,0),(4,'get value from dimmer',NULL,2,1),(5,'change current state on dimmer','1',3,0),(6,'disable dimmer','-2',2,0),(7,'read value from thermo',NULL,4,1),(8,'read value from thermo setpoint',NULL,5,1),(9,'set value to thermo setpoint','-1',5,0);
/*!40000 ALTER TABLE `webhook_command` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook_device`
--

DROP TABLE IF EXISTS `webhook_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `webhook_device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `connection` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `scene_id` int(11) NOT NULL,
  `max_value` int(11) NOT NULL,
  `start_value` int(11) NOT NULL,
  `percent` tinyint(1) NOT NULL,
  `connection_read` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webhook_device_scene_id_612090b9_fk_webhook_scene_id` (`scene_id`),
  CONSTRAINT `webhook_device_scene_id_612090b9_fk_webhook_scene_id` FOREIGN KEY (`scene_id`) REFERENCES `webhook_scene` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_device`
--

LOCK TABLES `webhook_device` WRITE;
/*!40000 ALTER TABLE `webhook_device` DISABLE KEYS */;
INSERT INTO `webhook_device` VALUES (1,0,'/devices/wb-gpio/controls/EXT2_R3A4/on',1,100,0,0,''),(2,2,'/devices/gr7_1_dimm/controls/Value/on',1,1023,0,1,''),(3,1,'/devices/gr6_dimm/controls/BTN_switch/on',2,1,0,0,''),(4,2,'/devices/siemens_rdf302_70/controls/current_temperature/',2,30,16,0,'/devices/siemens_rdf302_70/controls/current_temperature'),(5,2,'/devices/siemens_rdf302_70/controls/setpoint/on',2,30,16,0,'/devices/siemens_rdf302_70/controls/setpoint/');
/*!40000 ALTER TABLE `webhook_device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook_phrase`
--

DROP TABLE IF EXISTS `webhook_phrase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `webhook_phrase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phrase` longtext COLLATE utf8mb4_general_ci,
  `success_response` longtext COLLATE utf8mb4_general_ci,
  `fail_response` longtext COLLATE utf8mb4_general_ci,
  `command_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webhook_phrase_command_id_840a94ef_fk_webhook_command_id` (`command_id`),
  CONSTRAINT `webhook_phrase_command_id_840a94ef_fk_webhook_command_id` FOREIGN KEY (`command_id`) REFERENCES `webhook_command` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_phrase`
--

LOCK TABLES `webhook_phrase` WRITE;
/*!40000 ALTER TABLE `webhook_phrase` DISABLE KEYS */;
INSERT INTO `webhook_phrase` VALUES (1,'кондиционер','Сделано','Что-то пошло не так',3),(2,'Поставь кондиционер на','Хорошо, поставила','К сожалению, произошло нечто',3),(3,'Включи кондиционер на','Окей','Что-то пошло не так',3),(4,'Включить кондиционер на','Хорошо','Что-то пошло не так',3),(5,'Включи свет','Свет включен','Произошла ошибка со светом',1),(6,'Включить свет','Свет активирован','Произошла ошибка со светом',1),(7,'Выключи свет','Свет выключен','Произошла ошибка со светом',2),(8,'Выключить свет','Свет выключен','Произошла ошибка со светом',2),(9,'люстра','Хорошо, сделано','Произошла ошибка со светом',5),(10,'кондиционер на','Сделаю','Что-то пошло не так, извините',3),(11,'какая температура','Текущая температура','К сожалению, что-то пошло не так',4),(12,'Выключи кондиционер','Кондиционер выключен','Упс, что-то пошло не так',6),(13,'Какая уставка','Текущая уставка','.',8),(14,'Текущая температура','Текущая температура','Что-то пошло не так',7),(15,'Поставь температуру','Хорошо','Что-то пошло не так',9);
/*!40000 ALTER TABLE `webhook_phrase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook_scene`
--

DROP TABLE IF EXISTS `webhook_scene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `webhook_scene` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `activation` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_scene`
--

LOCK TABLES `webhook_scene` WRITE;
/*!40000 ALTER TABLE `webhook_scene` DISABLE KEYS */;
INSERT INTO `webhook_scene` VALUES (1,'Спальня','Спальня'),(2,'Коридор','Прихожая');
/*!40000 ALTER TABLE `webhook_scene` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook_session`
--

DROP TABLE IF EXISTS `webhook_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `webhook_session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `expired` tinyint(1) NOT NULL,
  `location_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webhook_session_location_id_e01536f9_fk_webhook_scene_id` (`location_id`),
  CONSTRAINT `webhook_session_location_id_e01536f9_fk_webhook_scene_id` FOREIGN KEY (`location_id`) REFERENCES `webhook_scene` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_session`
--

LOCK TABLES `webhook_session` WRITE;
/*!40000 ALTER TABLE `webhook_session` DISABLE KEYS */;
INSERT INTO `webhook_session` VALUES (1,'EA6428F4C26CEE7BAA5BD615C7AF7617CB02AAF38A00830CBD1AA82CB77CC3C7',1,1),(2,'EA6428F4C26CEE7BAA5BD615C7AF7617CB02AAF38A00830CBD1AA82CB77CC3C7',1,1),(3,'EA6428F4C26CEE7BAA5BD615C7AF7617CB02AAF38A00830CBD1AA82CB77CC3C7',1,1),(4,'0.26dh7krbh8',0,1),(5,'EA6428F4C26CEE7BAA5BD615C7AF7617CB02AAF38A00830CBD1AA82CB77CC3C7',1,1),(6,'EA6428F4C26CEE7BAA5BD615C7AF7617CB02AAF38A00830CBD1AA82CB77CC3C7',1,1),(7,'EA6428F4C26CEE7BAA5BD615C7AF7617CB02AAF38A00830CBD1AA82CB77CC3C7',1,1),(8,'EA6428F4C26CEE7BAA5BD615C7AF7617CB02AAF38A00830CBD1AA82CB77CC3C7',1,1),(9,'EA6428F4C26CEE7BAA5BD615C7AF7617CB02AAF38A00830CBD1AA82CB77CC3C7',1,2),(10,'EA6428F4C26CEE7BAA5BD615C7AF7617CB02AAF38A00830CBD1AA82CB77CC3C7',1,1),(11,'EA6428F4C26CEE7BAA5BD615C7AF7617CB02AAF38A00830CBD1AA82CB77CC3C7',1,1),(12,'EA6428F4C26CEE7BAA5BD615C7AF7617CB02AAF38A00830CBD1AA82CB77CC3C7',1,2),(13,'EA6428F4C26CEE7BAA5BD615C7AF7617CB02AAF38A00830CBD1AA82CB77CC3C7',1,1),(14,'EA6428F4C26CEE7BAA5BD615C7AF7617CB02AAF38A00830CBD1AA82CB77CC3C7',1,2),(15,'EA6428F4C26CEE7BAA5BD615C7AF7617CB02AAF38A00830CBD1AA82CB77CC3C7',1,1),(16,'EA6428F4C26CEE7BAA5BD615C7AF7617CB02AAF38A00830CBD1AA82CB77CC3C7',0,2);
/*!40000 ALTER TABLE `webhook_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook_usualphrase`
--

DROP TABLE IF EXISTS `webhook_usualphrase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `webhook_usualphrase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phrase` longtext COLLATE utf8mb4_general_ci,
  `success_response` longtext COLLATE utf8mb4_general_ci,
  `fail_response` longtext COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_usualphrase`
--

LOCK TABLES `webhook_usualphrase` WRITE;
/*!40000 ALTER TABLE `webhook_usualphrase` DISABLE KEYS */;
INSERT INTO `webhook_usualphrase` VALUES (1,'Привет','Приветики','Что-то пошло не так'),(2,'Помощь','Привет, я голосовой помощник умного дома. Для начала вам нужно авторизоваться в помещении дома - для этого существуют кодовые слова. Просто скажите \"Алиса, кодовое слово спальня\". После этого вы сможете управлять устройствами в этом помещении. Для того, чтобы узнать текущее помещение, скажите \"Алиса где я\", а чтобы поменять его - \"Алиса, поменять помещение\".','К сожалению, я не могу вам помочь сейчас - произошла внутренняя ошибка');
/*!40000 ALTER TABLE `webhook_usualphrase` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-02 13:38:20
