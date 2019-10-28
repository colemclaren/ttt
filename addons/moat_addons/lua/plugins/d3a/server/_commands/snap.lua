COMMAND.Name = "snap"

COMMAND.Flag = "t"
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)
	snapper.snap(pl, supp[1], 70)

	D3A.Chat.BroadcastStaff2(moat_cyan, D3A.Commands.Name(pl), moat_white," has initiated snap on ", moat_green, supp[1]:Name(), moat_white, ".")
end