net.Receive("Talents.BostonBasher", function()
	surface.PlaySound("vo/npc/male01/pain0" .. math.random(1, 9) .. ".wav")
end)