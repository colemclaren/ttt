---- VGUI panel version of the scoreboard, based on TEAM GARRY's sandbox mode
---- scoreboard.
local GetTranslation = LANG.GetTranslation
local GetPTranslation = LANG.GetParamTranslation
include("sb_team.lua")

surface.CreateFont("cool_small", {
	font = "coolvetica",
	size = 20,
	weight = 400
})

surface.CreateFont("cool_large", {
	font = "coolvetica",
	size = 24,
	weight = 400
})

surface.CreateFont("treb_small", {
	font = "Trebuchet18",
	size = 14,
	weight = 700
})

local logo = surface.GetTextureID("vgui/ttt/score_logo")
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
local surface_SetTexture = surface.SetTexture
local surface_DrawPoly = surface.DrawPoly
local surface_DrawCircle = surface.DrawCircle
local PANEL = {}
local max = math.max
local floor = math.floor

local function UntilMapChange()
	local rounds_left = max(0, GetGlobal("ttt_rounds_left"))
	local time_left = floor(max(0, ((GetGlobal("ttt_time_limit_minutes") or 60) * 60) - CurTime()))
	local h = floor(time_left / 3600)
	time_left = time_left - floor(h * 3600)
	local m = floor(time_left / 60)
	time_left = time_left - floor(m * 60)
	local s = floor(time_left)

	return rounds_left, string.format("%02i:%02i:%02i", h, m, s)
end

GROUP_TERROR = 1
GROUP_NOTFOUND = 2
GROUP_FOUND = 3
GROUP_SPEC = 4
GROUP_COUNT = 4

-- Utility function to register a score group
function AddScoreGroup(name)
	if _G["GROUP_" .. name] then
		error("Group of name '" .. name .. "' already exists!")

		return
	end

	GROUP_COUNT = GROUP_COUNT + 1
	_G["GROUP_" .. name] = GROUP_COUNT
end

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

function ScoreGroup(p)
	if not IsValid(p) then return -1 end -- will not match any group panel
	local group = hook.Call("TTTScoreGroup", nil, p)
	if group then return group end -- If that hook gave us a group, use it

	if DetectiveMode() then
		if p:IsSpec() and (not p:Alive()) then
			if p:GetNW2Bool("body_found", false) then
				return GROUP_FOUND
			else
				local client = LocalPlayer()

				-- To terrorists, missing players show as alive
				if client:IsSpec() or client:IsActiveTraitor() or client:IsActiveRole(ROLE_JESTER) or ((GAMEMODE.round_state ~= ROUND_ACTIVE) and client:IsTerror()) then
					return GROUP_NOTFOUND
				else
					return GROUP_TERROR
				end
			end
		end
	end

	return p:IsTerror() and GROUP_TERROR or GROUP_SPEC
end

function PANEL:Init()
	self.serverinfo = vgui.Create("DLabel", self)
	self.serverinfo:SetText((GetServerName() or "Moat TTT") .. " | 00 Rounds left")
	self.serverinfo:SetContentAlignment(7)
	self.serverinfo.Think = function(sf)
		local r, t = UntilMapChange()

		sf:SetText((GetServerName() or "Moat TTT") .. " | " .. r .. " Rounds Left")
		sf:SizeToContents()
	end

	-- self.mapchange = vgui.Create("DLabel", self)
	-- self.mapchange:SetText("Map changes in 00 rounds or in 00:00:00")
	-- self.mapchange:SetContentAlignment(8)

	-- self.mapchange.Think = function(sf)
	-- 	local r, t = UntilMapChange()

	-- 	sf:SetText(GetPTranslation("sb_mapchange", {
	-- 		num = r,
	-- 		time = t
	-- 	}))

	-- 	sf:SizeToContents()
	-- end

	self.ply_frame = vgui.Create("TTTPlayerFrame", self)
	self.ply_groups = {}
	local t = vgui.Create("TTTScoreGroup", self.ply_frame:GetCanvas())
	t:SetGroupInfo(GetTranslation("terrorists"), Color(0, 200, 0, 100), GROUP_TERROR)
	self.ply_groups[GROUP_TERROR] = t
	t = vgui.Create("TTTScoreGroup", self.ply_frame:GetCanvas())
	t:SetGroupInfo(GetTranslation("spectators"), Color(200, 200, 0, 100), GROUP_SPEC)
	self.ply_groups[GROUP_SPEC] = t

	if DetectiveMode() then
		t = vgui.Create("TTTScoreGroup", self.ply_frame:GetCanvas())
		t:SetGroupInfo(GetTranslation("sb_mia"), Color(130, 190, 130, 100), GROUP_NOTFOUND)
		self.ply_groups[GROUP_NOTFOUND] = t
		t = vgui.Create("TTTScoreGroup", self.ply_frame:GetCanvas())
		t:SetGroupInfo(GetTranslation("sb_confirmed"), Color(130, 170, 10, 100), GROUP_FOUND)
		self.ply_groups[GROUP_FOUND] = t
	end

	hook.Call("TTTScoreGroups", nil, self.ply_frame:GetCanvas(), self.ply_groups)
	-- the various score column headers
	self.cols = {}
	self:AddColumn(""/*GetTranslation("sb_ping")*/)
	self:AddColumn(GetTranslation("sb_deaths"))
	self:AddColumn(GetTranslation("sb_score"))
	self:AddColumn(GetTranslation("sb_karma"))

	-- Let hooks add their column headers (via AddColumn())
	hook.Call("TTTScoreboardColumns", nil, self)
	self:UpdateScoreboard()
	self:StartUpdateTimer()
