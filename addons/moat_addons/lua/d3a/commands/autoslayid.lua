COMMAND.Name = "Aslayid"

COMMAND.Flag = "t"
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"string", "SteamID"}, {"number", "Rounds/0 to Cancel"}, {"string", "Reason"}}

COMMAND.Run = function(pl, args, supplement)
	local plname = (pl:IsValid() and pl:Name()) or "Console"
	
	local targ = args[1]
	local rounds = tonumber(args[2]) or 1
	local reason = table.concat(args, " ", 3)

	if ( #reason == 0 ) then reason = "Rule breaking :(" end

	Damagelog:SetSlays(pl, targ, rounds, reason, false)
	
	if (rounds >= 1) then
		D3A.Chat.Broadcast2(moat_cyan, plname, moat_white, " has added ", moat_green, tostring(rounds), moat_white, " autoslays to ", moat_green, targ, moat_white, " with the reason: ", moat_green, reason, moat_white, ".")
	else
		D3A.Chat.Broadcast2(moat_cyan, plname, moat_white, " has removed the autoslays of ", moat_green, targ, moat_white, ".")
	end
end