CREATE TABLE IF NOT EXISTS `moat_staff_commands` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`staff_steamid` varchar(30) NOT NULL,
	`staff_rank` text NOT NULL,
	`staff_name` mediumtext NOT NULL,
	`command` mediumtext NOT NULL,
	`steamid` varchar(30) DEFAULT NULL,
	`args` mediumtext DEFAULT NULL,
	`server_for` mediumtext DEFAULT NULL,
	`server_ran` mediumtext NOT NULL,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
);