COMMAND.Name = "Luacl"

COMMAND.Flag = "*"

COMMAND.Args = {{"player", "Name/SteamID"}, {"string", "Lua"}}

COMMAND.Run = function(pl, args, supp)
	local da_lua = table.concat(args, " ", 2)

	D3A.Chat.SendToPlayer2(pl, moat_cyan, "You ", moat_white, "ran Lua on ", moat_green, supp[1]:Name(), moat_white, ": " .. da_lua)

	net.Start("D3A.LuaRunCL")
	net.WriteString(da_lua)
	net.Send(supp[1])
end

util.AddNetworkString("D3A.LuaRunCL")