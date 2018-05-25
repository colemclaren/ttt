COMMAND.Name = "Rcon"
COMMAND.Flag = "*"
COMMAND.Args = {{"string", "Command"}}
COMMAND.skipArgParsing = true

COMMAND.Run = function(pl, args, supp)
	local da_cmd = table.concat(args, " ", 1)

	game.ConsoleCommand(da_cmd .. "\n")
	D3A.Chat.SendToPlayer2(pl, moat_red, "Ran RCON: ", moat_white, da_cmd)
end