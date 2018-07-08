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
local MOAT_DOT = {}
MOAT_DOT.Damages = {}
MOAT_DOT.Config = {
	w = 200,
	h = 24,
	s = 10
}

function MOAT_DOT.Draw()
	if (/*GetRoundState() ~= ROUND_ACTIVE or*/ #MOAT_DOT.Damages < 1) then return end
	local scrw, scrh = ScrW(), ScrH()

	for k, v in ipairs(MOAT_DOT.Damages) do
		if (v[2] <= CurTime()) then table.remove(MOAT_DOT.Damages, k) end
	end

	local amt = #MOAT_DOT.Damages
	local ypos = (scrh/2) - (amt * ((MOAT_DOT.Config.h + MOAT_DOT.Config.s)/2))

	for i = 1, #MOAT_DOT.Damages do
		local dot = MOAT_DOT.Damages[i]

		surface.SetDrawColor(dot[4].r, dot[4].g, dot[4].b, 50)
		surface.DrawRect(scrw - MOAT_DOT.Config.w - MOAT_DOT.Config.s, ypos, MOAT_DOT.Config.w, MOAT_DOT.Config.h)

		surface.SetDrawColor(dot[4].r, dot[4].g, dot[4].b, 255)
		surface.DrawOutlinedRect(scrw - MOAT_DOT.Config.w - MOAT_DOT.Config.s, ypos, MOAT_DOT.Config.w, MOAT_DOT.Config.h)

		surface.SetDrawColor(0, 0, 0, 120)
		surface.DrawRect(scrw - MOAT_DOT.Config.w - MOAT_DOT.Config.s, ypos, MOAT_DOT.Config.h, MOAT_DOT.Config.h)

		--[[
			Showing Time Left
		]]

		local dot_w = math.max((dot[2] - CurTime())/dot[6], 0) * (MOAT_DOT.Config.w - 24)

		surface.SetDrawColor(dot[4].r, dot[4].g, dot[4].b, 50)
		surface.DrawRect(scrw - MOAT_DOT.Config.w - MOAT_DOT.Config.s + 24, ypos, dot_w, MOAT_DOT.Config.h)

		surface.SetDrawColor(0, 0, 0, 120)
		surface.SetMaterial(gradient_r)
		surface.DrawTexturedRect(scrw - MOAT_DOT.Config.w - MOAT_DOT.Config.s + 24, ypos, dot_w, MOAT_DOT.Config.h)

		--------------------------

		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(dot[3])
		surface.DrawTexturedRect(scrw - MOAT_DOT.Config.w - MOAT_DOT.Config.s + 4, ypos + 4, 16, 16)

		draw_SimpleTextOutlined(dot[1], "GModNotify", scrw - MOAT_DOT.Config.w + 20, ypos + 4, Color(dot[4].r, dot[4].g, dot[4].b, 25), 0, 0, 0, Color(10, 10, 10, 0))
        draw_SimpleTextOutlined(dot[1], "GModNotify", scrw - MOAT_DOT.Config.w + 20, ypos + 4, Color(0, 0, 0, 175), 0, 0, 0, Color(10, 10, 10, 0))
        draw_SimpleTextOutlined(dot[1], "GModNotify", scrw - MOAT_DOT.Config.w + 19, ypos + 3, dot[4], 0, 0, 0, Color(10, 10, 10, 0))

		ypos = ypos + MOAT_DOT.Config.h + MOAT_DOT.Config.s
	end
end
hook.Add("HUDPaint", "MOAT_DOT.Draw", MOAT_DOT.Draw)

net.Receive("moat.dot.init", function()
	local dot = {}
	dot[1] = net.ReadString()

	local time = net.ReadUInt(16)

	dot[2] = CurTime() + time
	dot[3] = Material(net.ReadString())
	dot[4] = net.ReadColor()
	dot[5] = net.ReadString()
	dot[6] = time

	table.insert(MOAT_DOT.Damages, dot)
end)

net.Receive("moat.dot.adjust", function()
	local id = net.ReadString()
	local new = net.ReadUInt(16)

	for i = 1, #MOAT_DOT.Damages do
		if (MOAT_DOT.Damages[i][5] == id) then
			MOAT_DOT.Damages[i][2] = CurTime() + new
			MOAT_DOT.Damages[i][6] = new
		end
	end
end)

net.Receive("moat.dot.end", function()
	local id = net.ReadString()

	for k, v in ipairs(MOAT_DOT.Damages) do
		if (v[5] == id) then table.remove(MOAT_DOT.Damages, k) end
	end
end)

function MOAT_DOT.Reset()
	MOAT_DOT.Damages = {}
end

hook.Add("TTTEndRound", "moat.dot.round.end", MOAT_DOT.Reset)
hook.Add("TTTPrepareRound", "moat.dot.round.begin", MOAT_DOT.Reset)

concommand.Add("moat_dot_reset", function()
	MOAT_DOT.Reset()
end)