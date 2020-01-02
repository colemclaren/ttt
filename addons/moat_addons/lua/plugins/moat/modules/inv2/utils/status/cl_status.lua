local gradient_r = Material("vgui/gradient-r")
MOAT_STATUS = MOAT_STATUS or {}
MOAT_STATUS.StatusList = MOAT_STATUS.StatusList or {}
MOAT_STATUS.Config = {
	w = 200,
	h = 24,
	s = 10
}

function MOAT_STATUS.Draw()
	if (#MOAT_STATUS.StatusList < 1) then return end

	local scrw, scrh = ScrW(), ScrH()
	for k, v in ipairs(MOAT_STATUS.StatusList) do
		if (v.EndTime <= CurTime()) then table.remove(MOAT_STATUS.StatusList, k) end
	end

	local amt = #MOAT_STATUS.StatusList
	local ypos = (scrh / 2) - (amt * ((MOAT_STATUS.Config.h + MOAT_STATUS.Config.s) / 2))

	for i = 1, amt do
		local status = MOAT_STATUS.StatusList[i]

		local col = status.Color

		surface.SetDrawColor(50, 50, 50, 50)
		surface.DrawRect(scrw - MOAT_STATUS.Config.w - MOAT_STATUS.Config.s, ypos, MOAT_STATUS.Config.w, MOAT_STATUS.Config.h)

		surface.SetDrawColor(50, 50, 50, 255)
		surface.DrawOutlinedRect(scrw - MOAT_STATUS.Config.w - MOAT_STATUS.Config.s, ypos, MOAT_STATUS.Config.w, MOAT_STATUS.Config.h)

		surface.SetDrawColor(0, 0, 0, 120)
		surface.DrawRect(scrw - MOAT_STATUS.Config.w - MOAT_STATUS.Config.s, ypos, MOAT_STATUS.Config.h, MOAT_STATUS.Config.h)

		--[[
		Showing Time Left
		]]

		local status_w = math.max((status.EndTime - CurTime()) / status.StartTime, 0) * (MOAT_STATUS.Config.w - 24)

		surface.SetDrawColor(col.r, col.g, col.b, 150)
		surface.DrawRect(scrw - MOAT_STATUS.Config.w - MOAT_STATUS.Config.s + 24, ypos + 1, status_w, MOAT_STATUS.Config.h - 2)

		surface.SetDrawColor(0, 0, 0, 120)
		surface.SetMaterial(gradient_r)
		surface.DrawTexturedRect(scrw - MOAT_STATUS.Config.w - MOAT_STATUS.Config.s + 24, ypos, status_w, MOAT_STATUS.Config.h)


		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(status.Material)
		surface.DrawTexturedRect(scrw - MOAT_STATUS.Config.w - MOAT_STATUS.Config.s + 4, ypos + 4, 16, 16)

		--draw.SimpleTextOutlined(status.Message, "GModNotify", scrw - MOAT_STATUS.Config.w + 20, ypos + 4, Color(col.r, col.g, col.b, 25), 0, 0, 0, Color(10, 10, 10, 0))
		--draw.SimpleTextOutlined(status.Message, "GModNotify", scrw - MOAT_STATUS.Config.w + 20, ypos + 4, Color(0, 0, 0, 175), 0, 0, 0, Color(10, 10, 10, 0))
		draw.SimpleTextOutlined(status.Message, "GModNotify", scrw - MOAT_STATUS.Config.w + 19, ypos + 3, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, color_black)

		ypos = ypos + MOAT_STATUS.Config.h + MOAT_STATUS.Config.s
	end
end
hook.Add("HUDPaint", "MOAT_STATUS.Draw", MOAT_STATUS.Draw)

net.Receive("moat.status.init", function()
	local status = {}

	status.Message = net.ReadString()
	status.EndTime = net.ReadFloat()
	status.Material = Material(net.ReadString())
	status.Color = net.ReadColor()
	status.ID = net.ReadString()
	status.StartTime = status.EndTime - net.ReadFloat()

	table.insert(MOAT_STATUS.StatusList, status)
end)


net.Receive("moat.status.adjust", function()
	local id = net.ReadString()
	local new = net.ReadFloat()
	local start = new - net.ReadFloat()

	for i = 1, #MOAT_STATUS.StatusList do
		if (MOAT_STATUS.StatusList[i].ID == id) then
			MOAT_STATUS.StatusList[i].EndTime = new
			MOAT_STATUS.StatusList[i].StartTime = start
		end
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
