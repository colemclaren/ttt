CREATE TABLE IF NOT EXISTS `gmod_owners` (
	`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	`date` varchar(255) NOT NULL,
	`start` int(11) NOT NULL,
	`end` int(11) NOT NULL,
	`difference` int(11) NOT NULL,
	PRIMARY KEY (`id`)
);