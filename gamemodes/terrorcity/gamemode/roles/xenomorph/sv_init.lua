util.AddNetworkString "xenomorph.timer"

local XENOMORPH = ROLE
XENOMORPH.HasDied = false
XENOMORPH.RespawnTime = 30
XENOMORPH.Ply = nil

function XENOMORPH.RespawnTimer(pl, rnd, rnd_now)
	if (GetRoundState() ~= ROUND_ACTIVE) then return end
	if ((rnd_now and rnd) and (rnd ~= rnd_now)) then return end


	pl:SpawnForRound(true)
	pl:SetRole(ROLE_XENOMORPH)

	CustomMsg(pl, "You have been respawned as a Phoenix!", Color(0, 249, 199))
end

InstallRoleHook("PlayerDeath", 1)

function XENOMORPH:PlayerDeath(pl, _, atk)
	if (GetRoundState() ~= ROUND_ACTIVE) then return end
	if (atk == pl) then
		return
	end
	if (not XENOMORPH.HasDied) then
		XENOMORPH.Ply = pl
		XENOMORPH.HasDied = true
		XENOMORPH.Respawning = true

		net.Start "xenomorph.timer"
		net.Send(pl)

		local rnd = GetGlobal("ttt_rounds_left")
		timer.Simple(XENOMORPH.RespawnTime, function()
			if (not IsValid(pl)) then
				return
			end
			XENOMORPH.Respawning = false
			XENOMORPH.RespawnTimer(pl, rnd, GetGlobal("ttt_rounds_left"))
		end)
	end
end

InstallRoleHook("PlayerCanHearPlayersVoice", 2)
function XENOMORPH:PlayerCanHearPlayersVoice(l, talker)
	if (self:Alive() and XENOMORPH.HasDied) then
		return false
	end
end

InstallRoleHook("PlayerCanSeePlayersChat", 4)
function XENOMORPH:PlayerCanSeePlayersChat(_, _, l, speaker)
	if (self:Alive() and XENOMORPH.HasDied) then
		return false
	end
end


function XENOMORPH.ResetXenomorph()
	XENOMORPH.Ply = nil
	XENOMORPH.Respawning = false
	XENOMORPH.HasDied = false
end
hook.Add("TTTPrepareRound", "terror.city.xenomorph", XENOMORPH.ResetXenomorph)
hook.Add("TTTEndRound", "terror.city.xenomorph", XENOMORPH.ResetXenomorph)