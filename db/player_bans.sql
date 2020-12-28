CREATE TABLE IF NOT EXISTS `player_bans` (
	`id` int(5) NOT NULL AUTO_INCREMENT,
	`time` int(11) DEFAULT NULL,
	`steam_id` bigint(17) DEFAULT NULL,
	`staff_steam_id` bigint(17) DEFAULT NULL,
	`name` varchar(100) DEFAULT NULL,
	`staff_name` varchar(100) DEFAULT NULL,
	`length` int(11) DEFAULT NULL,
	`reason` varchar(200) DEFAULT NULL,
	`unban_reason` varchar(200) DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `SteamID` (`steam_id`),
	KEY `A_SteamID` (`staff_steam_id`),
	KEY `Name` (`name`),
	KEY `A_Name` (`staff_name`),
	KEY `length` (`length`),
	KEY `time` (`time`)
);
