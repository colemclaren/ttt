if (CLIENT) then return end

local SURVIVOR = {}
SURVIVOR.Roles = {[ROLE_INNOCENT] = true, [ROLE_JESTER] = true}
SURVIVOR.Extra = {[ROLE_TRAITOR] = true, [ROLE_KILLER] = true}

function SURVIVOR:GiveHealth(pls, pls_num)
	local pl, extra = nil, 0
	for i = 1, pls_num do
		local ply = pls[i]
		if (self.Extra[ply:GetRole()]) then extra = extra + 1 end
		if (ply:GetRole() == ROLE_SURVIVOR) then pl = ply end
	end

	if (not pl or extra == 0) then return end
	local new_hp = extra * 200
	pl:SetMaxHealth(new_hp)
	pl:SetHealth(new_hp)
end

function SURVIVOR.CheckPlayers(pl)
	if (SURVIVOR.Dead or GetRoundState() ~= ROUND_ACTIVE) then return end
	if (pl:GetRole() == ROLE_SURVIVOR) then SURVIVOR.Dead = true return end
	
	local pls = player.GetAll()
	local pls_num = #pls
	local inno_alive = 0
	for i = 1, pls_num do
		local ply = pls[i]
		if (ply:IsDeadTerror()) then continue end
		if (SURVIVOR.Roles[BASIC_ROLE_LOOKUP[ply:GetRole()]]) then inno_alive = inno_alive + 1 end

		if (i == pls_num and inno_alive == 1) then SURVIVOR:GiveHealth(pls, pls_num) end
	end
end
hook.Add("PostPlayerDeath", "terror.city.survivor", SURVIVOR.CheckPlayers)

function SURVIVOR.CheckSurvivor()
	local pls = player.GetAll()
	for i = 1, #pls do
		if (pls[i]:GetRole() == ROLE_SURVIVOR) then SURVIVOR.Dead = false break end
	end
end
hook.Add("TTTBeginRound", "terror.city.survivor", SURVIVOR.CheckSurvivor)

function SURVIVOR.ResetSurvivor()
	SURVIVOR.Dead = true
end
hook.Add("TTTPrepareRound", "terror.city.survivor", SURVIVOR.ResetSurvivor)