local math              = math
local table             = table
local draw              = draw
local team              = team
local IsValid           = IsValid
local CurTime           = CurTime
local draw_SimpleText = draw.SimpleText
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local draw_RoundedBoxEx = draw.RoundedBoxEx
local draw_RoundedBox = draw.RoundedBox
local draw_DrawText = draw.DrawText
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
local gradient_u = Material("vgui/gradient-u")
local gradient_d = Material("vgui/gradient-d")
local gradient_r = Material("vgui/gradient-r")

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

MOAT_COMP = MOAT_COMP or {}
MOAT_COMP.Entries = {
	{"Item's evidence link", false, "Insert any evidence for the compensation ticket here."},
--	{"The players's steamid to comp", false, "SteamID of the person being compensated. (Ex: STEAM_0:0:46558052)"},
	{"Inventory credits to give", true, "Number of inventory credits for compensation if applicable. Leave blank if none."},
	{"Support credits to gift", true, "Number of event credits for compensation if applicable. Leave blank if none."},
	{"Event credits to drop", true, "Number of event credits for compensation if applicable. Leave blank if none."},
	{"Any tier / unique / item (ex. Sunny, Tolerable, Turtle Hat)", false, "Do NOT put the weapon name if the item is a Tier'd item. (Ex: Sunny Deagle < DO NOT DO THAT)"},
	{"Item's weapon class (ex. Deagle)", false, "Do NOT use this for unique items. Weapon name of the item if applicable."},
	{"Requested Talent 1", false, "First talent if applicable, leave blank if none."},
	{"Requested Talent 2", false, "Second talent if applicable, leave blank if none."},
	{"Requested Talent 3", false, "Third talent if applicable, leave blank if none."},
	{"Requested Talent 4", false, "Fourth talent if applicable, leave blank if none."},
	{"Additional Comments", false, "You may leave any additional comments here."}
}

function MOAT_COMP:Open()
	if (IsValid(self.bg)) then self.bg:Remove() end

	self.bg = vgui.Create("DFrame")
	self.bg:SetSize(500, 600)
	self.bg:MakePopup()
	self.bg:Center()
	self.bg:SetTitle("")
	self.bg.Paint = function(s, w, h)
        DrawBlur(s, 5)

        draw_RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
        draw_RoundedBox(0, 1, 1, w-2, h-2, Color(0, 0, 0, 50))

        surface_SetDrawColor(150, 150, 150, 50)
        surface_DrawRect(0, 0, w, 21)

        draw_SimpleText("Submit a New Compensation Ticket", "GModNotify", 4, 1, Color(255, 255, 255))
	end

	self.f = vgui.Create("DPanel", self.bg)
	self.f:Dock(FILL)
	self.f.Paint = function(s, w, h) end

	self.t = {}

	local cur_y = 0

	for i = 1, #self.Entries do
		local bp = vgui.Create("DPanel", self.f)
		bp:SetPos(0, cur_y)
		bp:SetSize(500, 40)
		bp.Paint = function(s, w, h)
			surface_SetDrawColor(0, 0, 0, 100)
        	surface_DrawRect(0, 0, w, h)

			draw_SimpleText(self.Entries[i][1], "GModNotify", 2, 1, Color(255, 255, 255))
		end

		local last = i == #self.Entries

		self.t[i] = vgui.Create("DTextEntry", bp)
		self.t[i]:SetPos(0, 19)
		self.t[i]:SetSize(490, 21)
		self.t[i].st = 50
		self.t[i].Paint = function(s, w, h)
			surface_SetDrawColor(0, 150, 150, 50)
        	surface_DrawOutlinedRect(0, 0, w, h)
        	surface_SetDrawColor(0, 0, 0, 100)
        	surface_DrawRect(1, 1, w-2, h-2)

        	s:DrawTextEntryText(Color(255, 255, 255, 255), s:GetHighlightColor(), Color(255, 255, 255, 255))

        	draw_SimpleText(self.Entries[i][3] or "Nothing", "DermaDefault", 3, last and 1 or 4, Color(255, 255, 255, s.st))
        end
    	self.t[i].Think = function(s) s.st = s:GetValue() ~= "" and 0 or 50 end

        if (self.Entries[i][2]) then
        	self.t[i]:SetNumeric(true)
        end

		cur_y = cur_y + 43
	
		if (last) then
			bp:SetTall(80)

			self.t[i]:SetTall(61)
			self.t[i]:SetMultiline(true)

			cur_y = cur_y + 50
		end
	end

	self.s = vgui.Create("DButton", self.bg)
    self.s:SetSize(200, 26)
    self.s:SetPos(150, cur_y + 35)
    self.s:SetText("")
    self.s.LerpNum = 0
    self.s.Paint = function(s, w, h)
        if (s:IsHovered()) then
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
        else
            s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
        end

        surface_SetDrawColor(150 * s.LerpNum, 150 * s.LerpNum, 150 * s.LerpNum, 100)
        surface_DrawOutlinedRect(0, 0, w, h)
        surface_SetDrawColor(150 * s.LerpNum, 150 * s.LerpNum, 150 * s.LerpNum, 225)
        surface_DrawRect(1, 1, w-2, h-2)

        draw_SimpleText("Submit for Review", "GModNotify", (w/2), (h/2), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    self.s.OnCursorEntered = function(s)
        surface.PlaySound("ui/buttonrollover.wav")
    end
    self.s.DoClick = function(s)
        surface.PlaySound("ui/buttonclickrelease.wav")

        net.Start("moat.comp.open")
        for i = 1, #self.t do
        	net.WriteString(self.t[i]:GetValue() or "")
        end
        net.SendToServer()

		if (IsValid(self.bg)) then self.bg:Remove() end
    end
end

net.Receive("moat.comp.open", function() MOAT_COMP:Open() end)


function MOAT_COMP.Chat()
	local str = net.ReadString()
	local e = net.ReadBool()

	chat.AddText(e and Color(255, 0, 0) or Color(0, 255, 0), str)
end

net.Receive("moat.comp.chat", MOAT_COMP.Chat)