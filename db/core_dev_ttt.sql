CREATE TABLE IF NOT EXISTS `core_dev_ttt` (
	`steamid` varchar(100) NOT NULL,
	`max_slots` int(255) NOT NULL,
	`credits` mediumtext NOT NULL,
	`l_slot1` mediumtext DEFAULT NULL,
	`l_slot2` mediumtext DEFAULT NULL,
	`l_slot3` mediumtext DEFAULT NULL,
	`l_slot4` mediumtext DEFAULT NULL,
	`l_slot5` mediumtext DEFAULT NULL,
	`l_slot6` mediumtext DEFAULT NULL,
	`l_slot7` mediumtext DEFAULT NULL,
	`l_slot8` mediumtext DEFAULT NULL,
	`l_slot9` mediumtext DEFAULT NULL,
	`l_slot10` mediumtext DEFAULT NULL,
	`inventory` longtext NOT NULL,
	PRIMARY KEY (`steamid`)
);