mlogs.AlivePlayers = mlogs.AlivePlayers or {num = 0}

function mlogs.RefreshAlive()
	mlogs.AlivePlayers = {num = 0}
end
mlogs:hook("mlogs.begin", mlogs.RefreshAlive)

function mlogs.AddAlive(pl)
	mlogs.AlivePlayers.num = mlogs.AlivePlayers.num + 1
	mlogs.AlivePlayers[mlogs.AlivePlayers.num] = pl
end
mlogs:hook("mlogs.ply.begin", mlogs.AddAlive)


function mlogs.PlayerCantSee(pos1, pos2)
	return util.TraceLine({start = pos1, endpos = pos2, mask = MASK_VISIBLE}).HitWorld
end

function mlogs.GetWitnesses(pos)
	if (mlogs.AlivePlayers.num == 0) then return end
	if (mlogs.DontLog) then return end

	local t = ""
	for i = 1, mlogs.AlivePlayers.num do
		if (not IsValid(mlogs.AlivePlayers[i])) then continue end
		if (mlogs.AlivePlayers[i]:Team() == TEAM_SPEC) then continue end
		if (mlogs.PlayerCantSee(mlogs.AlivePlayers[i]:GetPos(), pos)) then continue end

		t = t .. (mlogs.AlivePlayers[i]:PlayerID() or "") .. " "
	end
	if (t == "") then t = false end

	return t
end