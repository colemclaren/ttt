CREATE TABLE IF NOT EXISTS `moat_versus` (
	`steamid` varchar(20) NOT NULL,
	`money` int(11) NOT NULL,
	`time` int(11) DEFAULT NULL,
	`other` varchar(20) DEFAULT NULL,
	`winner` varchar(20) DEFAULT NULL,
	`rewarded` tinyint(1) DEFAULT NULL,
	PRIMARY KEY (`steamid`)
);