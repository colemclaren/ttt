local notstaff = {"user", "vip", "mvp", "hoodninja", "communitylead"}

hook.Add("PostGamemodeLoaded", "Moat.AFKFix", function()
    local idle = {
        ang = nil,
        pos = nil,
        mx = 0,
        my = 0,
        t = 0
    }

    local dev_server = GetHostName():lower():find("dev")

    function CheckIdle()
        if (MOAT_CONTAGION_ROUND_ACTIVE or dev_server) then return end
        local client = LocalPlayer()
        if not IsValid(client) then return end

        if not idle.ang or not idle.pos then
            -- init things
            idle.ang = client:GetAngles()
            idle.pos = client:GetPos()
            idle.mx = gui.MouseX()
            idle.my = gui.MouseY()
            idle.t = CurTime()

            return
        end

        if GetRoundState() == ROUND_ACTIVE and client:IsTerror() and client:Alive() then
            local idle_limit = 150

            if idle_limit <= 0 then
                idle_limit = 300
            end

            -- networking sucks sometimes
            if client:GetAngles() ~= idle.ang then
                -- Normal players will move their viewing angles all the time
                idle.ang = client:GetAngles()
                idle.t = CurTime()
                -- Players in eg. the Help will move their mouse occasionally
                -- Even if players don't move their mouse, they might still walk
                -- will repeat
            elseif gui.MouseX() ~= idle.mx or gui.MouseY() ~= idle.my then
                idle.mx = gui.MouseX()
                idle.my = gui.MouseY()
                idle.t = CurTime()
            elseif client:GetPos():Distance(idle.pos) > 10 then
                idle.pos = client:GetPos()
                idle.t = CurTime()
            elseif CurTime() > (idle.t + idle_limit) then
                if notstaff[LocalPlayer():GetUserGroup()] then
                    RunConsoleCommand("say", "(AUTOMATED MESSAGE) I have been moved to the Spectator team because I was idle/AFK.")

                    timer.Simple(0.3, function()
                        RunConsoleCommand("ttt_spectator_mode", 1)
                        RunConsoleCommand("ttt_cl_idlepopup")
                    end)
                else
                    RunConsoleCommand("disconnect")
                end
            elseif CurTime() > (idle.t + (idle_limit / 2)) then
                LANG.Msg("idle_warning")
            end
        end
    end
end)

hook.Add("InitPostEntity", "Moat.Multicore", function()
    if (system.IsWindows() and GetConVar("moat_multicore"):GetInt() == 0) then
        LocalPlayer():ConCommand("gmod_mcore_test 1")
        LocalPlayer():ConCommand("mat_queue_mode -1")
    end
end)