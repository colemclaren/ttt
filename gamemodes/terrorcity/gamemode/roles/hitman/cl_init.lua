local ROLE = ROLE

net.Receive("terrorcity.hitman.acquiretarget", function()
    ROLE.Target = net.ReadEntity()
end)

function ROLE.HUDPaint()
    if (IsValid(ROLE.Target) and LocalPlayer():GetRole() == ROLE_HITMAN) then
        local name = ROLE.Target:Nick()
        surface.SetFont "TargetID" -- better font pls
        local w = surface.GetTextSize "Target: "
        local w2 = surface.GetTextSize(name)
        local tw = w + w2
        local centerx, centery = ScrW() / 2, ScrH() / 2 + 90
        draw.SimpleTextOutlined("Target: ", "TimeLeft", centerx - tw / 2, centery, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
        draw.SimpleTextOutlined(name, "TimeLeft", centerx - tw / 2 + w, centery, Color(230, 20, 20), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
    end
end

hook.Add("HUDPaint", "terrorcity.roles.hitman", ROLE.HUDPaint)