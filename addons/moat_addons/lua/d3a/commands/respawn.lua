COMMAND.Name = "Respawn"
COMMAND.Flag = D3A.Config.Commands.Respawn

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)
	supp[1]:Spawn()
	
	D3A.Chat.Broadcast2(moat_cyan, pl:NameID(), moat_white, " has respawned ", moat_green, supp[1]:NameID(), moat_white, ".")
end