function D3A_selectUserInfo(steamid, steamid64)
	return "SELECT player.name, player.rank, player.first_join, player.last_join, player.playtime, player.inventory_credits, player.event_credits, player.donator_credits, player.extra, player_iplog.Address, player_iplog.LastSeen FROM player, player_iplog WHERE player.steam_id='" .. steamid64 .. "' AND player_iplog.SteamID='" .. steamid .. "' ORDER BY LastSeen DESC LIMIT 1;"
end

local meta = FindMetaTable("Player")

function meta:LoadInfo(callback)
	D3A.MySQL.Query(D3A_selectUserInfo(self:SteamID(), self:SteamID64()), function(d)
		if (!self:IsValid()) then return end
		
		local data = d[1]
		if (not data) then
			timer.Simple(2, function() D3A.Print("Failed to Load " .. self:Nick() .. " | " .. self:SteamID()) self:LoadInfo(callback) end)
			return
		end

		data.extra = data.extra or "[]";
		local newVars = util.JSONToTable(data.extra);
		newVars["IC"] = data.inventory_credits or 0
		newVars["EC"] = data.event_credits or 0
		newVars["SC"] = data.donator_credits or 0
		newVars["lastTimeSave"] = data.last_join

		if (not data.rank) then data.rank = "user" end

		data.Vars = newVars
		local checkToUpdate = table.Count(data.Vars)
		
		self._Vars = {}
		self._PersistVars = {}
		self._NetVars = {}
		
		hook.Call("PlayerDataLoaded", GAMEMODE, self, data)
		
		self._PersistVars = data.Vars
		for k, v in pairs(data.Vars) do
			if D3A.NW.IsRegistered(k) then
				self:SetDataVar(k, v)
			end
			self._Vars[k] = v
		end

		if (table.Count(data.Vars) != checkToUpdate) then -- Some script added a default value
			self:SaveVars()
		end
		
		hook.Call("PostPlayerDataLoaded", GAMEMODE, self, data);
		
		if callback then callback(data) end
	end)
end

function meta:SaveInfo()
	local steamid32 = self:SteamID()
	local steamid64 = self:SteamID64()
	local steamname = D3A.MySQL.Escape(self:SteamName())
	local ipaddress = self:IPAddress()

	D3A.MySQL.Query("UPDATE player SET `name`='" .. steamname .. "' WHERE `steam_id`='" .. steamid64 .. "';")

	D3A.MySQL.Query("SELECT `LastSeen` FROM player_iplog WHERE `SteamID`='" .. steamid32 .. "' AND `Address`='" .. ipaddress .. "';", function(d)
		if (d and #d > 0) then
			D3A.MySQL.Query("UPDATE player_iplog SET `LastSeen`='" .. os.time() .. "' WHERE `SteamID`='" .. steamid32 .. "' AND `Address`='" .. ipaddress .. "';")
		else
			D3A.MySQL.Query("INSERT INTO player_iplog (`SteamID`, `Address`, `LastSeen`) VALUES ('" .. steamid32 .. "', '" .. ipaddress .. "', '" .. os.time() .. "');")
		end
	end)


	--D3A.MySQL.Query("DELETE FROM player_iplog WHERE `SteamID`='" .. steamid32 .. "' AND `Address`='" .. ipaddress .. "';")
	--D3A.MySQL.Query("INSERT INTO player_iplog (`SteamID`, `Address`, `LastSeen`) VALUES ('" .. steamid32 .. "', '" .. ipaddress .. "', '" .. os.time() .. "');")
	--"CALL updateUserInfo('" .. self:SteamID() .. "', '" .. D3A.MySQL.Escape(self:SteamName()) .. "', '" .. self:IPAddress() .. "', '" .. os.time() .. "');")
end

function meta:SaveVars() -- The system will call this, you don't need to
	if (!self:IsValid()) then return end
	
	local t = table.Copy(self._PersistVars or {})

	local inventory_credits = t["IC"] or 0
	t["IC"] = nil

	local event_credits = t["EC"] or 0
	t["EC"] = nil

	local donator_credits = t["SC"] or 0
	t["SC"] = nil

	local last_join = t["lastTimeSave"] or 0
	t["lastTimeSave"] = nil

	local s = util.TableToJSON(t);
	
	local q = "UPDATE player SET last_join = '" .. last_join .. "', event_credits = '" .. event_credits .. "', inventory_credits = '" .. inventory_credits .. "', extra=\"" .. D3A.MySQL.Escape(s) .. "\" WHERE steam_id='" .. self:SteamID64() .. "';"
	timer.Create("save_" .. self:UniqueID(), 1, 1, function()
		D3A.MySQL.Query(q)
	end)
end

function meta:UpdateSC(num)
	if (!self:IsValid()) then return end

	local q = "UPDATE player SET donator_credits = donator_credits - " .. num .. " WHERE steam_id='" .. self:SteamID64() .. "';"
	timer.Create("save_sc_" .. self:UniqueID(), 1, 1, function()
		D3A.MySQL.Query(q)
	end)
end

function meta:SetDataVar(name, val, persist, network)
	if (!self._Vars) then
		D3A.Print("Queueing SetDataVar on " .. self:SteamID() .. " : " .. name)
		local pl = self
		hook.Add("PostPlayerDataLoaded", "VarQueue." .. self:SteamID() .. "." .. name, function()
			timer.Simple(0, function() 
				if IsValid(pl) then
					pl:SetDataVar(name, val, persist, network) 
				end
			end)
			hook.Remove("PostPlayerDataLoaded", "VarQueue." .. self:SteamID() .. "." .. name)
		end)
		
		return
	end

	self._Vars[name] = val
	
	if (persist) then
		self._PersistVars[name] = val
		
		self:SaveVars()
	end
	
	if (network) then
		self._NetVars[name] = val
		self:SetNetVar(name, val)
	end
end

meta.SteamName = meta.SteamName or meta.Name