end

-- For headings only the label parameter is relevant, func is included for
-- parity with sb_row
function PANEL:AddColumn(label, func, width)
	local lbl = vgui.Create("DLabel", self)
	lbl:SetText(label)
	lbl.IsHeading = true
	lbl.Width = width or 50 -- Retain compatibility with existing code
	table.insert(self.cols, lbl)

	return lbl
end

function PANEL:StartUpdateTimer()
	if not timer.Exists("TTTScoreboardUpdater") then
		timer.Create("TTTScoreboardUpdater", 0.5, 0, function()
			local pnl = GAMEMODE:GetScoreboardPanel()

			if IsValid(pnl) then
				pnl:UpdateScoreboard()
			end
		end)
	end
end

local colors = {
	bg = Color(30, 30, 30, 235),
	bar = Color(20, 20, 20, 200)
}

local y_logo_off = 92

function PANEL:Paint()
	-- Logo sticks out, so always offset bg
	--draw.RoundedBox( 8, 0, y_logo_off, self:GetWide(), self:GetTall() - y_logo_off, colors.bg)
	-- Server name is outlined by orange/gold area
	--draw.RoundedBox( 8, 0, y_logo_off + 25, self:GetWide(), 32, colors.bar)
	local w, h = self:GetWide(), self:GetTall()
	DrawBlur(self, 3)
	--[[surface_SetDrawColor(0, 0, 0, 150)
   surface_DrawRect(0, 0, w, h)]]
	cdn.DrawImage("http://static.moat.gg/f/bg.png", math.min((w/2) - (3840/2), 0), math.min((h/2) - (2160/2), 0), math.max(3840, h), math.max(2160, w), Color(255, 255, 255, 230))	
	
	-- surface_SetTexture(logo)
	-- surface_SetDrawColor(255, 255, 255, 255)
	-- surface_DrawTexturedRect(5, 0, 256, 256)
	-- cdn.SmoothImage("https://static.moat.gg/ttt/visit-website21.png", w - 256 - 20, 0, 256, 256)
	local img_w, img_h = ScrH() / 2.2, ScrH() / 2.2
	surface_SetDrawColor(183, 183, 183)
	DisableClipping(true)
	surface_DrawLine(0, -4, w, -4)
	surface_DrawLine(0, h + 3, w, h + 3)
	-- cdn.SmoothImage("https://static.moat.gg/ttt/moat-scoreboard.png", w/2 - (img_w/2), 5, img_w, img_h)
	DisableClipping(false)
end

