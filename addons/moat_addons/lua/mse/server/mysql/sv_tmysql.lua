require "tmysql4"

function MSE.MySQL.Connect()
	if (MSE.MySQL.DBHandle) then
		MSE.Print "Using pre-established MySQL link."
		return
	end

	local db, err = tmysql.initialize(MSE.Config.hostname, MSE.Config.username, MSE.Config.password, MSE.Config.database, MSE.Config.port)

	if ((db == false) or err) then
		MSE.Print("MySQL connection failed: " .. tostring(err))
		return
	end
	
	MSE.Print("MySQL connection established at " .. os.date())

	MSE.MySQL.DBHandle = db

	MSE.MySQL.CheckTable()
end

function MSE.MySQL.Escape(txt)
	return MSE.MySQL.DBHandle:Escape(tostring(txt or ""))
end

-- In case the mysql server dies, we auto reconnect if one of these errors
local retry_errors = {
	["Lost connection to MySQL server during query"] = true,
	[" MySQL server has gone away"] = true,
}

function MSE.MySQL.Query(query, callback, ret)
	if (!query) then
		MSE.Print "No query given."
		return
	end

	if (ret) then
		return MSE.MySQL.QueryRet(query, callback)
	end

	MSE.MySQL.DBHandle:Query(query, function(results)
		if (results[1].error ~= nil) then
			if retry_errors[results[1].error] then
				MSE.Print "MySQL connection lost during query. Reconnecting."
				MSE.MySQL.Query(query, callback, ret)
			else
				MSE.Print("MySQL error: " .. results[1].error)
				MSE.Print(" | Query: " .. query)
			end
		elseif (callback) then
			callback(results[1].data)
		end
	end)
end

function MSE.MySQL.FormatQuery(str, ...)
	local args, arg, succ = {...}, 0

	if (args and #args > 0 and isfunction(args[#args])) then
		succ = args[#args]
		args[#args] = nil
	end
	str = str:gsub("#", function() arg = arg + 1 return MSE.MySQL.Escape(args[arg]) end)

	MSE.MySQL.Query(str, succ)
end

function MSE.MySQL.QueryRet(query, callback)
	local data
	local start = SysTime() + 0.3
	MSE.MySQL.Query(query, function(_data)
		data = _data
	end)
	while ((not data) and (start >= SysTime())) do
		MSE.MySQL.DBHandle:Poll()
	end
	return callback and callback(data) or data
end

hook.Add("MSE_Initialize", "MSE.MySQL.Connect", MSE.MySQL.Connect)