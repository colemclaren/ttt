CREATE TABLE IF NOT EXISTS `moat_inventories_dev` (
	`steamid` varchar(255) NOT NULL,
	`max_slots` int(255) NOT NULL,
	`credits` text NOT NULL,
	`l_slot1` text DEFAULT NULL,
	`l_slot2` text DEFAULT NULL,
	`l_slot3` text DEFAULT NULL,
	`l_slot4` text DEFAULT NULL,
	`l_slot5` text DEFAULT NULL,
	`l_slot6` text DEFAULT NULL,
	`l_slot7` text DEFAULT NULL,
	`l_slot8` text DEFAULT NULL,
	`l_slot9` text DEFAULT NULL,
	`l_slot10` text DEFAULT NULL,
	`inventory` mediumtext NOT NULL,
	PRIMARY KEY (`steamid`)
);