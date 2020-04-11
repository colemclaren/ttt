if (not _BeginRound) then _BeginRound = BeginRound end
if (not _PrepareRound) then _PrepareRound = PrepareRound end

function ttt.RoundChecker()
    if (GetRoundState() == ROUND_ACTIVE) then
        if (CurTime() > GetGlobal("ttt_round_end")) then
			if (DidJesterDie) then
				EndRound(DidJesterDie() and WIN_JESTER or WIN_TIMELIMIT)
			else
				EndRound(WIN_TIMELIMIT)
			end
        else
            local win = hook.Call("TTTCheckForWin", GAMEMODE)

            if (win ~= WIN_NONE) then
                EndRound(win)
            end
        end
    elseif (GetRoundState() == ROUND_PREP) then
		 if (CurTime() >= (GetGlobal("ttt_round_end") - 1)) then
			if (CurTime() >= GetGlobal("ttt_round_end")) then
				ttt.StopChecker()
				BeginRound()
				hook.Run("ttt.BeginRound")
				return
			end
			MuteForRestart(true)
		end
	end
end

function ttt.StartChecker()
	if (not timer.Start("winchecker")) then
        timer.Create("winchecker", 1, 0, ttt.RoundChecker)
    end
end

function ttt.StopChecker()
	timer.Stop("winchecker")
end

function ttt.SetPrepareTime(ptime)
	SetRoundEnd(CurTime() + ptime)
	
	ttt.StartChecker()

    LANG.Msg("round_begintime", {
        num = ptime
    })
end

function ttt.PrepareRound()
    if (ttt.CheckForAbort()) then
		return
	end

    if (_CleanUp) then
		_CleanUp()
	else
		CleanUp()
	end

	GAMEMODE.MapWin = WIN_NONE
    GAMEMODE.AwardedCredits = false
    GAMEMODE.AwardedCreditsDead = 0
	-- Update damage scaling
	KARMA.InitState()
    SCORE:Reset()
    -- New look. Random if no forced model set.
    GAMEMODE.playermodel = GAMEMODE.force_plymodel == "" and GetRandomPlayerModel() or GAMEMODE.force_plymodel
	SetGlobalString("ttt_default_playermodel", GAMEMODE.playermodel or GetRandomPlayerModel() or "models/player/phoenix.mdl")
    GAMEMODE.playercolor = hook.Call("TTTPlayerColor", GAMEMODE, GAMEMODE.playermodel)
    
	if (ttt.CheckForAbort()) then
		return
	end

    local ptime = GetConVar("ttt_preptime_seconds"):GetInt()

    if (GAMEMODE.FirstRound) then
        ptime = GetConVar("ttt_firstpreptime"):GetInt()
        GAMEMODE.FirstRound = false
    end

    SetRoundState(ROUND_PREP)

	ttt.SetPrepareTime(ptime)
    -- Delay spawning until next frame to avoid ent overload

	if (_PlaceExtraWeapons) then
		timer.Simple(0, ttt.SpawnEntities)
	else
		timer.Simple(0, ttt.TTCSpawnEntities)
    end

    -- Undo the roundrestart mute, though they will once again be muted for the
    -- selectmute timer.
    timer.Create("restartmute", 1, 1, function()
        MuteForRestart(false)
    end)
	
	--net.Start("TTT_ClearClientState")
    --net.Broadcast()

    -- In case client's cleanup fails, make client set all players to innocent role
    timer.Simple(1, SendRoleReset)
    -- Tell hooks and map we started prep
    hook.Run("TTTPrepareRound")

	if (_TriggerRoundStateOutputs) then
    	_TriggerRoundStateOutputs(ROUND_PREP)
	else
		ents.TTT.TriggerRoundStateOutputs(ROUND_PREP)
	end
end

hook("PostGamemodeLoaded", function()
	PrepareRound = ttt.PrepareRound
end)