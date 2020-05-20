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

local DefaultLoadout = {
    ["weapon_ttt_unarmed"] = true,
    ["weapon_zm_improvised"] = true,
    ["weapon_zm_carry"] = true,
	["tnt_fists"] = true
}

local function StripWeapons(ply)
	if (not IsValid(ply)) then return end
    for k, v in pairs(ply:GetWeapons()) do
        if (IsValid(v) and not DefaultLoadout[v:GetClass()] and v.Kind ~= WEAPON_UNARMED) then
            if (v.SetZoom) then
                v:SetZoom(false)
            end
            if (v.SetIronSights) then
                v:SetIronsights(false)
            end

            if (IsValid(ply)) then
				ply:StripWeapon(v:GetClass())
			end
        end
    end
end

local ded = false

hook.Add("PlayerDeath", "terrortown.roles.jester", function(vic, inf, att)
	if (GetRoundState() == ROUND_ACTIVE and IsValid(vic) and vic:GetRole() == ROLE_JESTER and IsValid(att) and att:IsPlayer() and att:GetRole() ~= ROLE_JESTER and vic ~= att) then
		if (vic:IsActive()) then
			net.Start("terrortown.jester.killed")
        		net.WriteString(att:Nick() or "Someone")
				net.WritePlayer(vic)
			net.Broadcast()

			StartRoundSpeedup(math.ceil(ROLE.ActivePlayers * 0.175, 2))
			ded = true
		end

		vic.Skeleton = true

		timer.Simple(10, function()
			if (not IsValid(vic) or GetRoundState() ~= ROUND_ACTIVE) then
				return 
			end

			vic:SpawnForRound()
			vic:SetRole(ROLE_JESTER)
			vic:Spawn()
			StripWeapons(vic)
			vic:Give "tnt_fists"
			vic:SelectWeapon "tnt_fists"
			vic:ShouldDropWeapon(false)
		end)
    end
end)

hook.Add("m_ShouldPreventWeaponHitTalent", "terrortown.roles.jester", function(att, vic)
	return (GetRoundState() == ROUND_ACTIVE and att:IsActiveRole(ROLE_JESTER))
end)

hook.Add("TTTCanPickupAmmo", "terrortown.roles.jester", function(ply, ammo)
	if (DidJesterDie() and ply.Skeleton) then
		return false
	end
end)

hook.Add("MoatInventoryShouldGiveLoadout", "terrortown.roles.jester", function(pl)
	if (pl.Skeleton) then
		timer.Simple(1, function()
			pl:SetModel("models/player/skeleton.mdl")
			pl:SetRenderMode(RENDERMODE_TRANSALPHA)
			pl:SetColor(Color(255, 255, 255, 255))
			pl:SetPlayerColor(Vector(1, 1, 1))
		end)

		return true
	end
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

	for k, v in ipairs(player.GetAll()) do
		v.Skeleton = false
	end
end)

hook.Add("TTTPrepareRound", "terrortown.roles.jester", function()
	StartRoundSpeedup(0)
    ded = false

	for k, v in ipairs(player.GetAll()) do
		v.Skeleton = false
	end
end)

hook.Add("TTTBeginRound", "terrortown.roles.jester", function()
    ded = false
    ROLE.ActivePlayers = 0
    for _, ply in pairs(player.GetAll()) do
        if (not ply:IsSpec()) then
            ROLE.ActivePlayers = ROLE.ActivePlayers + 1
        end
    end
end)

function DidJesterDie()
    return ded
end