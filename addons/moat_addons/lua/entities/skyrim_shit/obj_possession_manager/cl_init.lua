include('shared.lua')

local iHealth = 0
/*
net.Receive("slv_possessor_start",function(len)
	local class = net.ReadString()
	local name = language.GetPhrase("#" .. class)
	local iHealthMax = net.ReadUInt(20)
	iHealth = net.ReadUInt(20)
	hook.Add("HUDPaint","slv_possessor_hudpaint",function()
		local w, h = ScrW(), ScrH()
		surface.SetFont("default")//HLR_AUX_FONT1")
		local iSizeText = surface.GetTextSize(name)
		local iSizeHealthMax = iSizeText
		local iSizeHealthMin = w *0.05
		if iSizeHealthMax < iSizeHealthMin then iSizeHealthMax = iSizeHealthMin end
		local iSizeHealth = (iSizeHealthMax /iHealthMax) *iHealth
		iSizeHealth = iSizeHealth +w *0.00375
		iSizeHealthMax = iSizeHealthMax +w *0.00375
		local iSizeBoxBG = iSizeHealthMax +w *0.015
		
		draw.RoundedBox(8, w *0.5 -iSizeBoxBG *0.5, h *0.025, iSizeBoxBG, h *0.044166, Color(10,10,10,150))
		draw.SimpleText(name, "default", w *0.5, h *0.0425, Color(255,255,255,255), 1, 1)
		
		if iHealth <= 0 then return end
		draw.RoundedBox(4, w *0.5 -iSizeHealthMax *0.5, h *0.0525, iSizeHealthMax, h *0.008333, Color(10,10,10,200))
		draw.RoundedBox(4, w *0.5 -iSizeHealthMax *0.5, h *0.0525, iSizeHealth, h *0.008333, Color(255,20,20,255))
	end)
end)

net.Receive("slv_possessor_updatehp",function(len) iHealth = net.ReadUInt(20) end)

net.Receive("slv_possessor_end",function(len) hook.Remove("HUDPaint","slv_possessor_hudpaint") end)*/

function ENT:Draw()
end
