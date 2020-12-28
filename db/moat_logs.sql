CREATE TABLE IF NOT EXISTS `moat_logs` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`time` int(11) NOT NULL,
	`message` mediumtext NOT NULL,
	PRIMARY KEY (`ID`)
);