CREATE TABLE IF NOT EXISTS `player_gmod` (
	`data_day` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`owners` int(11) NOT NULL,
	`price` float NOT NULL,
	`event` varchar(255) DEFAULT NULL,
	`event_link` varchar(255) DEFAULT NULL,
	PRIMARY KEY (`data_day`)
);