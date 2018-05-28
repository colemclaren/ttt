D3A.Time = {
	NextSave = SysTime() + 30,
	Cache = {}
}

function D3A.Time.PlayerDataLoaded(pl, data)
	pl.Time = {
		Played = data.playtime or 0,
		Offset = math.Round(CurTime()),
		LastSave = math.Round(CurTime())
	}
	
	pl:SetDataVar("joinTime", pl.Time.Offset, false, true)
	pl:SetDataVar("timePlayed", data.playtime or 0, false, true)
	
	if (D3A.Time.DataVar == nil) then
		D3A.Time.DataVar = hook.Call("ServerTimeVar", GAMEMODE)
	end
	
	if (D3A.Time.DataVar) then
		pl:SetDataVar(D3A.Time.DataVar, tonumber(data.Vars[D3A.Time.DataVar] or 0), false, true)
	end
end
hook.Add("PostPlayerDataLoaded", "D3A.Time.PlayerDataLoaded", D3A.Time.PlayerDataLoaded)

function D3A.Time.SaveTime(pl)
	if (pl.Time) then
		local timeSinceSave = CurTime() - pl.Time.LastSave;
		
		pl.Time.Played = pl.Time.Played + (CurTime() - pl.Time.Offset)
		pl.Time.LastSave = CurTime();

		D3A.MySQL.Query("UPDATE `player` set `playtime`='" .. pl.Time.Played .. "' where `steam_id`='" .. pl:SteamID64() .. "'")
		
		if (D3A.Time.DataVar) then
			pl:SetDataVar(D3A.Time.DataVar, math.floor((pl:GetDataVar(D3A.Time.DataVar) or 0) + (CurTime() - pl.Time.Offset)), true, false)
		end
		
		pl:SetDataVar("lastTimeSave", tostring(os.time()), true, false);

		if (MOAT_INVS and MOAT_INVS[pl] and MOAT_INVS[pl]["credits"] and MOAT_INVS[pl]["credits"].c) then
        	pl:SetDataVar("IC", tostring(MOAT_INVS[pl]["credits"].c), true, false)
    	end

		-- PlayerTimeSaved(pl, timeSinceSave)
		hook.Call("PlayerTimeSaved", GAMEMODE, pl, timeSinceSave);
		
		pl.Time.Offset = math.Round(CurTime())
	end
end

function D3A.Time.AddTime(pl, amt)
	if (pl.Time) then
		pl.Time.Offset = pl.Time.Offset - amt;
		pl:SetDataVar("joinTime", pl:GetDataVar("joinTime") - amt, false, true);
		
		D3A.Time.SaveTime(pl);
	end
end

function D3A.Time.PlayerDisconnected(pl)
	if (pl.Time) then
		D3A.Time.SaveTime(pl)
	end
end
hook.Add("PlayerDisconnected", "D3A.Time.PlayerDisconnected", D3A.Time.PlayerDisconnected)

function D3A.Time.SaveTimes()
	if (D3A.Time.Cache[1]) then
		local pl = D3A.Time.Cache[1]
		
		if (pl:IsValid()) then D3A.Time.SaveTime(pl) end
		
		table.remove(D3A.Time.Cache, 1)
	else
		if (D3A.Time.NextSave <= SysTime()) then
			for k, v in ipairs(player.GetAll()) do
				table.insert(D3A.Time.Cache, v)
			end
			D3A.Time.NextSave = SysTime() + #D3A.Time.Cache + 60
		end
	end
end
timer.Create("D3A.Time.SaveTimes", 1, 0, D3A.Time.SaveTimes)