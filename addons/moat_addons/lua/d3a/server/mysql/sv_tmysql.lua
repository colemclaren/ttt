require "tmysql4"

function D3A.MySQL.Connect()
	if (D3A.MySQL.DBHandle) then
		D3A.Print("Using pre-established MySQL link.")
		return
	end

	local db, err = tmysql.initialize(D3A.Config.hostname, D3A.Config.username, D3A.Config.password, D3A.Config.database, D3A.Config.port)

	if (db == false) or err then
		D3A.Print("MySQL connection failed: " .. tostring(err))
		return
	end
	
	D3A.Print("MySQL connection established at " .. os.date())

	D3A.MySQL.DBHandle = db
end

function D3A.MySQL.Escape(txt)
	return D3A.MySQL.DBHandle:Escape(tostring(txt or ""))
end

local retry_errors = {
	['Lost connection to MySQL server during query'] = true,
	[' MySQL server has gone away'] = true,
}

function D3A.MySQL.Query(query, callback, ret)
	if (!query) then
		print("No query given.")
		return
	end

	if ret then
		return D3A.MySQL.QueryRet(query, callback)
	end

	D3A.MySQL.DBHandle:Query(query, function(results)
		if (results[1].error ~= nil) then
			if retry_errors[results[1].error] then
				D3A.Print("MySQL connection lost during query. Reconnecting.")
				D3A.MySQL.Query(query, callback, ret)
			else
				D3A.Print("MySQL error: " .. results[1].error)
				D3A.Print(" | Query: " .. query)
			end
		elseif callback then
			callback(results[1].data)
		end
	end)
end

function D3A.MySQL.QueryRet(query, callback)
	local data
	local start = SysTime() + 0.3
	D3A.MySQL.Query(query, function(_data)
		data = _data
	end)
	while (not data) and (start >= SysTime()) do
		D3A.MySQL.DBHandle:Poll()
	end
	return callback and callback(data) or data
end

hook.Add("D3A_Initialize", "D3A.MySQL.Connect", D3A.MySQL.Connect)