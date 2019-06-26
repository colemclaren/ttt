local output = "--\n--		Built by Lua on " .. os.date("%b %d, %Y at %H:%M:%S PST", os.time()) .. "\n--\n"
local function str(str, breaks)
	breaks = breaks or 1

	output = output .. str
	for i = 1, breaks do
		output = output .. "\n"
	end
end

str"\nDELIMITER $$"

str"\nDROP PROCEDURE IF EXISTS moat_inv.item_add$$"
str"CREATE PROCEDURE moat_inv.item_add(in uid int unsigned, in owner bigint unsigned, in slot int, in haslock char(0)) BEGIN"
str"	INSERT INTO moat_inv.items (`itemid`, `ownerid`, `slotid`, `locked`) VALUES (uid, owner, owner, slot, haslock);"
str"	SELECT LAST_INSERT_ID() AS cid;"
str"END$$"

str"\nDROP PROCEDURE IF EXISTS moat_inv.item_delete$$"
str"CREATE PROCEDURE moat_inv.item_delete(in cid int unsigned) BEGIN"
str"	DELETE FROM moat_inv.items WHERE `id` = cid;"
str"	SELECT LAST_INSERT_ID() AS cid;"
str"END$$"

str"\nDROP PROCEDURE IF EXISTS moat_inv.item_paints_add$$"
str"CREATE PROCEDURE moat_inv.item_paints_add(in uid int unsigned, in ptype smallint unsigned, in pid smallint unsigned) BEGIN"
str"	INSERT INTO moat_inv.item_paints (weaponid, type, paintid) VALUES (uid, ptype, pid) ON DUPLICATE KEY UPDATE paintid = pid;"
str"	SELECT uid AS cid;"
str"END$$"


str"\nDROP PROCEDURE IF EXISTS moat_inv.item_names_add$$"
str"CREATE PROCEDURE moat_inv.item_names_add(in uid int unsigned, in nstr varchar(100), in pid bigint unsigned) BEGIN"
str"	INSERT INTO moat_inv.item_names (weaponid, nickname, changerid) VALUES (uid, nstr, pid) ON DUPLICATE KEY UPDATE nickname = nstr, changerid = pid;"
str"	SELECT uid AS cid;"
str"END$$"


str"\nDROP PROCEDURE IF EXISTS moat_inv.weapon_add$$"
str"CREATE PROCEDURE moat_inv.weapon_add(in uid int unsigned, in owner bigint unsigned, in slot int, in class int unsigned, in haslock char(0)) BEGIN"
str"	INSERT INTO moat_inv.items (itemid, ownerid, slotid, classid, locked) VALUES (uid, owner, slot, class, haslock);"
str"	SELECT LAST_INSERT_ID() AS cid;"
str"END$$"

for s = 1, 20 do
	str("\nDROP PROCEDURE IF EXISTS moat_inv.weapon_add_" .. s .. "Stats$$")
	

	str("CREATE PROCEDURE moat_inv.weapon_add_" .. s .. "Stats(in uid int unsigned, in owner bigint unsigned, in slot int, in class int unsigned, in haslock char(0)")
	for n = 1, s do
		str(", in stat" .. n .. " tinyint unsigned, in modifier" .. n .. " float", 0)
	end
	str") BEGIN"
	str"	INSERT INTO moat_inv.items (itemid, ownerid, slotid, classid, locked) VALUES (uid, owner, slot, class, haslock);"
	str"	SET @cid = LAST_INSERT_ID();"

	for n = 1, s do
		str("	INSERT INTO moat_inv.item_stats (weaponid, statid, modifier) VALUES (@cid, stat" .. n .. ", modifier" .. n .. ");")
	end

	str"	SELECT @cid AS cid;"
	str"END$$"
	
end

for s = 1, 20 do
	for t = 1, 20 do
		str("\nDROP PROCEDURE IF EXISTS moat_inv.weapon_add_" .. s .. "Stats_" .. t .. "Talents$$")
		

		str("CREATE PROCEDURE moat_inv.weapon_add_" .. s .. "Stats_" .. t .. "Talents(in uid int unsigned, in owner bigint unsigned, in slot int, in class int unsigned, in haslock char(0)")
		for n = 1, s do
			str(", in stat" .. n .. " tinyint unsigned, in modifier" .. n .. " float", 0)
		end
		for n = 1, t do
			str(", in talentid" .. n .. " smallint unsigned, in required" .. n .. " smallint unsigned, in modification" .. n .. " tinyint unsigned, in tmodifier" .. n .. " float", 0)
		end
		str") BEGIN"
		str"	INSERT INTO moat_inv.items (itemid, ownerid, slotid, classid, locked) VALUES (uid, owner, slot, class, haslock);"
		str"	SET @cid = LAST_INSERT_ID();"

		for n = 1, s do
			str("	INSERT INTO moat_inv.item_stats (weaponid, statid, modifier) VALUES (@cid, stat" .. n .. ", modifier" .. n .. ");")
		end
		for n = 1, t do
			str("	INSERT INTO moat_inv.item_talents (weaponid, talentid, required, modification, modifier) VALUES (@cid, talentid" .. n .. ", required" .. n .. ", modification" .. n .. ", tmodifier" .. n .. ");")
		end

		str"	SELECT @cid AS cid;"
		str"END$$"
		
	end
end


str"DELIMITER ;"
file.Write("superdupermeme.txt", output)
