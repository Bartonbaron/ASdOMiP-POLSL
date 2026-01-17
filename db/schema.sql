-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: music_app
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `albums` (
  `albumID` int NOT NULL AUTO_INCREMENT,
  `albumName` varchar(50) NOT NULL,
  `creatorID` int DEFAULT NULL,
  `coverURL` varchar(255) DEFAULT NULL,
  `description` text,
  `releaseDate` datetime DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `genreID` int NOT NULL,
  `isPublished` tinyint(1) DEFAULT '1',
  `moderationStatus` enum('ACTIVE','HIDDEN') NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`albumID`),
  KEY `fk_albums_creators` (`creatorID`),
  KEY `fk_albums_genres` (`genreID`),
  CONSTRAINT `fk_albums_creators` FOREIGN KEY (`creatorID`) REFERENCES `creatorprofiles` (`creatorID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_albums_genres` FOREIGN KEY (`genreID`) REFERENCES `genres` (`genreID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `creatorprofiles`
--

DROP TABLE IF EXISTS `creatorprofiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `creatorprofiles` (
  `creatorID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `numberOfFollowers` int NOT NULL DEFAULT '0',
  `bio` text,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`creatorID`),
  UNIQUE KEY `userID` (`userID`),
  CONSTRAINT `fk_creatorprofiles_users` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `favoritepodcasts`
--

DROP TABLE IF EXISTS `favoritepodcasts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoritepodcasts` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `podcastID` int NOT NULL,
  `addedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `userID` (`userID`),
  KEY `podcastID` (`podcastID`),
  CONSTRAINT `favoritepodcasts_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `favoritepodcasts_ibfk_2` FOREIGN KEY (`podcastID`) REFERENCES `podcasts` (`podcastID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `favoritesongs`
--

DROP TABLE IF EXISTS `favoritesongs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoritesongs` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `songID` int NOT NULL,
  `addedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `userID` (`userID`),
  KEY `songID` (`songID`),
  CONSTRAINT `favoritesongs_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `favoritesongs_ibfk_2` FOREIGN KEY (`songID`) REFERENCES `songs` (`songID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `folderplaylists`
--

DROP TABLE IF EXISTS `folderplaylists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `folderplaylists` (
  `folderID` int NOT NULL,
  `playlistID` int NOT NULL,
  PRIMARY KEY (`folderID`,`playlistID`),
  KEY `playlistID` (`playlistID`),
  CONSTRAINT `folderplaylists_ibfk_1` FOREIGN KEY (`folderID`) REFERENCES `folders` (`folderID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `folderplaylists_ibfk_2` FOREIGN KEY (`playlistID`) REFERENCES `playlists` (`playlistID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `folders`
--

DROP TABLE IF EXISTS `folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `folders` (
  `folderID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `folderName` varchar(50) NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`folderID`),
  KEY `fk_folders_users` (`userID`),
  CONSTRAINT `fk_folders_users` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `followers`
--

DROP TABLE IF EXISTS `followers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `followers` (
  `followerID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `creatorID` int NOT NULL,
  `followedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`followerID`),
  KEY `userID` (`userID`),
  KEY `creatorID` (`creatorID`),
  CONSTRAINT `followers_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `followers_ibfk_2` FOREIGN KEY (`creatorID`) REFERENCES `creatorprofiles` (`creatorID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `genreID` int NOT NULL AUTO_INCREMENT,
  `genreName` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`genreID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `library`
--

DROP TABLE IF EXISTS `library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library` (
  `libraryID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`libraryID`),
  UNIQUE KEY `userID` (`userID`),
  CONSTRAINT `fk_library_users` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `libraryalbums`
--

DROP TABLE IF EXISTS `libraryalbums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libraryalbums` (
  `libraryID` int NOT NULL,
  `albumID` int NOT NULL,
  `addedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`libraryID`,`albumID`),
  KEY `albumID` (`albumID`),
  CONSTRAINT `libraryalbums_ibfk_1` FOREIGN KEY (`libraryID`) REFERENCES `library` (`libraryID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `libraryalbums_ibfk_2` FOREIGN KEY (`albumID`) REFERENCES `albums` (`albumID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `libraryplaylists`
--

DROP TABLE IF EXISTS `libraryplaylists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libraryplaylists` (
  `libraryID` int NOT NULL,
  `playlistID` int NOT NULL,
  `addedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`libraryID`,`playlistID`),
  KEY `playlistID` (`playlistID`),
  CONSTRAINT `libraryplaylists_ibfk_1` FOREIGN KEY (`libraryID`) REFERENCES `library` (`libraryID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `libraryplaylists_ibfk_2` FOREIGN KEY (`playlistID`) REFERENCES `playlists` (`playlistID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playhistory`
--

DROP TABLE IF EXISTS `playhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playhistory` (
  `historyID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `songID` int DEFAULT NULL,
  `podcastID` int DEFAULT NULL,
  `playedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`historyID`),
  KEY `userID` (`userID`),
  KEY `songID` (`songID`),
  KEY `podcastID` (`podcastID`),
  CONSTRAINT `playhistory_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `playhistory_ibfk_2` FOREIGN KEY (`songID`) REFERENCES `songs` (`songID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `playhistory_ibfk_3` FOREIGN KEY (`podcastID`) REFERENCES `podcasts` (`podcastID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playlistactivities`
--

DROP TABLE IF EXISTS `playlistactivities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlistactivities` (
  `activityID` int NOT NULL AUTO_INCREMENT,
  `playlistID` int NOT NULL,
  `songID` int NOT NULL,
  `userID` int NOT NULL,
  `action` enum('ADD','REMOVE') NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`activityID`),
  KEY `fk_playlistactivities_song` (`songID`),
  KEY `idx_playlistactivities_playlist` (`playlistID`),
  KEY `idx_playlistactivities_playlist_created` (`playlistID`,`createdAt`),
  KEY `idx_playlistactivities_user` (`userID`),
  CONSTRAINT `fk_playlistactivities_playlist` FOREIGN KEY (`playlistID`) REFERENCES `playlists` (`playlistID`) ON DELETE CASCADE,
  CONSTRAINT `fk_playlistactivities_song` FOREIGN KEY (`songID`) REFERENCES `songs` (`songID`) ON DELETE CASCADE,
  CONSTRAINT `fk_playlistactivities_user` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playlistcollaborators`
--

DROP TABLE IF EXISTS `playlistcollaborators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlistcollaborators` (
  `collaboratorID` int NOT NULL AUTO_INCREMENT,
  `playlistID` int NOT NULL,
  `userID` int NOT NULL,
  `status` enum('INVITED','ACCEPTED') NOT NULL DEFAULT 'INVITED',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`collaboratorID`),
  UNIQUE KEY `uniq_playlist_user` (`playlistID`,`userID`),
  KEY `idx_playlist` (`playlistID`),
  KEY `idx_user` (`userID`),
  CONSTRAINT `fk_pc_playlist` FOREIGN KEY (`playlistID`) REFERENCES `playlists` (`playlistID`) ON DELETE CASCADE,
  CONSTRAINT `fk_pc_user` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playlists`
--

DROP TABLE IF EXISTS `playlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlists` (
  `playlistID` int NOT NULL AUTO_INCREMENT,
  `playlistName` varchar(50) NOT NULL,
  `userID` int NOT NULL,
  `likesCount` int DEFAULT '0',
  `description` text,
  `coverURL` varchar(255) DEFAULT NULL,
  `visibility` char(1) DEFAULT 'P',
  `isCollaborative` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `moderationStatus` enum('ACTIVE','HIDDEN') NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`playlistID`),
  KEY `fk_playlists_users` (`userID`),
  CONSTRAINT `fk_playlists_users` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playlistsongs`
--

DROP TABLE IF EXISTS `playlistsongs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlistsongs` (
  `playlistID` int NOT NULL,
  `songID` int NOT NULL,
  `position` int DEFAULT NULL,
  `addedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`playlistID`,`songID`),
  KEY `songID` (`songID`),
  CONSTRAINT `playlistsongs_ibfk_1` FOREIGN KEY (`playlistID`) REFERENCES `playlists` (`playlistID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `playlistsongs_ibfk_2` FOREIGN KEY (`songID`) REFERENCES `songs` (`songID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playqueue`
--

DROP TABLE IF EXISTS `playqueue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playqueue` (
  `queueID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `songID` int DEFAULT NULL,
  `podcastID` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  PRIMARY KEY (`queueID`),
  KEY `userID` (`userID`),
  KEY `songID` (`songID`),
  KEY `podcastID` (`podcastID`),
  CONSTRAINT `playqueue_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `playqueue_ibfk_2` FOREIGN KEY (`songID`) REFERENCES `songs` (`songID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `playqueue_ibfk_3` FOREIGN KEY (`podcastID`) REFERENCES `podcasts` (`podcastID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `podcasts`
--

DROP TABLE IF EXISTS `podcasts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `podcasts` (
  `podcastID` int NOT NULL AUTO_INCREMENT,
  `podcastName` varchar(100) NOT NULL,
  `creatorID` int DEFAULT NULL,
  `topicID` int DEFAULT NULL,
  `fileURL` varchar(255) DEFAULT NULL,
  `description` text,
  `duration` int DEFAULT NULL,
  `releaseDate` datetime DEFAULT NULL,
  `streamCount` int DEFAULT '0',
  `coverURL` varchar(255) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `moderationStatus` enum('ACTIVE','HIDDEN') NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`podcastID`),
  KEY `fk_podcasts_creators` (`creatorID`),
  KEY `fk_podcasts_topics` (`topicID`),
  CONSTRAINT `fk_podcasts_creators` FOREIGN KEY (`creatorID`) REFERENCES `creatorprofiles` (`creatorID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_podcasts_topics` FOREIGN KEY (`topicID`) REFERENCES `topics` (`topicID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `reportID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `contentID` int NOT NULL,
  `contentType` enum('song','podcast','playlist','album','user') NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `status` enum('pending','reviewed','resolved') DEFAULT 'pending',
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`reportID`),
  KEY `userID` (`userID`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `roleID` int NOT NULL AUTO_INCREMENT,
  `roleName` varchar(30) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`roleID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `songs`
--

DROP TABLE IF EXISTS `songs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `songs` (
  `songID` int NOT NULL AUTO_INCREMENT,
  `songName` varchar(100) NOT NULL,
  `description` text,
  `creatorID` int DEFAULT NULL,
  `albumID` int DEFAULT NULL,
  `genreID` int DEFAULT NULL,
  `fileURL` varchar(255) DEFAULT NULL,
  `duration` int NOT NULL,
  `streamCount` int DEFAULT '0',
  `likeCount` int DEFAULT '0',
  `coverURL` varchar(255) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `trackNumber` int DEFAULT NULL,
  `moderationStatus` enum('ACTIVE','HIDDEN') NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`songID`),
  KEY `fk_songs_creators` (`creatorID`),
  KEY `fk_songs_albums` (`albumID`),
  KEY `fk_songs_genres` (`genreID`),
  CONSTRAINT `fk_songs_albums` FOREIGN KEY (`albumID`) REFERENCES `albums` (`albumID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_songs_creators` FOREIGN KEY (`creatorID`) REFERENCES `creatorprofiles` (`creatorID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_songs_genres` FOREIGN KEY (`genreID`) REFERENCES `genres` (`genreID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `streamhistory`
--

DROP TABLE IF EXISTS `streamhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `streamhistory` (
  `streamID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `targetType` enum('song','podcast') NOT NULL,
  `targetID` int NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`streamID`),
  KEY `idx_stream_user_target` (`userID`,`targetType`,`targetID`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topics` (
  `topicID` int NOT NULL AUTO_INCREMENT,
  `topicName` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`topicID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `roleID` int NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `email` varchar(100) DEFAULT NULL,
  `profilePicURL` varchar(255) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `volume` float DEFAULT '1',
  `playbackMode` enum('normal','shuffle','repeat') DEFAULT 'normal',
  `autoplay` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`userID`),
  KEY `fk_users_roles` (`roleID`),
  CONSTRAINT `fk_users_roles` FOREIGN KEY (`roleID`) REFERENCES `roles` (`roleID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usersonglikes`
--

DROP TABLE IF EXISTS `usersonglikes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usersonglikes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `songID` int NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_song` (`userID`,`songID`),
  KEY `songID` (`songID`),
  CONSTRAINT `usersonglikes_ibfk_1` FOREIGN KEY (`songID`) REFERENCES `songs` (`songID`) ON DELETE CASCADE,
  CONSTRAINT `usersonglikes_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-17 16:41:40
