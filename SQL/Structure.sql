-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: localhost    Database: sensors
-- ------------------------------------------------------
-- Server version	5.6.17

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
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `descr` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Área onde estão agrupados um conjunto de sensores';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `area_coord`
--

DROP TABLE IF EXISTS `area_coord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `area_coord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lat` float DEFAULT NULL,
  `lon` float DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `area_area_coord_fki` (`area_id`),
  CONSTRAINT `area_area_coord_fki` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Coordenadas do polígono da área. No mímimo três coordenadas definem uma área triangular';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `descr` text,
  `apikey` varchar(64) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `device_user_fki_idx` (`user_id`),
  CONSTRAINT `device_user_fki` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Devices form users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `place`
--

DROP TABLE IF EXISTS `place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `place` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `descr` text,
  `lat` float DEFAULT NULL,
  `lon` float DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `area_place_fki` (`area_id`),
  CONSTRAINT `area_place_fki` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Espaços individuais dentro da área';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sensor`
--

DROP TABLE IF EXISTS `sensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `descr` text,
  `sensor_type_id` int(11) DEFAULT NULL,
  `place_id` int(11) DEFAULT NULL,
  `device_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `sensor_sensor_type_fki` (`sensor_type_id`),
  KEY `sensor_aplace_fki` (`place_id`),
  KEY `sensor_device_fki_idx` (`device_id`),
  CONSTRAINT `sensor_device_fki` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sensor_aplace_fki` FOREIGN KEY (`place_id`) REFERENCES `place` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sensor_sensor_type_fki` FOREIGN KEY (`sensor_type_id`) REFERENCES `sensor_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Sensores disponíveis';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sensor_characteristic`
--

DROP TABLE IF EXISTS `sensor_characteristic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensor_characteristic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `descr` text,
  `img` varchar(45) DEFAULT NULL,
  `sensor_id` int(11) DEFAULT NULL,
  `unity_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `sensor_characteristic_sensor_fki` (`sensor_id`),
  KEY `sensor_characteristic_unity_fki` (`unity_id`),
  CONSTRAINT `sensor_characteristic_sensor_fki` FOREIGN KEY (`sensor_id`) REFERENCES `sensor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sensor_characteristic_unity_fki` FOREIGN KEY (`unity_id`) REFERENCES `unity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Características de cada sensor';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sensor_type`
--

DROP TABLE IF EXISTS `sensor_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensor_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `descr` text,
  `img` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Tipos de sensores disponíveis';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sensor_value`
--

DROP TABLE IF EXISTS `sensor_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensor_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `moment` datetime DEFAULT CURRENT_TIMESTAMP,
  `sensor_characteristic_id` int(11) DEFAULT NULL,
  `value` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `sensor_value_sensor_characteristic_fki` (`sensor_characteristic_id`),
  CONSTRAINT `sensor_value_sensor_characteristic_fki` FOREIGN KEY (`sensor_characteristic_id`) REFERENCES `sensor_characteristic` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3415 DEFAULT CHARSET=utf8 COMMENT='Valores obtidos dos sensores';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unity`
--

DROP TABLE IF EXISTS `unity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `descr` text,
  `sigla` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Tabela de unidades';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `descr` varchar(100) DEFAULT NULL,
  `password` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Usuários dos sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `v_characteristic`
--

DROP TABLE IF EXISTS `v_characteristic`;
/*!50001 DROP VIEW IF EXISTS `v_characteristic`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_characteristic` AS SELECT 
 1 AS `id`,
 1 AS `characteristic`,
 1 AS `characteristic_descr`,
 1 AS `sensor`,
 1 AS `sensor_name`,
 1 AS `sensor_description`,
 1 AS `sensor_type_id`,
 1 AS `sensor_type`,
 1 AS `unity_id`,
 1 AS `unity_sigla`,
 1 AS `characteristic_img`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_sensor_values`
--

DROP TABLE IF EXISTS `v_sensor_values`;
/*!50001 DROP VIEW IF EXISTS `v_sensor_values`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_sensor_values` AS SELECT 
 1 AS `id`,
 1 AS `value`,
 1 AS `moment`,
 1 AS `characteristic_id`,
 1 AS `characteristic`,
 1 AS `sigla`,
 1 AS `name`,
 1 AS `type`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_characteristic`
--

/*!50001 DROP VIEW IF EXISTS `v_characteristic`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_characteristic` AS select `c`.`id` AS `id`,`c`.`title` AS `characteristic`,`c`.`descr` AS `characteristic_descr`,`s`.`id` AS `sensor`,`s`.`title` AS `sensor_name`,`s`.`descr` AS `sensor_description`,`t`.`id` AS `sensor_type_id`,`t`.`title` AS `sensor_type`,`u`.`id` AS `unity_id`,`u`.`sigla` AS `unity_sigla`,`c`.`img` AS `characteristic_img` from (((`sensor_characteristic` `c` join `sensor` `s`) join `unity` `u`) join `sensor_type` `t`) where ((`c`.`sensor_id` = `s`.`id`) and (`c`.`unity_id` = `u`.`id`) and (`s`.`sensor_type_id` = `t`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_sensor_values`
--

/*!50001 DROP VIEW IF EXISTS `v_sensor_values`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_sensor_values` AS select `v`.`id` AS `id`,`v`.`value` AS `value`,`v`.`moment` AS `moment`,`c`.`id` AS `characteristic_id`,`c`.`title` AS `characteristic`,`u`.`sigla` AS `sigla`,`s`.`title` AS `name`,`t`.`title` AS `type` from ((((`sensor_value` `v` join `sensor_characteristic` `c`) join `unity` `u`) join `sensor` `s`) join `sensor_type` `t`) where ((`c`.`sensor_id` = `s`.`id`) and (`c`.`id` = `v`.`sensor_characteristic_id`) and (`u`.`id` = `c`.`unity_id`) and (`s`.`sensor_type_id` = `t`.`id`)) order by `v`.`id` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-07-20 21:38:56
