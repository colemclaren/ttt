CREATE TABLE IF NOT EXISTS `moat_lottery_players` (
	`steamid` varchar(32) NOT NULL,
	`name` varchar(255) DEFAULT NULL,
	`ticket` int(11) NOT NULL,
	PRIMARY KEY (`steamid`)
);