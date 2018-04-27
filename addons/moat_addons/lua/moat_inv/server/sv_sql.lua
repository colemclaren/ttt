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

function MOAT_INV:CheckTable(db)
end

hook.Add("SQLConnected", "MOAT_INV.SQL", function(db)
	MOAT_INV.DBHandle = db
	MOAT_INV:CheckTable(db)
end)

/*
local str = ""
str = str .. "\nDROP PROCEDURE IF EXISTS `insertItem`;\nCREATE PROCEDURE structure for PROCEDURE `insertItem`\n"
str = str .. "DELIMITER $$\n"
str = str .. "CREATE PROCEDURE `insertItem`(in uid int, in owner bigint, in slot smallint"
str = str .. ")\n"
str = str .. "BEGIN\n"
str = str .. "  insert into mg_items (itemid, ownerid, slotid) values (uid, owner, slot);\n"
str = str .. "END; $$\n"
str = str .. "DELIMITER ;\n"

str = str .. "\nDROP PROCEDURE IF EXISTS insertWeapon;\nCREATE PROCEDURE structure for PROCEDURE `insertWeapon`\n"
str = str .. "DELIMITER $$\n"
str = str .. "CREATE PROCEDURE `insertWeapon`(in uid int, in owner bigint, in slot smallint, in class varchar"
str = str .. ")\n"
str = str .. "BEGIN\n"
str = str .. "  insert into mg_items (itemid, ownerid, slotid, classname) values (uid, owner, slot, class);\n"
str = str .. "END; $$\n"
str = str .. "DELIMITER ;\n"

for s = 1, 20 do
    str = str .. "\nDROP PROCEDURE IF EXISTS `insertWeapon" .. s .. "Stats`;\nCREATE PROCEDURE structure for PROCEDURE `insertWeapon" .. s .. "Stats`\n"
    str = str .. "DELIMITER $$\n"

    str = str .. "CREATE PROCEDURE `insertWeapon" .. s .. "Stats`(in uid int, in owner bigint, in slot smallint, in class varchar"
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

    str = str .. "END; $$\n"
    str = str .. "DELIMITER ;\n"
end

for s = 1, 20 do
    for t = 1, 10 do
        str = str .. "\nDROP PROCEDURE IF EXISTS `insertWeapon" .. s .. "Stats" .. t .. "Talents`;\nCREATE PROCEDURE structure for PROCEDURE `insertWeapon" .. s .. "Stats" .. t .. "Talents`\n"
        str = str .. "DELIMITER $$\n"

        str = str .. "CREATE PROCEDURE `insertWeapon" .. s .. "Stats" .. t .. "Talents`(in uid int, in owner bigint, in slot smallint, in class varchar"
        for n = 1, s do
            str = str .. ", in stat" .. n .. " char(1), in value" .. n .. " float"
        end
        for n = 1, t do
            str = str .. ", in talentid" .. n .. " smallint, in required" .. n .. " smallint, in modification" .. n .. " tinyint, in value" .. n .. " float"
        end
        str = str .. ")\n"
        str = str .. "BEGIN\n"
        str = str .. "  insert into mg_items (itemid, ownerid, slotid, classname) values (uid, owner, slot, class);\n"
        str = str .. "  set @cid = LAST_INSERT_ID();\n"

        for n = 1, s do
            str = str .. "  insert into mg_itemstats (weaponid, statid, value) values (@cid, stat" .. n .. ", value" .. n .. ");\n"
        end
        for n = 1, t do
            str = str .. "  insert into mg_itemstats (weaponid, talentid, required, modification, value) values (@cid, talentid" .. n .. ", required" .. n .. ", modification" .. n .. ", value" .. n .. ");\n"
        end

        str = str .. "END; $$\n"
        str = str .. "DELIMITER ;\n"
    end
end

str = str .. "\nDROP PROCEDURE IF EXISTS `insertItemPaint`;\nCREATE PROCEDURE structure for PROCEDURE `insertItemPaint`\n"
str = str .. "DELIMITER $$\n"
str = str .. "CREATE PROCEDURE `insertItemPaint`(in uid int, in ptype smallint, in pid smallint"
str = str .. ")\n"
str = str .. "BEGIN\n"
str = str .. "  insert into mg_itempaints (weaponid, type, paintid) values (uid, ptype, pid);\n"
str = str .. "END; $$\n"
str = str .. "DELIMITER ;\n"


str = str .. "\nDROP PROCEDURE IF EXISTS `insertItemName`;\nCREATE PROCEDURE structure for PROCEDURE `insertItemName`\n"
str = str .. "DELIMITER $$\n"
str = str .. "CREATE PROCEDURE `insertItemPaint`(in uid int, in nstr varchar"
str = str .. ")\n"
str = str .. "BEGIN\n"
str = str .. "  insert into mg_itemnames (weaponid, nickname) values (uid, nstr);\n"
str = str .. "END; $$\n"
str = str .. "DELIMITER ;\n"

file.Write("export.txt", str)
*/