function D3A_selectUserInfo(id64)
	id64 = D3A.MySQL.Escape(id64)

	return [[SELECT name, rank, first_join, last_join, 
	playtime, inventory_credits, event_credits, donator_credits, 
	extra, rank_expire, rank_expire_to, rank_changed FROM
	player WHERE steam_id = ']] .. id64 .. [[' LIMIT 1;]]
end

function D3A.InitializePlayer(pl, data, cb)
	if (not IsValid(pl)) then return end
	if (not data.rank) then data.rank = "user" end

	pl._Vars = {}

	pl:SetDataVar("EC", tonumber(data.event_credits) or 0, false, true)
	pl:SetDataVar("SC", tonumber(data.donator_credits) or 0, false, true)

	D3A.Time.LoadPlayer(pl, data.playtime)
	D3A.Ranks.LoadRank(pl, data.rank, data.rank_expire, data.rank_expire_to)

	hook.Run("PlayerDataLoaded", pl, data)

	if (cb) then cb(data) end
end

local meta = FindMetaTable("Player")
function meta:LoadInfo(callback)
	local pl = self

	local id32, id64 = pl:SteamID(), pl:SteamID64()
	if (id64 and D3A.Player.Cache[id64]) then
		D3A.InitializePlayer(pl, D3A.Player.Cache[id64], callback)
		return
	end

	D3A.MySQL.Query(D3A_selectUserInfo(id64), function(d)
		if (not IsValid(pl)) then return end

		local data = d and d[1]
		if (not data) then
			timer.Simple(2, function()
				if (IsValid(pl)) then
					D3A.Print("Failed to Load " .. pl:Nick() .. " | " .. pl:SteamID())
					pl:LoadInfo(callback)
				end
			end)

			return
		end

		D3A.InitializePlayer(pl, data, callback)
	end)
end

function meta:SaveInfo()
	local steamid32 = self:SteamID()
	local steamid64 = self:SteamID64()
	local steamname = D3A.MySQL.Escape(self:Nick())
	local ipaddress = D3A.MySQL.Escape(string.Explode(":", self:IPAddress())[1])

	local qstr = "UPDATE player_iplog SET LastSeen = UNIX_TIMESTAMP() WHERE SteamID = # AND Address = #;"
	qstr = qstr .. "UPDATE player SET name = #, last_join = UNIX_TIMESTAMP() WHERE steam_id = #;"

	D3A.MySQL.FormatQuery(qstr, steamid32, ipaddress, steamname, steamid64, function(r, q)
		local ar = q:affectedRows()
		if (not ar or tonumber(ar) >= 1) then return end

		D3A.MySQL.FormatQuery("SELECT LastSeen FROM player_iplog WHERE SteamID = # AND Address = #;", steamid32, ipaddress, function(res)
			if (res and res[1]) then return end

			D3A.MySQL.FormatQuery("INSERT INTO player_iplog (LastSeen, SteamID, Address) VALUES (UNIX_TIMESTAMP(), #, #);", steamid32, ipaddress)
		end)
	end)
end

local var_columns = {
	["SC"] = "donator_credits",
	["EC"] = "event_credits",
	["IC"] = "inventory_credits",
	["timePlayed"] = "playtime",
	["lastTimeSave"] = "last_join"
}

function meta:SaveVar(var, val)
	if (not IsValid(self)) then return end
	local id64 = self:SteamID64()
	if (not id64) then return end

	local qstr = "UPDATE player SET " .. var_columns[var] .. " = # WHERE steam_id = #;"
	D3A.MySQL.FormatQuery(qstr, val, id64)
end

function meta:SaveVars(var, val)
	if (not IsValid(self)) then return end
	if (var and var_columns[var]) then
		self:SaveVar(var, val)
		return
	end

	-- hmm
end

function meta:UpdateSC(num)
	if (not IsValid(self)) then return end

	local q = "UPDATE player SET donator_credits = donator_credits - " .. num .. " WHERE steam_id='" .. self:SteamID64() .. "';"
	D3A.MySQL.Query(q)
end

function meta:SetDataVar(name, val, persist, network)
	local pl = self
	if (not IsValid(pl)) then return end

	if (not pl._Vars) then
		local hn = "VarQueue." .. pl:SteamID() .. "." .. name
		D3A.Print("Queueing SetDataVar for " .. hn)

		hook.Add("PlayerDataLoaded", hn, function()
			timer.Simple(0, function() 
				if (IsValid(pl)) then
					pl:SetDataVar(name, val, persist, network) 
				end
			end)

			hook.Remove("PlayerDataLoaded", hn)
		end)

		return
	end

	pl._Vars[name] = val

	if (persist) then
		pl:SaveVars(name, val)
	end

	if (network) then
		pl:SetNetVar(name, val)
	end
end

meta.SteamName = meta.SteamName or meta.Name