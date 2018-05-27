surface.CreateFont("moat_MOTDHead2", {
    font = "DermaLarge",
    size = 50,
    weight = 700
})

local draw              = draw
local IsValid           = IsValid
local draw_SimpleText = draw.SimpleText
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local draw_RoundedBoxEx = draw.RoundedBoxEx
local draw_RoundedBox = draw.RoundedBox
local surface_DrawRect = surface.DrawRect
local surface_DrawLine = surface.DrawLine
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
local blur = Material("pp/blurscreen")

local function DrawBlur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface_SetDrawColor(255, 255, 255)
    surface_SetMaterial(blur)

    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface_DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

MOTD = {}
MOTD.CurTab = 1
MOTD.Tabs = {
    {"Home", "https://i.moat.gg/servers/ttt/motd/rules.php?n=User"},
    {"Tutorial", "https://i.moat.gg/servers/ttt/motd/help.php"},
    {"Errors", "https://moat.gg/ttt/motd/content.php", true},
    {"Changelog", "https://i.moat.gg/servers/ttt/motd/changelog.php"},
    {"Forums", "https://moat.gg/forums/", true},
    {"Donate", "https://moat.gg/store/", true},
    {"Leaderboard", "https://moat.gg/players", true},
    {"Bans", "https://moat.gg/bans", true},
    {"Steam Group", "https://steamcommunity.com/groups/moatgaming", true},
    {"Discord", "https://discord.gg/NsTmMn9", true},
    {"Close", ""},
}

