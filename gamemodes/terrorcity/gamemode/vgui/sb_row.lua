---- Scoreboard player score row, based on sandbox version
include("sb_info.lua")
local GetTranslation = LANG.GetTranslation
local GetPTranslation = LANG.GetParamTranslation
local surface = surface
local draw = draw
local math = math
local string = string
local vgui = vgui
local math = math
local table = table
local draw = draw
local team = team
local IsValid = IsValid
local CurTime = CurTime
local draw_SimpleText = draw.SimpleText
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local draw_RoundedBoxEx = draw.RoundedBoxEx
local draw_RoundedBox = draw.RoundedBox
local surface_SetFont = surface.SetFont
local surface_DrawRect = surface.DrawRect
local surface_DrawLine = surface.DrawLine
local surface_GetTextSize = surface.GetTextSize
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_DrawTexturedRectRotated = surface.DrawTexturedRectRotated
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
local surface_DrawPoly = surface.DrawPoly
local surface_DrawCircle = surface.DrawCircle
local surface_DrawLine = surface.DrawLine
SB_ROW_HEIGHT = 24 --16
local PANEL = {}
local mat_group = Material("icon16/group.png")
function PANEL:Init()
    -- cannot create info card until player state is known
    self.info = nil
    self.open = false
    self.cols = {}
    self:AddColumn(""/*GetTranslation("sb_ping")*/, function(ply) return ply:Ping() end)
    self:AddColumn(GetTranslation("sb_deaths"), function(ply) return ply:Deaths() end)
    self:AddColumn(GetTranslation("sb_score"), function(ply) return ply:Frags() end)
    self:AddColumn(GetTranslation("sb_karma"), function(ply) return math.Round(ply:GetBaseKarma()) end)

    -- Let hooks add their custom columns
    hook.Call("TTTScoreboardColumns", nil, self)

    for _, c in ipairs(self.cols) do
        c:SetMouseInputEnabled(false)
    end

    self.tag = vgui.Create("DLabel", self)
    self.tag:SetText("")
    self.tag:SetMouseInputEnabled(false)
    self.sresult = vgui.Create("DImage", self)
    self.sresult:SetSize(16, 16)
    self.sresult:SetMouseInputEnabled(false)
    self.avatar = vgui.Create("AvatarImage", self)
    self.avatar:SetSize(SB_ROW_HEIGHT - 2, SB_ROW_HEIGHT - 2)
    self.avatar:SetMouseInputEnabled(false)
    self.rankimage = vgui.Create("DImage", self)
    self.rankimage:SetSize(SB_ROW_HEIGHT, SB_ROW_HEIGHT)
    self.rankimage:SetMaterial(mat_group)
    self.rankimage:SetMouseInputEnabled(false)
    self.titles = vgui.Create("DLabel", self)
    self.titles:SetMouseInputEnabled(false)
    self.title = vgui.Create("DLabel", self)
    self.title:SetMouseInputEnabled(false)
    self.nicks = vgui.Create("DLabel", self)
    self.nicks:SetMouseInputEnabled(false)
    self.nick = vgui.Create("DLabel", self)
    self.nick:SetMouseInputEnabled(false)
    self.voice = vgui.Create("DImageButton", self)
    self.voice:SetSize(16, 16)
    self:SetCursor("hand")
end

function PANEL:AddColumn(label, func, width)
    local lbl = vgui.Create("DLabel", self)
    lbl.GetPlayerText = func
    lbl.IsHeading = false
    lbl.Width = width or 50 -- Retain compatibility with existing code
    table.insert(self.cols, lbl)

    return lbl
end

local namecolor = {
    default = COLOR_WHITE,
    admin = Color(220, 180, 0, 255),
    dev = Color(100, 240, 105, 255)
}

