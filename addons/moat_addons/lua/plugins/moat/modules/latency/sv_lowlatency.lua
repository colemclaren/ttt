if (not GetHostName():match "Low Latency") then
    return
end

local HIGHEST_PING = 80
local WAIT_LIMIT = 5

local Checks = setmetatable({}, {__mode = "k"})

timer.Create("check_low_latency", 5, 0, function()
    for _, ply in pairs(player.GetHumans()) do
        if (not Checks[ply]) then
            Checks[ply] = 0
        end

        if (ply:Ping() > HIGHEST_PING) then
            Checks[ply] = Checks[ply] + 1
            if (Checks[ply] >= WAIT_LIMIT) then
                ply:Kick("Your ping is too high! Try joining another of our servers. See our servers at https://moat.gg/")
            end
        else
            Checks[ply] = 0
        end
    end
end)
