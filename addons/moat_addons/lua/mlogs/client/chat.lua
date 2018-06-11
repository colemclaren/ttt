mlogs.chat = mlogs.chat or {}

function mlogs.chat.read()
	local num = net.ReadUInt(8)
	if (num == 0) then return end
	local args = {}

	for i = 1, num do
		if (net.ReadBool()) then
			table.insert(args, net.ReadColor())
		else
			table.insert(args, net.ReadString())
		end
	end

	return args
end

mlogs:Receive("chat", function()
	local args = mlogs.chat.read()
	if (not args or not next(args)) then return end
	chat.AddText(mlogs.Colors.moat_blue, "| ", mlogs.Colors.moat_white, unpack(args))
end)