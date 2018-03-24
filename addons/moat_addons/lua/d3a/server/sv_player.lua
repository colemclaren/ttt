D3A.Player = {}

function D3A.Player.CanTarget(pl1, pl2)
	return D3A.Ranks.CheckWeight(pl1:GetUserGroup(), pl2:GetUserGroup())
end

function D3A.Player.InsertNewPlayerToTable(SteamID, SteamID32, IP, Name, AvatarURL)
	D3A.MySQL.Query("REPLACE INTO player (`steam_id`, `name`, `first_join`, `avatar_url`, `inventory_credits`, `event_credits`, `donator_credits`, `extra`) VALUES ('" .. SteamID .."', '" .. D3A.MySQL.Escape(Name) .. "', '" .. os.time() .. "', '" .. AvatarURL .. "', 0, 0, 0, null);")
	D3A.MySQL.Query("REPLACE INTO player_iplog (`SteamID`, `Address`, `LastSeen`) VALUES ('" .. SteamID32 .. "', '" .. IP .. "', '-1');")
	D3A.Print(SteamID32 .. " | Connecting for the first time")
end

local max = GetConVarNumber("maxplayers")
local cur_max = 0
local playersjoined = {}
local math_Clamp = math.Clamp

local function raise_cur()
    cur_max = math_Clamp(cur_max + 1, 0, max)
end

local function lower_cur()
    cur_max = math_Clamp(cur_max - 1, 0, max)
end

hook.Add("PlayerAuthed","ReservedSlotsAuthed",function(ply)
    if not playersjoined[ply:SteamID64()] then
        raise_cur()
    end
end)

gameevent.Listen("player_disconnect")
hook.Add("player_disconnect","ReservedSlotsDisconnect",function()
    lower_cur()
end)

local staff_slots = {}
staff_slots["moderator"] = true
staff_slots["trialstaff"] = true
staff_slots["admin"] = true
staff_slots["senioradmin"] = true
staff_slots["headadmin"] = true
staff_slots["communitylead"] = true


function D3A.Player.CheckReserved(steamid, rank)
	if (cur_max < max) then return end
	if (staff_slots[rank]) then return end
	local pls = player.GetAll()
	local staff_found = false

	for i = 1, #pls do
		local g = pls[i]:GetUserGroup()

		if (g and staff_slots[g]) then
			staff_found = true
			break
		end
	end

	if (staff_found) then return end
	game.KickID(steamid, "Server Full!\n\nThere is a reserved slot for staff members only, sorry <3")
end

local vip_server = GetHostName():lower():find("beta")
local vip_slots = table.Copy(staff_slots)
vip_slots["credibleclub"] = true
vip_slots["vip"] = true

function D3A.Player.CheckPassword(SteamID, IP, sv_Pass, cl_Pass, Name)
	local SteamID32 = util.SteamIDFrom64(SteamID)

    raise_cur()
    playersjoined[SteamID] = true

	-- Check if banned
	D3A.Bans.IsBanned(SteamID32, function(isbanned, data)
		if isbanned then
			local exp
			if (tonumber(data.Current.length) == 0) then
				exp = "permanently"
			else
				exp = math.Round(((data.Current.time + data.Current.length) - os.time())/60, 2) .. " minutes"
			end
			game.KickID(SteamID32, "\nYou are banned!\n==================\nTime left: " .. exp .. "\nReason: " .. data.Current.reason .. "\n==================\nThink it's an unfair ban?\nHead to http://moat.gg/unban to make an unban appeal")
		end
	end)

	-- Check pass
	if (sv_Pass != "") and (cl_Pass != sv_Pass) then
		return false, "Invalid password: " .. cl_Pass
	end

	-- Create data
	D3A.MySQL.Query("SELECT rank FROM player WHERE `steam_id` ='" .. SteamID .. "';", function(d)
		if (d and d[1]) then
			D3A.Print(SteamID32 .. " | Connecting")

			if (vip_server and (not d[1].rank or not vip_slots[d[1].rank])) then
				game.KickID(SteamID32, "This is the Moat.GG TTT Testing server. It is currently only accessable to VIP's and above. Please join one of our regular servers, sorry!")
				return
			end

			D3A.Player.CheckReserved(SteamID32, d[1].rank or "user")
		else
			local def = "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/fe/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb_full.jpg"
			http.Fetch("https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/?key=13E8032658377F036842094BDD9E7000&steamids=" .. SteamID, function(b)
				D3A.Player.InsertNewPlayerToTable(SteamID, SteamID32, IP, Name, util.JSONToTable(b).response.players[1]["avatarfull"])
			end, function(e)
				D3A.Player.InsertNewPlayerToTable(SteamID, SteamID32, IP, Name, def)
			end)
			
			if (vip_server) then
				game.KickID(SteamID32, "This is the Moat.GG TTT Testing server. It is currently only accessable to VIP's and above. Please join one of our regular servers, sorry!")
				return
			end

			D3A.Player.CheckReserved(SteamID32, "user")
		end
	end)

	/*D3A.MySQL.Query("CALL createUserInfo('" .. SteamID .. "', '" .. D3A.MySQL.Escape(Name) .. "', '" .. IP .. "', '" .. os.time() .. "');", function(d)
		if (tonumber(d[1].Created) == 1) then
			D3A.Print(SteamID .. " | Connecting for the first time")
		else
			D3A.Print(SteamID .. " | Connecting")
		end
	end)*/

	--return true
