function D3A.LoadSteamID(id, succ, err)
	D3A.MySQL.Query(D3A_selectUserInfo(id), function(d)
		if (d and d[1]) then
			local r = d[1]
			
			if (not r.rank) then r.rank = "user" end
			if (r.rank_expire and r.rank_expire <= os.time()) then
				r.rank = r.rank_expire_to or "user"
			end

			if (succ) then succ(r) end
		else
			if (err) then err() end
		end
	end)
end

util.AddNetworkString "D3A.Warn"

function D3A.NewWarning(targstid, plstid, targname, plname, reason, cb)
	D3A.MySQL.FormatQuery("INSERT INTO player_warns (steam_id, staff_steam_id, name, staff_name, time, reason, acknowledged) VALUES (#, #, #, #, UNIX_TIMESTAMP(), #, NULL)",
	targstid, plstid, targname, plname, reason, function()
		if (cb) then cb() end
	end)
end

D3A.Warns = D3A.Warns or {}
function D3A.WarnPlayer(pl)
	local sid = pl:SteamID64()
	if (not sid) then return end

	D3A.MySQL.FormatQuery("SELECT id, CAST(staff_steam_id AS CHAR) AS staff_steam_id, staff_name, time, reason FROM player_warns WHERE steam_id = # AND acknowledged IS NULL;", 
	sid, function(r)
		if (not r or not r[1]) then return end
		D3A.Warns[sid] = r

		net.Start "D3A.Warn"
			net.WriteUInt(#r, 8)

			for i = 1, #r do
				net.WriteUInt(i, 8)
				net.WriteUInt(r[i].id, 32)
				net.WriteString(r[i].staff_steam_id)
				net.WriteString(r[i].staff_name)
				net.WriteString(tostring(r[i].time))
				net.WriteString(r[i].reason)
			end

		net.Send(pl)
	end)
end
--hook.Add("PlayerInitialSpawn", "D3A.Check.Warns", D3A.WarnPlayer)