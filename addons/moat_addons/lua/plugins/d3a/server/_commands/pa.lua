COMMAND.Name = "pa"

COMMAND.Flag = "t"

COMMAND.Args = {{"string", "Message"}}

COMMAND.Run = function(pl, args, supp)
	local plname = pl:Name()
	local msg = table.concat(args, " ", 1)

	D3A.Chat.Broadcast2(pl, moat_cyan, "[", moat_pink, "STAFF", moat_cyan, "]", moat_green, " " .. msg)
	D3A.Commands.Discord("pa", (((pl and pl.rcon) or IsValid(pl)) and pl:NameID()) or D3A.Console, msg)
end