CREATE TABLE IF NOT EXISTS `moat_stats` (
	`steamid` varchar(32) NOT NULL,
	`stats_tbl` mediumtext NOT NULL,
	PRIMARY KEY (`steamid`)
);