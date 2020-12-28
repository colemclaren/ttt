CREATE TABLE IF NOT EXISTS `moat_contracts_revamped` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`contract` varchar(255) NOT NULL,
	`start_time` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`updating_server` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`ID`)
);