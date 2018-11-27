COMMAND.Name = "Aslay"

COMMAND.Flag = "t"
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}, {"number", "Rounds/0 to Cancel"}, {"string", "Reason"}}

-- checkargs is automatic now

COMMAND.Run = function(pl, args, supplement)
	local plname = D3A.Commands.Name(pl)
	
	local targ = D3A.FindPlayer(args[1])
	local rounds = tonumber(args[2]) or 1
	local reason = table.concat(args, " ", 3)

	if ( #reason == 0 ) then reason = "Rule breaking :(" end

	Damagelog:SetSlays(pl, targ:SteamID(), rounds, reason, targ)
	
	if (rounds >= 1) then
		D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has added ", moat_green, tostring(rounds), moat_white, " autoslays to ", moat_green, targ:Name(), moat_white, " with the reason: ", moat_green, reason, moat_white, ".")
		D3A.Commands.Discord("aslay", D3A.Commands.NameID(pl), rounds, IsValid(targ) and targ:NameID() or "Unknown (???)", reason)
	else
		D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has removed the autoslays of ", moat_green, targ:Name(), moat_white, ".")
		D3A.Commands.Discord("removeslays", D3A.Commands.NameID(pl), IsValid(targ) and targ:NameID() or "Unknown (???)")
	end
end