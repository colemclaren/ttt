CREATE TABLE IF NOT EXISTS `rcon_queue` (
	`cmdid` int(10) unsigned NOT NULL,
	`server` varchar(255) NOT NULL,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`cmdid`,`server`),
	CONSTRAINT `fk_rcon_queue_rcon_commands` FOREIGN KEY (`cmdid`) REFERENCES `rcon_commands` (`id`) ON DELETE CASCADE
);