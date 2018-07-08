
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

MOAT_FORUMS = MOAT_FORUMS or {}

function MOAT_FORUMS.ButtonPaint(b, col)
	b.LerpNum = 0
	b.Paint = function(s, w, h)
		s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, s:IsHovered() and 1 or 0)

        surface_SetDrawColor(col[1] * s.LerpNum, col[2] * s.LerpNum, col[3] * s.LerpNum, 150 + (50 * s.LerpNum))
        surface_DrawRect(0, 0, w, h)

        surface_SetDrawColor(col[1], col[2], col[3])
        surface_DrawOutlinedRect(0, 0, w, h)

        draw_SimpleTextOutlined(s.Label, "Trebuchet24", w/2, h/2, Color(col[1] + ((255 - col[1]) * s.LerpNum), col[2] + ((255 - col[2]) * s.LerpNum), col[3] + ((255 - col[3]) * s.LerpNum)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
    end
    b.OnCursorEntered = function(s)
	    surface.PlaySound("ui/buttonrollover.wav")
    end
    --surface.PlaySound("ui/buttonclickrelease.wav")
end

function MOAT_FORUMS:OpenWindow()
	if (IsValid(MOAT_FORUMS.BG)) then MOAT_FORUMS.BG:Remove() end
	if (IsValid(MOAT_INV_BG)) then MOAT_INV_BG:Remove() end
	
	MOAT_FORUMS.BG = vgui.Create("DFrame")
	MOAT_FORUMS.BG:SetSize(465, 126)
	MOAT_FORUMS.BG:Center()
	MOAT_FORUMS.BG:MakePopup()
	MOAT_FORUMS.BG:SetTitle("")
	MOAT_FORUMS.BG:ShowCloseButton(false)
	MOAT_FORUMS.BG:DockPadding(0, 6, 0, 6)
	MOAT_FORUMS.BG.Paint = function(s, w, h)
		surface_SetDrawColor(183, 183, 183)
		surface_DrawLine(0, 0, w, 0)
		surface_DrawLine(0, h - 1, w, h - 1)
	end

	local p = vgui.Create("DPanel", MOAT_FORUMS.BG)
	p:Dock(FILL)
	p:DockPadding(6, 6, 6, 6)
	p.Paint = function(s, w, h)
        surface_SetDrawColor(0, 0, 0, 200)
        surface_DrawRect(0, 0, w, h)
        DrawBlur(s, 3)

        draw_SimpleText("Sign in with Steam on our", "GModNotify", 329/2, 20, Color(255, 255, 0), TEXT_ALIGN_CENTER)
        draw_SimpleText("forums to earn 2,500 IC!", "GModNotify", 329/2, 40, Color(255, 255, 0), TEXT_ALIGN_CENTER)

        draw_SimpleText("Click the Check button once you've signed up.", "moat_ItemDesc", 329/2, 92, Color(255, 255, 255), TEXT_ALIGN_CENTER)
	end

	local bp = p:Add("DPanel")
	bp:Dock(RIGHT)
	bp:SetWide(130)
	bp.Paint = nil

	local x = bp:Add("DButton")
	x:Dock(BOTTOM)
	x:SetSize(100, 30)
	x:SetText("")
	x.Label = "Close"
	x.DoClick = function()
		surface.PlaySound("ui/buttonclickrelease.wav")
		MOAT_FORUMS.BG:Remove()
		LocalPlayer():ConCommand("moat_forum_rewards 1")
	end
	self.ButtonPaint(x, {255, 50, 50})

	local c = bp:Add("DButton")
	c:Dock(BOTTOM)
	c:DockMargin(0, 6, 0, 6)
	c:SetSize(100, 30)
	c:SetText("")
	c.Label = "Check"
	c.cd = CurTime()
	c.DoClick = function()
		surface.PlaySound("ui/buttonclickrelease.wav")
		if (c.cd > CurTime()) then return end
		c.cd = CurTime() + 5

		net.Start("moat.forums.check")
		net.SendToServer()
	end
	self.ButtonPaint(c, {46, 204, 113})

	local o = bp:Add("DButton")
	o:Dock(BOTTOM)
	o:SetSize(100, 30)
	o:SetText("")
	o.Label = "Open"
	o.DoClick = function(s, w, h)
		surface.PlaySound("ui/buttonclickrelease.wav")
		gui.OpenURL("https://moat.gg/login")
	end
	self.ButtonPaint(o, {51, 153, 255})
end

function MOAT_FORUMS.Success()
	local pl = net.ReadEntity()
	if (not IsValid(pl)) then return end
	if (IsValid(MOAT_FORUMS.BG)) then surface.PlaySound("ui/buttonclickrelease.wav") MOAT_FORUMS.BG:Remove() end

	chat.AddText(moat_blue, "| ", moat_cyan, pl:Nick(), moat_white, " joined our forums and received ", moat_green, "2,500 IC", moat_white, "! Type !forums in chat to do the same!")
end

net.Receive("moat.forums.success", MOAT_FORUMS.Success)

concommand.Add("moat_forums", function()
	MOAT_FORUMS:OpenWindow()
end)