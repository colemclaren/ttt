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
local MOAT_STATUS = {}
MOAT_STATUS.StatusList = {}
MOAT_STATUS.Config = {
	w = 200,
	h = 24,
	s = 10
}

function MOAT_STATUS.Draw()
	if (#MOAT_STATUS.StatusList < 1) then return end

	local scrw, scrh = ScrW(), ScrH()
	for k, v in ipairs(MOAT_STATUS.StatusList) do
		if (v[2] <= CurTime()) then table.remove(MOAT_STATUS.StatusList, k) end
	end

	local amt = #MOAT_STATUS.StatusList
	local ypos = (scrh/2) - (amt * ((MOAT_STATUS.Config.h + MOAT_STATUS.Config.s)/2))

	for i = 1, amt do
		local status = MOAT_STATUS.StatusList[i]

		surface.SetDrawColor(status[4].r, status[4].g, status[4].b, 50)
		surface.DrawRect(scrw - MOAT_STATUS.Config.w - MOAT_STATUS.Config.s, ypos, MOAT_STATUS.Config.w, MOAT_STATUS.Config.h)

		surface.SetDrawColor(status[4].r, status[4].g, status[4].b, 255)
		surface.DrawOutlinedRect(scrw - MOAT_STATUS.Config.w - MOAT_STATUS.Config.s, ypos, MOAT_STATUS.Config.w, MOAT_STATUS.Config.h)

		surface.SetDrawColor(0, 0, 0, 120)
		surface.DrawRect(scrw - MOAT_STATUS.Config.w - MOAT_STATUS.Config.s, ypos, MOAT_STATUS.Config.h, MOAT_STATUS.Config.h)

		--[[
			Showing Time Left
		]]

		local status_w = math.max((status[2] - CurTime())/status[6], 0) * (MOAT_STATUS.Config.w - 24)

		surface.SetDrawColor(status[4].r, status[4].g, status[4].b, 50)
		surface.DrawRect(scrw - MOAT_STATUS.Config.w - MOAT_STATUS.Config.s + 24, ypos, status_w, MOAT_STATUS.Config.h)

		surface.SetDrawColor(0, 0, 0, 120)
		surface.SetMaterial(gradient_r)
		surface.DrawTexturedRect(scrw - MOAT_STATUS.Config.w - MOAT_STATUS.Config.s + 24, ypos, status_w, MOAT_STATUS.Config.h)

		--------------------------

		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(status[3])
		surface.DrawTexturedRect(scrw - MOAT_STATUS.Config.w - MOAT_STATUS.Config.s + 4, ypos + 4, 16, 16)

		draw_SimpleTextOutlined(status[1], "GModNotify", scrw - MOAT_STATUS.Config.w + 20, ypos + 4, Color(status[4].r, status[4].g, status[4].b, 25), 0, 0, 0, Color(10, 10, 10, 0))
        draw_SimpleTextOutlined(status[1], "GModNotify", scrw - MOAT_STATUS.Config.w + 20, ypos + 4, Color(0, 0, 0, 175), 0, 0, 0, Color(10, 10, 10, 0))
        draw_SimpleTextOutlined(status[1], "GModNotify", scrw - MOAT_STATUS.Config.w + 19, ypos + 3, status[4], 0, 0, 0, Color(10, 10, 10, 0))

		ypos = ypos + MOAT_STATUS.Config.h + MOAT_STATUS.Config.s
	end
end
hook.Add("HUDPaint", "MOAT_STATUS.Draw", MOAT_STATUS.Draw)

net.Receive("moat.status.init", function()
	local status = {}
	status[1] = net.ReadString()

	local endtime = net.ReadUInt(16)
	
	status[2] = endtime
	status[3] = Material(net.ReadString())
	status[4] = net.ReadColor()
	status[5] = net.ReadString()
	status[6] = endtime - CurTime()
	
	table.insert(MOAT_STATUS.StatusList, status)
end)

net.Receive("moat.status.adjust", function()
	local id = net.ReadString()
	local new = net.ReadUInt(16)

	for i = 1, #MOAT_STATUS.StatusList do
		if (MOAT_STATUS.StatusList[i][5] == id) then
			MOAT_STATUS.StatusList[i][2] = CurTime() + new
			MOAT_STATUS.StatusList[i][6] = new
		end
	end
end)

net.Receive("moat.status.end", function()
	local id = net.ReadString()

	for k, v in ipairs(MOAT_STATUS.StatusList) do
		if (v[5] == id) then table.remove(MOAT_STATUS.StatusList, k) end
	end
end)

function MOAT_STATUS.Reset()
	MOAT_STATUS.StatusList = {}
end

net.Receive("moat.status.reset", MOAT_STATUS.Reset)
hook.Add("TTTEndRound", "moat.status.round.end", MOAT_STATUS.Reset)
hook.Add("TTTPrepareRound", "moat.status.round.begin", MOAT_STATUS.Reset)

concommand.Add("MOAT_STATUS_reset", function()
	MOAT_STATUS.Reset()
end)