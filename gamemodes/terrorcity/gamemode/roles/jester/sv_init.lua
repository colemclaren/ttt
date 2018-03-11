InstallRoleHook("PlayerShouldTakeDamage", 2)

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
        StartRoundSpeedup(5)
        ded = true
    end
end

hook.Add("TTTBeginRound", "terrorcity.roles.jester", function()
    ded = false
end)

hook.Add("TTTEndRound", "terrorcity.roles.jester", function()
    StartRoundSpeedup(1)
end)

function DidJesterDie()
    return ded
end