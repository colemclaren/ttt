CREATE TABLE IF NOT EXISTS `ac_hashes_real` (
	`hash` binary(64) NOT NULL,
	`triggers` int(10) unsigned NOT NULL DEFAULT 1,
	PRIMARY KEY (`hash`)
);