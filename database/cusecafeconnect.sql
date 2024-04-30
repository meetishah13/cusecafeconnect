-- MySQL dump 10.13  Distrib 8.0.36, for macos14 (arm64)
--
-- Host: 127.0.0.1    Database: cusecafeconnect
-- ------------------------------------------------------
-- Server version	8.3.0

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
  `cafeName` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cafeLat` double NOT NULL,
  `cafeLong` double NOT NULL,
  PRIMARY KEY (`cafeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cafe`
--

LOCK TABLES `cafe` WRITE;
/*!40000 ALTER TABLE `cafe` DISABLE KEYS */;
INSERT INTO `cafe` VALUES (0,'Student',0,0),(101,'Olstein',43.03451,76.14285),(102,'Pages',43.0399,76.1326),(103,'Halal Shack',0,0),(104,'Dunkin',0,0),(105,'Core',0,0),(106,'Pandas',0,0),(107,'Eggers',0,0),(108,'NVRC',0,0),(109,'Life Sciences',0,0),(110,'Schine Pizza',0,0),(111,'Falk',0,0),(112,'NewHouse',0,0),(113,'General',0,0);
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
  `roleName` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`roleID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Coordinator',0),(2,'Supervisor',0),(3,'Student',0);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule` (
  `scheduleID` int NOT NULL AUTO_INCREMENT,
  `timeSlotID` int DEFAULT NULL,
  `userID` int DEFAULT NULL,
  `cafeID` int DEFAULT NULL,
  `isAccepted` tinyint DEFAULT NULL,
  `requestComments` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`scheduleID`),
  KEY `timeSlotID_idx` (`timeSlotID`),
  KEY `cafeID_idx` (`cafeID`),
  KEY `userID_idx` (`userID`),
  CONSTRAINT `cafeID` FOREIGN KEY (`cafeID`) REFERENCES `cafe` (`cafeID`),
  CONSTRAINT `timeSlotID` FOREIGN KEY (`timeSlotID`) REFERENCES `timeSlot` (`timeSlotID`),
  CONSTRAINT `userID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES (1,301,1234,101,1,NULL),(2,306,1234,101,1,'Shift Assigned'),(3,312,1234,101,1,NULL),(4,302,4567,101,1,NULL),(5,307,4567,101,1,NULL),(6,304,6348,101,1,NULL),(7,312,6348,101,0,'Already taken'),(8,316,4567,101,1,'Shift Assigned'),(9,301,6348,102,1,NULL),(10,302,1234,102,0,NULL);
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stu_cafe_group`
--

