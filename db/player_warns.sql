CREATE TABLE IF NOT EXISTS `player_warns` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`steam_id` bigint(20) unsigned NOT NULL,
	`staff_steam_id` bigint(20) unsigned NOT NULL,
	`name` varchar(100) NOT NULL,
	`staff_name` varchar(100) NOT NULL,
	`time` int(10) unsigned NOT NULL,
	`reason` varchar(255) NOT NULL,
	`acknowledged` int(10) unsigned DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `acknowledged` (`acknowledged`),
	KEY `steam_id` (`steam_id`)
);