COMMAND.Name = "Respawn"
COMMAND.Flag = D3A.Config.Commands.Respawn

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)
	supp[1]:Spawn()
	
	D3A.Chat.Broadcast2(pl, moat_cyan, D3A.Commands.NameID(pl), moat_white, " has respawned ", moat_green, supp[1]:NameID(), moat_white, ".")
end