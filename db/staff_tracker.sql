CREATE TABLE IF NOT EXISTS `staff_tracker` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`steamid` bigint(20) unsigned NOT NULL,
	`join_time` timestamp DEFAULT CURRENT_TIMESTAMP,
	`leave_time` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`rounds_played` tinyint(10) unsigned NOT NULL DEFAULT 0,
	`rounds_on` int(10) unsigned NOT NULL DEFAULT 0,
	`time_played` int(10) unsigned NOT NULL DEFAULT 0,
	`reports_handled` smallint(10) unsigned NOT NULL DEFAULT 0,
	`server_ip` int(4) unsigned NOT NULL,
	`server_port` smallint(2) unsigned NOT NULL,
	PRIMARY KEY (`id`),
	KEY `join_time` (`join_time`),
	KEY `leave_time` (`leave_time`),
	KEY `steamid` (`steamid`),
	KEY `server_ip` (`server_ip`),
	KEY `server_port` (`server_port`)
);