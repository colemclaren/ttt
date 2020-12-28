CREATE TABLE IF NOT EXISTS `moat_versus_v2` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`creator_steamid64` bigint(20) unsigned NOT NULL,
	`money` int(10) unsigned NOT NULL,
	`taker_steamid64` bigint(20) unsigned DEFAULT NULL,
	`roll_time` timestamp NULL DEFAULT NULL,
	`creator_won` tinyint(1) DEFAULT NULL,
	`reward_time` timestamp NULL DEFAULT NULL,
	`cancel_time` timestamp NULL DEFAULT NULL,
	`creation_time` timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	KEY `id` (`id`,`reward_time`)
);