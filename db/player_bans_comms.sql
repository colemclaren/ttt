CREATE TABLE IF NOT EXISTS `player_bans_comms` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`ban_type` tinyint(3) unsigned NOT NULL,
	`steam_id` bigint(20) unsigned NOT NULL,
	`staff_steam_id` bigint(20) unsigned NOT NULL,
	`name` varchar(32) DEFAULT NULL,
	`staff_name` varchar(32) DEFAULT NULL,
	`length` int(10) unsigned DEFAULT NULL,
	`time` int(10) unsigned DEFAULT NULL,
	`reason` varchar(255) DEFAULT NULL,
	`unban_reason` varchar(255) DEFAULT NULL,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	KEY `steam_id` (`steam_id`),
	KEY `length` (`length`),
	KEY `time` (`time`),
	KEY `unban_reason` (`unban_reason`)
);