require "mysqloo"

D3A.MySQL = D3A.MySQL or {}
local dev = false

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
	if (dev) then print("Query | " .. query) end
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
			D3A.Print("MySQL error: " .. err)
			D3A.Print(" | Query: " .. query)
		end
	end
	
	q:start()

	return r
end

function D3A.MySQL.QueryRet(query, callback)
	callback = callback or function(data) return data end
	
	return D3A.MySQL.Query(query, callback, true)
end


local da_quotes = {
	['"'] = true,
	["'"] = true
}
function D3A.MySQL.FormatEscape(str, quotes)
	if (str == nil) then return "" end
	if (str == "NULL") then return "NULL" end

	quotes = quotes or "\""
	if (type(str) == "string" and da_quotes[str[0]]) then quotes = "" end

    return isnumber(str) and tostring(str) or quotes .. D3A.MySQL.DBHandle:escape(tostring(str)) .. quotes
end

function D3A.MySQL.FormatQueryString(str, ...)
	local args, arg = {...}, 0
	str = str:gsub("#", function() arg = arg + 1 return D3A.MySQL.FormatEscape(args[arg]) end)

	return str
end

function D3A.MySQL.FormatQuery(str, ...)
	local args, arg, succ = {...}, 0

	if (args and #args > 0 and isfunction(args[#args])) then
		succ = args[#args]
		args[#args] = nil
	end
	str = str:gsub("#", function() arg = arg + 1 return D3A.MySQL.FormatEscape(args[arg]) end)
	local db = D3A.MySQL.DBHandle
	if (dev) then print("FormatQuery | " .. str) end
    local dbq = db:query(str)
    if (succ) then
    	function dbq:onSuccess(data) succ(data, self) end
    end

    function dbq:onError(err)
    	if (db:status() == mysqloo.DATABASE_NOT_CONNECTED) then
			D3A.Print("MySQL connection lost during query. Reconnecting.")

			db:connect()
			timer.Simple(1, function() r = D3A.MySQL.FormatQuery(str, succ) end)
		else
			D3A.Print("MySQL error: " .. err)
			D3A.Print(" | Query: " .. str)
		end
    end

    dbq:start()
end