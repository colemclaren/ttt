COMMAND.Name = "Noinvis"

COMMAND.Flag = "a"

COMMAND.Args = {}

COMMAND.Run = function(pl, args, supp)
	BroadcastLua("LocalPlayer():ConCommand('record 1;stop')")

	D3A.Chat.Broadcast2(moat_cyan, pl:Name(), moat_white, " has fixed any invisible players.")
end