CREATE TABLE IF NOT EXISTS `moat_errors` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`error` mediumtext NOT NULL,
	`serverip` varchar(255) NOT NULL,
	`realm` tinyint(1) NOT NULL,
	`stack` mediumtext DEFAULT NULL,
	`steamid` varchar(20) DEFAULT NULL,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
);