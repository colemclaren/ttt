net.Receive("MSE.Notify", function()
	local str = net.ReadString()

	chat.AddText(MSE.Colors.Blue, "| ", MSE.Colors.White, str)
end)