local h_logo_off = 82
function PANEL:PerformLayout()
	-- position groups and find their total size
	local gy = 0

	-- can't just use pairs (undefined ordering) or ipairs (group 2 and 3 might not exist)
	for i = 1, GROUP_COUNT do
		local group = self.ply_groups[i]

		if IsValid(group) then
			if group:HasRows() then
				group:SetVisible(true)
				group:SetPos(0, gy)
				group:SetSize(self.ply_frame:GetWide(), group:GetTall())
				group:InvalidateLayout()
				gy = gy + group:GetTall() + 5
			else
				group:SetVisible(false)
			end
		end
	end

	self.ply_frame:GetCanvas():SetSize(self.ply_frame:GetCanvas():GetWide(), gy)
	local h = 110 + self.ply_frame:GetCanvas():GetTall() - h_logo_off
	-- if we will have to clamp our height, enable the mouse so player can scroll
	local scrolling = h > ScrH() * 0.95
	--   gui.EnableScreenClicker(scrolling)
	self.ply_frame:SetScroll(scrolling)
	h = math.Clamp(h, 110 - h_logo_off, ScrH() * 0.95)
	local w = math.max(ScrW() * 0.6, 750)
	self:SetSize(w, h)
	self:SetPos((ScrW() - w) / 2, math.min(110, (ScrH() - h) / 2))
	self.ply_frame:SetPos(8, 109 - h_logo_off)
	self.ply_frame:SetSize(self:GetWide() - 16, self:GetTall() - 109 - 5 + h_logo_off)
	-- server stuff
	-- self.mapchange:SizeToContents()
	-- self.mapchange:SetPos((w - self.mapchange:GetWide() - 16)/2, 60 - h_logo_off)
	self.serverinfo:SizeToContents()
	self.serverinfo:SetPos(8, 90 - h_logo_off)
	-- score columns
	local cy = 90 - h_logo_off
	local cx = w - 8 - (scrolling and 16 or 0)

	for k, v in ipairs(self.cols) do
		v:SizeToContents()
		cx = cx - v.Width

		if (v:GetText() == "Rank") then
			v:SetPos(50 + cx - v:GetWide() / 2, cy)
			continue
		end

		v:SetPos(cx - v:GetWide() / 2, cy)
	end
end

function PANEL:ApplySchemeSettings()
	self.serverinfo:SetFont("treb_small")
	self.serverinfo:SetTextColor(COLOR_WHITE)
	-- self.mapchange:SetFont("treb_small")
	-- self.mapchange:SetTextColor(COLOR_WHITE)

	for k, v in pairs(self.cols) do
		v:SetFont("treb_small")
		v:SetTextColor(COLOR_WHITE)
	end
end

function PANEL:UpdateScoreboard(force)
	if not force and not self:IsVisible() then return end
	local layout = false

	-- Put players where they belong. Groups will dump them as soon as they don't
	-- anymore.
	for k, p in ipairs(player.GetAll()) do
		if IsValid(p) then
			local group = ScoreGroup(p)

			if self.ply_groups[group] and not self.ply_groups[group]:HasPlayerRow(p) then
				self.ply_groups[group]:AddPlayerRow(p)
				layout = true
			end
		end
	end

	for k, group in ipairs(self.ply_groups) do
		if IsValid(group) then
			group:SetVisible(group:HasRows())
			group:UpdatePlayerData()
		end
	end

	if layout then
		self:PerformLayout()
	else
		self:InvalidateLayout()
	end
end

vgui.Register("TTTScoreboard", PANEL, "Panel")
---- PlayerFrame is defined in sandbox and is basically a little scrolling
---- hack. Just putting it here (slightly modified) because it's tiny.
local PANEL = {}

function PANEL:Init()
	self.pnlCanvas = vgui.Create("Panel", self)
	self.YOffset = 0
	self.scroll = vgui.Create("DVScrollBar", self)
end

function PANEL:GetCanvas()
	return self.pnlCanvas
end

function PANEL:OnMouseWheeled(dlta)
	self.scroll:AddScroll(dlta * -2)
	self:InvalidateLayout()
end

function PANEL:SetScroll(st)
	self.scroll:SetEnabled(st)
end

function PANEL:PerformLayout()
	self.pnlCanvas:SetVisible(self:IsVisible())
	-- scrollbar
	self.scroll:SetPos(self:GetWide() - 16, 0)
	self.scroll:SetSize(16, self:GetTall())
	local was_on = self.scroll.Enabled
	self.scroll:SetUp(self:GetTall(), self.pnlCanvas:GetTall())
	self.scroll:SetEnabled(was_on) -- setup mangles enabled state
	self.YOffset = self.scroll:GetOffset()
	self.pnlCanvas:SetPos(0, self.YOffset)
	self.pnlCanvas:SetSize(self:GetWide() - (self.scroll.Enabled and 16 or 0), self.pnlCanvas:GetTall())
end

vgui.Register("TTTPlayerFrame", PANEL, "Panel")