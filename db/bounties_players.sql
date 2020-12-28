CREATE TABLE IF NOT EXISTS `bounties_players` (
	`steamid` varchar(100) NOT NULL,
	`score` text NOT NULL,
	PRIMARY KEY (`steamid`)
);