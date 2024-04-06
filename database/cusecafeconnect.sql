-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: 127.0.0.1    Database: cafecuseconnect_db
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cafe`
--

DROP TABLE IF EXISTS `cafe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cafe` (
  `cafeID` int NOT NULL,
  `cafeName` varchar(45) NOT NULL,
  `cafeLat` varchar(45) DEFAULT NULL,
  `cafeLong` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cafeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cafe`
--

LOCK TABLES `cafe` WRITE;
/*!40000 ALTER TABLE `cafe` DISABLE KEYS */;
INSERT INTO `cafe` VALUES (101,'Olstein',NULL,NULL),(102,'Pages',NULL,NULL),(103,'Halal Shack',NULL,NULL),(104,'Dunkin',NULL,NULL),(105,'Core',NULL,NULL),(106,'Pandas',NULL,NULL),(107,'Eggers',NULL,NULL),(108,'NVRC',NULL,NULL),(109,'Life Sciences',NULL,NULL),(110,'Schine Pizza',NULL,NULL),(111,'Falk',NULL,NULL),(112,'NewHouse',NULL,NULL),(113,'General',NULL,NULL);
/*!40000 ALTER TABLE `cafe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `roleID` int NOT NULL AUTO_INCREMENT,
  `roleName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`roleID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Coordinator'),(2,'Supervisor'),(3,'Student');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule` (
  `scheduleID` int NOT NULL,
  `timeSlotID` int DEFAULT NULL,
  `userID` int DEFAULT NULL,
  `cafeID` int DEFAULT NULL,
  `isAccepted` tinyint DEFAULT NULL,
  `requestComments` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`scheduleID`),
  KEY `timeSlotID_idx` (`timeSlotID`),
  KEY `cafeID_idx` (`cafeID`),
  KEY `userID_idx` (`userID`),
  CONSTRAINT `cafeID` FOREIGN KEY (`cafeID`) REFERENCES `cafe` (`cafeID`),
  CONSTRAINT `timeSlotID` FOREIGN KEY (`timeSlotID`) REFERENCES `timeSlot` (`timeSlotID`),
  CONSTRAINT `userID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu_cafe_group`
--

DROP TABLE IF EXISTS `stu_cafe_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu_cafe_group` (
  `stuCafeGrpID` int NOT NULL,
  `userID` int DEFAULT NULL,
  `cafeID` int DEFAULT NULL,
  `isAccepted` tinyint NOT NULL,
  PRIMARY KEY (`stuCafeGrpID`),
  KEY `user_idx` (`userID`),
  KEY `cafe_idx` (`cafeID`),
  CONSTRAINT `cafe` FOREIGN KEY (`cafeID`) REFERENCES `cafe` (`cafeID`),
  CONSTRAINT `user` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu_cafe_group`
--

LOCK TABLES `stu_cafe_group` WRITE;
/*!40000 ALTER TABLE `stu_cafe_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `stu_cafe_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subBook`
--

DROP TABLE IF EXISTS `subBook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subBook` (
  `subID` int NOT NULL AUTO_INCREMENT,
  `subTypeID` int DEFAULT NULL,
  `dropDate` datetime DEFAULT NULL,
  `dropUser` int DEFAULT NULL,
  `pickUpUser` int DEFAULT NULL,
  `acceptSub` tinyint DEFAULT NULL,
  `cafeID` int DEFAULT NULL,
  `scheduleID` int DEFAULT NULL,
  `comments` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`subID`),
  KEY `dropUser_idx` (`dropUser`),
  KEY `pickUpUser_idx` (`pickUpUser`),
  KEY `cafeID_idx` (`cafeID`),
  KEY `scID_idx` (`scheduleID`),
  CONSTRAINT `cID` FOREIGN KEY (`cafeID`) REFERENCES `cafe` (`cafeID`),
  CONSTRAINT `dUID` FOREIGN KEY (`dropUser`) REFERENCES `user` (`userID`),
  CONSTRAINT `pUID` FOREIGN KEY (`pickUpUser`) REFERENCES `user` (`userID`),
  CONSTRAINT `scID` FOREIGN KEY (`scheduleID`) REFERENCES `schedule` (`scheduleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subBook`
--

LOCK TABLES `subBook` WRITE;
/*!40000 ALTER TABLE `subBook` DISABLE KEYS */;
/*!40000 ALTER TABLE `subBook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeSlot`
--

DROP TABLE IF EXISTS `timeSlot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timeSlot` (
  `timeSlotID` int NOT NULL,
  `timeSlot` varchar(45) DEFAULT NULL,
  `timeSlotDay` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`timeSlotID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeSlot`
--

LOCK TABLES `timeSlot` WRITE;
/*!40000 ALTER TABLE `timeSlot` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeSlot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userID` int NOT NULL,
  `userEmail` varchar(45) NOT NULL,
  `fName` varchar(45) NOT NULL,
  `lName` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phoneNo` varchar(45) NOT NULL,
  `roleID` int DEFAULT NULL,
  `cafeID` int DEFAULT NULL,
  `photoPath` blob,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `userEmail_UNIQUE` (`userEmail`),
  UNIQUE KEY `phoneNo_UNIQUE` (`phoneNo`),
  KEY `roles_idx` (`roleID`),
  KEY `cafeID_idx` (`cafeID`),
  CONSTRAINT `cafeuserID` FOREIGN KEY (`cafeID`) REFERENCES `cafe` (`cafeID`),
  CONSTRAINT `roles` FOREIGN KEY (`roleID`) REFERENCES `roles` (`roleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-06 19:36:57
