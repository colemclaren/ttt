net.Receive("Talents.BostonBasher", function()
	surface.PlaySound("vo/npc/male01/pain0" .. math.random(1, 9) .. ".wav")
end)

net.Receive("Switch_wep_primary",function()
	local e = net.ReadEntity()
	e.Primary = net.ReadTable()
	if e:GetOwner() == LocalPlayer() then
		chat.AddText(Color(255,255,255),"Your weapon turned into a ",Color(0,255,0), e.PrintName,Color(255,255,255), "!")
	end
end)