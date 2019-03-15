function D3A.MySQL.GetPlayer(id64, res, empty)
	return moat.mysql("SELECT * FROM player WHERE steam_id = ? LIMIT 1;", id64, function(d)
		if (d and d[1]) then
			return res and res()
		else
			return empty and empty()
		end
	end)
end

D3A.Player = D3A.Player or {}
D3A.Player.Cache = D3A.Player.Cache or {}

function D3A.Player.CanTarget(pl1, pl2)
	return moat.Ranks.CheckWeight(pl1:GetUserGroup(), pl2:GetUserGroup())
end

function D3A.Player.PlayerAuthed(pl)
	pl:LoadInfo(function(data)
		if (not data or not IsValid(pl)) then return end

		local msg_tbl = {}
		table.insert(msg_tbl, moat_cyan)
		table.insert(msg_tbl, pl:SteamName())
		table.insert(msg_tbl, moat_white)

		if (not data.last_join) then 
			table.insert(msg_tbl, " has joined for the first time")
		else
			table.insert(msg_tbl, " last joined ")
			table.insert(msg_tbl, moat_green)
			table.insert(msg_tbl, D3A.FormatTimeNow(data.last_join))
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
	local id = pl:SteamID64()
	if (id) then D3A.Player.Cache[id] = nil end

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
	if (pl:HasAccess(D3A.Config.PlayerNoClip)) then
		return true
	end
end
hook.Add("PlayerNoClip", "D3A.Player.PlayerNoClip", D3A.Player.PlayerNoClip)

function D3A.Player.DisconnectEvent(info)
	D3A.HandleMapDisconnects(info.reason)

	local steamid64 = util.SteamIDTo64(info.networkid)
	if (not steamid64) then return end

	D3A.Player.Cache[steamid64] = nil
end

gameevent.Listen "player_disconnect"
hook.Add("player_disconnect", "D3A.Player.DisconnectEvent", D3A.Player.DisconnectEvent)