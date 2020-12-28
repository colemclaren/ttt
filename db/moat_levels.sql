CREATE TABLE IF NOT EXISTS `moat_levels` (
	`steam_id` bigint(20) NOT NULL,
	`color_r` int(11) DEFAULT NULL,
	`color_g` int(11) DEFAULT NULL,
	`color_b` int(11) DEFAULT NULL,
	`color_effect` int(11) DEFAULT NULL,
	`updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`steam_id`)
);