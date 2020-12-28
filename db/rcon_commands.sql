CREATE TABLE IF NOT EXISTS `rcon_commands` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`staff_steamid` varchar(30) NOT NULL,
	`staff_rank` text NOT NULL,
	`staff_name` text DEFAULT NULL,
	`server` varchar(255) NOT NULL,
	`command` mediumtext NOT NULL,
	`args` text DEFAULT NULL,
	`steamid` varchar(30) DEFAULT NULL,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
);