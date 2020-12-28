CREATE TABLE IF NOT EXISTS `mg_items` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`itemid` int(10) unsigned NOT NULL,
	`ownerid` bigint(20) unsigned NOT NULL,
	`slotid` int(10) DEFAULT NULL,
	`classname` varchar(32) DEFAULT NULL,
	`createdat` timestamp DEFAULT CURRENT_TIMESTAMP,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	KEY `ownerid` (`ownerid`)
);