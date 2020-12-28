CREATE TABLE IF NOT EXISTS `player_logs` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`steam_id` bigint(20) unsigned NOT NULL,
	`name` varchar(100) NOT NULL,
	`cmd` varchar(100) NOT NULL,
	`args` text NOT NULL,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
);