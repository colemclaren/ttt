CREATE TABLE IF NOT EXISTS `player_bans_votekick` (
	`steam_id` bigint(20) NOT NULL,
	`staff_steam_id` bigint(20) NOT NULL,
	`reason` varchar(255) NOT NULL,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`steam_id`)
);