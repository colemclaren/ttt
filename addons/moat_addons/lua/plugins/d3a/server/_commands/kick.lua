COMMAND.Name = "Kick"

COMMAND.Flag = D3A.Config.Commands.Kick
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}, {"string", "Reason"}}

COMMAND.Run = function(pl, args, supplement)
	local plname = D3A.Commands.Name(pl)
	
	local targ = supplement[1]
	local reason = table.concat(args, " ", 2)
	local targid = IsValid(targ) and targ:NameID() or "Unknown (???)"

	D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has kicked ", moat_green, targ:Name(), moat_white, ". Reason: ", moat_green, reason, moat_white, ".")
	targ:Kick("Kicked by " .. plname .. ": " .. reason)

	D3A.Commands.Discord("kick", D3A.Commands.NameID(pl), targid, reason)
end