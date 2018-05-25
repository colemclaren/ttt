D3A.Ranks 		 = D3A.Ranks or {}
D3A.Ranks.Stored = D3A.Ranks.Stored or {}
D3A.Ranks.Prefix = D3A.Ranks.Prefix or nil

function D3A.Ranks.Register(name, weight, flags, global, color)
	color = color or Color(255, 255, 255)
	global = global or false
	flags = flags or ""
	weight = weight or 0
	-- It should have a name, of all things
	
	local flagstab = {}
	for i=1, #flags do
		flagstab[flags[i]:lower()] = true
	end
	
	local basename = string.Replace(name:lower(), " ", "")
	D3A.Ranks.Stored[basename] = {Name = name, Weight = weight, FlagsString = flags, Flags = flagstab, Global = global}
	
	for k, v in ipairs(player.GetAll()) do
		local r = v:GetDataVar("rank")
		if (r) then
			if (r[1] == basename) then
				D3A.Ranks.Parse(v)
			end
		end
	end
end

function D3A.Ranks.CheckWeight(tm1, tm2)
	if (type(tm1) == "Player") then tm1 = tm1.Rank end
	if (type(tm1) == "Entity") then if (!tm1:IsPlayer()) then return true end end
	if (type(tm2) == "Player") then tm2 = tm2.Rank end
	if (istable(tm1) and tm1.rcon) then tm1 = tm1:GetUserGroup() end
	if (istable(tm2) and tm2.rcon) then tm2 = tm2:GetUserGroup() end
	
	if (!D3A.Ranks.Stored[tm1] or !D3A.Ranks.Stored[tm2]) then return true end
	
	return D3A.Ranks.Stored[tm1].Flags["*"] or (D3A.Ranks.Stored[tm1].Weight >= D3A.Ranks.Stored[tm2].Weight)
end

function D3A.Ranks.Parse(pl)
	local tm = D3A.Ranks.Stored[pl.Rank]
	
	if (!tm) then return end
	
	pl:SetDataVar("rank", {Name = tm.Name, Weight = tm.Weight, Flags = tm.Flags, FlagsString = tm.FlagsString}, false, true)
end

function D3A.Ranks.SetSteamIDRank(sid, tmname, exptime, exptm, data)
	local tm = D3A.Ranks.Stored[tmname] or nil;
	local extm;
	
	if (exptime and exptime == 0) then exptime = nil; end
	
	if (exptime) then
		extm = D3A.Ranks.Stored[exptm] or nil
		if (!extm) then return false, ("No such team: " .. exptm) end
	end
	
	if (!data) then
		data = D3A.MySQL.QueryRet(D3A_selectUserInfo(self:SteamID(), self:SteamID64()));
		
		if (!data) then
			return false, "User data not found";
		end
		
		data = data[1];
		data.Vars = util.JSONToTable(data.extra or "[]");
		
	end
	
	if (tm) then
		if (tm.Global) then
			local sqln = "'" .. tmname .. "'";
			if (tmname == "user") then sqln = "NULL"; end
			
			D3A.MySQL.Query("UPDATE player SET rank=" .. sqln .. " WHERE steam_id='" .. util.SteamIDTo64(sid) .. "'", function()			
				exptime = tostring((exptime and os.time() + exptime) or 0)
				data.Vars["rankexpire"] = exptime
				data.Vars["rankexpireto"] = exptm

				if (D3A.Ranks.Prefix) then
					data.Vars[D3A.Ranks.Prefix .. "_rank"] = nil;
					data.Vars[D3A.Ranks.Prefix .. "_rankexpire"] = nil;
					data.Vars[D3A.Ranks.Prefix .. "_rankexpireto"] = nil;
				else
					D3A.Print(sid .. " set to global rank " .. tmname);
				end

				D3A.MySQL.Query("UPDATE player SET extra=\"" .. D3A.MySQL.Escape(util.TableToJSON(data.Vars)) .. "\" WHERE steam_id='" .. util.SteamIDTo64(sid) .. "';", function()
					D3A.Print(sid .. " set to global rank " .. tmname);
				end);
			end)

			return true
		else
			if (D3A.Ranks.Prefix) then
				exptime = tostring((exptime and os.time() + exptime) or 0)
				
				data.Vars[D3A.Ranks.Prefix .. "_rank"] = tmname;
				data.Vars[D3A.Ranks.Prefix .. "_rankexpire"] = exptime;
				data.Vars[D3A.Ranks.Prefix .. "_rankexpireto"] = exptm;
				
				D3A.MySQL.Query("UPDATE player SET rank=NULL WHERE steam_id='" .. util.SteamIDTo64(sid) .. "'", function()
					D3A.MySQL.Query("UPDATE player SET extra=\"" .. D3A.MySQL.Escape(util.TableToJSON(data.Vars)) .. "\" WHERE steam_id='" .. util.SteamIDTo64(sid) .. "';");
				end);

				return true
			else
				return false, "Local ranks prefix not set"
			end
		end
	else
		return false, ("No such team: " .. tmname)
	end
