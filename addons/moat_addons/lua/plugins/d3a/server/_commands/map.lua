COMMAND.Name = "Map"
COMMAND.CheckRankWeight = true
COMMAND.Args = {{"string", "Map"}}
COMMAND.Flag = D3A.Config.Commands.PlayTime

COMMAND.Run = function(pl, args, supp)
	local map_req = table.concat(args, " ", 1):lower()

	if (not map_req:StartWith("ttt_")) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "You can only use ttt_ maps for this gamemode! Sorry!")
		return
	end

	if (not MapVote.MapAvailable(map_req)) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "The map name " .. map_req .. " doesn't exist!")
		return
	end

	local playing = 0
	for k, v in ipairs(player.GetAll()) do
		if (v:GetInfoNum("ttt_spectator_mode", 1) == 0) then
			playing = playing + 1
		end
	end

	if ((pl and not pl.rcon) and pl:IsPlayer() and not pl:HasAccess(D3A.Config.Commands.Reload) and playing > 1) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "You can only change the map if there's nobody else active! Sorry!")
		return
	end

	local plname = D3A.Commands.Name(pl)
	D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has changed the map to ", moat_green, args[1], moat_white, ".")
	D3A.Commands.Discord("map", D3A.Commands.NameID(pl), args[1])

	timer.Simple(0.5, function() RunConsoleCommand( "changelevel", args[1] ) end)
end