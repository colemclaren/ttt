util.AddNetworkString "terrorcity.doctor"

local DOCTOR = ROLE
DOCTOR.HasRespawned = false

local suiciders = DOCTOR.Suiciders or {}
DOCTOR.Suiciders = suiciders

function DOCTOR.Respawn(_, pl)
	if (pl:GetRole() ~= ROLE_DOCTOR) then return end

	if (pl.LastDoctorMessage and pl.LastDoctorMessage > CurTime() or pl:IsDeadTerror()) then return end
	pl.LastDoctorMessage = CurTime() + 1

	if (DOCTOR.HasRespawned) then
		CustomMsg(pl, "You've already respawned someone this round!", Color(0, 200, 255))
		return
	end
	if (GetRoundState() ~= ROUND_ACTIVE) then
		CustomMsg(pl, "You can only revive while the round is active!", Color(0, 200, 255))
		return
	end

	local vic = net.ReadEntity()
	if (not IsValid(vic) or not vic:IsPlayer() or not vic:IsDeadTerror() or suiciders[vic] or vic:GetBasicRole() ~= ROLE_INNOCENT) then
		return
	end

	DOCTOR.HasRespawned = true
	CustomMsg(pl, "You have revived " .. vic:Nick() .. "!", Color(0, 200, 255))

	net.Start "terrorcity.doctor"
		net.WriteUInt(0, 3)
	net.Send(pl)

	timer.Create("respawn_player" .. vic:EntIndex(), 0.1, 0, function()
		if (not IsValid(vic)) then return end

		vic:SpawnForRound(true)

		if (vic:GetRole() == ROLE_VETERAN) then
			vic:StripAll()
			vic:Give("weapon_ttt_veteran")
		end
		--vic:SetRole(ROLE_BODYGUARD)

		CustomMsg(vic, "You have been revived by a doctor!", Color(0, 200, 255))

		if (vic:IsActive()) then timer.Destroy("respawn_player" .. vic:EntIndex()) return end
	end)
end
net.Receive("terrorcity.doctor", DOCTOR.Respawn)

hook.Add("PlayerDeath", "terrorcity.doctor", function(pl, _, atk)
	if (atk == pl) then
		suiciders[pl] = true

		-- notify doctors so they cannot revive suicides
		net.Start "terrorcity.doctor"
			net.WriteUInt(1, 3)
			net.WriteEntity(pl)
		net.Send(GetRoleFilter(ROLE_DOCTOR))
	end
end)

InstallRoleHook("PlayerDeath", 3)
function ROLE:PlayerDeath(pl)
	-- doctor cannot revive people he has killed
	suiciders[pl] = true
	net.Start "terrorcity.doctor"
		net.WriteUInt(1, 3)
		net.WriteEntity(pl)
	net.Send(self)
end


function ROLE:TTTBeginRound()
	DOCTOR.HasRespawned = false
end