#THE FIRST INVENTORY TTT SERVER
=========
From my past experiences, your gmod server's player slots __WILL__ become fulled or be filled up too quickly.

To fix this for garry, your requirements is MySQL server to launch __as many more totally__ new replicated gmod servers as we need effortlessly.

You absolutely __WILL__ see needs to expand your TTT server fleet right away if you're starting up with just one server.

#Whats Moat?
---
Moat is the best Trouble in Terrorist Town base. Developed between 2015 to 2020, Cole McLaren also known as elu, has released their entire lifes work on their TTT server. His whole SERVER codebase to the most addicting TTT servers on Garry's Mod (over 30 servers) was made public for free, so that setting up your community is simplified and easy.

#MySQL Server
---
Config located @ [system/cfg/sql/sv_config.lua](https://github.com/colemclaren/moat-gg-ttt/blob/master/addons/moat_addons/lua/system/cfg/sql/sv_config.lua#L3-L6).


#Database Schema
---
``Pro Tip: Database name is `forum` for most of the code.``

Here's the queries for your MySQL database schema for your server.

You can run these queries in your own table, or save the below code to a temporary SQL file, for example like \`moat.sql\`.

You must import these into your MySQL database to complete setup, before the inventories try to load on your server starting up.

Then import that temporary file to your MySQL \`forum\` database, subsequently creating the inventory data tables schema, which are absolutely necessary if you want to save data properly, like you should be doing between each of your players sessions on your server.

#License TL;DR
---
You may use or reditribute Moat TTT freely, provided you do not take credit for it and include the license.

#Pull Requests
---
Pull requests are welcome.

Please make sure your [line endings are correct](https://help.github.com/articles/dealing-with-line-endings/).

Also try to condense multiple commits down to easily see the changes made, either through [resetting the head](http://stackoverflow.com/a/5201642) or [rebasing the branch](http://stackoverflow.com/a/5189600).

#Issues and Requests
---
These are also welcome.

```sql
CREATE TABLE IF NOT EXISTS `core_dev_ttt` (
	`steamid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`max_slots` int(255) NOT NULL,
	`credits` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`l_slot1` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot2` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot3` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot4` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot5` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot6` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot7` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot8` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot9` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot10` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`inventory` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `ac_hash_track_real` (
	`steamid` bigint(20) unsigned NOT NULL,
	`hash` binary(64) NOT NULL,
	PRIMARY KEY (`steamid`,`hash`)
);

CREATE TABLE IF NOT EXISTS `ac_hashes_real` (
	`hash` binary(64) NOT NULL,
	`triggers` int(10) unsigned NOT NULL DEFAULT 1,
	PRIMARY KEY (`hash`)
);

CREATE TABLE IF NOT EXISTS `bounties_current` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`bounties` text COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS `bounties_players` (
	`steamid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`score` text COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `core_members` (
	`member_id` mediumint(8) NOT NULL AUTO_INCREMENT,
	`name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
	`member_group_id` smallint(3) NOT NULL DEFAULT 0,
	`email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
	`joined` int(10) NOT NULL DEFAULT 0,
	`ip_address` varchar(46) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
	`skin` smallint(5) DEFAULT NULL,
	`warn_level` int(10) DEFAULT NULL,
	`warn_lastwarn` int(10) NOT NULL DEFAULT 0,
	`language` mediumint(4) DEFAULT NULL,
	`restrict_post` int(10) NOT NULL DEFAULT 0,
	`bday_day` int(2) DEFAULT NULL,
	`bday_month` int(2) DEFAULT NULL,
	`bday_year` int(4) DEFAULT NULL,
	`msg_count_new` int(2) NOT NULL DEFAULT 0,
	`msg_count_total` int(3) NOT NULL DEFAULT 0,
	`msg_count_reset` int(1) NOT NULL DEFAULT 0,
	`msg_show_notification` int(1) NOT NULL DEFAULT 0,
	`last_visit` int(10) DEFAULT 0,
	`last_activity` int(10) DEFAULT 0,
	`mod_posts` int(10) NOT NULL DEFAULT 0,
	`auto_track` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0',
	`temp_ban` int(10) DEFAULT 0,
	`mgroup_others` varchar(245) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
	`member_login_key_expire` int(10) NOT NULL DEFAULT 0,
	`members_seo_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
	`members_cache` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`failed_logins` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`failed_login_count` smallint(3) NOT NULL DEFAULT 0,
	`members_profile_views` int(10) unsigned NOT NULL DEFAULT 0,
	`members_pass_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`members_pass_salt` varchar(22) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`members_bitoptions` int(10) unsigned NOT NULL DEFAULT 0,
	`fb_uid` bigint(20) unsigned NOT NULL DEFAULT 0,
	`members_day_posts` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0,0',
	`live_id` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`twitter_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
	`twitter_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
	`twitter_secret` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
	`notification_cnt` mediumint(9) NOT NULL DEFAULT 0,
	`fb_token` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`ipsconnect_id` int(10) NOT NULL DEFAULT 0,
	`google_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`linkedin_id` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`pp_last_visitors` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`pp_main_photo` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`pp_main_width` int(5) DEFAULT NULL,
	`pp_main_height` int(5) DEFAULT NULL,
	`pp_thumb_photo` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`pp_thumb_width` int(5) DEFAULT NULL,
	`pp_thumb_height` int(5) DEFAULT NULL,
	`pp_setting_count_comments` int(2) DEFAULT NULL,
	`pp_reputation_points` int(10) DEFAULT NULL,
	`pp_photo_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`signature` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`pconversation_filters` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`fb_photo` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`fb_photo_thumb` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`fb_bwoptions` int(10) DEFAULT NULL,
	`tc_last_sid_import` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`tc_photo` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`tc_bwoptions` int(10) DEFAULT NULL,
	`pp_customization` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`timezone` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`pp_cover_photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
	`profilesync` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`profilesync_lastsync` int(10) NOT NULL DEFAULT 0 COMMENT 'Indicates the last time any profile sync service was ran',
	`google_token` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`linkedin_token` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`live_token` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`allow_admin_mails` bit(1) DEFAULT b'0',
	`members_bitoptions2` int(10) unsigned NOT NULL DEFAULT 0,
	`create_menu` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Cached contents of the "Create" drop down menu.',
	`ipsconnect_revalidate_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`members_disable_pm` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '0 - not disabled, 1 - disabled, member can re-enable, 2 - disabled',
	`marked_site_read` int(10) unsigned DEFAULT 0,
	`pp_cover_offset` int(10) NOT NULL DEFAULT 0,
	`acp_skin` smallint(6) DEFAULT NULL,
	`acp_language` mediumint(9) DEFAULT NULL,
	`member_title` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`member_posts` mediumint(7) NOT NULL DEFAULT 0,
	`member_last_post` int(10) DEFAULT NULL,
	`member_streams` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`photo_last_update` int(10) DEFAULT NULL,
	`steamid` varchar(17) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`kuzi_song_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'Profile song path.',
	`failed_mfa_attempts` smallint(3) unsigned DEFAULT 0 COMMENT 'Number of times tried and failed MFA',
	`unlucky_enable` int(1) DEFAULT 0,
	`unlucky_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
	`mfa_details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`permission_array` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'A cache of the clubs and social groups that the member is in',
	`discord_id` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`discord_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`account_closed` tinyint(1) unsigned DEFAULT 0,
	`account_closed_reason` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`autoreplypm_on` tinyint(1) DEFAULT 0,
	`autoreplypm_text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`nbcontentratings_positive` int(10) unsigned DEFAULT NULL,
	`nbcontentratings_negative` int(10) unsigned DEFAULT NULL,
	`nbcontentratings_neutral` int(10) unsigned DEFAULT NULL,
	`tm_member_tracked` tinyint(1) NOT NULL DEFAULT 0,
	`tm_member_tracked_deadline` int(10) NOT NULL DEFAULT 0,
	`tm_member_tracked_log_entries` int(10) NOT NULL DEFAULT 0,
	`tm_member_tracked_actions` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`completed` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Whether the account is completed or not',
	`conv_password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`conv_password_extra` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`membermap_location_synced` tinyint(1) DEFAULT 0,
	`cm_credits` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`cm_no_sev` tinyint(1) DEFAULT 0,
	`cm_return_group` smallint(3) DEFAULT 0,
	`idm_block_submissions` tinyint(1) unsigned DEFAULT 0 COMMENT 'Blocked from submitting Downloads files?',
	PRIMARY KEY (`member_id`),
	UNIQUE KEY `discord_id` (`discord_id`),
	KEY `bday_day` (`bday_day`),
	KEY `bday_month` (`bday_month`),
	KEY `members_bitoptions` (`members_bitoptions`),
	KEY `ip_address` (`ip_address`),
	KEY `failed_login_count` (`failed_login_count`),
	KEY `joined` (`joined`),
	KEY `fb_uid` (`fb_uid`),
	KEY `twitter_id` (`twitter_id`(191)),
	KEY `email` (`email`),
	KEY `member_groups` (`member_group_id`,`mgroup_others`(188)),
	KEY `google_id` (`google_id`),
	KEY `linkedin_id` (`linkedin_id`),
	KEY `mgroup` (`member_id`,`member_group_id`),
	KEY `allow_admin_mails` (`allow_admin_mails`),
	KEY `name_index` (`name`(191)),
	KEY `ipsconnect_id` (`ipsconnect_id`),
	KEY `mod_posts` (`mod_posts`),
	KEY `photo_last_update` (`photo_last_update`),
	KEY `steamid` (`steamid`),
	KEY `last_activity` (`last_activity`),
	KEY `completed` (`completed`,`temp_ban`),
	KEY `profilesync` (`profilesync_lastsync`,`profilesync`(150))
);

CREATE TABLE IF NOT EXISTS `github_authors` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`uid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`name` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`email` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`node_id` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`avatar_url` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`github_url` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`moat_url` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`steam_url` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`bio` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`jobs` int(1) DEFAULT NULL,
	`hide` tinyint(1) DEFAULT NULL,
	PRIMARY KEY (`uid`),
	UNIQUE KEY `id` (`id`,`uid`) USING BTREE
);

CREATE TABLE IF NOT EXISTS `github_commits` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`sha` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
	`date` datetime NOT NULL,
	`repo_id` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`author_id` int(11) NOT NULL,
	`summary` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`type` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`branch` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`files_modified` int(11) NOT NULL,
	`payload` int(11) NOT NULL,
	`hide` tinyint(1) DEFAULT NULL,
	`lines_added` int(11) DEFAULT NULL,
	`lines_removed` int(11) DEFAULT NULL,
	PRIMARY KEY (`sha`),
	UNIQUE KEY `id` (`id`) USING BTREE
);

CREATE TABLE IF NOT EXISTS `github_payloads` (
	`pid` int(11) NOT NULL AUTO_INCREMENT,
	`time` timestamp DEFAULT CURRENT_TIMESTAMP,
	`payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`pid`)
);

CREATE TABLE IF NOT EXISTS `gmod_owners` (
	`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
	`date` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`start` int(11) NOT NULL,
	`end` int(11) NOT NULL,
	`difference` int(11) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `lola_error_reports` (
	`id` int(11) NOT NULL,
	`messageid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `mg_itemnames` (
	`weaponid` int(10) unsigned NOT NULL,
	`nickname` varchar(32) NOT NULL,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`weaponid`),
	CONSTRAINT `mg_itemnames_ibfk_1` FOREIGN KEY (`weaponid`) REFERENCES `mg_items` (`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `mg_itempaints` (
	`weaponid` int(10) unsigned NOT NULL,
	`type` smallint(5) unsigned NOT NULL,
	`paintid` smallint(5) unsigned NOT NULL,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`weaponid`,`type`),
	KEY `weaponid` (`weaponid`),
	CONSTRAINT `mg_itempaints_ibfk_1` FOREIGN KEY (`weaponid`) REFERENCES `mg_items` (`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `mg_items` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`itemid` int(10) unsigned NOT NULL,
	`ownerid` bigint(20) unsigned NOT NULL,
	`slotid` int(10) DEFAULT NULL,
	`classname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
	`createdat` timestamp DEFAULT CURRENT_TIMESTAMP,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	KEY `ownerid` (`ownerid`)
);

CREATE TABLE IF NOT EXISTS `mg_itemstats` (
	`weaponid` int(10) unsigned NOT NULL,
	`statid` char(1) NOT NULL,
	`value` float NOT NULL,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`weaponid`,`statid`),
	KEY `weaponid` (`weaponid`),
	CONSTRAINT `mg_itemstats_ibfk_1` FOREIGN KEY (`weaponid`) REFERENCES `mg_items` (`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `mg_itemtalents` (
	`weaponid` int(10) unsigned NOT NULL,
	`talentid` smallint(5) unsigned NOT NULL,
	`required` smallint(5) unsigned DEFAULT NULL,
	`modification` tinyint(3) unsigned NOT NULL,
	`value` float NOT NULL,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	KEY `weaponid` (`weaponid`),
	CONSTRAINT `mg_itemtalents_ibfk_1` FOREIGN KEY (`weaponid`) REFERENCES `mg_items` (`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `mg_players` (
	`id` bigint(20) unsigned NOT NULL,
	`var` char(1) NOT NULL,
	`val` int(10) unsigned NOT NULL,
	`createdat` timestamp DEFAULT CURRENT_TIMESTAMP,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`,`var`),
	UNIQUE KEY `id` (`id`,`var`) USING BTREE
);

CREATE TABLE IF NOT EXISTS `moat_alt` (
	`steamid64` bigint(20) NOT NULL,
	`fp1` int(11) NOT NULL,
	`fp2` bigint(20) NOT NULL,
	`fp3` bigint(20) NOT NULL,
	PRIMARY KEY (`steamid64`),
	KEY `fp1` (`fp1`),
	KEY `fp2` (`fp2`),
	KEY `fp3` (`fp3`)
);

CREATE TABLE IF NOT EXISTS `moat_battlepass` (
	`steamid` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
	`tier` int(11) DEFAULT NULL,
	`xp` int(11) DEFAULT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_comps` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`time` int(11) NOT NULL,
	`steamid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`admin` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`link` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`ic` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`ec` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`sc` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`item` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`class` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`talent1` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`talent2` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`talent3` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`talent4` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`comment` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`approved` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS `moat_contract_cache` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`wpns` int(10) unsigned DEFAULT NULL,
	`kills` int(10) unsigned DEFAULT NULL,
	`last_updated` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `moat_contractplayers` (
	`steamid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`score` int(11) NOT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_contractplayers_v2` (
	`steamid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`score` int(11) NOT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_contractrig` (
	`contract` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`contract`)
);

CREATE TABLE IF NOT EXISTS `moat_contracts` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`contract` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`start_time` int(11) NOT NULL,
	`active` int(11) NOT NULL,
	`refresh_next` int(11) DEFAULT NULL,
	`updating_server` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	PRIMARY KEY (`ID`),
	KEY `active` (`active`),
	KEY `refresh_next` (`refresh_next`)
);

CREATE TABLE IF NOT EXISTS `moat_contracts_revamped` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`contract` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`start_time` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`updating_server` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS `moat_contracts_test` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`contract` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`start_time` int(11) NOT NULL,
	`active` int(11) NOT NULL,
	`refresh_next` int(11) DEFAULT NULL,
	`updating_server` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS `moat_contracts_v2` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`contract` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
	`start_time` timestamp NULL DEFAULT NULL,
	`contract_id` int(11) NOT NULL,
	`updating_server` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS `moat_contractwinners` (
	`steamid` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
	`place` int(11) NOT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_contractwinners_v2` (
	`steamid` bigint(20) unsigned NOT NULL,
	`place` int(10) unsigned NOT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_discord` (
	`steamid` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
	`oauth` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_errors` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`error` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`serverip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`realm` tinyint(1) NOT NULL,
	`stack` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`steamid` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `moat_feedback` (
	`vote` int(11) NOT NULL,
	`map` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`steamid` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
	KEY `vote` (`vote`),
	KEY `map` (`map`),
	KEY `steamid` (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_forums` (
	`id` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
	`num` int(11) DEFAULT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `moat_gchat` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`time` int(11) NOT NULL,
	`name` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
	`msg` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`ID`),
	KEY `time` (`time`)
);

CREATE TABLE IF NOT EXISTS `moat_inv_items_names` (
	`weaponid` int(10) unsigned NOT NULL,
	`nickname` varchar(32) NOT NULL,
	`changerid` bigint(20) unsigned NOT NULL,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `moat_inv_items_paints` (
	`weaponid` int(10) unsigned NOT NULL,
	`type` smallint(5) unsigned NOT NULL,
	`paintid` smallint(5) unsigned NOT NULL,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `moat_inv_items_talents` (
	`weaponid` int(10) unsigned NOT NULL,
	`talentid` smallint(5) unsigned NOT NULL,
	`required` smallint(5) unsigned DEFAULT NULL,
	`modification` tinyint(3) unsigned NOT NULL,
	`value` float NOT NULL,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	KEY `weaponid` (`weaponid`),
	CONSTRAINT `moat_inv_items_talents_ibfk_1` FOREIGN KEY (`weaponid`) REFERENCES `moat_inv_items` (`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `moat_inv_players` (
	`id` bigint(20) unsigned NOT NULL,
	`var` char(1) NOT NULL,
	`val` int(10) unsigned NOT NULL,
	`createdat` timestamp DEFAULT CURRENT_TIMESTAMP,
	`updatedat` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`,`var`),
	UNIQUE KEY `id` (`id`,`var`) USING BTREE
);

CREATE TABLE IF NOT EXISTS `moat_inventories` (
	`steamid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`max_slots` int(255) NOT NULL,
	`credits` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`l_slot1` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot2` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot3` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot4` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot5` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot6` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot7` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot8` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot9` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot10` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`inventory` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`steamid`)
);

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

CREATE TABLE IF NOT EXISTS `moat_inventories_test` (
	`steamid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`max_slots` int(255) NOT NULL,
	`credits` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`l_slot1` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot2` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot3` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot4` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot5` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot6` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot7` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot8` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot9` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot10` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`inventory` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_itemqueue` (
	`id` int(255) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`item` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `moat_jpgames` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`time_end` int(11) NOT NULL,
	`active` int(11) NOT NULL,
	`cool` int(11) DEFAULT NULL,
	PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS `moat_jpplayers` (
	`steamid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`money` text COLLATE utf8mb4_unicode_ci NOT NULL,
	`winner` int(11) DEFAULT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_jpservers` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`crc` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS `moat_jpwinners` (
	`steamid` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
	`money` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_lastnum` (
	`num` int(11) NOT NULL,
	PRIMARY KEY (`num`)
);

CREATE TABLE IF NOT EXISTS `moat_levels` (
	`steam_id` bigint(20) NOT NULL,
	`color_r` int(11) DEFAULT NULL,
	`color_g` int(11) DEFAULT NULL,
	`color_b` int(11) DEFAULT NULL,
	`color_effect` int(11) DEFAULT NULL,
	`updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`steam_id`)
);

CREATE TABLE IF NOT EXISTS `moat_logs` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`time` int(11) NOT NULL,
	`message` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS `moat_lottery` (
	`amount` int(11) NOT NULL,
	PRIMARY KEY (`amount`)
);

CREATE TABLE IF NOT EXISTS `moat_lottery_last` (
	`num` int(11) NOT NULL,
	PRIMARY KEY (`num`)
);

CREATE TABLE IF NOT EXISTS `moat_lottery_players` (
	`steamid` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
	`name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`ticket` int(11) NOT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_lottery_winners` (
	`steamid` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
	`amount` int(11) NOT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_mapvote_prevent` (
	`active` tinyint(4) NOT NULL,
	PRIMARY KEY (`active`)
);

CREATE TABLE IF NOT EXISTS `moat_megavape` (
	`itemid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`time` int(11) NOT NULL,
	PRIMARY KEY (`itemid`)
);

CREATE TABLE IF NOT EXISTS `moat_namerewards` (
	`steamid` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
	`last_name` int(11) NOT NULL,
	`last_reward` int(11) NOT NULL,
	`pending_ic` int(11) NOT NULL,
	`pending_sc` int(11) NOT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_pendingitems` (
	`steamid` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
	`item` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
);

CREATE TABLE IF NOT EXISTS `moat_rollsave` (
	`id` int(255) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
	`item_tbl` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`id`),
	KEY `steamid` (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_staff_commands` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`staff_steamid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
	`staff_rank` text COLLATE utf8mb4_unicode_ci NOT NULL,
	`staff_name` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`command` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`steamid` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`args` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`server_for` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`server_ran` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `moat_stats` (
	`steamid` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
	`stats_tbl` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_tradebans` (
	`steamid64` bigint(20) unsigned NOT NULL,
	`banner` bigint(20) unsigned DEFAULT NULL,
	`reason` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
	`unban_time` timestamp NULL DEFAULT NULL,
	KEY `steamid64` (`steamid64`) USING BTREE
);

CREATE TABLE IF NOT EXISTS `moat_trades` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`time` int(11) NOT NULL,
	`my_steamid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
	`their_steamid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
	`my_nick` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`their_nick` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`trade_tbl` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS `moat_versus` (
	`steamid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
	`money` int(11) NOT NULL,
	`time` int(11) DEFAULT NULL,
	`other` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`winner` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`rewarded` tinyint(1) DEFAULT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_versus_dev` (
	`steamid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`money` int(11) NOT NULL,
	`time` int(11) DEFAULT NULL,
	`other` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`winner` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`rewarded` tinyint(1) DEFAULT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_versus_meme` (
	`steamid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`money` int(11) NOT NULL,
	`time` int(11) DEFAULT NULL,
	`other` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`winner` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`rewarded` tinyint(1) DEFAULT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_versus_test` (
	`steamid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
	`money` int(11) NOT NULL,
	`time` int(11) DEFAULT NULL,
	`other` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`winner` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	PRIMARY KEY (`steamid`)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `moat_versus_v2` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`creator_steamid64` bigint(20) unsigned NOT NULL,
	`money` int(10) unsigned NOT NULL,
	`taker_steamid64` bigint(20) unsigned DEFAULT NULL,
	`roll_time` timestamp NULL DEFAULT NULL,
	`creator_won` tinyint(1) DEFAULT NULL,
	`reward_time` timestamp NULL DEFAULT NULL,
	`cancel_time` timestamp NULL DEFAULT NULL,
	`creation_time` timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	KEY `id` (`id`,`reward_time`)
);

CREATE TABLE IF NOT EXISTS `moat_versuslogs` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`other` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`winner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`amount` int(11) NOT NULL,
	`time` int(11) NOT NULL,
	`tax` int(11) DEFAULT NULL,
	PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS `moat_versusstreaks` (
	`steamid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`streak` int(11) NOT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_versusstreaks_history` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`streak` int(11) NOT NULL,
	`time` int(11) NOT NULL,
	PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS `moat_veterangamers` (
	`steamid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `moat_vswinners` (
	`ID` int(11) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`money` int(11) NOT NULL,
	PRIMARY KEY (`ID`)
);

CREATE TABLE IF NOT EXISTS `mse_logs` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
	`cmd` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`time` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `mse_players` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
	`rank` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`cooldown` int(11) NOT NULL,
	`amount` int(11) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `player` (
	`steam_id` bigint(17) NOT NULL,
	`name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`rank` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`first_join` int(10) DEFAULT NULL,
	`last_join` int(10) DEFAULT NULL,
	`avatar_url` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`playtime` int(10) DEFAULT NULL,
	`inventory_credits` int(10) unsigned DEFAULT NULL,
	`event_credits` int(10) unsigned DEFAULT NULL,
	`donator_credits` int(10) unsigned DEFAULT NULL,
	`extra` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`rank_expire` int(11) DEFAULT NULL,
	`rank_expire_to` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`rank_changed` int(11) DEFAULT NULL,
	`mvp_access` int(11) DEFAULT NULL,
	PRIMARY KEY (`steam_id`),
	KEY `rank` (`rank`),
	KEY `inventory_credits` (`inventory_credits`),
	KEY `playtime` (`playtime`),
	KEY `last_join` (`last_join`),
	FULLTEXT KEY `name` (`name`)
);

CREATE TABLE IF NOT EXISTS `player_bans` (
	`id` int(5) NOT NULL AUTO_INCREMENT,
	`time` int(11) DEFAULT NULL,
	`steam_id` bigint(17) DEFAULT NULL,
	`staff_steam_id` bigint(17) DEFAULT NULL,
	`name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`staff_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`length` int(11) DEFAULT NULL,
	`reason` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`unban_reason` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `SteamID` (`steam_id`),
	KEY `A_SteamID` (`staff_steam_id`),
	KEY `Name` (`name`),
	KEY `A_Name` (`staff_name`),
	KEY `length` (`length`),
	KEY `time` (`time`)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `player_bans_comms` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`ban_type` tinyint(3) unsigned NOT NULL,
	`steam_id` bigint(20) unsigned NOT NULL,
	`staff_steam_id` bigint(20) unsigned NOT NULL,
	`name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`staff_name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`length` int(10) unsigned DEFAULT NULL,
	`time` int(10) unsigned DEFAULT NULL,
	`reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`unban_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	KEY `steam_id` (`steam_id`),
	KEY `length` (`length`),
	KEY `time` (`time`),
	KEY `unban_reason` (`unban_reason`)
);

CREATE TABLE IF NOT EXISTS `player_bans_votekick` (
	`steam_id` bigint(20) NOT NULL,
	`staff_steam_id` bigint(20) NOT NULL,
	`reason` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`steam_id`)
);

CREATE TABLE IF NOT EXISTS `player_cmds` (
	`name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`flag` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`weight` bit(1) DEFAULT b'0',
	`args` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	PRIMARY KEY (`name`)
);

CREATE TABLE IF NOT EXISTS `player_gmod` (
	`data_day` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`owners` int(11) NOT NULL,
	`price` float NOT NULL,
	`event` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`event_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	PRIMARY KEY (`data_day`)
);

CREATE TABLE IF NOT EXISTS `player_iplog` (
	`LastSeen` bigint(20) NOT NULL,
	`SteamID` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
	`Address` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
	KEY `SteamID` (`SteamID`),
	KEY `Address` (`Address`)
);

CREATE TABLE IF NOT EXISTS `player_logs` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`steam_id` bigint(20) unsigned NOT NULL,
	`name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`cmd` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`args` text COLLATE utf8mb4_unicode_ci NOT NULL,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `player_ranks` (
	`name` varchar(255) NOT NULL,
	`weight` int(11) NOT NULL,
	`flags` tinytext NOT NULL,
	PRIMARY KEY (`name`)
);

CREATE TABLE IF NOT EXISTS `player_servers` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`full_ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`map` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'NULL',
	`players` int(10) unsigned DEFAULT NULL,
	`staff` int(10) unsigned DEFAULT NULL,
	`ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`port` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
	`custom_ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`join_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`hostname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'NULL',
	`map_changed` int(10) unsigned DEFAULT NULL,
	`max_players` int(10) unsigned DEFAULT NULL,
	`rounds_left` int(10) unsigned DEFAULT NULL,
	`round_state` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
	`time_left` int(10) unsigned DEFAULT NULL,
	`map_time_left` int(10) unsigned DEFAULT NULL,
	`traitors_alive` int(10) unsigned DEFAULT NULL,
	`innocents_alive` int(10) unsigned DEFAULT NULL,
	`others_alive` int(10) unsigned DEFAULT NULL,
	`spectators` int(10) unsigned DEFAULT NULL,
	`traitor_wins` int(10) unsigned DEFAULT NULL,
	`innocent_wins` int(10) unsigned DEFAULT NULL,
	`top_player_steamid` bigint(20) unsigned DEFAULT NULL,
	`top_player_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`top_player_score` int(10) unsigned DEFAULT NULL,
	`special_round` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`map_event` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`last_update` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	UNIQUE KEY `ip` (`ip`,`port`),
	UNIQUE KEY `full_ip` (`full_ip`)
);

CREATE TABLE IF NOT EXISTS `player_sessions` (
	`steamid64` bigint(20) NOT NULL,
	`time` int(11) NOT NULL,
	`server` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
	`name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`rank` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`level` int(11) NOT NULL,
	`team_kills` int(11) NOT NULL,
	`slays` int(11) NOT NULL,
	PRIMARY KEY (`steamid64`),
	KEY `name` (`name`)
);

CREATE TABLE IF NOT EXISTS `player_warns` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`steam_id` bigint(20) unsigned NOT NULL,
	`staff_steam_id` bigint(20) unsigned NOT NULL,
	`name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`staff_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`time` int(10) unsigned NOT NULL,
	`reason` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`acknowledged` int(10) unsigned DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `acknowledged` (`acknowledged`),
	KEY `steam_id` (`steam_id`)
);

CREATE TABLE IF NOT EXISTS `rcon_commands` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`staff_steamid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
	`staff_rank` text COLLATE utf8mb4_unicode_ci NOT NULL,
	`staff_name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`server` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`command` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`args` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`steamid` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `rcon_errors` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`error` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`serverip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`realm` tinyint(1) NOT NULL,
	`stack` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`steamid` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `rcon_queue` (
	`cmdid` int(10) unsigned NOT NULL,
	`server` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`cmdid`,`server`),
	CONSTRAINT `rcon_queue_ibfk_1` FOREIGN KEY (`cmdid`) REFERENCES `rcon_commands` (`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `staff_tracker` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`steamid` bigint(20) unsigned NOT NULL,
	`join_time` timestamp DEFAULT CURRENT_TIMESTAMP,
	`leave_time` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`rounds_played` tinyint(10) unsigned NOT NULL DEFAULT 0,
	`rounds_on` int(10) unsigned NOT NULL DEFAULT 0,
	`time_played` int(10) unsigned NOT NULL DEFAULT 0,
	`reports_handled` smallint(10) unsigned NOT NULL DEFAULT 0,
	`server_ip` int(4) unsigned NOT NULL,
	`server_port` smallint(2) unsigned NOT NULL,
	PRIMARY KEY (`id`),
	KEY `join_time` (`join_time`),
	KEY `leave_time` (`leave_time`),
	KEY `steamid` (`steamid`),
	KEY `server_ip` (`server_ip`),
	KEY `server_port` (`server_port`)
);

CREATE TABLE IF NOT EXISTS `stats` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
	`credits` int(11) NOT NULL,
	`time` int(11) NOT NULL,
	`rank` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`name` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `steam_rewards` (
	`steam` char(20) COLLATE utf8mb4_unicode_ci NOT NULL,
	`value` int(11) NOT NULL,
	PRIMARY KEY (`steam`)
);

CREATE TABLE IF NOT EXISTS `titles` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`steamid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
	`title` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`color` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`changerid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `steamid` (`steamid`)
);

CREATE TABLE IF NOT EXISTS `customnotifications_notifications` (
	`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID Number',
	`options` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`enabled` tinyint(1) NOT NULL DEFAULT 1,
	`to_run` int(10) DEFAULT 0,
	`bf_options` int(11) NOT NULL DEFAULT 0,
	`url` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`member_id` int(11) NOT NULL DEFAULT 0,
	`sent_on` int(11) DEFAULT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `damagelog_oldlogs` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`date` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`server` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
	`map` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
	`round` tinyint(4) NOT NULL,
	`damagelog` longblob NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `damagelog_weapons` (
	`class` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`class`)
);

CREATE TABLE IF NOT EXISTS `core_dev_ttt` (
	`steamid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`max_slots` int(255) NOT NULL,
	`credits` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`l_slot1` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot2` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot3` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot4` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot5` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot6` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot7` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot8` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot9` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot10` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`inventory` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`steamid`)
);

CREATE TABLE IF NOT EXISTS `core_dev_ttt` (
	`steamid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
	`max_slots` int(255) NOT NULL,
	`credits` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
	`l_slot1` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot2` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot3` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot4` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot5` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot6` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot7` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot8` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot9` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`l_slot10` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
	`inventory` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
	PRIMARY KEY (`steamid`)
);
```

Useful Info
---
[![https://www.discord.gg/elu](https://i.imgur.com/kz02DD6.gif)](https://www.discord.gg/elu)
