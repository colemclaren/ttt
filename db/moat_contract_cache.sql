CREATE TABLE IF NOT EXISTS `moat_contract_cache` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`wpns` int(10) unsigned DEFAULT NULL,
	`kills` int(10) unsigned DEFAULT NULL,
	`last_updated` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
);