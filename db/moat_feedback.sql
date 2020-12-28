CREATE TABLE IF NOT EXISTS `moat_feedback` (
	`vote` int(11) NOT NULL,
	`map` varchar(100) NOT NULL,
	`steamid` varchar(32) NOT NULL,
	KEY `vote` (`vote`),
	KEY `map` (`map`),
	KEY `steamid` (`steamid`)
);