CREATE TABLE IF NOT EXISTS `moat_comps` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`time` int(11) NOT NULL,
	`steamid` varchar(255) NOT NULL,
	`admin` mediumtext NOT NULL,
	`link` mediumtext NOT NULL,
	`ic` mediumtext NOT NULL,
	`ec` mediumtext NOT NULL,
	`sc` mediumtext DEFAULT NULL,
	`item` mediumtext NOT NULL,
	`class` mediumtext NOT NULL,
	`talent1` mediumtext NOT NULL,
	`talent2` mediumtext NOT NULL,
	`talent3` mediumtext NOT NULL,
	`talent4` mediumtext NOT NULL,
	`comment` mediumtext NOT NULL,
	`approved` mediumtext NOT NULL,
	PRIMARY KEY (`ID`)
);