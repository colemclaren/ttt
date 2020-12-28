CREATE TABLE IF NOT EXISTS `moat_itemqueue` (
	`id` int(255) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(255) NOT NULL,
	`item` mediumtext NOT NULL,
	PRIMARY KEY (`id`)
);