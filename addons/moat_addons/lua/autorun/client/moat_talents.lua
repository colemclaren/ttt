net.Receive("Talents.BostonBasher", function()
	surface.PlaySound("vo/npc/male01/pain0" .. math.random(1, 9) .. ".wav")
end)

net.Receive("Switch_wep_primary",function()
	local e = net.ReadEntity()
	local new_primary = net.ReadTable()
	local old_primary = e.Primary
	e.Primary = new_primary
	local n = net.ReadEntity()
	e.PrintName = "Copied " .. (n.PrintName or e.PrintName)
	if e:GetOwner() == LocalPlayer() then
		old_primary.Damage = math.Round(old_primary.Damage)
		new_primary.Damage = math.Round(new_primary.Damage)
		surface.PlaySound("Resource/warning.wav")
		chat.AddText(Color(255,255,255),"Your weapon turned into a ",Color(0,255,0), e.PrintName,Color(255,255,255), ", with ",Color(255,0,0),tostring(new_primary.Damage)," (",tostring(old_primary.Damage),"+",tostring(new_primary.Damage - old_primary.Damage),") DMG",Color(255,255,255)," and ",Color(255,0,0),tostring(net.ReadInt(8)),Color(255,255,255),"  active talents!")
	end
end)