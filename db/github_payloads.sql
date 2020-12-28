CREATE TABLE IF NOT EXISTS `github_payloads` (
	`pid` int(11) NOT NULL AUTO_INCREMENT,
	`time` timestamp DEFAULT CURRENT_TIMESTAMP,
	`payload` longtext NOT NULL,
	PRIMARY KEY (`pid`)
);