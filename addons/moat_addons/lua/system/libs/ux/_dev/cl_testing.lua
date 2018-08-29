if (IsValid(UX_TEST)) then UX_TEST:Remove() end
UX_TEST = ux.Create("DFrame", function(pnl)
	pnl:SetPos(300, 300)
	pnl:size(500, 500)
	pnl:MakePopup()
end, {Paint = function(s, w, h)
	ux.blur(s, 3)
	local mat = Material("data/moat_assets/2173269432.png")

	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(mat)
	surface.DrawTexturedRect(0, 0, mat:Width(), mat:Height())
end})