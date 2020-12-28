CREATE TABLE IF NOT EXISTS `moat_versuslogs` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(255) NOT NULL,
	`other` varchar(255) NOT NULL,
	`winner` varchar(255) NOT NULL,
	`amount` int(11) NOT NULL,
	`time` int(11) NOT NULL,
	`tax` int(11) DEFAULT NULL,
	PRIMARY KEY (`ID`)
);