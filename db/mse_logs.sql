CREATE TABLE IF NOT EXISTS `mse_logs` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(30) NOT NULL,
	`cmd` mediumtext NOT NULL,
	`time` mediumtext NOT NULL,
	PRIMARY KEY (`id`)
);