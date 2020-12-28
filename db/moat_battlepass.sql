CREATE TABLE IF NOT EXISTS `moat_battlepass` (
	`steamid` varchar(32) NOT NULL,
	`tier` int(11) DEFAULT NULL,
	`xp` int(11) DEFAULT NULL,
	PRIMARY KEY (`steamid`)
);