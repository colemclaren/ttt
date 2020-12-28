DROP PROCEDURE IF EXISTS createUserInfo;
DELIMITER $$
CREATE PROCEDURE createUserInfo(in stid text, in stname text charset utf8mb4, in ipaddr text, in ostime bigint)
BEGIN
	set @Count = (SELECT COUNT(*) AS Cnt FROM player WHERE `SteamID`=stid);
	if (@Count = 0) then
		insert into player (`SteamID`, `SteamName`, `FirstJoined`, `Vars`) VALUES (stid, stname, ostime, null);
		insert into player_iplog (`SteamID`, `Address`, `LastSeen`) VALUES(stid, ipaddr, -1);
		select 1 as Created;
	else
		select 0 as Created;
	end if;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS selectUserInfo;
DELIMITER $$
CREATE PROCEDURE selectUserInfo(in stid text)
BEGIN
	SELECT player.SteamName, player.Rank, player.TimePlayed, player.FirstJoined, player.Vars, player_iplog.Address, player_iplog.LastSeen FROM player, player_iplog WHERE player.SteamID=stid AND player_iplog.SteamID=stid ORDER BY LastSeen DESC LIMIT 1;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS updateUserInfo;
DELIMITER $$
CREATE PROCEDURE updateUserInfo(in stid text, in steamname text, in ipaddr text, in ostime bigint)
BEGIN
	update player set `SteamName` = steamname where `SteamID` = stid;
	delete from player_iplog where `SteamID` = stid and `Address` = ipaddr;
	INSERT INTO player_iplog (`SteamID`, `Address`, `LastSeen`) VALUES (stid, ipaddr, ostime);
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS removeItem;
DELIMITER $$
CREATE PROCEDURE removeItem(in cid int)
BEGIN
	update mg_items set ownerid = 0 where id = cid;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS transferItem;
DELIMITER $$
CREATE PROCEDURE transferItem(in cid int, in owner bigint)
BEGIN
	update mg_items set ownerid = owner where id = cid;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS updateItemStat;
DELIMITER $$
CREATE PROCEDURE updateItemStat(in cid int, in stat char(1), in newval float)
BEGIN
	update mg_itemstats set statid = newval where weaponid = cid;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS insertItemName;
DELIMITER $$
CREATE PROCEDURE insertItemName(in uid int unsigned, in nstr varchar(32))
BEGIN
	insert into moat_inv_items_names (weaponid, nickname) values (uid, nstr);
	select uid as cid;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS selectStats;
DELIMITER $$
CREATE PROCEDURE selectStats(in steamid bigint)
BEGIN
	select var, val from mg_players where id = steamid;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS selectStat;
DELIMITER $$
CREATE PROCEDURE selectStat(in steamid bigint, in stat char(1))
BEGIN
	select var, val from mg_players where id = steamid and var = stat;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS saveStat;
DELIMITER $$
CREATE PROCEDURE saveStat(in `steamid` bigint, in `stat` CHAR(1), in `num` INT)
BEGIN
	insert into mg_players (id, var, val) values (steamid, stat, num) on duplicate key update val = num;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS getSteamIDFromDiscordTag;
DELIMITER $$
CREATE PROCEDURE getSteamIDFromDiscordTag(in tag varchar(255))
BEGIN
	SET @mid = (SELECT member_id FROM memberssocialinfo_sites WHERE discord LIKE tag LIMIT 1);
	if (FOUND_ROWS() = 0) then
		select 0 as steamid;
	else
		select steamid FROM core_members WHERE member_id LIKE @mid LIMIT 1;
	end if;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS selectRconCommands;
DELIMITER $$
CREATE PROCEDURE selectRconCommands(in `srvr` varchar(255))
BEGIN
	select id, staff_steamid, staff_rank, staff_name, command, args, steamid from rcon_commands as rc inner join rcon_queue as rq on rc.id = rq.cmdid where rq.server = srvr;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS insertRconCommand;
DELIMITER $$
CREATE PROCEDURE insertRconCommand(in `sid` varchar(30), in `srank` tinytext, in `sname` text, in `cmd` text, in `srvr` varchar(255), in `arg` text, in `sido` varchar(30))
BEGIN
	insert into rcon_commands (staff_steamid, staff_rank, staff_name, `server`, command, args, steamid) values (sid, srank, sname, srvr, cmd, arg, sido);

	set @cid = LAST_INSERT_ID();
	if (srvr = "*") then
		set @num = (SELECT COUNT(*) FROM player_servers);
		while @num > 0 do
			select ip, port into @i, @p from player_servers where id = @num;
			insert into rcon_queue (cmdid, server) values (@cid, concat(@i, ":", @p));
			set @num = @num - 1;
		end while;
	else
		insert into rcon_queue (cmdid, server) values (@cid, srvr);
	end if;

	select @cid as cmd_id;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS insertRconCommand;
