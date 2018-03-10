util.AddNetworkString "xenomorph.timer"

local XENOMORPH = {}
XENOMORPH.HasDied = false
XENOMORPH.RespawnTime = 30
XENOMORPH.Ply = nil

function XENOMORPH.RespawnTimer(pl, rnd, rnd_now)
	if (GetRoundState() ~= ROUND_ACTIVE) then return end
	if ((rnd_now and rnd) and (rnd ~= rnd_now)) then return end


    timer.Create("respawn_player" .. pl:EntIndex(), 0.1, 0, function()
        if (not IsValid(pl)) then return end

        pl:SpawnForRound(true)
        pl:SetRole(ROLE_XENOMORPH)

        if (pl:IsActive()) then timer.Destroy("respawn_player" .. pl:EntIndex()) return end
    end)
end

function XENOMORPH.PostDeath(pl)
	if (GetRoundState() ~= ROUND_ACTIVE) then return end
	if (pl:GetRole() == ROLE_XENOMORPH and not XENOMORPH.HasDied) then
		XENOMORPH.Ply = pl
		XENOMORPH.HasDied = true
		XENOMORPH.Respawning = true

		net.Start "xenomorph.timer"
		net.Send(pl)

		local rnd = GetGlobalInt("ttt_rounds_left")
		timer.Create("terror.city.xenomorph", XENOMORPH.RespawnTime, 1, function()
			if (not IsValid(pl)) then return end
			XENOMORPH.Respawning = false
			XENOMORPH.RespawnTimer(pl, rnd, GetGlobalInt("ttt_rounds_left"))
		end)
	end
end
hook.Add("PostPlayerDeath", "terror.city.xenomorph", XENOMORPH.PostDeath)


function XENOMORPH.CanHearVoice(l, t)
	if (XENOMORPH.HasDied and XENOMORPH.Respawning and IsValid(XENOMORPH.Ply) and (l == XENOMORPH.Ply or t == XENOMORPH.Ply)) then
		return false
	end
end
hook.Add("PlayerCanHearPlayersVoice", "terror.city.xenomorph", XENOMORPH.CanHearVoice)

function XENOMORPH.PlayerCanSeePlayersChat(_, _, l, s)
	if (XENOMORPH.HasDied and XENOMORPH.Respawning and IsValid(XENOMORPH.Ply) and (l == XENOMORPH.Ply or s == XENOMORPH.Ply)) then
		return false
	end
end
hook.Add("GM:PlayerCanSeePlayersChat", "terror.city.xenomorph", XENOMORPH.PlayerCanSeePlayersChat)


function XENOMORPH.ResetXenomorph()
	XENOMORPH.Ply = nil
	XENOMORPH.Respawning = false
	XENOMORPH.HasDied = false
end
hook.Add("TTTPrepareRound", "terror.city.xenomorph", XENOMORPH.ResetXenomorph)
hook.Add("TTTEndRound", "terror.city.xenomorph", XENOMORPH.ResetXenomorph)