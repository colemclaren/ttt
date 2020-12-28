CREATE TABLE IF NOT EXISTS `ac_hash_track_real` (
	`steamid` bigint(20) unsigned NOT NULL,
	`hash` binary(64) NOT NULL,
	PRIMARY KEY (`steamid`,`hash`)
);