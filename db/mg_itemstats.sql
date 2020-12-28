CREATE TABLE IF NOT EXISTS `mg_itemstats` (
	`weaponid` int(10) unsigned NOT NULL,
	`statid` char(1) NOT NULL,
	`value` float NOT NULL,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`weaponid`,`statid`),
	KEY `weaponid` (`weaponid`),
	CONSTRAINT `fk_mg_itemstats_mg_items` FOREIGN KEY (`weaponid`) REFERENCES `mg_items` (`id`) ON DELETE CASCADE
);