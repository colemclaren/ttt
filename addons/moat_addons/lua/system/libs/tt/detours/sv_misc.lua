function tt.SpawnEntities()
	local import = ents.TTT.CanImportEntities()

	_RemoveCorpses()
	_PlaceExtraWeapons(import)
	_ReplaceMapItems()
	
	local pls = player.GetAll()
	for k, v in ipairs(pls) do
		if (not IsValid(v)) then continue end
		KARMA.RoundBegin(v)
        v.JustSpawned = v:SpawnForRound()
		hook.Run("TTTPrepareRoundPlayer", v)
	end
end

function tt.EnoughPlayers(p)
	if (not p) then return false end
    local ready = 0

    for _, ply in ipairs(p) do
        if (IsValid(ply) and ply:ShouldSpawn()) then
            ready = ready + 1
        end
    end

    return ready >= tt.MinimumPlayers
end

function tt.CheckForAbort(p)
	local pls = player.GetAll()
    if (not tt.EnoughPlayers(pls)) then
        LANG.Msg("round_minplayers")
        tt.StopTimers()
        WaitForPlayers()

        return true
    end

    return false
end