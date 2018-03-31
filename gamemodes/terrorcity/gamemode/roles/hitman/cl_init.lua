local ROLE = ROLE

net.Receive("terrorcity.hitman.acquiretarget", function()
    ROLE.Target = net.ReadEntity()
end)
net.Receive("terrorcity.hitman.notifykills", function()
    ROLE.False_Kills = net.ReadUInt(8)
end)

local function FalseKills()
    return ROLE.False_Kills or 0
end

local function CanKillAmount()
    local credits = LocalPlayer():GetCredits()
    local r = 0
    local worth = FalseKills() + 1
    while (credits >= worth) do
        r, worth, credits = r + 1, worth + 1, credits - worth
    end
    return r, math.ceil((worth - credits) / 2)
end

function ROLE.HUDPaint()
    if (IsValid(ROLE.Target) and LocalPlayer():GetRole() == ROLE_HITMAN) then
        local name = ROLE.Target:Nick()
        surface.SetFont "TargetID" -- better font pls
        local w = surface.GetTextSize "Target: "
        local w2, h = surface.GetTextSize(name)
        local tw = w + w2
        local centerx, centery = ScrW() / 2, ScrH() / 2 + 90
        draw.SimpleTextOutlined("Target: ", "TargetID", centerx - tw / 2, centery, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 40))
        draw.SimpleTextOutlined(name, "TargetID", centerx - tw / 2 + w, centery, Color(230, 90, 90), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 40))

        local killamt, credneeded = CanKillAmount()
        local text = "Free Kills (next in "..credneeded.." kills):"

        w = surface.GetTextSize(text)
        w2 = surface.GetTextSize(killamt)
        tw = w + w2
        centerx, centery = ScrW() / 2, ScrH() / 2 + 90 + h + 5
        draw.SimpleTextOutlined(text, "TargetID", centerx - tw / 2, centery, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 40))
        draw.SimpleTextOutlined(killamt, "TargetID", centerx - tw / 2 + w, centery, Color(230, 90, 90), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 40))

    end
end

function ROLE.PreDrawHalos()
    if (LocalPlayer():GetRole() == ROLE_HITMAN and IsValid(ROLE.Target) and not ROLE.Target:IsDormant()) then
        halo.Add({ROLE.Target}, Color(255,25,255))
    end
end

hook.Add("HUDPaint", "terrorcity.roles.hitman", ROLE.HUDPaint)

hook.Add("PreDrawHalos", "terrorcity.roles.hitman", ROLE.PreDrawHalos)