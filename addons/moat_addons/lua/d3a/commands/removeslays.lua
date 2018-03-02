COMMAND.Name = "Removeslays"

COMMAND.Flag = "t"
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supplement)
	local plname = (pl:IsValid() and pl:Name()) or "Console"
	
	local targ = supplement[1]

	Damagelog:SetSlays(pl, targ:SteamID(), 0, "gay", targ)

	D3A.Chat.Broadcast2(moat_cyan, plname, moat_white, " has removed the autoslays of ", moat_green, targ:Name(), moat_white, ".")
end