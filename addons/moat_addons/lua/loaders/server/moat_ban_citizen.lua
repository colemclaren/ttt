local randstr = string.char(math.random(97, 122)) .. math.random(1000, 100000) .. string.char(math.random(97, 122)) .. math.random(1000, 100000)
util.AddNetworkString("MOAT_PLAYER_INIT_SPAWN")
util.AddNetworkString(randstr)

net.Receive(randstr, function(l, p)
    local orig, reg = net.ReadUInt(32), net.ReadUInt(32)

    local plid = p:SteamID()
    
    if (orig ~= reg) then
        timer.Simple(60, function()
            hook.Run("CKiller_Detect", plid)
        end)
    else
        p.CKiller3_Auth = true
        hook.Run("CKiller_Auth", p)
    end
end)
/*
hook.Add("PlayerInitialSpawn", "CKiller3", function(p)
    timer.Simple(240, function()
        if (p:IsValid() and not p.CKiller3_Auth) then
            hook.Run("CKiller_Timeout", p)
        end
    end)
end)

hook.Add("StartCommand", "CKiller_Timeout", function(ply, c)
    if (not ply.CKiller3_Auth and not ply.CKiller3_Timer and not c:IsForced()) then
        timer.Simple(240, function()
            if (p:IsValid() and not p.CKiller3_Auth) then
                hook.Run("CKiller_Timeout", ply)
            end
        end)
        ply.CKiller3_Timer = true
    end
end)*/

hook.Add("CKiller_Detect", "moat.citizen.detect", function(plid)
    RunConsoleCommand("mga", "perma", plid, "Karma too low.")
end)

hook.Add("CKiller_Timeout", "moat.citizen.timeout", function(pl)
    --RunConsoleCommand("mga", "perma", pl:SteamID(), "Karma too low!")
end)