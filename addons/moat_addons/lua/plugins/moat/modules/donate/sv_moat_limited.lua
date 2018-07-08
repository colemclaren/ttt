if (true) then return end

MOAT_LIMITED = MOAT_LIMITED or {}
MOAT_LIMITED.DBHandle = nil

function MOAT_LIMITED:Escape(str)

    return "\"" .. self.DBHandle:escape(tostring(str)) .. "\""
end

function MOAT_LIMITED:JSON(arg)
	if (istable(arg)) then
		arg = util.TableToJSON(arg)
	else
		arg = util.JSONToTable(arg)
	end

	return arg
end

function MOAT_LIMITED:Query(str, ...)
	local args, arg, succ = {...}, 0

	if (args and #args > 0 and isfunction(args[#args])) then
		succ = args[#args]
		args[#args] = nil
	end
	str = str:gsub("#", function() arg = arg + 1 print(args[arg]) return self:Escape(args[arg]) end)

    local dbq = self.DBHandle:query(str)
    if (succ) then
    	function dbq:onSuccess(data) succ(data) end
    end

    function dbq:onError(er)
    	ServerLog("\nQuery Error: " .. er .. " | With Query: " .. str .. "\n")
    end

    dbq:start()
end

function MOAT_LIMITED:CheckTable(db)
	MOAT_LIMITED:Query([[
		CREATE TABLE IF NOT EXISTS moat_limited (
		id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
		date TEXT NOT NULL,
		name TEXT NOT NULL,
		steamid VARCHAR(30) NOT NULL,
		item TEXT NOT NULL)
	]])
end


hook.Add("SQLConnected", "LimitedSQL", function(db)
	MOAT_LIMITED.DBHandle = db
	MOAT_LIMITED:CheckTable(db)
end)