if (CLIENT) then return end

local BODYGUARD = {}
BODYGUARD.Roles = {[ROLE_DETECTIVE] = true}
BODYGUARD.Ply = nil
function BODYGUARD.CheckPlayers(pl)
	if (BODYGUARD.Dead or GetRoundState() ~= ROUND_ACTIVE) then return end
	if (pl:GetRole() == ROLE_BODYGUARD) then BODYGUARD.Dead = true return end

	local pls = player.GetAll()
	local pls_num = #pls
	local d_alive = 0
	for i = 1, pls_num do
		local ply = pls[i]

		if (ply:IsDeadTerror()) then continue end
		if (BODYGUARD.Roles[ply:GetRole()]) then
			d_alive = d_alive + 1
		end
	end

	if (d_alive < 1 and IsValid(BODYGUARD.Ply)) then
		BODYGUARD.Dead = true
		BODYGUARD.Ply:SetRole(ROLE_DETECTIVE)
		BODYGUARD.Ply:SetHealth(math.min(BODYGUARD.Ply:Health(), 25))
		BODYGUARD.Ply:SetMaxHealth(25)
		SendDetectiveList()
		CustomMsg(BODYGUARD.Ply, "You failed to protect the detectives, so you take their place!", Color(0, 153, 153))
	end
end
hook.Add("PostPlayerDeath", "terror.city.bodyguard", BODYGUARD.CheckPlayers)

function BODYGUARD.CheckBodyguard()
	local pls = player.GetAll()
	for i = 1, #pls do
		if (pls[i]:GetRole() == ROLE_BODYGUARD) then
			BODYGUARD.Dead = false
			BODYGUARD.Ply = pls[i]
			break
		end
	end
end
hook.Add("TTTBeginRound", "terror.city.bodyguard", BODYGUARD.CheckBodyguard)

function BODYGUARD.ResetBodyguard()
	BODYGUARD.Dead = true
end
hook.Add("TTTPrepareRound", "terror.city.bodyguard", BODYGUARD.ResetBodyguard)