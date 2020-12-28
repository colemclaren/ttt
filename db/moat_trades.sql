CREATE TABLE IF NOT EXISTS `moat_trades` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`time` int(11) NOT NULL,
	`my_steamid` varchar(30) NOT NULL,
	`their_steamid` varchar(30) NOT NULL,
	`my_nick` mediumtext NOT NULL,
	`their_nick` mediumtext NOT NULL,
	`trade_tbl` mediumtext NOT NULL,
	PRIMARY KEY (`ID`)
);