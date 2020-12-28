CREATE TABLE IF NOT EXISTS `moat_versus_meme` (
	`steamid` varchar(100) NOT NULL,
	`money` int(11) NOT NULL,
	`time` int(11) DEFAULT NULL,
	`other` varchar(255) DEFAULT NULL,
	`winner` varchar(255) DEFAULT NULL,
	`rewarded` tinyint(1) DEFAULT NULL,
	PRIMARY KEY (`steamid`)
);