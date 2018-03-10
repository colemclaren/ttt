InstallRoleHook("PlayerShouldTakeDamage", 2)

function ROLE:PlayerShouldTakeDamage(ply)
    return false
end

util.AddNetworkString "jester.killed"

hook.Add("PlayerDeath", "jester.killer", function(pl, inf, att)
    if (GetRoundState() == ROUND_ACTIVE and pl:GetRole() == ROLE_JESTER and IsValid(att) and att:IsPlayer() and pl ~= att) then
        net.Start("jester.killed")
        net.WriteString(att:Nick() or "Someone")
        net.Broadcast()
    end
end)