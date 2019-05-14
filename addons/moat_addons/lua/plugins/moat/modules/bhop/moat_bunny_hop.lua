local cv
if (SERVER) then
    util.AddNetworkString "moat_bunny_hop"
    net.Receive("moat_bunny_hop", function(_, ply)
        ply.moat_bunny_hop = net.ReadBool()
    end)
else
    cv = CreateClientConVar("moat_bunny_hop", 0, true, false)
    local function cb()
        timer.Simple(0, function()
            net.Start "moat_bunny_hop"
                net.WriteBool(cv:GetBool())
            net.SendToServer()
        end)
    end
    cvars.AddChangeCallback("moat_bunny_hop", cb, "moat_bunny_hop")
    cb()
end

hook.Add("SetupMove", "moat_bunny_hop", function(ply, mv, data)
    if ((cv and cv:GetBool() or ply.moat_bunny_hop) and not MOAT_DISABLE_BUNNY_HOP and ply:GetMoveType() == MOVETYPE_WALK and data:KeyDown(IN_JUMP) and ply:WaterLevel() < 2) then -- can bunny hop
        local shouldhop = ply:GetGroundEntity() ~= NULL and bit.band(mv:GetOldButtons(), IN_JUMP) == 0
        if (not shouldhop) then
            data:SetButtons(bit.band(data:GetButtons(), bit.bnot(IN_JUMP)))
            mv:SetButtons(data:GetButtons())
        end
    end
end)

if (CLIENT) then
    --[[
    gameevent.Listen "player_hurt"
    local TimeBefore = -math.huge

    hook.Add("CreateMove", "StopCrouching", function(c)
        if (TimeBefore > CurTime()) then
            c:SetButtons(bit.band(bit.bnot(bit.bor(IN_JUMP, IN_DUCK)), c:GetButtons()))
        end
    end)


    hook.Add("player_hurt", "StopCrouch", function(info)
        local ply = Player(info.userid)
        if (not MOAT_CUR_BOSS and ply == LocalPlayer() and IsValid(Player(info.attacker))) then
            TimeBefore = CurTime() + 0.2
            RunConsoleCommand "-jump"
            RunConsoleCommand "-duck"
        end
    end)]]
end