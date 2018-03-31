util.AddNetworkString "terrorcity.hitman.acquiretarget"
local ROLE = ROLE

local ok_roles = {
    [ROLE_JESTER] = true,
    [ROLE_KILLER] = true,
}

local function SelectTarget()

    for _, ply in RandomPairs(player.GetAll()) do
        if (ply:GetRole() == ROLE_JESTER or ply:IsDeadTerror() or ply:GetTraitor() or ply:IsSpec()) then
            continue
        end

        ROLE.Target = ply

        local hitmen = {}
        for k,v in pairs(player.GetAll()) do
            if (v:GetRole() == ROLE_HITMAN) then
                table.insert(hitmen, v)
            end
        end

        net.Start "terrorcity.hitman.acquiretarget"
            net.WriteEntity(ROLE.Target)
        net.Send(hitmen)

        break
    end

end

function ROLE:TTTBeginRound()
    SelectTarget()
end

function ROLE:TTTEndRound()
    ROLE.Target = nil
end

InstallRoleHook("PlayerDeath", 3)

function ROLE:PlayerDeath(victim, inflictor, attacker)
    if (victim ~= attacker and victim ~= ROLE.Target and not ok_roles[victim:GetRole()]) then
        if (self:GetCredits() > 1) then
            self:SetCredits(self:GetCredits() - 1)
        else
            attacker:TakeDamage(75, attacker, attacker)
        end
    elseif (ROLE.Target == victim) then
        attacker:AddCredits(2)
    end
end

function ROLE.PostPlayerDeath(ply)
    if (ply == ROLE.Target) then
        SelectTarget()
    end
end

function ROLE.PlayerDisconnected(ply)
    if (ply == ROLE.Target) then
        SelectTarget()
    end
end

hook.Add("PlayerDisconnected", "terrortown.roles.hitman", ROLE.PlayerDisconnected)
hook.Add("PostPlayerDeath", "terrortown.roles.hitman", ROLE.PostPlayerDeath)