if (CLIENT) then return end

local SURVIVOR = ROLE
SURVIVOR.Roles = {[ROLE_INNOCENT] = true}
SURVIVOR.Extra = {[ROLE_TRAITOR] = true, [ROLE_KILLER] = true, [ROLE_JESTER] = true}

function SURVIVOR:GiveHealth()
	if (SURVIVOR.GotHealth) then
		return
	end
	local pl, extra = nil, 0
	for i, ply in pairs(player.GetAll()) do
		if (self.Extra[ply:GetRole()]) then extra = extra + 1 end
		if (ply:GetRole() == ROLE_SURVIVOR) then pl = ply end
	end

	if (not IsValid(pl)) then
		return
	end

	SURVIVOR.GotHealth = true
	local new_hp = pl:Health() + extra * 75
	pl:SetMaxHealth(new_hp)
	pl:SetHealth(new_hp)
end

function SURVIVOR.CheckPlayers(pl)
	if (GetRoundState() ~= ROUND_ACTIVE or SURVIVOR.Extra[pl:GetRole()]) then return end

	local inno_alive = 0
	for i, ply in pairs(player.GetAll()) do
		if (ply:IsDeadTerror() or ply:IsSpec()) then
			continue
		end

		if (SURVIVOR.Roles[BASIC_ROLE_LOOKUP[ply:GetRole()]]) then
			inno_alive = inno_alive + 1
		end
	end

	if (inno_alive == 1) then
		SURVIVOR:GiveHealth()
	end
end
hook.Add("PostPlayerDeath", "terror.city.survivor", SURVIVOR.CheckPlayers)

function SURVIVOR:TTTBeginRound()
	SURVIVOR.GotHealth = false
end