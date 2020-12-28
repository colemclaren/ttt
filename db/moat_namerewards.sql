CREATE TABLE IF NOT EXISTS `moat_namerewards` (
	`steamid` varchar(32) NOT NULL,
	`last_name` int(11) NOT NULL,
	`last_reward` int(11) NOT NULL,
	`pending_ic` int(11) NOT NULL,
	`pending_sc` int(11) NOT NULL,
	PRIMARY KEY (`steamid`)
);