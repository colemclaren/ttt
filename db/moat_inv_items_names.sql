CREATE TABLE IF NOT EXISTS `moat_inv_items_names` (
	`weaponid` int(10) unsigned NOT NULL,
	`nickname` varchar(32) NOT NULL,
	`changerid` bigint(20) unsigned NOT NULL,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);