local rolecolor = {
    default = Color(0, 0, 0, 0),
    traitor = Color(255, 0, 0, 30),
    detective = Color(0, 0, 255, 30),
	[ROLE_JESTER]    = Color(253, 158, 255, 30),
	[ROLE_KILLER]    = Color(255, 145, 0, 30),
	[ROLE_DOCTOR]    = Color(0, 200, 255, 30),
	[ROLE_BEACON]    = Color(255, 200, 0, 30),
	[ROLE_SURVIVOR]  = Color(128, 142, 0, 30),
	[ROLE_HITMAN]    = Color(40, 42, 47, 30),
	[ROLE_BODYGUARD] = Color(0, 153, 153, 30),
	[ROLE_VETERAN]   = Color(179, 0, 255, 30),
	[ROLE_XENOMORPH] = Color(255, 80, 80, 30),
	[ROLE_WITCHDOCTOR] = Color(255, 255, 80, 30)
}

function GM:TTTScoreboardColorForPlayer(ply)
    if not IsValid(ply) then return namecolor.default end

    return namecolor.default
end

function GM:TTTScoreboardRowColorForPlayer(ply)
    if not IsValid(ply) then return rolecolor.default end

    if ply:IsTraitor() then
        return rolecolor.traitor
    elseif ply:IsDetective() then
        return rolecolor.detective
    elseif rolecolor[ply:GetRole()] then
		return rolecolor[ply:GetRole()]
	end

    return rolecolor.default
end

local function ColorForPlayer(ply)
    if IsValid(ply) then
        local c = hook.Call("TTTScoreboardColorForPlayer", GAMEMODE, ply)

        -- verify that we got a proper color
        if c and type(c) == "table" and c.r and c.b and c.g and c.a then
            return c
        else
            ErrorNoHalt("TTTScoreboardColorForPlayer hook returned something that isn't a color!\n")
        end
    end

    return namecolor.default
end

local bl_cl = Color(15, 15, 17, 150)

function PANEL:Paint(width, height)
    if not IsValid(self.Player) then return end
    local ply = self.Player
    self:InvalidateLayout()
    local c = hook.Call("TTTScoreboardRowColorForPlayer", GAMEMODE, ply)
    surface_SetDrawColor(103, 103, 103, 35)
    surface_DrawLine(0, 0, width, 0)
    surface_DrawLine(0, height - 1, width, height - 1)
    surface_SetDrawColor(c or bl_cl)
    surface_DrawRect(0, 1, width, height - 2)

    if ply == LocalPlayer() then
        surface_SetDrawColor(200, 200, 200, math.Clamp(math.sin(RealTime() * 2) * 50, 0, 100))
        surface_DrawRect(0, 0, width, SB_ROW_HEIGHT)
    end

    return true
end

function PANEL:SetPlayer(ply)
    self.Player = ply
    self.avatar:SetPlayer(ply)

    if not self.info then
        local g = ScoreGroup(ply)

        if g == GROUP_TERROR and ply ~= LocalPlayer() then
            self.info = vgui.Create("TTTScorePlayerInfoTags", self)
            self.info:SetPlayer(ply)
            self:InvalidateLayout()
        elseif g == GROUP_FOUND or g == GROUP_NOTFOUND then
            self.info = vgui.Create("TTTScorePlayerInfoSearch", self)
            self.info:SetPlayer(ply)
            self:InvalidateLayout()
        end
    else
        self.info:SetPlayer(ply)
        self:InvalidateLayout()
    end

    self.voice.DoClick = function()
        if IsValid(ply) and ply ~= LocalPlayer() then
            ply:SetMuted(not ply:IsMuted())
        end
    end

    self:UpdatePlayerData()
end

function PANEL:GetPlayer()
    return self.Player
end

