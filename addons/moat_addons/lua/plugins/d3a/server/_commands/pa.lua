COMMAND.Name = "pa"

COMMAND.Flag = "t"

COMMAND.Args = {{"string", "Message"}}

COMMAND.Run = function(pl, args, supp)
	local msg = table.concat(args, " ", 1)

	D3A.Chat.Broadcast2(pl, moat_cyan, "[", moat_pink, (IsValid(pl) and not moat.is(pl)) and "STAFF" or "CONSOLE", moat_cyan, "]", moat_green, " " .. msg)
	D3A.Commands.Discord("pa", D3A.Commands.NameID(pl), msg)
end