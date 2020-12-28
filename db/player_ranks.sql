CREATE TABLE IF NOT EXISTS `player_ranks` (
	`name` varchar(255) NOT NULL,
	`weight` int(11) NOT NULL,
	`flags` tinytext NOT NULL,
	PRIMARY KEY (`name`)
);