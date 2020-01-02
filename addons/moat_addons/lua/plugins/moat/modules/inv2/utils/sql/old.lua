local ORM = include "mysqloo.lua"

function mi:SQLQuery(str, ...)
    local args = {n = select("#", ...), ...}
    local succ, err = isfunction(args[args.n]), isfunction(args[args.n - 1])
	if (succ) then
		succ, err = err and args[args.n - 1] or args[args.n], err and args[args.n] or nil
		args.n = args.n - (err and 2 or 1)
	end

    self.SQL:Query(self.SQL:CreateQuery(str, unpack(args, 1, args.n)), succ, err or function(er)
		mi.Print("Query Error: " .. er .. " | With Query: " .. str, true)
    end)
end

hook("SQLConnected", function(db)
    mi.SQL = ORM(db)
    hook.Run "InventoryPrepare"
end)

--[=[[
BEGIN
    SELECT id, itemid, slotid, classname FROM moat_inv_items WHERE ownerid = steamid64;
    SELECT id, statid, value FROM moat_inv_items_stats as ws INNER JOIN moat_inv_items as wd ON ws.weaponid = wd.id WHERE wd.ownerid = steamid64;
    SELECT id, talentid, required, modification, value FROM moat_inv_items_talents as wt INNER JOIN moat_inv_items as wd ON wt.weaponid = wd.id WHERE wd.ownerid = steamid64 ORDER BY modification;
    SELECT id, nickname FROM moat_inv_items_names as wn INNER JOIN moat_inv_items as wd ON wn.weaponid = wd.id WHERE wd.ownerid = steamid64;
    SELECT id, type, paintid FROM moat_inv_items_paints as wp INNER JOIN moat_inv_items as wd ON wp.weaponid = wd.id WHERE wd.ownerid = steamid64;
END
]]

local str = ""
str = str .. "\nDROP PROCEDURE IF EXISTS `insertItem`;\n"
str = str .. "DELIMITER $$\n"
str = str .. "CREATE PROCEDURE `insertItem`(in uid int unsigned, in owner bigint unsigned, in slot smallint unsigned"
str = str .. ")\n"
str = str .. "BEGIN\n"
str = str .. "  insert into moat_inv_items (itemid, ownerid, slotid) values (uid, owner, slot);\n"
str = str .. "  select LAST_INSERT_ID() as cid;\n"
str = str .. "END; $$\n"
str = str .. "DELIMITER ;\n"

str = str .. "\nDROP PROCEDURE IF EXISTS `insertWeapon`;\n"
str = str .. "DELIMITER $$\n"
str = str .. "CREATE PROCEDURE `insertWeapon`(in uid int unsigned, in owner bigint unsigned, in slot smallint unsigned, in class varchar(32)"
str = str .. ")\n"
str = str .. "BEGIN\n"
str = str .. "  insert into moat_inv_items (itemid, ownerid, slotid, classname) values (uid, owner, slot, class);\n"
str = str .. "  select LAST_INSERT_ID() as cid;\n"
str = str .. "END; $$\n"
str = str .. "DELIMITER ;\n"

for s = 1, 20 do
    str = str .. "\nDROP PROCEDURE IF EXISTS `insertWeapon" .. s .. "Stats`;\n"
    str = str .. "DELIMITER $$\n"

    str = str .. "CREATE PROCEDURE `insertWeapon" .. s .. "Stats`(in uid int unsigned, in owner bigint unsigned, in slot smallint unsigned, in class varchar(32)"
    for n = 1, s do
        str = str .. ", in stat" .. n .. " char(1), in value" .. n .. " float"
    end
    str = str .. ")\n"
    str = str .. "BEGIN\n"
    str = str .. "  insert into moat_inv_items (itemid, ownerid, slotid, classname) values (uid, owner, slot, class);\n"
    str = str .. "  set @cid = LAST_INSERT_ID();\n"

    for n = 1, s do
        str = str .. "  insert into moat_inv_items_stats (weaponid, statid, value) values (@cid, stat" .. n .. ", value" .. n .. ");\n"
    end

    str = str .. "  select @cid as cid;\n"
    str = str .. "END; $$\n"
    str = str .. "DELIMITER ;\n"
end

for s = 1, 20 do
    for t = 1, 20 do
        str = str .. "\nDROP PROCEDURE IF EXISTS `insertWeapon" .. s .. "Stats" .. t .. "Talents`;\n"
        str = str .. "DELIMITER $$\n"

        str = str .. "CREATE PROCEDURE `insertWeapon" .. s .. "Stats" .. t .. "Talents`(in uid int unsigned, in owner bigint unsigned, in slot smallint unsigned, in class varchar(32)"
        for n = 1, s do
            str = str .. ", in stat" .. n .. " char(1), in value" .. n .. " float"
        end
        for n = 1, t do
            str = str .. ", in talentid" .. n .. " smallint unsigned, in required" .. n .. " smallint unsigned, in modification" .. n .. " tinyint unsigned, in tvalue" .. n .. " float"
        end
        str = str .. ")\n"
        str = str .. "BEGIN\n"
        str = str .. "  insert into moat_inv_items (itemid, ownerid, slotid, classname) values (uid, owner, slot, class);\n"
        str = str .. "  set @cid = LAST_INSERT_ID();\n"

        for n = 1, s do
            str = str .. "  insert into moat_inv_items_stats (weaponid, statid, value) values (@cid, stat" .. n .. ", value" .. n .. ");\n"
        end
        for n = 1, t do
            str = str .. "  insert into moat_inv_items_talents (weaponid, talentid, required, modification, value) values (@cid, talentid" .. n .. ", required" .. n .. ", modification" .. n .. ", tvalue" .. n .. ");\n"
        end

         str = str .. "  select @cid as cid;\n"
        str = str .. "END; $$\n"
        str = str .. "DELIMITER ;\n"
    end
end

str = str .. "\nDROP PROCEDURE IF EXISTS `insertItemPaint`;\n"
str = str .. "DELIMITER $$\n"
str = str .. "CREATE PROCEDURE `insertItemPaint`(in uid int unsigned, in ptype smallint unsigned, in pid smallint unsigned"
str = str .. ")\n"
str = str .. "BEGIN\n"
str = str .. "  insert into moat_inv_items_paints (weaponid, type, paintid) values (uid, ptype, pid);\n"
str = str .. "  select uid as cid;\n"
str = str .. "END; $$\n"
str = str .. "DELIMITER ;\n"


str = str .. "\nDROP PROCEDURE IF EXISTS `insertItemName`;\n"
str = str .. "DELIMITER $$\n"
str = str .. "CREATE PROCEDURE `insertItemName`(in uid int unsigned, in nstr varchar(32)"
str = str .. ")\n"
str = str .. "BEGIN\n"
str = str .. "  insert into moat_inv_items_names (weaponid, nickname) values (uid, nstr);\n"
str = str .. "  select uid as cid;\n"
str = str .. "END; $$\n"
str = str .. "DELIMITER ;\n"

file.Write("export.txt", str)--]]=]