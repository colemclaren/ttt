COMMAND.Name = "Noinvis"

COMMAND.Flag = "a"

COMMAND.Args = {}

COMMAND.Run = function(pl, args, supp)
	BroadcastLua("LocalPlayer():ConCommand('record 1;stop')")

	D3A.Chat.Broadcast2(pl, moat_cyan, D3A.Commands.Name(pl), moat_white, " has fixed any invisible players.")
	D3A.Commands.Discord("noinvis", D3A.Commands.NameID(pl))
end