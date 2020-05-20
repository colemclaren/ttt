util.AddNetworkString "terrortown.jester.killed"

local ROLE = ROLE
function ROLE:PlayerShouldTakeDamage(ply)
    return false
end

InstallRoleHook("PlayerShouldTakeDamage", 2)

function ROLE:m_ShouldPreventWeaponHitTalent(attacker, victim)
    return true
end

InstallRoleHook("m_ShouldPreventWeaponHitTalent", 1)

local ded = false

hook.Add("PlayerDeath", "terrortown.roles.jester", function(vic, inf, att)
	if (GetRoundState() == ROUND_ACTIVE and IsValid(vic) and vic:IsActiveRole(ROLE_JESTER) and IsValid(att) and att:IsPlayer() and att:GetRole() ~= ROLE_JESTER and vic ~= att) then
		net.Start("jester.killed")
        net.WriteString(att:Nick() or "Someone")
        net.Broadcast()

		StartRoundSpeedup(math.ceil(ROLE.ActivePlayers * 0.175, 2))
		ded = true
    end
end)

hook.Add("m_ShouldPreventWeaponHitTalent", "terrortown.roles.jester", function(att, vic)
	return (GetRoundState() == ROUND_ACTIVE and att:IsActiveRole(ROLE_JESTER))
end)

hook.Add("EntityTakeDamage", "terrortown.roles.jester", function(pl, dmg)
	if (GetGlobal("MOAT_MINIGAME_ACTIVE") or GetRoundState() ~= ROUND_ACTIVE) then
		return
	end

	local att = dmg:GetAttacker()
	if (IsValid(pl) and pl:IsPlayer() and pl:IsActiveRole(ROLE_JESTER)) then
		if ((not IsValid(att) or (IsValid(att) and not att:IsPlayer()) or att == pl)) then
			return true
		end
	elseif (IsValid(att) and att:IsPlayer() and att:IsActiveRole(ROLE_JESTER)) then
		return true
	end
end)

hook.Add("TTTEndRound", "terrortown.roles.jester", function()
    StartRoundSpeedup(0)
end)

hook.Add("TTTPrepareRound", "terrortown.roles.jester", function()
    ded = false
end)

function DidJesterDie()
    return ded
end