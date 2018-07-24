COMMAND.Name = "Map"

COMMAND.Flag = "s"

COMMAND.Args = {{"string", "Map"}}

COMMAND.Run = function(pl, args, supp)
	if (args[1] and file.Exists("maps/" .. args[1] .. ".bsp", "GAME")) then
		local plname = (((pl and pl.rcon) or pl:IsValid()) and pl:Name()) or "Console"
		D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has changed the map to ", moat_green, args[1], moat_white, ".")

		timer.Simple(0.5, function() RunConsoleCommand( "changelevel", args[1] ) end)
	else
		D3A.Chat.SendToPlayer2(pl, moat_red, "Specified map not found!")
	end
end