end
hook.Add("CheckPassword", "D3A.Player.CheckPassword", D3A.Player.CheckPassword)

function D3A.Player.PlayerAuthed(pl)
	pl:LoadInfo(function(data)
		if (!data) then return end

		local msg_tbl = {}
		table.insert(msg_tbl, moat_cyan)
		table.insert(msg_tbl, pl:SteamName())
		table.insert(msg_tbl, moat_white)

		if (not data.last_join) then 
			table.insert(msg_tbl, " has joined for the first time")
		else
			table.insert(msg_tbl, " last joined ")
			table.insert(msg_tbl, moat_green)
			table.insert(msg_tbl, D3A.FormatTime(os.time(), data.last_join))
			table.insert(msg_tbl, moat_white)
			table.insert(msg_tbl, " ago")

			if (data.name ~= pl:SteamName()) then
				table.insert(msg_tbl, " as ")
				table.insert(msg_tbl, moat_green)
				table.insert(msg_tbl, data.name)
				table.insert(msg_tbl, moat_white)
			end
		end
		table.insert(msg_tbl, ".")
		D3A.Chat.Broadcast2(unpack(msg_tbl))
		
		pl:SaveInfo()
		D3A.Ranks.IPBSync(pl)
	end)
end
hook.Add("PlayerAuthed", "D3A.Player.PlayerAuthed", D3A.Player.PlayerAuthed)

function D3A.Player.PlayerDisconnected(pl)
	D3A.Chat.Broadcast2(moat_cyan, pl:SteamName(), moat_white, " has disconnected. (", moat_green, pl:SteamID(), moat_white, ")")
end
hook.Add("PlayerDisconnected", "D3A.Player.PlayerDisconnected", D3A.Player.PlayerDisconnected)

function D3A.Player.PhysgunPickup(pl, ent)
	if ent:IsPlayer() and pl:HasAccess(D3A.Config.PlayerPhysgun) and pl:GetDataVar("adminmode") and D3A.Player.CanTarget(pl, ent) then
		ent:Freeze(true)
		ent:SetMoveType(MOVETYPE_NOCLIP)
		return true
	end
end
hook.Add("PhysgunPickup", "D3A.Player.PhysgunPickup", D3A.Player.PhysgunPickup)

function D3A.Player.PhysgunDrop(pl, ent)
	if ent:IsPlayer() then
		ent:Freeze(false)
		ent:SetMoveType(MOVETYPE_WALK)
	end
end
hook.Add("PhysgunDrop", "D3A.Player.PhysgunDrop", D3A.Player.PhysgunDrop)

function D3A.Player.PlayerNoClip(pl)
	if pl:HasAccess(D3A.Config.PlayerNoClip) then
		return true
	end
end
hook.Add("PlayerNoClip", "D3A.Player.PlayerNoClip", D3A.Player.PlayerNoClip)