function m_OpenMOTD(str)
    if (IsValid(M_MOTD_BG)) then
        M_MOTD_BG:Remove()
    end

    if (IsValid(LocalPlayer())) then
        LocalPlayer():ConCommand("gmod_mcore_test 0")
    end

    local name = str or LocalPlayer():Nick()
    local scrw, scrh = ScrW(), ScrH()

    M_MOTD_BG = vgui.Create("DFrame")
    M_MOTD_BG:SetSize(scrw * 0.9, scrh * 0.9)
    M_MOTD_BG:SetTitle("")
    M_MOTD_BG:ShowCloseButton(false)
    M_MOTD_BG:SetDraggable(true)
    M_MOTD_BG:MakePopup()
    M_MOTD_BG:DockPadding(0, 6, 0, 6)
    M_MOTD_BG:Center()
    M_MOTD_BG.Paint = function(s, w, h)
        surface_SetDrawColor(180, 180, 180, 200)
        surface_DrawLine(0, 0, w, 0)
        surface_DrawLine(0, h-1, w, h-1)
    end

    local p = vgui.Create("DPanel", M_MOTD_BG)
    p:Dock(FILL)
    p.Paint = function(s, w, h)
        DrawBlur(s, 3)
        draw.WebImage(MOAT_BG_URL, 0, 0, w, h, Color(255, 255, 255, 230))
    end

    local c = vgui.Create("DPanel", p)
    c:Dock(LEFT)
    c:SetWide(250)
    c.Paint = function(s, w, h)
        draw.WebImage("https://moat.gg/assets/img/moat-gg-motd2.png", 35, 35, 256, 256)
    end

    MOTD.w = vgui.Create("DHTML", p)
    MOTD.w:DockMargin(0, 10, 10, 10)
    MOTD.w:Dock(FILL)
    MOTD.w:OpenURL("https://i.moat.gg/servers/ttt/motd/rules.php?n=" .. name)
    MOTD.w.Paint = function(s, w, h)
        DrawRainbowText(1, "Loading Page...", "DermaLarge", w/2, h/2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    MOTD.CurTab = 1

    for i = 1, #MOTD.Tabs do
        if (i == 1) then
            MOTD.Tabs[i][2] = "https://i.moat.gg/servers/ttt/motd/rules.php?n=" .. name
        end

        local btn = vgui.Create("DButton", c)

        if (i == #MOTD.Tabs) then
            btn:SetPos(35, M_MOTD_BG:GetTall() - 6 - 65)
        else
            btn:SetPos(35, 100 + ((i * 40) - 40))
        end

        btn:SetSize(250 - 70, 30)
        btn:SetText("")
        btn.LerpNum = 0
        btn.Label = MOTD.Tabs[i][1]
        btn.Index = i
        btn.Paint = function(s, w, h)
            if (s:IsHovered() or MOTD.CurTab == i) then
                s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
            else
                s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
            end

            if (i == #MOTD.Tabs) then
                surface_SetDrawColor(255 * s.LerpNum, 50 * s.LerpNum, 50 * s.LerpNum, 150 + (50 * s.LerpNum))
                surface_DrawRect(0, 0, w, h)

                surface_SetDrawColor(255, 50, 50)
                surface_DrawOutlinedRect(0, 0, w, h)

                draw_SimpleTextOutlined(s.Label, "Trebuchet24", w/2, h/2, Color(255, 50 + (205 * s.LerpNum), 50 + (205 * s.LerpNum)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
            else
                surface_SetDrawColor(51 * s.LerpNum, 153 * s.LerpNum, 255 * s.LerpNum, 150 + (50 * s.LerpNum))
                surface_DrawRect(0, 0, w, h)

                surface_SetDrawColor(51, 153, 255)
                surface_DrawOutlinedRect(0, 0, w, h)

                draw_SimpleTextOutlined(s.Label, "Trebuchet24", w/2, h/2, Color(51 + (204 * s.LerpNum), 153 + (102 * s.LerpNum), 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
            end
        end
        btn.OnCursorEntered = function(s)
            surface.PlaySound("ui/buttonrollover.wav")
        end
        btn.DoClick = function(s)
            surface.PlaySound("ui/buttonclickrelease.wav")

            if (i == #MOTD.Tabs) then
                M_MOTD_BG:Remove()
                if (system.IsWindows() and GetConVar("moat_multicore"):GetInt() == 0) then
                    LocalPlayer():ConCommand("gmod_mcore_test 1")
                    LocalPlayer():ConCommand("mat_queue_mode -1")
                end
            elseif (MOTD.Tabs[i][3]) then
                gui.OpenURL(MOTD.Tabs[i][2])
            else
                MOTD.CurTab = i
                MOTD.w:Remove()
                MOTD.w = vgui.Create("DHTML", p)
                MOTD.w:DockMargin(0, 10, 10, 10)
                MOTD.w:Dock(FILL)
                MOTD.w:OpenURL(MOTD.Tabs[i][2])
                MOTD.w.Paint = function(s, w, h)
                    DrawRainbowText(1, "Loading Page...", "DermaLarge", w/2, h/2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
        end
    end
end

net.Receive("MOAT_MOTD", function(len)
    m_OpenMOTD(net.ReadString())

    timer.Create("moat_motd_timer", 1, 0, function()
        if (IsValid(LocalPlayer())) then
            LocalPlayer():ConCommand("gmod_mcore_test 0")
            timer.Remove("moat_motd_timer")
            return
        end
    end)
end)

/*
murl = murl or {}
if (not murl.openurl) then
    murl.openurl = gui.OpenURL
end
murl.colors = {
    white = Color(255, 255, 255),
    shadow = Color(0, 0, 0, 130),
    blue = Color(82, 150, 255),
    hblue = Color(102, 170, 255)
}
murl.open = "Copy & Open Overlay"
murl.copy = "Copy to Clipboard"
murl.dontcopy = "No Thanks"
murl.header = "You must open this link in your own web browser."
murl.font = "GModNotify"
murl.whitelist = {
    ["http://steamcommunity.com/gid/"] = true,
    ["https://steamcommunity.com/gid/"] = true,
    ["http://steamcommunity.com/groups/"] = true,
    ["https://steamcommunity.com/groups/"] = true
}
murl.bwidth = 180

function murl:text(t, x, y)
    draw.SimpleText(t, self.font, x + 1, y + 1, self.colors.shadow, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText(t, self.font, x, y, self.colors.white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function murl.btn(s, w, h)
    draw.RoundedBox(4, 0, 0, w, h, s:IsHovered() and murl.colors.hblue or murl.colors.blue)

    murl:text(s.Text, w/2, h/2)
end

function murl.prompt(t, u)
    local sw, sh = ScrW(), ScrH()

    local fr = vgui.Create("DFrame")
    fr:SetSize(ScrW(), ScrH())
    fr:MakePopup()
    fr:Center()
    fr:SetTitle("")
    fr:ShowCloseButton(false)
    fr.Paint = function(s, w, h)
        Derma_DrawBackgroundBlur(s, s.m_fCreateTime)

        murl:text(t, w/2, (h/2) - 30)
        murl:text(u, w/2, h/2)
        murl:text(murl.header, w/2, (h/2) - 100)
    end

    local o = vgui.Create("DButton", fr)
    o:SetPos((sw/2) - (murl.bwidth/2) - 10 - murl.bwidth, (sh/2) + 30)
    o:SetSize(murl.bwidth, 30)
    o:SetText("")
    o.Text = murl.open
    o.Paint = murl.btn
    o.DoClick = function(s)
        print("Copied URL to clipboard: " .. u)
        SetClipboardText(u)
        steamworks.OpenWorkshop()
        fr:Remove()
    end

    local c = vgui.Create("DButton", fr)
    c:SetPos((sw/2) - (murl.bwidth/2), (sh/2) + 30)
    c:SetSize(murl.bwidth, 30)
    c:SetText("")
    c.Text = murl.copy
    c.Paint = murl.btn
    c.DoClick = function(s)
        print("Copied URL to clipboard: " .. u)
        SetClipboardText(u)
        fr:Remove()
    end

    local e = vgui.Create("DButton", fr)
    e:SetPos((sw/2) + (murl.bwidth/2) + 10, (sh/2) + 30)
    e:SetSize(murl.bwidth, 30)
    e:SetText("")
    e.Text = murl.dontcopy
    e.Paint = murl.btn
    e.DoClick = function(s)
        fr:Remove()
    end
end

gui.OpenURL = function(str)
    if (not str) then return end

    if (murl.whitelist[str:sub(1, 34)] or murl.whitelist[str:sub(1, 33)] or murl.whitelist[str:sub(1, 31)] or murl.whitelist[str:sub(1, 30)]) then
        murl.openurl(str)
        
        return
    end

    http.Fetch(str, function(b, s, h)
        local t = b:match("<title>(.+)</title>")
        if (not t) then t = str end
        
        murl.prompt(t, str)
    end, function(e)
        print("Couldn't load " .. str)
    end)
end*/