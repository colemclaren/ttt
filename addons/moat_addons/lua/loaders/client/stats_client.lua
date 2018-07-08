net.Receive("MOAT_EASTER_GIVEAWAY", function()
	local str = net.ReadString()
	local amt = net.ReadUInt(8)

	local strs = "s"
	if (amt == 1) then
		strs = ""
	end

	chat.AddText(Material("icon16/star.png"), Color(255, 255, 0), str .. " ", Color(0, 255, 255), "has received " .. amt .. " easter egg" .. strs .. " for entering the 2017 easter giveaway! Thanks for entering cutie!")
end) 