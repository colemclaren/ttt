require "mysqloo"

MSE.MySQL = MSE.MySQL or {}

function MSE.MySQL.CheckTable()
	MSE.MySQL.Query([[
		CREATE TABLE IF NOT EXISTS mse_players (
		id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
		steamid VARCHAR(30) NOT NULL,
		rank TEXT NOT NULL, 
		cooldown INTEGER NOT NULL, 
		amount INTEGER NOT NULL)
	]])
	MSE.MySQL.Query([[
		CREATE TABLE IF NOT EXISTS mse_logs (
		id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
		steamid VARCHAR(30) NOT NULL,
		cmd TEXT NOT NULL, 
		time INTEGER NOT NULL)
	]])
end

hook.Add("SQLConnected", "mseSQL", function(db)
	MSE.Print("MySQL connection established at " .. os.date())
	MSE.MySQL.DBHandle = db
	MSE.MySQL.CheckTable()
end)

hook.Add("SQLConnectionFailed", "mseSQL", function(db, err)
    MSE.Print("MySQL connection failed: " .. tostring(err))
end)

function MSE.MySQL.Escape(txt)
	return MSE.MySQL.DBHandle:escape(tostring(txt or ""))
end

function MSE.MySQL.Query(query, callback, ret)
	if (!query) then
		MSE.Print "No query given."
		return
	end
	
	local db = MSE.MySQL.DBHandle
	local q = db:query(query)
	local d, r
	
	q.onData = function(self, dat)
		d = d or {}
		table.insert(d, dat)
	end
	
	q.onSuccess = function()
		if (callback) then r = callback(d) end
	end
	
	q.onError = function(q, err, query)
		if (db:status() == mysqloo.DATABASE_NOT_CONNECTED) then
			MSE.Print "MySQL connection lost during query. Reconnecting."
			
			db:connect()
			timer.Simple(1, function() r = MSE.MySQL.Query(query, callback, ret) end)
		else
			MSE.Print("MySQL error: " ..err)
			MSE.Print(" | Query: " .. query)
		end
	end
	
	q:start()
	
	--if (ret) then q:wait() end
	
	return r
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
	callback = callback or function(data) return data end
	
	return MSE.MySQL.Query(query, callback, true)
end

//hook.Add("MSE_Initialize", "MSE.MySQL.Connect", MSE.MySQL.Connect)