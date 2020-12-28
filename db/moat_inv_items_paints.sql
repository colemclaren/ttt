CREATE TABLE IF NOT EXISTS `moat_inv_items_paints` (
	`weaponid` int(10) unsigned NOT NULL,
	`type` smallint(5) unsigned NOT NULL,
	`paintid` smallint(5) unsigned NOT NULL,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);