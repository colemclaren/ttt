CREATE TABLE IF NOT EXISTS `damagelog_oldlogs` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`server` tinytext NOT NULL,
	`map` tinytext NOT NULL,
	`round` tinyint(4) NOT NULL,
	`damagelog` longblob NOT NULL,
	PRIMARY KEY (`id`)
);