InstallRoleHook("PlayerShouldTakeDamage", 2)
local ROLE = ROLE
function ROLE:PlayerShouldTakeDamage(ply)
    return false
end

InstallRoleHook("PlayerDeath", 1)
util.AddNetworkString "jester.killed"

local ded = false

function ROLE:PlayerDeath(pl, inf, att)
    if (GetRoundState() == ROUND_ACTIVE and IsValid(att) and att:IsPlayer() and pl ~= att and att:GetBasicRole() == ROLE_INNOCENT) then
        net.Start("jester.killed")
        net.WriteString(att:Nick() or "Someone")
        net.Broadcast()
        StartRoundSpeedup(math.ceil(ROLE.ActivePlayers * 0.175, 2))
        ded = true
    end
end

InstallRoleHook("m_ShouldPreventWeaponHitTalent", 1)

function ROLE:m_ShouldPreventWeaponHitTalent(attacker, victim)
    return true
end

hook.Add("TTTBeginRound", "terrorcity.roles.jester", function()
    ded = false
    ROLE.ActivePlayers = 0
    for _, ply in pairs(player.GetAll()) do
        if (not ply:IsSpec()) then
            ROLE.ActivePlayers = ROLE.ActivePlayers + 1
        end
    end
end)

hook.Add("TTTEndRound", "terrorcity.roles.jester", function()
    StartRoundSpeedup(0)
end)

function DidJesterDie()
    return ded
end