end

function D3A.Ranks.SetPlayerRank(pl, tmname, exptime, exptm)
	local tm = D3A.Ranks.Stored[tmname] or nil
	local extm
	
	if (exptime and exptime == 0) then exptime = nil end
	
	if (exptime) then
		extm = D3A.Ranks.Stored[exptm] or nil
		if (!extm) then return false, ("No such team: " .. exptm) end
	end
	
	if (tm) then
		if (tm.Global) then
			local sqln = "'" .. tmname .. "'"
			if (tmname == "user") then sqln = "NULL" end
			D3A.MySQL.Query("UPDATE player SET rank=" .. sqln .. " WHERE steam_id='" .. pl:SteamID64() .. "'", function()
				D3A.Print(pl:SteamID() .. " set to global rank " .. tmname)
				pl.Rank = tmname
				D3A.Ranks.Parse(pl)
			end)

			exptime = tostring((exptime and os.time() + exptime) or 0)
			pl:SetDataVar("rankexpire", exptime, true, false)
			pl:SetDataVar("rankexpireto", exptm, true, false)
			
			if (D3A.Ranks.Prefix) then
				pl:SetDataVar(D3A.Ranks.Prefix .. "_rank", nil, true, false)
				pl:SetDataVar(D3A.Ranks.Prefix .. "_rankexpire", nil, true, false)
				pl:SetDataVar(D3A.Ranks.Prefix .. "_rankexpireto", nil, true, false)
			end
			
			return true
		else
			if (D3A.Ranks.Prefix) then
				exptime = tostring((exptime and os.time() + exptime) or 0)
				pl:SetDataVar(D3A.Ranks.Prefix .. "_rank", tmname, true, false)
				pl:SetDataVar(D3A.Ranks.Prefix .. "_rankexpire", exptime, true, false)
				pl:SetDataVar(D3A.Ranks.Prefix .. "_rankexpireto", exptm, true, false)
				pl.Rank = tmname
				D3A.Ranks.Parse(pl)

				return true
			else
				return false, "Local ranks prefix not set"
			end
		end
	else
		return false, ("No such team: " .. tmname)
	end
end

local function expirePlayerRank(pl, newRank)
	timer.Simple(0.1, function()
		if (pl:IsValid()) then
			D3A.Ranks.SetPlayerRank(pl, newRank);
						
			pl:ChatPrint("Your rank has expired, and you've been set to " .. D3A.Ranks.Stored[newRank].Name .. ".");
		end
	end);
end

function D3A.Ranks.PlayerTimeSaved(pl, delta)
	local pre = D3A.Ranks.Prefix;

	local exptime = tonumber(pl:GetDataVar("rankexpire") or 0)
	if (exptime) then
		if (exptime != 0 and exptime < os.time()) then
			local newRank = pl:GetDataVar("rankexpireto") or D3A.Ranks.Default

			expirePlayerRank(pl, newRank)
		end
		return
	end
	
	if (pre and pl:GetDataVar(pre .. "_rank")) then
		local exptime = tonumber(pl:GetDataVar(pre .. "_rankexpire")) or 0;
		
		if (exptime != 0 and exptime < os.time()) then
			local newRank = (pl:GetDataVar(pre .. "_rankexpireto") or D3A.Ranks.Default);
			
			D3A.Ranks.SetPlayerRank(pl, newRank);
			
			pl:ChatPrint("Your rank has expired, and you've been set to " .. D3A.Ranks.Stored[newRank].Name .. ".");
		end
	end
