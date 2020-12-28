CREATE TABLE IF NOT EXISTS `moat_rollsave` (
	`id` int(255) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(32) NOT NULL,
	`item_tbl` mediumtext NOT NULL,
	PRIMARY KEY (`id`),
	KEY `steamid` (`steamid`)
);