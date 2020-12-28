CREATE TABLE IF NOT EXISTS `mg_itempaints` (
	`weaponid` int(10) unsigned NOT NULL,
	`type` smallint(5) unsigned NOT NULL,
	`paintid` smallint(5) unsigned NOT NULL,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`weaponid`,`type`),
	KEY `weaponid` (`weaponid`),
	CONSTRAINT `mg_itempaints` FOREIGN KEY (`weaponid`) REFERENCES `mg_items` (`id`) ON DELETE CASCADE
);