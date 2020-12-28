CREATE TABLE IF NOT EXISTS `stats` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(30) NOT NULL,
	`credits` int(11) NOT NULL,
	`time` int(11) NOT NULL,
	`rank` mediumtext NOT NULL,
	`name` mediumtext NOT NULL,
	PRIMARY KEY (`id`)
);