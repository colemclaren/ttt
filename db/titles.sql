CREATE TABLE IF NOT EXISTS `titles` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(30) NOT NULL,
	`title` mediumtext NOT NULL,
	`color` mediumtext NOT NULL,
	`changerid` varchar(30) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `steamid` (`steamid`)
);