util.AddNetworkString "terrorcity.doctor"

local DOCTOR = {}
DOCTOR.HasRespawned = false

function DOCTOR.Respawn(_, pl)
	if (pl.LastDoctorMessage and pl.LastDoctorMessage > CurTime()) then return end
	pl.LastDoctorMessage = CurTime() + 1

	if (pl:GetRole() ~= ROLE_DOCTOR) then return end
	if (pl:GetRoundState() ~= ROUND_ACTIVE) then
		CustomMsg(pl, "You can only revive while the round is active!", Color(0, 200, 255))
		return
	end

	if (DOCTOR.HasRespawned) then
		CustomMsg(pl, "You've already respawned someone this round!", Color(0, 200, 255))
		return
	end

	local vic = net.ReadEntity()
	if (not IsValid(vic) or not vic:IsPlayer()) then return end
	
	DOCTOR.HasRespawned = true
	CustomMsg(pl, "You have been revived " .. vic:Nick() .. " as your bodyguard!", Color(0, 200, 255))

	net.Start "terrorcity.doctor"
	net.Send(pl)
	
    timer.Create("respawn_player" .. vic:EntIndex(), 0.1, 0, function()
        if (not IsValid(vic)) then return end

        vic:SpawnForRound(true)
        vic:SetRole(ROLE_BODYGUARD)

        CustomMsg(vic, "You have been revived by a doctor! Protect them or you will perish!", Color(0, 200, 255))

        if (vic:IsActive()) then timer.Destroy("respawn_player" .. vic:EntIndex()) return end
    end)
end
net.Receive("terrorcity.doctor", DOCTOR.Respawn)


function DOCTOR.Reset()
	DOCTOR.HasRespawned = false
end
hook.Add("TTTBeginRound", "terror.city.doctor", DOCTOR.Reset)