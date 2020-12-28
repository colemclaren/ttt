CREATE TABLE IF NOT EXISTS `moat_versusstreaks_history` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(255) NOT NULL,
	`streak` int(11) NOT NULL,
	`time` int(11) NOT NULL,
	PRIMARY KEY (`ID`)
);