end
hook.Add("PlayerTimeSaved", "D3A.Ranks.PlayerTimeSaved", D3A.Ranks.PlayerTimeSaved);

function D3A.Ranks.PlayerDataLoaded(pl, data)
	if (D3A.Ranks.Prefix == nil) then
		local inf = hook.Call("D3A_SetupRanks", GAMEMODE) or {false, "user"}
		D3A.Ranks.Prefix, D3A.Ranks.Default = inf[1], inf[2]
	end

	if (data.rank) then
		pl.Rank = data.rank

		local exptime = tonumber(data.Vars["rankexpire"] or 0)

		if (exptime != 0 and exptime < os.time()) then
			local newRank = data.Vars["rankexpireto"] or D3A.Ranks.Default

			expirePlayerRank(pl, newRank)
		end
	else		
		if (D3A.Ranks.Prefix and data.Vars[D3A.Ranks.Prefix .. "_rank"]) then
			local exptime = tonumber(data.Vars[D3A.Ranks.Prefix .. "_rankexpire"] or 0)
			
			if (exptime != 0 and exptime < os.time()) then
				local newRank = (data.Vars[D3A.Ranks.Prefix .. "_rankexpireto"] or D3A.Ranks.Default);
				
				expirePlayerRank(pl, newRank)
			else
				pl.Rank = data.Vars[D3A.Ranks.Prefix .. "_rank"]
			end
		else
			pl.Rank = D3A.Ranks.Default or "user"
		end
	end

	if (not pl.Rank) then pl.Rank = "user" end
	
	D3A.Ranks.Parse(pl)
end
hook.Add("PlayerDataLoaded", "D3A.Ranks.PlayerDataLoaded", D3A.Ranks.PlayerDataLoaded)

local ipb_group_to_id = {
	["communitylead"] = 14,
	["headadmin"] = 13,
	["senioradmin"] = 12,
	["admin"] = 11,
	["moderator"] = 10,
	["trialstaff"] = 9,
	["credibleclub"] = 8,
	["vip"] = 7
}

local ipb_id_to_group = {
	[14] = "communitylead",
	[13] = "headadmin",
	[12] = "senioradmin",
	[11] = "admin",
	[10] = "moderator",
	[9] = "trialstaff",
	[8] = "credibleclub",
	[23] = "vip",
	[3] = "user"
}

function D3A.Ranks.IPBSync(pl)
	D3A.MySQL.Query("SELECT member_group_id, mgroup_others FROM core_members WHERE steamid='" .. pl:SteamID64() .. "'", function(data)
		if (data and data[1] and data[1]["member_group_id"]) then
			local group_id = tonumber(data[1]["member_group_id"])
			local is_ttt_staff = data[1]["mgroup_others"] and string.find(data[1]["mgroup_others"], "21")
			local vip_or_user = group_id == 23 or group_id == 3

			if (pl:GetUserGroup() == "vip") then
				D3A.MySQL.Query("UPDATE core_members SET member_group_id=23, mgroup_others=3 WHERE steamid='" .. pl:SteamID64() .. "'")
				group_id = 23
			end

			if (pl:IsValid() and IsValid(pl) and ipb_id_to_group[group_id] and (pl:GetUserGroup() ~= ipb_id_to_group[group_id]) and ((not vip_or_user and is_ttt_staff) or (vip_or_user and not is_ttt_staff))) then
				local tmname = ipb_id_to_group[group_id]
				local newrank
				local succ, err = D3A.Ranks.SetPlayerRank(pl, tmname, 0, newrank)
		
				if (!succ) then
					return
				else
					tmname = D3A.Ranks.Stored[tmname].Name
					newrank = (newrank and D3A.Ranks.Stored[newrank].Name) or nil
				end
			end
		end
	end)
end

function moat_makevip(pl)
	if (pl:IsValid() and IsValid(pl)) then
		local tmname = "vip"
		local newrank
		local succ, err = D3A.Ranks.SetPlayerRank(pl, tmname, 0, newrank)
		
		if (!succ) then
			return
		else
			tmname = D3A.Ranks.Stored[tmname].Name
			newrank = (newrank and D3A.Ranks.Stored[newrank].Name) or nil
		end

		D3A.MySQL.Query("UPDATE core_members SET member_group_id=23, mgroup_others=3 WHERE steamid='" .. pl:SteamID64() .. "'")
	end
end