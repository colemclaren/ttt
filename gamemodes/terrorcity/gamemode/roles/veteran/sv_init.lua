if (CLIENT) then return end

local VETERAN = {}
VETERAN.Roles = {[ROLE_TRAITOR] = true, [ROLE_KILLER] = true}

function VETERAN.PlayerDeath(vic, inf, att)
	if (not att or not IsValid(att) or not att:IsPlayer()) then return end
	if (not vic or not IsValid(vic) or att == vic) then return end
	if (att:GetRole() ~= ROLE_VETERAN or GetRoundState() ~= ROUND_ACTIVE) then return end

	if (not VETERAN.Roles[BASIC_ROLE_LOOKUP[vic:GetRole()]]) then
		att:Kill()
		CustomMsg(att, "You killed an innocent terrorist, you must perish!", Color(179, 0, 255))
	end
end

hook.Add("PlayerDeath", "terror.city.veteran", VETERAN.PlayerDeath)

function VETERAN.Strip()
	local pls = player.GetAll()
	for i = 1, #pls do
		if (pls[i]:GetRole() == ROLE_VETERAN) then
			pls[i]:Give("weapon_ttt_veteran")
		end
	end
end
hook.Add("TTTBeginRound", "terror.city.veteran", VETERAN.Strip)

function VETERAN.RestrictPickup(pl, wep)
	if (GetRoundState() == ROUND_ACTIVE and pl:GetRole() == ROLE_VETERAN) then
		return wep:GetClass() == "weapon_ttt_veteran"
	end
end
hook.Add("PlayerCanPickupWeapon", "terror.city.veteran", VETERAN.RestrictPickup)