DELIMITER $$
CREATE PROCEDURE insertRconCommand(in `sid` varchar(30), in `srank` tinytext, in `sname` text, in `cmd` text, in `srvr` varchar(255), in `arg` text, in `sido` varchar(30))
BEGIN
	insert into rcon_commands (staff_steamid, staff_rank, staff_name, `server`, command, args, steamid) values (sid, srank, sname, srvr, cmd, arg, sido);

	set @cid = LAST_INSERT_ID();
	if (srvr = "*") then
		set @num = (SELECT COUNT(*) FROM player_servers);
		while @num > 0 do
			select ip, port into @i, @p from player_servers where id = @num;
			insert into rcon_queue (cmdid, server) values (@cid, concat(@i, ":", @p));
			set @num = @num - 1;
		end while;
	else
		insert into rcon_queue (cmdid, server) values (@cid, srvr);
	end if;

	select @cid as cmd_id;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS selectContract;
DELIMITER $$
CREATE PROCEDURE selectContract(in `id` varchar(255))
BEGIN
	SELECT score as myscore, steamid, (SELECT COUNT(*) FROM moat_contractplayers_v2 WHERE score >= myscore) AS position, (SELECT COUNT(steamid) FROM moat_contractplayers_v2) AS players FROM moat_contractplayers_v2 WHERE steamid = id;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS removeRconCommands;
DELIMITER $$
CREATE PROCEDURE removeRconCommands(in srvr varchar(255))
BEGIN
	delete from rcon_queue where server = srvr;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS selectContracts;
DELIMITER $$
CREATE PROCEDURE selectContracts(in `ip` varchar(255))
BEGIN
	SELECT `moat_contractplayers`.`score` as myscore, `moat_contractplayers`.`steamid`, (SELECT COUNT(*) FROM `moat_contractplayers` WHERE score >= myscore) AS position, (SELECT COUNT(steamid) FROM moat_contractplayers) AS players FROM `moat_contractplayers` INNER JOin `player_sessions` ON (`moat_contractplayers`.`steamid` = `player_sessions`.`steamid64` AND `player_sessions`.`server` = ip) ORDER BY score;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS insertPayload;
DELIMITER $$
CREATE PROCEDURE insertPayload(in `pl` mediumtext)
BEGIN
	INSERT INTO github_payloads (payload) VALUES (pl);
	SELECT LAST_INSERT_ID() AS pid;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS updateGithubAuthors;
DELIMITER $$
CREATE PROCEDURE updateGithubAuthors(in `puid` varchar(255), in `pname` text, in `pemail` text, in `pnode_id` text, in `pavatar_url` text, in `pgithub_url` text)
BEGIN
	INSERT INTO github_authors (uid, name, email, node_id, avatar_url, github_url) VALUES (puid, pname, pemail, pnode_id, pavatar_url, pgithub_url) ON DUPLICATE KEY UPDATE name = pname, email = pemail, avatar_url = pavatar_url, github_url = pgithub_url;
	SELECT id FROM github_authors WHERE uid = puid;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS selectInventory;
DELIMITER $$
CREATE PROCEDURE selectInventory(in `steamid64` bigint)
BEGIN
	SELECT id, itemid, slotid, classname FROM mg_items WHERE ownerid = steamid64;
	SELECT id, statid, value FROM mg_itemstats as ws INNER JOin mg_items as wd ON ws.weaponid = wd.id WHERE wd.ownerid = steamid64;
	SELECT id, talentid, required, modification, value FROM mg_itemtalents as wt INNER JOin mg_items as wd ON wt.weaponid = wd.id WHERE wd.ownerid = steamid64 ORDER BY modification;
	SELECT id, nickname FROM mg_itemnames as wn INNER JOin mg_items as wd ON wn.weaponid = wd.id WHERE wd.ownerid = steamid64;
	SELECT id, type, paintid FROM mg_itempaints as wp INNER JOin mg_items as wd ON wp.weaponid = wd.id WHERE wd.ownerid = steamid64;
END; $$
DELIMITER ;