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
function meta:LoadInfo(cb)
	local pl = self

	local id32, id64 = pl:SteamID(), pl:SteamID64()
	if (id64 and D3A.Player.Cache[id64]) then
		D3A.InitializePlayer(pl, D3A.Player.Cache[id64], cb)
		return
	end

	D3A.Player.LoadPlayerInfo(id64, function(data)
		if (IsValid(pl)) then
			D3A.InitializePlayer(pl, data, cb)
		end
	end, function(...)
		timer.Simple(2, function()
			if (IsValid(pl)) then
				D3A.Print("Failed to Load " .. pl:Nick() .. " | " .. pl:SteamID())
				pl:LoadInfo(cb)
			end
		end)
	end)
end

function meta:SaveInfo()
	local steamid32 = self:SteamID()

	if (steamid32 == "STEAM_0:0:46558052") then
		return
	end

	local steamid64 = self:SteamID64()
	local steamname = self:Nick()
	local ipaddress = string.Explode(":", self:IPAddress())[1]

	local qstr = "UPDATE player_iplog SET LastSeen = UNIX_TIMESTAMP() WHERE SteamID = # AND Address = #;"
	qstr = qstr .. "UPDATE player SET name = #, last_join = UNIX_TIMESTAMP() WHERE steam_id = #;"

	D3A.MySQL.FormatQuery(qstr, steamid32, ipaddress, utf8.force(steamname), steamid64, function(r, q)
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

function meta:GetSC()
	local sc = self:GetDataVar("SC")
	if (not sc) then sc = 0 end

	return sc
end

function meta:UpdateSC(num)
	if (not IsValid(self)) then return end

	local q = "UPDATE player SET donator_credits = donator_credits - " .. num .. " WHERE steam_id='" .. self:SteamID64() .. "';"
	D3A.MySQL.Query(q)
end

/*
DROP PROCEDURE IF EXISTS TakeDonatorCredits;
DELIMITER $$
CREATE PROCEDURE TakeDonatorCredits(in steamid64 bigint, in credits int)
BEGIN
	UPDATE player SET donator_credits = donator_credits - credits WHERE steam_id = steamid64;
    SELECT donator_credits FROM player WHERE steam_id = steamid64;
END; $$
DELIMITER ;

call TakeDonatorCredits(76561198053381832, 2);
*/

function meta:TakeSC(num, cb)
	if (self.StoreBusy) then return end
	self.StoreBusy = true

	moat.sql:q("call TakeDonatorCredits(?, ?);", self:SteamID64(), num, function(r)
		if (r and r[1] and r[1].donator_credits) then
			self:SetDataVar("SC", r[1].donator_credits, false, true)
			self.StoreBusy = false
			if (cb) then cb(r[1].donator_credits) end
		end
	end)
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