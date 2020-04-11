function ttt.SpawnEntities()
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

function ttt.TTCSpawnEntities()
    local et = ents.TTT
    -- Spawn weapons from script if there is one
    local import = et.CanImportEntities(game.GetMap())

    if (import) then
        et.ProcessImportScript(game.GetMap())
    else
        et.ReplaceEntities()
        et.PlaceExtraWeapons()
    end

    SpawnWillingPlayers()
end

function ttt.EnoughPlayers(p)
	if (not p) then return false end
    local ready = 0

    for _, ply in ipairs(p) do
        if (IsValid(ply) and ply:ShouldSpawn()) then
            ready = ready + 1
        end
    end

    return ready >= ttt.MinimumPlayers
end

function ttt.CheckForAbort(p)
	local pls = player.GetAll()
    if (not ttt.EnoughPlayers(pls)) then
        LANG.Msg("round_minplayers")
        ttt.StopTimers()
        WaitForPlayers()

        return true
    end

    return false
end