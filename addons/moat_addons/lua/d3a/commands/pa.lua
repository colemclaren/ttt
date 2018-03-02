COMMAND.Name = "pa"

COMMAND.Flag = "t"

COMMAND.Args = {{"string", "Message"}}

COMMAND.Run = function(pl, args, supp)
	local plname = pl:Name()
	local msg = table.concat(args, " ", 1)

	D3A.Chat.Broadcast2(moat_cyan, "[", moat_pink, "STAFF", moat_cyan, "]", moat_green, " " .. msg)
end