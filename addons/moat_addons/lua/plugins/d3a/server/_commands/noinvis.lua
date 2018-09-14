COMMAND.Name = "Noinvis"

COMMAND.Flag = "a"

COMMAND.Args = {}

COMMAND.Run = function(pl, args, supp)
	BroadcastLua("LocalPlayer():ConCommand('record 1;stop')")

	D3A.Chat.Broadcast2(pl, moat_cyan, pl:Name(), moat_white, " has fixed any invisible players.")
	D3A.Commands.Discord("noinvis", (((pl and pl.rcon) or IsValid(pl)) and pl:NameID()) or D3A.Console)
end