DROP TABLE IF EXISTS `stu_cafe_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stu_cafe_group` (
  `stuCafeGrpID` int NOT NULL AUTO_INCREMENT,
  `userID` int DEFAULT NULL,
  `cafeID` int DEFAULT NULL,
  `isAccepted` tinyint NOT NULL,
  PRIMARY KEY (`stuCafeGrpID`),
  KEY `user_idx` (`userID`),
  KEY `cafe_idx` (`cafeID`),
  CONSTRAINT `cafe` FOREIGN KEY (`cafeID`) REFERENCES `cafe` (`cafeID`),
  CONSTRAINT `user` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stu_cafe_group`
--

LOCK TABLES `stu_cafe_group` WRITE;
/*!40000 ALTER TABLE `stu_cafe_group` DISABLE KEYS */;
INSERT INTO `stu_cafe_group` VALUES (0,1234,101,1),(1,4567,101,1),(2,6348,101,1);
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
  `dropDate` date DEFAULT NULL,
  `dropUser` int DEFAULT NULL,
  `pickUpUser` int DEFAULT NULL,
  `acceptSub` tinyint DEFAULT NULL,
  `cafeID` int DEFAULT NULL,
  `scheduleID` int DEFAULT NULL,
  `comments` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`subID`),
  KEY `dropUser_idx` (`dropUser`),
  KEY `pickUpUser_idx` (`pickUpUser`),
  KEY `cafeID_idx` (`cafeID`),
  KEY `scID_idx` (`scheduleID`),
  CONSTRAINT `cID` FOREIGN KEY (`cafeID`) REFERENCES `cafe` (`cafeID`),
  CONSTRAINT `dUID` FOREIGN KEY (`dropUser`) REFERENCES `user` (`userID`),
  CONSTRAINT `pUID` FOREIGN KEY (`pickUpUser`) REFERENCES `user` (`userID`),
  CONSTRAINT `scID` FOREIGN KEY (`scheduleID`) REFERENCES `schedule` (`scheduleID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subBook`
--

LOCK TABLES `subBook` WRITE;
/*!40000 ALTER TABLE `subBook` DISABLE KEYS */;
INSERT INTO `subBook` VALUES (1,1,'2024-04-29',4567,1234,1,101,4,NULL),(2,1,'2024-05-02',4567,6348,1,101,8,NULL),(3,1,'2024-04-30',1234,4567,1,101,2,NULL),(4,1,'2024-04-29',6348,1234,1,101,6,NULL),(5,1,'2024-04-29',6348,4567,2,101,6,'Already Taken'),(6,1,'2024-04-29',4567,1234,0,101,4,NULL),(7,1,'2024-04-30',4567,6348,1,101,2,NULL),(8,1,'2024-05-23',4567,NULL,0,101,8,'Sick');
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
  `timeSlot` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timeSlotDay` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`timeSlotID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeSlot`
--

LOCK TABLES `timeSlot` WRITE;
/*!40000 ALTER TABLE `timeSlot` DISABLE KEYS */;
INSERT INTO `timeSlot` VALUES (301,'8:00am - 12:00am','Monday'),(302,'9:00am - 1:00pm','Monday'),(303,'10:00am - 2:00pm','Monday'),(304,'11:00am - 3:00pm','Monday'),(305,'12:00pm - 3:30pm','Monday'),(306,'8:00am - 12:00pm','Tuesday'),(307,'9:00am - 1:00pm','Tuesday'),(308,'10:00am - 2:00pm','Tuesday'),(309,'11:00am - 3:00pm','Tuesday'),(310,'12:00pm - 3:30pm','Tuesday'),(311,'8:00am - 12:00pm','Wednesday'),(312,'9:00am - 1:00pm','Wednesday'),(313,'10:00am - 2:00pm','Wednesday'),(314,'11:00am - 3:00pm','Wednesday'),(315,'12:00pm - 3:30pm','Wednesday'),(316,'8:00am - 12:00pm','Thursday'),(317,'9:00am - 1:00pm','Thursday'),(318,'10:00am - 2:00pm','Thursday'),(319,'11:00am - 3:00pm','Thursday'),(320,'12:00pm - 3:30pm','Thursday'),(321,'8:00am - 12:00pm','Friday'),(322,'9:00am - 1:00pm','Friday'),(323,'10:00am - 2:00pm','Friday'),(324,'11:00am - 3:00pm','Friday'),(325,'12:00pm - 3:30pm','Friday');
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
  `userEmail` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fName` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lName` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phoneNo` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1043,'dikshita@gmail.com,','diskhita','patel','823','3158865396',3,103,_binary 'dsfsdc'),(1234,'rohan@gmail.com','rohan','bhowmick','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3','3158865393',3,101,_binary 'dsfsdc'),(4567,'meeti@gmail.com,','meeti','shah','234','3158865391',3,101,_binary 'dsfsdc'),(4903,'olsteinsup@gmail.com,','olstein','supervisor','502','3158865395',2,101,_binary 'dsfsdc'),(6348,'jaynam@gmail.com,','jaynam','sanghavi','975','3158865392',3,101,_binary 'dsfsdc'),(8011,'kavish@gmail.com,','kavish','shah','5620','3158865398',3,105,_binary 'dsfsdc'),(8765,'karen@gmail.com','Karen','Burray','34354635','123456789',2,101,NULL),(9023,'niddhi@gmail.com,','niddhi','chauhan','42378','3158865397',3,104,_binary 'dsfsdc'),(9345,'deena@gmail.com,','deena','capria','532','3158865394',1,NULL,_binary 'dsfsdc');
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

-- Dump completed on 2024-04-29 22:38:55
