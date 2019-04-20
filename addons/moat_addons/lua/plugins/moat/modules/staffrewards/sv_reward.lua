local MOAT_REWARDS = {
    moderator = 1,
    admin = 2,
    senioradmin = 3,
    headadmin = 4,
    techlead = 6,
    communitylead = 6,
}

local newest_death = CurTime()

hook.Add("PlayerDeath", "moat.StaffReward", function(vic, inf, att)
    if (IsValid(att) and att:IsPlayer() and att ~= vic) then
        newest_death = CurTime()
    end
end)

local function debug(...)
    if (Server.IsDev) then
        if (type(n) == "table") then
            PrintTable((...))
        else
            print("[STAFF REWARDS]", ...)
        end
    end
end


if (Server.IsDev) then
    timer.Remove("moat.StaffRewards")
    return
end

timer.Create("moat.StaffRewards", 60, 0, function()
    if (player.GetCount() < 8) then
        debug("count")
        return
    end

    if (newest_death + 155 < CurTime()) then
        debug("death")
        return
    end

    local cur_round = Damagelog.sync_ent:GetPlayedRounds()
    local reports = Damagelog.Reports.Current

    for _, report in pairs(reports) do
        if ((report.status == RDM_MANAGER_PROGRESS or report.status == RDM_MANAGER_WAITING) and report.round ~= cur_round) then
            debug("bad reward")
            debug(report)
            return
        end
    end

    for _, ply in pairs(player.GetAll()) do
        local group = ply:GetUserGroup()

        local rewardamt = MOAT_REWARDS[group]

        if (not ply:IsSpec() and rewardamt) then
            debug("reward", ply, rewardamt)
            ply:TakeSC(-rewardamt, function()
                debug("rewarded", ply, rewardamt)
            end)
        end
    end
end)