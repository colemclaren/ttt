
print"q"
if (SERVER) then
    util.AddNetworkString "moat_bunny_hop"
    net.Receive("moat_bunny_hop", function(_, ply)
        ply.moat_bunny_hop = net.ReadBool()
    end)
else
    local cv = CreateClientConVar("moat_bunny_hop", 0, true, false)
    local function cb()
        net.Start "moat_bunny_hop"
            net.WriteBool(cv:GetBool())
            LocalPlayer().moat_bunny_hop = cv:GetBool()
        net.SendToServer()
    end
    cvars.AddChangeCallback("moat_bunny_hop", cb, "moat_bunny_hop")
    cb()
end

hook.Add("SetupMove", "moat_bunny_hop", function(ply, mv, data)
    if (true) then
        return
    end
    if (ply.moat_bunny_hop and not MOAT_DISABLE_BUNNY_HOP and data:KeyDown(IN_JUMP) and ply:WaterLevel() < 2) then -- can bunny hop
        local shouldhop = ply:GetGroundEntity() ~= NULL and bit.band(mv:GetOldButtons(), IN_JUMP) == 0
        if (not shouldhop) then
            data:SetButtons(bit.band(data:GetButtons(), bit.bnot(IN_JUMP)))
            mv:SetButtons(data:GetButtons())
        end
    end
end)