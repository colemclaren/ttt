D3A.Time = D3A.Time or {}
D3A.Time.Joins = D3A.Time.Joins or {}

function D3A.Time.GetQueryString(id)
	local c = D3A.Time.Joins[id]
	if (not c) then return end
	local add, fq = math.max(1, SysTime() - c)
	add = math.Round(add) or 1

	if (MOAT_CREDSAVE and MOAT_CREDSAVE[id]) then
		fq = D3A.MySQL.FormatQueryString("UPDATE player SET last_join = UNIX_TIMESTAMP(), playtime = playtime + #, inventory_credits = # WHERE steam_id = #;", add, MOAT_CREDSAVE[id], id)
    else
		fq = D3A.MySQL.FormatQueryString("UPDATE player SET last_join = UNIX_TIMESTAMP(), playtime = playtime + # WHERE steam_id = #;", add, id)
	end

	D3A.Time.Joins[id] = nil
	return fq
end

function D3A.Time.LoadPlayer(pl, time)
	pl:SetDataVar("timePlayed", tonumber(time) or 0, false, true)

	local id = pl:SteamID64()
	if (not id) then return end

	D3A.Time.Joins[id] = SysTime()
end


function D3A.Time.SaveTimeDisconnect(info)
	local steamid64 = util.SteamIDTo64(info.networkid)
	if (not steamid64) then return end
	local qstr = D3A.Time.GetQueryString(steamid64)
	if (not qstr) then return end

	D3A.MySQL.Query(qstr)
end
gameevent.Listen "player_disconnect"
hook.Add("player_disconnect", "D3A.Time.SaveTimeDisconnect", D3A.Time.SaveTimeDisconnect)


function D3A.Time.SaveAllTimes()
	local pls, qstr = player.GetAll(), ""

	for k = 1, #pls do
		local v = pls[k]
		if (not IsValid(v)) then continue end
		local id = v:SteamID64()
		if (not id) then continue end

		local pstr = D3A.Time.GetQueryString(id)
		if (not pstr) then continue end

		qstr = qstr .. pstr
	end

	if (qstr == "") then return end
	D3A.MySQL.Query(qstr)
end
hook.Add("ShutDown", "D3A.Time.SaveTimes", D3A.Time.SaveAllTimes)