local group_images = {
	["user"] = Material("icon16/group.png"),
	["vip"] = Material("icon16/star.png"),
	["partner"] = Material("icon16/star.png"),
   	["bugboomer"] = Material("icon16/bomb.png"),
   	["trialstaff"] = Material("icon16/shield.png"),
   	["moderator"] = Material("icon16/shield_add.png"),
   	["admin"] = Material("icon16/lightning.png"),
   	["senioradmin"] = Material("icon16/lightning_add.png"),
   	["headadmin"] = Material("icon16/world.png"),
   	["communitylead"] = Material("icon16/application_xp_terminal.png"),
	["owner"] = Material("icon16/application_xp_terminal.png"),
	["techartist"] = Material("icon16/application_xp_terminal.png"),
	["audioengineer"] = Material("icon16/application_xp_terminal.png"),
	["softwareengineer"] = Material("icon16/application_osx_terminal.png"),
	["gamedesigner"] = Material("icon16/application_xp_terminal.png"),
	["creativedirector"] = Material("icon16/application_xp_terminal.png"),
}

function PANEL:UpdatePlayerData()
    if not IsValid(self.Player) then return end
    local ply = self.Player

    for i = 1, #self.cols do
        -- Set text from function, passing the label along so stuff like text
        -- color can be changed
        self.cols[i]:SetText(self.cols[i].GetPlayerText(ply, self.cols[i]))
    end

    self.rankimage:SetMaterial((not ply:GetNW2Bool("adminmode", false)) and group_images[ply:GetUserGroup()] or group_images["user"])
    local plytitle = ply:GetNW2String("MoatTitlesTitle", ""):Trim()

    if (plytitle and #plytitle:Trim() > 0) then
        local col = {ply:GetNW2Int("MoatTitlesTitleR", 255), ply:GetNW2Int("MoatTitlesTitleG", 255), ply:GetNW2Int("MoatTitlesTitleB", 255)}
        self.title.Text = plytitle
        self.title:SetText " "
        surface.SetFont(self:GetFont())
        function self.title:SizeToContents()
            surface.SetFont(self:GetFont())
            local w, h = emoji.GetTextSize(self.Text)
            self:SetSize(w, h + emoji.GetTextOffsetNeeded(self.Text))
        end
        self.title:SizeToContents()
        self.title:SetTextColor(Color(col[1], col[2], col[3]))  
        function self.title:Paint(w, h)
            surface.SetFont(self:GetFont())
            emoji.SimpleText(self.Text, self:GetFont(), 0, emoji.GetTextOffsetNeeded(self.Text), self:GetTextColor(), nil, nil, nil, true)
        end

        self.titles.Text = plytitle
        self.titles:SetText " "
        function self.titles:SizeToContents()
            surface.SetFont(self:GetFont())
            local w, h = emoji.GetTextSize(self.Text)
            self:SetSize(w, h + emoji.GetTextOffsetNeeded(self.Text))
        end
        self.titles:SizeToContents()
        self.titles:InvalidateLayout(true)
        function self.titles:Paint(w, h)
            surface.SetFont(self:GetFont())
            emoji.SimpleText(self.Text, self:GetFont(), 0, emoji.GetTextOffsetNeeded(self.Text), self:GetTextColor(), nil, nil, true, true)
        end
    else
        self.title:SetText("")
        self.nick:SetPos(SB_ROW_HEIGHT + 10 + 15, (SB_ROW_HEIGHT / 2) - self.nick:GetTall() / 2)
        self.nicks:SetPos(SB_ROW_HEIGHT + 10 + 16, 1 + (SB_ROW_HEIGHT / 2) - self.nick:GetTall() / 2)
        self.titles:SetText("")
        self.titles:SizeToContents()
    end

    self.nicks:SetText(ply:Nick())
    self.nicks:SizeToContents()
    self.nick:SetText(ply:Nick())
    self.nick:SizeToContents()
    self.nick:SetTextColor(ColorForPlayer(ply))
    local ptag = ply.sb_tag

    if ScoreGroup(ply) ~= GROUP_TERROR then
        ptag = nil
    end

    self.tag:SetText(ptag and GetTranslation(ptag.txt) or "")
    self.tag:SetTextColor(ptag and ptag.color or COLOR_WHITE)
    self.sresult:SetVisible(ply.search_result ~= nil)

    -- more blue if a detective searched them
    if ply.search_result and (LocalPlayer():IsDetective() or (not ply.search_result.show)) then
        self.sresult:SetImageColor(Color(200, 200, 255))
    end

    -- cols are likely to need re-centering
    self:LayoutColumns()

    if self.info then
        self.info:UpdatePlayerData()
    end

    if self.Player ~= LocalPlayer() then
        local muted = self.Player:IsMuted()
        self.voice:SetImage(muted and "icon16/sound_mute.png" or "icon16/sound.png")
    else
        self.voice:Hide()
    end
end

function PANEL:ApplySchemeSettings()
    for k, v in pairs(self.cols) do
        v:SetFont("treb_small")
        v:SetTextColor(COLOR_WHITE)
    end

    self.title:SetFont("Default")
    self.title:SetTextColor(Color(255, 255, 255))
    self.titles:SetFont("Default")
    self.titles:SetTextColor(Color(0, 0, 0))
    self.nicks:SetFont("treb_small")
    self.nicks:SetTextColor(Color(0, 0, 0))
    self.nick:SetFont("treb_small")
    self.nick:SetTextColor(ColorForPlayer(self.Player))
    local ptag = self.Player and self.Player.sb_tag
    self.tag:SetTextColor(ptag and ptag.color or COLOR_WHITE)
    self.tag:SetFont("treb_small")
    self.sresult:SetImage("icon16/magnifier.png")
    self.sresult:SetImageColor(Color(170, 170, 170, 150))
end

local moat_levels = {Color(220, 220, 220), Color(220, 20, 60), Color(255, 127, 80), Color(255, 255, 0), Color(50, 205, 50), Color(0, 191, 255), Color(138, 43, 226), Color(255, 0, 255), Color(139, 0, 84), Color(255, 222, 173), Color(112, 128, 144)}
local sb_w = nil
local sb_h = nil

function PANEL:LayoutColumns()
    local cx = self:GetWide()

    for k, v in ipairs(self.cols) do
        v:SizeToContents()
        cx = cx - v.Width

        if (k == 5) then
            v:SetPos(50 + cx - v:GetWide() / 2, (SB_ROW_HEIGHT - v:GetTall()) / 2)
            continue
        elseif (k == 1) then
            local num_mod = tonumber(v:GetText())

            if (num_mod) then
                local p_num = GetConVar("moat_scoreboard_ping"):GetInt()

                if (sb_w == nil) then
                    sb_w = v:GetWide()
                end

                if (sb_h == nil) then
                    sb_h = v:GetTall()
                end

                if (p_num == 1) then
                    v:SetTextColor(Color(num_mod, 255 - num_mod, 0, 255))
                else
                    v:SetWide(19)
                    v:SetTall(15)
                    v:SetTextColor(Color(0, 0, 0, 0))
                end

                v.PaintOver = function(s, w, h)
                    if (p_num == 1) then return end
                    surface.SetDrawColor(100, 100, 100)

                    if (num_mod <= 150) then
                        surface.SetDrawColor(0, 255, 0)
                    end

                    surface.DrawRect(14, 0, 5, 15)

                    if (num_mod > 150 and num_mod <= 300) then
                        surface.SetDrawColor(255, 200, 0)
                    end

                    surface.DrawRect(7, 5, 5, 10)

                    if (num_mod > 300) then
                        surface.SetDrawColor(255, 0, 0)
                    end

                    surface.DrawRect(0, 10, 5, 5)
                end
            end
        elseif (k == 4) then
            local num_mod = tonumber(v:GetText())

            if (num_mod) then
                local text_mod = num_mod / 1150
                v:SetTextColor(Color(255 - (255 * text_mod), 255 * text_mod, 0))
            end
        elseif (k == 6) then
            local num_mod = tonumber( v:GetText() )
			if (num_mod) then
				local col = moat_levels[1]
				v.Ply = self:GetPlayer()
				v:SizeToContents()
    			v:SetContentAlignment(5)
				if (num_mod >= 100) then
					col = Color(0, 0, 0, 0)
					if (not v.OldPaint) then v.OldPaint = v.Paint end
					v.Paint = function(s, w, h)
						local text_str, font, draw_x, draw_y, col, tfx = s:GetText(), "treb_small", w/2, h/2, Color(255, 255, 255), "Normal"

						if (IsValid(s.Ply)) then
							col.r = s.Ply:GetNW2Int("Moat.Level.R", 255)
							col.g = s.Ply:GetNW2Int("Moat.Level.G", 255)
							col.b = s.Ply:GetNW2Int("Moat.Level.B", 255)
							tfx = MOAT_LEVELS.Effects[s.Ply:GetNW2Int("Moat.Level.Effect", 1)]
						end

						surface.SetFont(font)
						local txw, txh = surface.GetTextSize(text_str)
						draw_x = draw_x - (txw/2)
						draw_y = draw_y - (txh/2)

						-- DisableClipping(true)
						if (tfx == "Glow") then
							m_DrawGlowingText(false, text_str, font, draw_x, draw_y, col)
						elseif (tfx == "Fire") then
							m_DrawFireText(7, text_str, font, draw_x, draw_y, col)
						elseif (tfx == "Bounce") then
							DrawBouncingText(3, 3, text_str, font, draw_x, draw_y, col)
						elseif (tfx == "Enchanted") then
							m_DrawEnchantedText(text_str, font, draw_x, draw_y, col, Color(127, 0, 255))
						elseif (tfx == "Electric") then
							m_DrawElecticText(text_str, font, draw_x, draw_y, col)
						elseif (tfx == "Frost") then
							DrawFrostingText(10, 1.5, text_str, font, draw_x, draw_y, col, Color(255, 255, 255))
						else
							if (tfx == "Rainbow") then
								col = rarity_names[9][2]:Copy()
							end

							draw.SimpleText(text_str, font, w/2, h/2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						end
						-- DisableClipping(false)
					end
                elseif (num_mod >= 90) then
					if (v.OldPaint) then v.Paint = v.OldPaint v.OldPaint = nil end
                    col = moat_levels[10]
                elseif (num_mod >= 80) then
					if (v.OldPaint) then v.Paint = v.OldPaint v.OldPaint = nil end
                    col = moat_levels[9]
                elseif (num_mod >= 70) then
					if (v.OldPaint) then v.Paint = v.OldPaint v.OldPaint = nil end
                    col = moat_levels[8]
                elseif (num_mod >= 60) then
					if (v.OldPaint) then v.Paint = v.OldPaint v.OldPaint = nil end
                    col = moat_levels[7]
                elseif (num_mod >= 50) then
					if (v.OldPaint) then v.Paint = v.OldPaint v.OldPaint = nil end
                    col = moat_levels[6]
                elseif (num_mod >= 40) then
					if (v.OldPaint) then v.Paint = v.OldPaint v.OldPaint = nil end
                    col = moat_levels[5]
                elseif (num_mod >= 30) then
					if (v.OldPaint) then v.Paint = v.OldPaint v.OldPaint = nil end
                    col = moat_levels[4]
                elseif (num_mod >= 20) then
					if (v.OldPaint) then v.Paint = v.OldPaint v.OldPaint = nil end
                    col = moat_levels[3]
                elseif (num_mod >= 10) then
					if (v.OldPaint) then v.Paint = v.OldPaint v.OldPaint = nil end
                    col = moat_levels[2]
                end

                v:SetTextColor(col)
            end
        end

        v:SetPos(cx - v:GetWide() / 2, (SB_ROW_HEIGHT - v:GetTall()) / 2)
    end

    self.tag:SizeToContents()
    cx = cx - 90
    self.tag:SetPos(cx - self.tag:GetWide() / 2, (SB_ROW_HEIGHT - self.tag:GetTall()) / 2)
    self.sresult:SetPos(cx - 8, (SB_ROW_HEIGHT - 16) / 2)
end

function PANEL:PerformLayout()
    self.avatar:SetPos(0, 1)
    self.avatar:SetSize(SB_ROW_HEIGHT - 2, SB_ROW_HEIGHT - 2)
    local fw = sboard_panel.ply_frame:GetWide()
    self:SetWide(sboard_panel.ply_frame.scroll.Enabled and fw - 16 or fw)

    if not self.open then
        self:SetSize(self:GetWide(), SB_ROW_HEIGHT)

        if self.info then
            self.info:SetVisible(false)
        end
    elseif self.info then
        self:SetSize(self:GetWide(), 100 + SB_ROW_HEIGHT)
        self.info:SetVisible(true)
        self.info:SetPos(5, SB_ROW_HEIGHT + 5)
        self.info:SetSize(self:GetWide(), 100)
        self.info:PerformLayout()
        self:SetSize(self:GetWide(), SB_ROW_HEIGHT + self.info:GetTall())
    end

    self.rankimage:SetPos(28, 4)
    self.rankimage:SetSize(16, 16)

    if (self.title and self.title:GetText() ~= "") then
        surface.SetFont(self.title:GetFont())
        self.title:SizeToContents()
        self.title:SetPos(SB_ROW_HEIGHT + 10 + 15, 11 - emoji.GetTextOffsetNeeded(self.title:GetText()))
        self.titles:SizeToContents()
        self.titles:SetPos(SB_ROW_HEIGHT + 10 + 16, 12 - emoji.GetTextOffsetNeeded(self.title:GetText()))
        self.nick:SizeToContents()
        self.nick:SetPos(SB_ROW_HEIGHT + 10 + 15, -1)
        self.nicks:SizeToContents()
        self.nicks:SetPos(SB_ROW_HEIGHT + 10 + 16, 0)
    else
        self.nick:SizeToContents()
        self.nick:SetPos(SB_ROW_HEIGHT + 10 + 15, (SB_ROW_HEIGHT / 2) - self.nick:GetTall() / 2)
        self.nicks:SizeToContents()
        self.nicks:SetPos(SB_ROW_HEIGHT + 10 + 16, 1 + (SB_ROW_HEIGHT / 2) - self.nick:GetTall() / 2)
    end

    self:LayoutColumns()
    self.voice:SetVisible(not self.open)
    self.voice:SetSize(16, 16)
    self.voice:DockMargin(4, 4, 4, 4)
    self.voice:Dock(RIGHT)
end

function PANEL:DoClick(x, y)
    self:SetOpen(not self.open)
end

function PANEL:SetOpen(o)
	if (GetConVar "moat_ui_sounds" and GetConVar "moat_ui_sounds":GetInt() and GetConVar "moat_ui_sounds":GetInt() > 0) then
		LocalPlayer():EmitSound "moatsounds/pop2.wav"
	end

    self.open = o
    self:PerformLayout()
    self:GetParent():PerformLayout()
    sboard_panel:PerformLayout()
end

function PANEL:OnCursorEntered(s)
	if (GetConVar "moat_ui_sounds" and GetConVar "moat_ui_sounds":GetInt() and GetConVar "moat_ui_sounds":GetInt() > 0) then
		LocalPlayer():EmitSound "moatsounds/pop1.wav"
	end
end

function PANEL:DoRightClick()
    local menu = DermaMenu()
    menu.Player = self:GetPlayer()
    local close = hook.Call("TTTScoreboardMenu", nil, menu)

    if close then
        menu:Remove()

        return
    end

    menu:Open()

	if (cdn and cdn.PlayURL and GetConVar "moat_ui_sounds" and GetConVar "moat_ui_sounds":GetInt() and GetConVar "moat_ui_sounds":GetInt() > 0) then
		cdn.PlayURL "https://static.moat.gg/ttt/appear-online.ogg"
	end
end

vgui.Register("TTTScorePlayerRow", PANEL, "Button")