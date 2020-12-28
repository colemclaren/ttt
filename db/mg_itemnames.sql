CREATE TABLE IF NOT EXISTS `mg_itemnames` (
	`weaponid` int(10) unsigned NOT NULL,
	`nickname` varchar(32) NOT NULL,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`weaponid`),
	CONSTRAINT `mg_itemnames` FOREIGN KEY (`weaponid`) REFERENCES `mg_items` (`id`) ON DELETE CASCADE
);