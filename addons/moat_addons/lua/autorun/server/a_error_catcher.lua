local HTTP, reset, limit = HTTP, 0
local function post(tbl)
	local now = os.time(os.date("!*t"))

	if limit == 0 and now < reset then
		local function tcb()
			post(data)
		end
		timer.Simple(reset - now, tcb)
	end

	local function cb(_, _, headers)
		limit = headers["X-RateLimit-Remaining"]
		reset = headers["X-RateLimit-Reset"]
	end

	HTTP({
		method = "POST",
		url = "http://107.191.51.43:3000/servererrors",
		body = util.TableToJSON(tbl),
		type = "application/json",
		success = cb
	})
end

require "luaerror"
luaerror.EnableRuntimeDetour(true)
luaerror.EnableCompiletimeDetour(true)
luaerror.EnableClientDetour(true)

sql.Query [[CREATE TABLE IF NOT EXISTS server_errors (
	error VARCHAR NOT NULL PRIMARY KEY,
	stack TEXT DEFAULT NULL
);]]

local log_str = "INSERT INTO rcon_errors (error, serverip, realm, stack, steamid) VALUES (#, #, #, #, #);"
local function logerror(report, error, serverip, realm, stack, steamid)
	MOAT_RCON:Query(log_str, error, serverip, realm, stack or "NULL", steamid or "NULL", function(d, q)
		if (not report) then return end

		local id = q:lastInsert() or 0
		if (stack) then stack = util.JSONToTable(stack) end
		post({err = error, ip = serverip, rlm = realm, st = stack, pl = steamid, errid = id})
	end)
end

local error_cache = {}
local function catchError(pl, err, _, _, _, stack)
	if (not err or error_cache[err]) then return end
	error_cache[err] = true

	local row = sql.QueryRow("SELECT stack FROM server_errors WHERE error = " .. sql.SQLStr(err))
	if (row) then return end
	local st = {}
	if (stack) then
		for i = 1, 5 do
			if (not stack[i]) then break end
			table.insert(st, stack[i])
		end
	end

	st = util.TableToJSON(st)
	sql.Query("INSERT INTO server_errors (error, stack) VALUES (" .. sql.SQLStr(err) .. ", " .. sql.SQLStr(st) .. ");")

	pl = type(pl) == "Player" and pl:SteamID64() or nil
	MOAT_RCON:Query("SELECT serverip FROM rcon_errors WHERE error = #", err, function(d)
		logerror((not d or not d[1]), err, MOAT_RCON.Server, pl and 1 or 0, st, pl)
	end)
end

hook.Add("LuaError", "catchServerError", catchError)
hook.Add("ClientLuaError", "catchClientError", catchError)