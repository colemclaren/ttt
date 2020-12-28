CREATE TABLE IF NOT EXISTS `mg_players` (
	`id` bigint(20) unsigned NOT NULL,
	`var` char(1) NOT NULL,
	`val` int(10) unsigned NOT NULL,
	`createdat` timestamp DEFAULT CURRENT_TIMESTAMP,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`,`var`),
	UNIQUE KEY `id` (`id`,`var`) USING BTREE
);