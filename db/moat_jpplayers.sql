CREATE TABLE IF NOT EXISTS `moat_jpplayers` (
	`steamid` varchar(255) NOT NULL,
	`money` text NOT NULL,
	`winner` int(11) DEFAULT NULL,
	PRIMARY KEY (`steamid`)
);