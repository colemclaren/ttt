util.AddNetworkString "xenomorph.timer"

local XENOMORPH = {}
XENOMORPH.HasDied = false
XENOMORPH.RespawnTime = 30

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
		XENOMORPH.HasDied = true
		local rnd = GetGlobalInt("ttt_rounds_left")

		net.Start "xenomorph.timer"
		net.Send(pl)

		timer.Create("terror.city.xenomorph", XENOMORPH.RespawnTime, 1, function()
			if (not IsValid(pl)) then return end
			XENOMORPH.RespawnTimer(pl, rnd, GetGlobalInt("ttt_rounds_left"))
		end)
	end
end
hook.Add("PostPlayerDeath", "terror.city.xenomorph", XENOMORPH.PostDeath)

function XENOMORPH.ResetXenomorph()
	XENOMORPH.HasDied = false
end
hook.Add("TTTPrepareRound", "terror.city.xenomorph", XENOMORPH.ResetXenomorph)