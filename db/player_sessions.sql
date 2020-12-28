CREATE TABLE IF NOT EXISTS `player_sessions` (
	`steamid64` bigint(20) NOT NULL,
	`time` int(11) NOT NULL,
	`server` varchar(32) NOT NULL,
	`name` varchar(100) NOT NULL,
	`rank` mediumtext NOT NULL,
	`level` int(11) NOT NULL,
	`team_kills` int(11) NOT NULL,
	`slays` int(11) NOT NULL,
	PRIMARY KEY (`steamid64`),
	KEY `name` (`name`)
);