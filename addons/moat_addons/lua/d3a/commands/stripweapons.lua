COMMAND.Name = "StripWeapons"
COMMAND.Flag = D3A.Config.Commands.StripWeps

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)
	supp[1]:StripWeapons()
	supp[1]:StripAmmo()
	
	D3A.Chat.Broadcast2(moat_cyan, pl:NameID(), moat_white, " has stripped ", moat_green, supp[1]:NameID() .. "'s", moat_white, " weapons.")
end