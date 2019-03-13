concommand.Add("wipe_inv2", function(pl, cmd, args)
	mi:SQLQuery("SET FOREIGN_KEY_CHECKS=0; TRUNCATE TABLE `moat_inv.item_names`; TRUNCATE TABLE `moat_inv.item_paints`; TRUNCATE TABLE `moat_inv.item`; TRUNCATE TABLE `moat_inv.item_stats`; TRUNCATE TABLE `moat_inv.item_talents`; TRUNCATE TABLE `moat_inv.players$$", function(d)
		MsgC(Color(255, 0, 0), "wiped inv2 tables")
	end)
end)

concommand.Add("wipe_me", function(pl, cmd, args)
	mi:SQLQuery("DELETE FROM `moat_inv.item` WHERE ownerid = 76561198053381832;", function(d)
		MsgC(Color(255, 0, 0), "wiped you")
	end)
end)

--[[
BEGIN
	SELECT id, itemid, slotid, classname FROM moat_inv.item WHERE ownerid = steamid64;
	SELECT id, statid, value FROM moat_inv.item_stats AS ws INNER JOIN moat_inv.item AS wd ON ws.weaponid = wd.id WHERE wd.ownerid = steamid64;
	SELECT id, talentid, required, modification, value FROM moat_inv.item_talents AS wt INNER JOIN moat_inv.item AS wd ON wt.weaponid = wd.id WHERE wd.ownerid = steamid64 ORDER BY modification;
	SELECT id, nickname FROM moat_inv.item_names AS wn INNER JOIN moat_inv.item AS wd ON wn.weaponid = wd.id WHERE wd.ownerid = steamid64;
	SELECT id, type, paintid FROM moat_inv.item_paints AS wp INNER JOIN moat_inv.item AS wd ON wp.weaponid = wd.id WHERE wd.ownerid = steamid64;
END

DROP TABLE moat_inv.moat_inv.item`;
CREATE TABLE `moat_inv.item` (
  `id` int(10) UNSIGNED NOT NULL,
  `itemid` int(10) UNSIGNED NOT NULL,
  `ownerid` bigint(20) UNSIGNED NOT NULL,
  `slotid` int(10) DEFAULT NULL,
  `classid` int(10) UNSIGNED NOT NULL,
  `finderid` bigint(20) UNSIGNED NOT NULL,
  `islocked` char(0) DEFAULT NULL,
  `createdat` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
]]
local str_output = "--\n--		Built by Lua on " .. os.date("%b %d, %Y at %H:%M:%S PST", os.time()) .. "\n--\n"
local function push(str, breaks)
	breaks = breaks or 1

	str_output = str_output .. str
	for i = 1, breaks do
		str_output = str_output .. "\n"
	end
end

push"\nDELIMITER $$"

push"\nDROP PROCEDURE IF EXISTS moat_inv.item_add$$"
push"CREATE PROCEDURE moat_inv.item_add(in uid int unsigned, in owner bigint unsigned, in slot int, in haslock char(0)) BEGIN"
push"	INSERT INTO moat_inv.items (`itemid`, `ownerid`, `finderid`, `slotid`, `locked`) VALUES (uid, owner, owner, slot, haslock);"
push"	SELECT LAST_INSERT_ID() AS cid;"
push"END$$"

push"\nDROP PROCEDURE IF EXISTS moat_inv.item_delete$$"
push"CREATE PROCEDURE moat_inv.item_delete(in cid int unsigned) BEGIN"
push"	DELETE FROM moat_inv.items WHERE `id` = cid;"
push"	SELECT LAST_INSERT_ID() AS cid;"
push"END$$"

push"\nDROP PROCEDURE IF EXISTS moat_inv.item_paints_add$$"
push"CREATE PROCEDURE moat_inv.item_paints_add(in uid int unsigned, in ptype smallint unsigned, in pid smallint unsigned) BEGIN"
push"	INSERT INTO moat_inv.item_paints (weaponid, type, paintid) VALUES (uid, ptype, pid) ON DUPLICATE KEY UPDATE paintid = pid;"
push"	SELECT uid AS cid;"
push"END$$"


push"\nDROP PROCEDURE IF EXISTS moat_inv.item_names_add$$"
push"CREATE PROCEDURE moat_inv.item_names_add(in uid int unsigned, in nstr varchar(100), in pid bigint unsigned) BEGIN"
push"	INSERT INTO moat_inv.item_names (weaponid, nickname, changerid) VALUES (uid, nstr, pid) ON DUPLICATE KEY UPDATE nickname = nstr, changerid = pid;"
push"	SELECT uid AS cid;"
push"END$$"


push"\nDROP PROCEDURE IF EXISTS moat_inv.weapon_add$$"
push"CREATE PROCEDURE moat_inv.weapon_add(in uid int unsigned, in owner bigint unsigned, in slot int, in class int unsigned, in haslock char(0)) BEGIN"
push"	INSERT INTO moat_inv.items (itemid, ownerid, finderid, slotid, classid, locked) VALUES (uid, owner, owner, slot, class, haslock);"
push"	SELECT LAST_INSERT_ID() AS cid;"
push"END$$"

for s = 1, 20 do
	push("\nDROP PROCEDURE IF EXISTS moat_inv.weapon_add_" .. s .. "Stats$$")
	

	push("CREATE PROCEDURE moat_inv.weapon_add_" .. s .. "Stats(in uid int unsigned, in owner bigint unsigned, in slot int, in class int unsigned, in haslock char(0)")
	for n = 1, s do
		push(", in stat" .. n .. " tinyint unsigned, in modifier" .. n .. " float", 0)
	end
	push") BEGIN"
	push"	INSERT INTO moat_inv.items (itemid, ownerid, finderid, slotid, classid, locked) VALUES (uid, owner, owner, slot, class, haslock);"
	push"	SET @cid = LAST_INSERT_ID();"

	for n = 1, s do
		push("	INSERT INTO moat_inv.item_stats (weaponid, statid, modifier) VALUES (@cid, stat" .. n .. ", modifier" .. n .. ");")
	end

	push"	SELECT @cid AS cid;"
	push"END$$"
	
end

for s = 1, 20 do
	for t = 1, 20 do
		push("\nDROP PROCEDURE IF EXISTS moat_inv.weapon_add_" .. s .. "Stats_" .. t .. "Talents$$")
		

		push("CREATE PROCEDURE moat_inv.weapon_add_" .. s .. "Stats_" .. t .. "Talents(in uid int unsigned, in owner bigint unsigned, in slot int, in class int unsigned, in haslock char(0)")
		for n = 1, s do
			push(", in stat" .. n .. " tinyint unsigned, in modifier" .. n .. " float", 0)
		end
		for n = 1, t do
			push(", in talentid" .. n .. " smallint unsigned, in required" .. n .. " smallint unsigned, in modification" .. n .. " tinyint unsigned, in tmodifier" .. n .. " float", 0)
		end
		push") BEGIN"
		push"	INSERT INTO moat_inv.items (itemid, ownerid, finderid, slotid, classid, locked) VALUES (uid, owner, owner, slot, class, haslock);"
		push"	SET @cid = LAST_INSERT_ID();"

		for n = 1, s do
			push("	INSERT INTO moat_inv.item_stats (weaponid, statid, modifier) VALUES (@cid, stat" .. n .. ", modifier" .. n .. ");")
		end
		for n = 1, t do
			push("	INSERT INTO moat_inv.item_talents (weaponid, talentid, required, modification, modifier) VALUES (@cid, talentid" .. n .. ", required" .. n .. ", modification" .. n .. ", tmodifier" .. n .. ");")
		end

		push"	SELECT @cid AS cid;"
		push"END$$"
		
	end
end

push"DELIMITER ;"
file.Write("export.txt", str_output)