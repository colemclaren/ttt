CREATE TABLE IF NOT EXISTS `player_cmds` (
	`name` varchar(100) NOT NULL,
	`flag` char(1) DEFAULT NULL,
	`weight` bit(1) DEFAULT b'0',
	`args` mediumtext DEFAULT NULL,
	PRIMARY KEY (`name`)
);