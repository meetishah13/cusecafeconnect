-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Host: sql5.freemysqlhosting.net
-- Generation Time: Apr 10, 2024 at 07:28 PM
-- Server version: 5.5.62-0ubuntu0.14.04.1
-- PHP Version: 7.0.33-0ubuntu0.16.04.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sql5697261`
--
CREATE DATABASE IF NOT EXISTS `cafeCuseConnect` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `cafeCuseConnect`;

-- --------------------------------------------------------

--
-- Table structure for table `cafe`
--

CREATE TABLE `cafe` (
  `cafeID` int(11) NOT NULL,
  `cafeName` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cafeLat` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cafeLong` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cafe`
--

INSERT INTO `cafe` (`cafeID`, `cafeName`, `cafeLat`, `cafeLong`) VALUES
(101, 'Olstein', NULL, NULL),
(102, 'Pages', NULL, NULL),
(103, 'Halal Shack', NULL, NULL),
(104, 'Dunkin', NULL, NULL),
(105, 'Core', NULL, NULL),
(106, 'Pandas', NULL, NULL),
(107, 'Eggers', NULL, NULL),
(108, 'NVRC', NULL, NULL),
(109, 'Life Sciences', NULL, NULL),
(110, 'Schine Pizza', NULL, NULL),
(111, 'Falk', NULL, NULL),
(112, 'NewHouse', NULL, NULL),
(113, 'General', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `roleID` int(11) NOT NULL,
  `roleName` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`roleID`, `roleName`) VALUES
(1, 'Coordinator'),
(2, 'Supervisor'),
(3, 'Student');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `scheduleID` int(11) NOT NULL,
  `timeSlotID` int(11) DEFAULT NULL,
  `userID` int(11) DEFAULT NULL,
  `cafeID` int(11) DEFAULT NULL,
  `isAccepted` tinyint(4) DEFAULT NULL,
  `requestComments` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stu_cafe_group`
--

CREATE TABLE `stu_cafe_group` (
  `stuCafeGrpID` int(11) NOT NULL,
  `userID` int(11) DEFAULT NULL,
  `cafeID` int(11) DEFAULT NULL,
  `isAccepted` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subBook`
--

CREATE TABLE `subBook` (
  `subID` int(11) NOT NULL,
  `subTypeID` int(11) DEFAULT NULL,
  `dropDate` datetime DEFAULT NULL,
  `dropUser` int(11) DEFAULT NULL,
  `pickUpUser` int(11) DEFAULT NULL,
  `acceptSub` tinyint(4) DEFAULT NULL,
  `cafeID` int(11) DEFAULT NULL,
  `scheduleID` int(11) DEFAULT NULL,
  `comments` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `timeSlot`
--

CREATE TABLE `timeSlot` (
  `timeSlotID` int(11) NOT NULL,
  `timeSlot` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timeSlotDay` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userID` int(11) NOT NULL,
  `userEmail` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fName` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lName` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phoneNo` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roleID` int(11) DEFAULT NULL,
  `cafeID` int(11) DEFAULT NULL,
  `photoPath` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cafe`
--
ALTER TABLE `cafe`
  ADD PRIMARY KEY (`cafeID`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`roleID`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`scheduleID`),
  ADD KEY `timeSlotID_idx` (`timeSlotID`),
  ADD KEY `cafeID_idx` (`cafeID`),
  ADD KEY `userID_idx` (`userID`);

--
-- Indexes for table `stu_cafe_group`
--
ALTER TABLE `stu_cafe_group`
  ADD PRIMARY KEY (`stuCafeGrpID`),
  ADD KEY `user_idx` (`userID`),
  ADD KEY `cafe_idx` (`cafeID`);

--
-- Indexes for table `subBook`
--
ALTER TABLE `subBook`
  ADD PRIMARY KEY (`subID`),
  ADD KEY `dropUser_idx` (`dropUser`),
  ADD KEY `pickUpUser_idx` (`pickUpUser`),
  ADD KEY `cafeID_idx` (`cafeID`),
  ADD KEY `scID_idx` (`scheduleID`);

--
-- Indexes for table `timeSlot`
--
ALTER TABLE `timeSlot`
  ADD PRIMARY KEY (`timeSlotID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userID`),
  ADD UNIQUE KEY `userEmail_UNIQUE` (`userEmail`),
  ADD UNIQUE KEY `phoneNo_UNIQUE` (`phoneNo`),
  ADD KEY `roles_idx` (`roleID`),
  ADD KEY `cafeID_idx` (`cafeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `roleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `subBook`
--
ALTER TABLE `subBook`
  MODIFY `subID` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `cafeID` FOREIGN KEY (`cafeID`) REFERENCES `cafe` (`cafeID`),
  ADD CONSTRAINT `timeSlotID` FOREIGN KEY (`timeSlotID`) REFERENCES `timeSlot` (`timeSlotID`),
  ADD CONSTRAINT `userID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`);

--
-- Constraints for table `stu_cafe_group`
--
ALTER TABLE `stu_cafe_group`
  ADD CONSTRAINT `cafe` FOREIGN KEY (`cafeID`) REFERENCES `cafe` (`cafeID`),
  ADD CONSTRAINT `user` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`);

--
-- Constraints for table `subBook`
--
ALTER TABLE `subBook`
  ADD CONSTRAINT `cID` FOREIGN KEY (`cafeID`) REFERENCES `cafe` (`cafeID`),
  ADD CONSTRAINT `dUID` FOREIGN KEY (`dropUser`) REFERENCES `user` (`userID`),
  ADD CONSTRAINT `pUID` FOREIGN KEY (`pickUpUser`) REFERENCES `user` (`userID`),
  ADD CONSTRAINT `scID` FOREIGN KEY (`scheduleID`) REFERENCES `schedule` (`scheduleID`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `cafeuserID` FOREIGN KEY (`cafeID`) REFERENCES `cafe` (`cafeID`),
  ADD CONSTRAINT `roles` FOREIGN KEY (`roleID`) REFERENCES `roles` (`roleID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
