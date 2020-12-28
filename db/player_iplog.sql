CREATE TABLE IF NOT EXISTS `player_iplog` (
	`LastSeen` bigint(20) NOT NULL,
	`SteamID` varchar(50) NOT NULL,
	`Address` varchar(50) NOT NULL,
	KEY `SteamID` (`SteamID`),
	KEY `Address` (`Address`)
);