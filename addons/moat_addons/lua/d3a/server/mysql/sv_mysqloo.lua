require "mysqloo"

/*
function D3A.MySQL.Connect()
	if (D3A.MySQL.DBHandle) then
		D3A.Print("Using pre-established MySQL link.")
		return
	end

	local db = mysqloo.connect(D3A.Config.hostname, D3A.Config.username, D3A.Config.password, D3A.Config.database, D3A.Config.port)
	
	db.onConnectionFailed = function(msg, err)
		D3A.Print("MySQL connection failed: " .. tostring(err))
	end
	
	db.onConnected = function()
		D3A.Print("MySQL connection established at " .. os.date())
		
		D3A.MySQL.DBHandle = db
		
		db.onConnected = function() D3A.Print("MySQL connection re-established at " .. os.date()) end
	end
	
	db:connect()
	db:wait()
	
	D3A.MySQL.DBHandle = db
end
*/
hook.Add("SQLConnected", "d3aSQL", function(db)
	D3A.Print("MySQL connection established at " .. os.date())
	D3A.MySQL.DBHandle = db
end)

hook.Add("SQLConnectionFailed", "d3aSQL", function(db, err)
    D3A.Print("MySQL connection failed: " .. tostring(err))
end)

function D3A.MySQL.Escape(txt)
	return D3A.MySQL.DBHandle:escape(tostring(txt or ""))
end

function D3A.MySQL.Query(query, callback, ret)
	if (!query) then
		print("No query given.")
		return
	end

	if (not D3A.MySQL.DBHandle) then
		timer.Simple(1, function() D3A.MySQL.Query(query, callback, ret) end)
		return
	end
	
	local db = D3A.MySQL.DBHandle
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
			D3A.Print("MySQL connection lost during query. Reconnecting.")
			
			db:connect()
			timer.Simple(1, function() r = D3A.MySQL.Query(query, callback, ret) end)
		else
			D3A.Print("MySQL error: " ..err)
			D3A.Print(" | Query: " .. query)
		end
	end
	
	q:start()
	
	--if (ret) then q:wait() end
	
	return r
end

function D3A.MySQL.QueryRet(query, callback)
	callback = callback or function(data) return data end
	
	return D3A.MySQL.Query(query, callback, true)
end

--hook.Add("D3A_Initialize", "D3A.MySQL.Connect", D3A.MySQL.Connect)