function MOAT_INV:Escape(str)

    return "\"" .. self.DBHandle:escape(tostring(str)) .. "\""
end

function MOAT_INV:JSON(arg)
    if (istable(arg)) then
        arg = util.TableToJSON(arg)
    else
        arg = util.JSONToTable(arg)
    end

    return arg
end

function MOAT_INV:Query(str, ...)
    local args, arg, succ = {...}, 0

    if (args and #args > 0 and isfunction(args[#args])) then
        succ = args[#args]
        args[#args] = nil
    end
    str = str:gsub("#", function() arg = arg + 1 return self:Escape(args[arg]) end)

    local dbq = self.DBHandle:query(str)
    if (succ) then
        function dbq:onSuccess(data) succ(data, self) end
    end

    function dbq:onError(er)
        ServerLog("\nQuery Error: " .. er .. " | With Query: " .. str .. "\n")
    end

    dbq:start()
end


hook.Add("SQLConnected", "MOAT_INV.SQL", function(db)
    MOAT_INV.DBHandle = db
end)


--[=[
BEGIN
    SELECT id, itemid, slotid, classname FROM mg_items WHERE ownerid = steamid64;
    SELECT id, statid, value FROM mg_itemstats as ws INNER JOIN mg_items as wd ON ws.weaponid = wd.id WHERE wd.ownerid = steamid64;
    SELECT id, talentid, required, modification, value FROM mg_itemtalents as wt INNER JOIN mg_items as wd ON wt.weaponid = wd.id WHERE wd.ownerid = steamid64 ORDER BY modification;
    SELECT id, nickname FROM mg_itemnames as wn INNER JOIN mg_items as wd ON wn.weaponid = wd.id WHERE wd.ownerid = steamid64;
    SELECT id, type, paintid FROM mg_itempaints as wp INNER JOIN mg_items as wd ON wp.weaponid = wd.id WHERE wd.ownerid = steamid64;
END
]]

local str = ""
str = str .. "\nDROP PROCEDURE IF EXISTS `insertItem`;\n"
str = str .. "DELIMITER $$\n"
str = str .. "CREATE PROCEDURE `insertItem`(in uid int unsigned, in owner bigint unsigned, in slot smallint unsigned"
str = str .. ")\n"
str = str .. "BEGIN\n"
str = str .. "  insert into mg_items (itemid, ownerid, slotid) values (uid, owner, slot);\n"
str = str .. "  select LAST_INSERT_ID() as cid;\n"
str = str .. "END; $$\n"
str = str .. "DELIMITER ;\n"

str = str .. "\nDROP PROCEDURE IF EXISTS `insertWeapon`;\n"
str = str .. "DELIMITER $$\n"
str = str .. "CREATE PROCEDURE `insertWeapon`(in uid int unsigned, in owner bigint unsigned, in slot smallint unsigned, in class varchar(32)"
str = str .. ")\n"
str = str .. "BEGIN\n"
str = str .. "  insert into mg_items (itemid, ownerid, slotid, classname) values (uid, owner, slot, class);\n"
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
    str = str .. "  insert into mg_items (itemid, ownerid, slotid, classname) values (uid, owner, slot, class);\n"
    str = str .. "  set @cid = LAST_INSERT_ID();\n"

    for n = 1, s do
        str = str .. "  insert into mg_itemstats (weaponid, statid, value) values (@cid, stat" .. n .. ", value" .. n .. ");\n"
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
        str = str .. "  insert into mg_items (itemid, ownerid, slotid, classname) values (uid, owner, slot, class);\n"
        str = str .. "  set @cid = LAST_INSERT_ID();\n"

        for n = 1, s do
            str = str .. "  insert into mg_itemstats (weaponid, statid, value) values (@cid, stat" .. n .. ", value" .. n .. ");\n"
        end
        for n = 1, t do
            str = str .. "  insert into mg_itemtalents (weaponid, talentid, required, modification, value) values (@cid, talentid" .. n .. ", required" .. n .. ", modification" .. n .. ", tvalue" .. n .. ");\n"
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
str = str .. "  insert into mg_itempaints (weaponid, type, paintid) values (uid, ptype, pid);\n"
str = str .. "  select uid as cid;\n"
str = str .. "END; $$\n"
str = str .. "DELIMITER ;\n"


str = str .. "\nDROP PROCEDURE IF EXISTS `insertItemName`;\n"
str = str .. "DELIMITER $$\n"
str = str .. "CREATE PROCEDURE `insertItemName`(in uid int unsigned, in nstr varchar(32)"
str = str .. ")\n"
str = str .. "BEGIN\n"
str = str .. "  insert into mg_itemnames (weaponid, nickname) values (uid, nstr);\n"
str = str .. "  select uid as cid;\n"
str = str .. "END; $$\n"
str = str .. "DELIMITER ;\n"

file.Write("export.txt", str)]=]