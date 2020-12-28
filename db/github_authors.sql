CREATE TABLE IF NOT EXISTS `github_authors` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`uid` varchar(255) NOT NULL,
	`name` mediumtext NOT NULL,
	`email` mediumtext NOT NULL,
	`node_id` mediumtext DEFAULT NULL,
	`avatar_url` mediumtext DEFAULT NULL,
	`github_url` mediumtext DEFAULT NULL,
	`moat_url` mediumtext DEFAULT NULL,
	`steam_url` mediumtext DEFAULT NULL,
	`bio` text DEFAULT NULL,
	`jobs` int(1) DEFAULT NULL,
	`hide` tinyint(1) DEFAULT NULL,
	PRIMARY KEY (`uid`),
	UNIQUE KEY `id` (`id`,`uid`) USING BTREE
);