COMMAND.Name = "Kick"

COMMAND.Flag = D3A.Config.Commands.Kick
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}, {"string", "Reason"}}

COMMAND.Run = function(pl, args, supplement)
	local plname = (((pl and pl.rcon) or pl:IsValid()) and pl:Name()) or "Console"
	
	local targ = supplement[1]
	local reason = table.concat(args, " ", 2)
	
	D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has kicked ", moat_green, targ:Name(), moat_white, ". Reason: ", moat_green, reason, moat_white, ".")
	targ:Kick("Kicked by " .. plname .. ": " .. reason)
end