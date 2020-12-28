CREATE TABLE IF NOT EXISTS `moat_tradebans` (
	`steamid64` bigint(20) unsigned NOT NULL,
	`banner` bigint(20) unsigned DEFAULT NULL,
	`reason` varchar(128) NOT NULL,
	`unban_time` timestamp NULL DEFAULT NULL,
	KEY `steamid64` (`steamid64`) USING BTREE
);