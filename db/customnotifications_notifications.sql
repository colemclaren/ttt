CREATE TABLE IF NOT EXISTS `customnotifications_notifications` (
	`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID Number',
	`options` mediumtext DEFAULT NULL,
	`enabled` tinyint(1) NOT NULL DEFAULT 1,
	`to_run` int(10) DEFAULT 0,
	`bf_options` int(11) NOT NULL DEFAULT 0,
	`url` mediumtext DEFAULT NULL,
	`member_id` int(11) NOT NULL DEFAULT 0,
	`sent_on` int(11) DEFAULT NULL,
	PRIMARY KEY (`id`)
);