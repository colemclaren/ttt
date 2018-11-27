COMMAND.Name = "ForceMOTD"

COMMAND.Flag = D3A.Config.Commands.ForceMoTD
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)
	supp[1]:SendLua("D3A.OpenMoTD()")
	D3A.Chat.Broadcast2(pl, moat_cyan, D3A.Commands.Name(pl), moat_white, " has forced the MOTD to open on ", moat_green, supp[1]:Name(), moat_white, ".")
	D3A.Commands.Discord("forcemotd", D3A.Commands.NameID(pl), IsValid(supp[1]) and supp[1]:NameID())
end