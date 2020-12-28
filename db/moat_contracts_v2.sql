CREATE TABLE IF NOT EXISTS `moat_contracts_v2` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`contract` varchar(64) NOT NULL,
	`start_time` timestamp NULL DEFAULT NULL,
	`contract_id` int(11) NOT NULL,
	`updating_server` varchar(32) DEFAULT NULL,
	PRIMARY KEY (`ID`)
);