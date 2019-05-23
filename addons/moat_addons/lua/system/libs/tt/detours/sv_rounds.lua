if (not _BeginRound) then _BeginRound = BeginRound end
if (not _PrepareRound) then _PrepareRound = PrepareRound end

function tt.RoundChecker()
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
				tt.StopChecker()
				BeginRound()
				hook.Run("tt.BeginRound")
				return
			end
			MuteForRestart(true)
		end
	end
end

function tt.StartChecker()
	if (not timer.Start("winchecker")) then
        timer.Create("winchecker", 1, 0, tt.RoundChecker)
    end
end

function tt.StopChecker()
	timer.Stop("winchecker")
end

function tt.SetPrepareTime(ptime)
	SetRoundEnd(CurTime() + ptime)
	
	tt.StartChecker()

    LANG.Msg("round_begintime", {
        num = ptime
    })
end

function tt.PrepareRound()
    if (tt.CheckForAbort()) then
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
    GAMEMODE.playercolor = hook.Call("TTTPlayerColor", GAMEMODE, GAMEMODE.playermodel)
    
	if (tt.CheckForAbort()) then
		return
	end

    local ptime = GetConVar("ttt_preptime_seconds"):GetInt()

    if (GAMEMODE.FirstRound) then
        ptime = GetConVar("ttt_firstpreptime"):GetInt()
        GAMEMODE.FirstRound = false
    end

    SetRoundState(ROUND_PREP)

	tt.SetPrepareTime(ptime)
    -- Delay spawning until next frame to avoid ent overload

	if (_PlaceExtraWeapons) then
		timer.Simple(0, tt.SpawnEntities)
	else
		timer.Simple(0, tt.TTCSpawnEntities)
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
	PrepareRound = tt.PrepareRound
end)