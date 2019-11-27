local report_errors = CreateConVar("moat_report_errors", 1)
local HTTP, reset, limit = HTTP, 0
local function report_error(tbl)
	local now = os.time(os.date("!*t"))

	if limit == 0 and now < reset then
		local function tcb()
			report_error(data)
		end
		timer.Simple(reset - now, tcb)
	end

	local msg = Either(tbl.rlm == 1, ":orange_book: Client Error", ":blue_book: Server Error")
	msg = msg .. style.Dot(player.GetCount() .. "/" .. game.MaxPlayers() .. " Players") 
		.. style.Dot(math.max(0, GetGlobal("ttt_rounds_left")) .. " Rounds Left")
		.. style.Dot(game.GetMap())
		.. style.Dot(string.Extra(GetServerName(), GetServerURL()))


	if (tbl.rlm == 1 and tbl.pl) then
		local p = player.GetBySteamID64(tbl.pl)

		msg = msg .. style.NewLine(style.Pipe("Error for ")) 
			.. style.Code(IsValid(p) and p:Nick() or "Unknown Player") 
			.. style.Dot(style.Code(IsValid(p) and p:SteamID() or "???")) 
			.. style.Dot(style.Code(IsValid(p) and p:GetIP() or "???")) 
			.. style.Dot(IsValid(p) and p:SteamURL() or tbl.pl)
	end

	msg = msg .. style.NewLine(style.CodeBlock("[ERROR] " .. tbl.err))

	if tbl.rlm == 1 then
		discord.Send("Client Error Reports", msg)
	else
		discord.Send("Server Error Reports", msg)
	end
end

require "luaerror"
luaerror.EnableRuntimeDetour(true)
luaerror.EnableCompiletimeDetour(true)
luaerror.EnableClientDetour(true)

sql.Query [[CREATE TABLE IF NOT EXISTS luaerror_reports (
	error VARCHAR NOT NULL PRIMARY KEY,
	stack TEXT DEFAULT NULL
);]]

local log_str = "INSERT INTO moat_errors (error, serverip, realm, stack, steamid) VALUES (#, #, #, #, #);"
local function logerror(report, error, serverip, realm, stack, steamid)
	MOAT_RCON:Query(log_str, error, serverip, realm, stack or "NULL", steamid or "NULL", function(d, q)
		if (not report) then return end

		local id = q:lastInsert() or 0
		if (stack) then stack = util.JSONToTable(stack) end
		report_error({err = error, ip = serverip, rlm = realm, st = stack, pl = steamid, errid = id})
	end)
end

local error_cache = {}
local pl_error_cache = {}
local function isskid(err,stack)
	if err:match("^%:") then return true, true end
	if not stack[1] then return false end
	if not isstring(stack[1].source) then return false end
	if (stack[1].source == "[C]") and (not stack[2]) then 
		return true, true 
	elseif (stack[1].source == "[C]" and stack[2]) then
		stack[1] = stack[2]
	end
	if stack[1].source == "filename" then return true, true end
	if stack[1].source == "LuaCmd" then return true, true end
	if (not stack[1].source:match("%/")) then return true, true end
	if (not file.Exists(stack[1].source,"GAME")) then return true, true end
	return false
end

local function catchError(pl, err, src, _, _, stack)
	if (not err or error_cache[err]) then return end
	if isbool(pl) or (not pl) then -- serverside error
		report_error({err = err, ip = MOAT_RCON.Server, rlm = 2, st = stack})
	end
	if (not MOAT_RCON or not MOAT_RCON.DBHandle) then return end -- sql not loaded yet
	error_cache[err] = true
	--if (not src or not src:find("moat_addons")) then return end
	local ply = pl
	pl = type(pl) == "Player" and pl:SteamID64() or nil
	if (pl and pl_error_cache[pl]) then
		if (pl_error_cache[pl] >= 5) then return end
		pl_error_cache[pl] = pl_error_cache[pl] + 1
	elseif (pl) then
		pl_error_cache[pl] = 1
	end

	/*if type(ply) == "Player" then
		local skid,ping = isskid(err,stack)
		if skid then
			discord.Send("Skid",(ping and "<@135912347389788160> <@150809682318065664> " or "") .. "`" .. ply:Nick() .. "` (`" .. ply:SteamID() .. "`) (`" .. ply:IPAddress() .. "`) " .. string.Extra(GetServerName(), GetServerURL()) .. " Skid Error: ```" .. err .. "```")
		end
	end*/
	local row = sql.QueryRow("SELECT stack FROM luaerror_reports WHERE error = " .. sql.SQLStr(err))
	if (row) then return end
	if (report_errors:GetInt() ~= 1) then return end

	local st = {}
	if (stack) then
		for i = 1, 5 do
			if (not stack[i]) then break end
			table.insert(st, stack[i])
		end
	end

	st = util.TableToJSON(st)
	sql.Query("INSERT INTO luaerror_reports (error, stack) VALUES (" .. sql.SQLStr(err) .. ", " .. sql.SQLStr(st) .. ");")

	MOAT_RCON:Query("SELECT serverip FROM moat_errors WHERE error = #", err, function(d)
		logerror((not d or not d[1]), err, MOAT_RCON.Server, pl and 1 or 0, st, pl)
	end)
end

hook.Add("LuaError", "catchServerError", catchError)
hook.Add("ClientLuaError", "catchClientError", catchError)