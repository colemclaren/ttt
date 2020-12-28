CREATE TABLE IF NOT EXISTS `moat_lottery_winners` (
	`steamid` varchar(32) NOT NULL,
	`amount` int(11) NOT NULL,
	PRIMARY KEY (`steamid`)
);