CREATE TABLE IF NOT EXISTS `moat_discord` (
	`steamid` varchar(32) NOT NULL,
	`oauth` mediumtext NOT NULL,
	`date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`steamid`)
);