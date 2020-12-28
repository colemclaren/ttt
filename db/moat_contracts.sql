CREATE TABLE IF NOT EXISTS `moat_contracts` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`contract` varchar(255) NOT NULL,
	`start_time` int(11) NOT NULL,
	`active` int(11) NOT NULL,
	`refresh_next` int(11) DEFAULT NULL,
	`updating_server` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`ID`),
	KEY `active` (`active`),
	KEY `refresh_next` (`refresh_next`)
);