local v36 = Vector(0, 0, 36)

local cv = CreateConVar("test_hop_enabled", "0", FCVAR_REPLICATED)

if (SERVER) then
    local allowed = {
        ["STEAM_0:0:44950009"] = true
    }
    cv:SetBool(false)
    concommand.Add("toggle_test_hop", function(ply)
        if (not allowed[ply:SteamID()]) then
            return
        end
        ply:ChatPrint "toggling"
        cv:SetBool(not cv:GetBool())
    end)
end

hook.Add("Move", "test_hop_limiter", function(ply, mv)
    local prevent = ply:GetNW2Bool("PreventCrouch", false)

    if (ply:IsOnGround()) then
        if (prevent) then
            ply:SetNW2Bool("PreventCrouch", false)
        end
    else
        if (mv:KeyReleased(IN_DUCK)) then
            ply:SetNW2Bool("PreventCrouch", true)
        elseif (mv:KeyPressed(IN_DUCK) and prevent) then
            mv:SetButtons(bit.band(bit.bnot(IN_DUCK), mv:GetButtons()))
        end
    end

end)

hook.Add("FinishMove", "test_hop", function(ply, mv)
    if (not cv:GetBool()) then
        return
    end

    if (mv:KeyDown(0x8000) and ply:Crouching() and not ply:IsOnGround()) then
        ply:SetCurrentViewOffset(ply:GetViewOffsetDucked() + v36)
    end
end)

hook.Add("SetupMove", "test_hop", function(ply, mv)
    if (not cv:GetBool()) then
        return
    end

    mv:SetButtons(bit.band(mv:GetButtons(), bit.bnot(0x8000)))
    local was_done = bit.band(mv:GetOldButtons(), 0x8000) ~= 0
    if (was_done) then
        mv:SetOrigin(mv:GetOrigin() + v36)
    end
    local mnh, mxh = ply:GetHull()

    if (mv:KeyDown(IN_DUCK) and not ply:IsOnGround()) then
        mv:SetButtons(bit.bor(0x8000, mv:GetButtons()))
        mv:SetOrigin(mv:GetOrigin() - v36)
        ply:SetCurrentViewOffset(ply:GetViewOffsetDucked() + v36)
        ply:SetHullDuck(mnh + v36, mxh)
    end

    if (was_done and not ply:IsOnGround() and not mv:KeyDown(IN_DUCK)) then
        local trace = {
            start = mv:GetOrigin() - v36,
            filter = ply,
            mask = MASK_PLAYERSOLID
        }
        trace.mins, trace.maxs = mnh, mxh
        trace.endpos = trace.start
        local tr = util.TraceHull(trace)

        if (tr.Hit) then
            mv:SetButtons(bit.bor(mv:GetButtons(), IN_DUCK))
            mv:SetButtons(bit.bor(0x8000, mv:GetButtons()))
            mv:SetOrigin(mv:GetOrigin() - v36)
            ply:SetCurrentViewOffset(ply:GetViewOffsetDucked() + v36)
        end
    end

    if (was_done and not mv:KeyDown(0x8000)) then
        ply:SetHullDuck(mnh, mxh - v36)
        if (mv:KeyDown(IN_DUCK) or ply:Crouching()) then
            ply:SetCurrentViewOffset(ply:GetViewOffsetDucked())
        else
            ply:SetCurrentViewOffset(ply:GetViewOffset())
        end
    end
end)