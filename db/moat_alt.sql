CREATE TABLE IF NOT EXISTS `moat_alt` (
	`steamid64` bigint(20) NOT NULL,
	`fp1` int(11) NOT NULL,
	`fp2` bigint(20) NOT NULL,
	`fp3` bigint(20) NOT NULL,
	PRIMARY KEY (`steamid64`),
	KEY `fp1` (`fp1`),
	KEY `fp2` (`fp2`),
	KEY `fp3` (`fp3`)
);