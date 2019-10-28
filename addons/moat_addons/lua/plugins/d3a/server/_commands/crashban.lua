COMMAND.Name = "CrashBan"

COMMAND.Flag = D3A.Config.Commands.CrashBan
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}, {"string", "Reason"}}

COMMAND.Run = function(pl, args, supp)
	supp[1]:SendLua("while (true) do end")
	D3A.Chat.Broadcast2(pl, moat_cyan, D3A.Commands.Name(pl), moat_white, " has crashed ", moat_green, supp[1]:Name(), moat_white, ".")
	
	D3A.Commands.Stored["perma"].Run(pl, args, supp)
end