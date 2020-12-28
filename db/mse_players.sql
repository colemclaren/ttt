CREATE TABLE IF NOT EXISTS `mse_players` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(30) NOT NULL,
	`rank` mediumtext NOT NULL,
	`cooldown` int(11) NOT NULL,
	`amount` int(11) NOT NULL,
	PRIMARY KEY (`id`)
);