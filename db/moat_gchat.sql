CREATE TABLE IF NOT EXISTS `moat_gchat` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(255) NOT NULL,
	`time` int(11) NOT NULL,
	`name` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
	`msg` mediumtext NOT NULL,
	PRIMARY KEY (`ID`),
	KEY `time` (`time`)
);