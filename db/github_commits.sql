CREATE TABLE IF NOT EXISTS `github_commits` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`sha` varchar(40) NOT NULL,
	`date` datetime NOT NULL,
	`repo_id` mediumtext NOT NULL,
	`author_id` int(11) NOT NULL,
	`summary` mediumtext NOT NULL,
	`type` mediumtext DEFAULT NULL,
	`branch` mediumtext NOT NULL,
	`files_modified` int(11) NOT NULL,
	`payload` int(11) NOT NULL,
	`hide` tinyint(1) DEFAULT NULL,
	`lines_added` int(11) DEFAULT NULL,
	`lines_removed` int(11) DEFAULT NULL,
	PRIMARY KEY (`sha`),
	UNIQUE KEY `id` (`id`) USING BTREE
);