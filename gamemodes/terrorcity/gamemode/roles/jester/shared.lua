if (CLIENT) then
	net.Receive("jester.killed", function()
		local nick1 = net.ReadString()

		chat.AddText(Material("icon16/information.png"), Color(253, 158, 255), nick1 .. " killed the jester!")
	end)
end