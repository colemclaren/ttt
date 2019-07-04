MOAT_RCON = MOAT_RCON or {}
MOAT_RCON.Server = GetConVarString("ip") .. ":" .. GetConVarString("hostport") //"208.103.169.30:27015"
MOAT_RCON.RanCommands = {}

function MOAT_RCON:Escape(str)
	if (not str or str == "NULL") then return "NULL" end
    return isnumber(str) and tostring(str) or "\"" .. self.DBHandle:escape(tostring(str)) .. "\""
end

function MOAT_RCON:Query(str, ...)
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

function MOAT_RCON:ProcessCommand(d)
	if (self.RanCommands[d.id]) then return end
	if (d.command and d.command == "fixed") then
		sql.QueryRow("DELETE FROM server_errors WHERE error = " .. sql.SQLStr(d.args))
		print("DELETE FROM server_errors WHERE error = " .. sql.SQLStr(d.args))
		self.RanCommands[d.id] = true
		return
	end

	if (d.args) then d.args = util.JSONToTable(d.args) end
	if (d.steamid and d.steamid:StartWith("STEAM_0")) then d.args[1] = d.steamid end

	local admin = MOAT_RCON.Player(d.staff_name, d.staff_steamid, d.staff_rank, d.id)
	if d.command == "po2" then d.command = "po" end
	D3A.Commands.Parse(admin, d.command, d.args or {})

	self.RanCommands[d.id] = true
end

function MOAT_RCON:CheckQueue(srvr)
	self:Query("select id, staff_steamid, staff_rank, staff_name, command, args, steamid from rcon_commands as rc inner join rcon_queue as rq on rc.id = rq.cmdid where rq.server = #;", srvr, function(d)
		if (not d or not d[1]) then return end
		self:Query("delete from rcon_queue where server = #;", srvr, function()
			for i = 1, #d do
				MOAT_RCON:ProcessCommand(d[i])
			end
		end)
	end)
end

function MOAT_RCON:OnConnected()
	timer.Create("moat.rcon.queue", 5, 0, function()
		MOAT_RCON:CheckQueue(MOAT_RCON.Server)
	end)
end


hook.Add("SQLConnected", "MoatRCONSQL", function(db)
	MOAT_RCON.DBHandle = db
	MOAT_RCON:OnConnected(db)
end)

function MOAT_RCON.Player(name, steamid, rank, id)
	local pl = {}
	pl.rcon = {Name = name, SteamID = steamid, SteamID64 = util.SteamIDTo64(steamid), Rank = rank, ID = id}

	function pl:SteamID() return self.rcon.SteamID end
	function pl:SteamID64() return self.rcon.SteamID64 end
	function pl:Nick() return self.rcon.Name end
	function pl:Name() return self:Nick() end
	function pl:GetName() return self:Nick() end
	function pl:SteamName() return self:Nick() end
	function pl:NameID() return self:Nick() .. " (" .. self:SteamID() .. ")" end
	function pl:GetUserGroup() return self.rcon.Rank end
	function pl:IsUserGroup(r) return self:GetUserGroup() == r end

	local tm = moat.Ranks.Get(pl.rcon.Rank) or moat.Ranks.Get "user"
	function pl:GetRank() return {Name = tm.Name, Weight = tm.Weight, Flags = tm.Flags, FlagsString = tm.FlagsString} end
	function pl:HasAccess(Flag)
		if (Flag == "") then return true end
		Flag = Flag:lower()

		local flags = self:GetRank() and self:GetRank().Flags
		return (flags ~= nil) and ((flags["*"] or flags[Flag]) == true)
	end
	function pl:GetGroupWeight() return self:GetRank() and self:GetRank().Weight or 0 end
	function pl:IsAdmin() return self:HasAccess(D3A.Config.IsAdmin) end
	function pl:IsSuperAdmin() return self:HasAccess(D3A.Config.IsSuperAdmin) end
	function pl:RconID() return self.rcon.ID end
	function pl:IsValid() return false end

	setmetatable(pl, {__index = function(s) return NULL end})
	return pl
end




--[[

		Discord Message Part

]]--

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
		url = moat.cfg.oldwebhook .. "serverrcon",
		body = util.TableToJSON(tbl),
		type = "application/json",
		success = cb
	})

	HTTP({
		method = "POST",
		url = moat.cfg.webhook .. "serverrconmoon",
		body = util.TableToJSON(tbl),
		type = "application/json",
		success = cb
	})
end


function MOAT_RCON:Post(pl, chatmsg)
	local tbl = {}
	tbl.server = self.Server
	tbl.player = pl.rcon
	tbl.msg = chatmsg

	post(tbl)
end




--[[

		Keep these here just in case.
		When restoring commands, make sure to remove any commands that a staff should not be using remotely. (teleporting, etc)
		There's also other commands for discord shit so pls try not to use these commands.

concommand.Add("_restorecommands", function(pl)
	if (IsValid(pl)) then return end

	MOAT_RCON:Query("TRUNCATE TABLE player_cmds", function()
		local t = table.Copy(D3A.Commands.Stored)

		for k, v in pairs(t) do
			if (not v.Flag or v.Flag == "" or v.Flag:lower() == "c") then continue end

			MOAT_RCON:Query("INSERT INTO player_cmds (name, flag, weight, args) VALUES (#, #, #, #)", k:lower(), v.Flag:lower(), v.CheckRankWeight and 1 or 0, v.Args and util.TableToJSON(v.Args) or "NULL") 
		end
	end)
end)

concommand.Add("_restoreranks", function(pl)
	if (IsValid(pl)) then return end

	MOAT_RCON:Query("TRUNCATE TABLE player_ranks", function()
		local t = table.Copy(D3A.Ranks.Stored)

		for k, v in pairs(t) do
			MOAT_RCON:Query("INSERT INTO player_ranks (name, weight, flags) VALUES (#, #, #)", k:lower(), v.Weight, v.FlagsString:lower()) 
		end
	end)
end)

]]--