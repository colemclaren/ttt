COMMAND.Name = "ClearDecals"
COMMAND.Flag = D3A.Config.Commands.ClearDecals

COMMAND.Run = function(pl, args, supp)
	BroadcastLua("LocalPlayer():ConCommand('r_cleardecals')")

	D3A.Chat.Broadcast2(pl, moat_cyan, D3A.Commands.Name(pl), moat_white, " has cleared decals.")
	D3A.Commands.Discord("cleardecals", D3A.Commands.NameID(pl))
end