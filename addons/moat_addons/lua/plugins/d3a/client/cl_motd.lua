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

MOTD = MOTD or {}
MOTD.SpawnSettings = GetConVar "moat_disable_motd"
MOTD.OpenTime = 0
MOTD.CurTab = 1
MOTD.Tabs = {
	[1] = {"Home", "https://cdn.moat.gg/ttt/motd/20190608_3.html?n=User"},
	[2] = {"Tutorial", "https://i.moat.gg/servers/ttt/motd/help.php"},
	[3] = {"Errors", "https://moat.gg/ttt/motd/content.php", true},
	[4] = {"Changes", "https://moat.gg/changes/", true},
	[5] = {"Forums", "https://moat.gg/forums/", true},
	[6] = {"Donate", "https://moat.gg/store/", true},
	[7] = {"Leaderboard", "https://moat.gg/players", true},
	[8] = {"Bans", "https://moat.gg/bans", true},
	[9] = {"Steam Group", "https://steamcommunity.com/groups/moatgaming", true},
	[10] = {"Discord", "https://discord.gg/moat", true},
	[11] = {"Close", ""	},
}

function MOTD.Closable()
	return math.ceil(cookie.GetNumber("moat_motd_wait", 0)) <= 0
end

function MOTD.Open(secs, invalid)
    if (IsValid(M_MOTD_BG)) then
        M_MOTD_BG:Remove()
    end

	if (secs <= -1) then
		return cookie.Set("moat_motd_wait", 0)
	end

    if (not IsValid(LocalPlayer()) and not invalid) then
		timer.Loop("LoadPlayerMOTD", .1, function()
			return IsValid(LocalPlayer())
		end, function()
			LocalPlayer():ConCommand("gmod_mcore_test 0")

			return MOTD.Open(secs, true)
		end)

		return
    end

    local nick = LocalPlayer():Nick() or "friend"
    local scrw, scrh = ScrW(), ScrH()

	if (secs and secs > 0) then
		cookie.Set("moat_motd_wait", cookie.GetNumber("moat_motd_wait", 0) + secs)
	end

	MOTD.OpenTime = CurTime()

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
        cdn.DrawImage(MOAT_BG_URL, 0, 0, w, h, Color(255, 255, 255, 230))
    end

    local c = vgui.Create("DPanel", p)
    c:Dock(LEFT)
    c:SetWide(250)
    c.Paint = function(s, w, h)
        cdn.DrawImage("https://cdn.moat.gg/f/JoVQapGqtskHBJkPCLbEaoIOosuF.png", 35, 35, 256, 256)
    end

    MOTD.w = vgui.Create("DHTML", p)
    MOTD.w:DockMargin(0, 10, 10, 10)
    MOTD.w:Dock(FILL)
    MOTD.w:OpenURL("https://cdn.moat.gg/ttt/motd/20190608_3.html?n=" .. nick)
    MOTD.w.Paint = function(s, w, h)
        DrawRainbowText(1, "Loading Page...", "DermaLarge", w/2, h/2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    MOTD.CurTab = 1

    for i = 1, #MOTD.Tabs do
        if (i == 1) then
            MOTD.Tabs[i][2] = "https://cdn.moat.gg/ttt/motd/20190608_3.html?n=" .. nick
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
		btn.Time = 0
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

                draw_SimpleTextOutlined(MOTD.Closable() and s.Label or util.Upper(util.FormatTimeSingle(math.ceil(cookie.GetNumber("moat_motd_wait", 0)), false)).. " Left", "Trebuchet24", w/2, h/2, Color(255, 50 + (205 * s.LerpNum), 50 + (205 * s.LerpNum)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))

				if (s.Time and s.Time <= CurTime() and not MOTD.Closable()) then
					s.Time = CurTime() + 1

					cookie.Set("moat_motd_wait", math.max(cookie.GetNumber("moat_motd_wait", 0) - 1, 0))
				end
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
			if (not MOTD.Closable()) then
				return
			else
				surface.PlaySound("ui/buttonclickrelease.wav")
			end

            if (i == #MOTD.Tabs and MOTD.Closable()) then
				cookie.Set("moat_motd_wait", 0)

                M_MOTD_BG:Remove()

                if (system.IsWindows() and GetConVar("moat_multicore"):GetInt() == 0) then
                    LocalPlayer():ConCommand("gmod_mcore_test 1")
                    LocalPlayer():ConCommand("mat_queue_mode -1")
                end
            elseif (MOTD.Tabs[i][3]) then
                gui.OpenURL(MOTD.Tabs[i][2])
            elseif (MOTD.Closable()) then
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

hook("InitPostEntity", function()
	MOTD.SpawnSettings = GetConVar "moat_disable_motd"

	if (MOTD.SpawnSettings and MOTD.SpawnSettings:GetString() == "0") then
		return MOTD.Open(0)
	end
end)

net.Receive("motd", function()
	return MOTD.Open(net.ReadInt(32))
end)