COMMAND.Name = "Removeslays"

COMMAND.Flag = "t"
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supplement)
	local plname = D3A.Commands.Name(pl)
	
	local targ = supplement[1]

	Damagelog:SetSlays(pl, targ:SteamID(), 0, "gay", targ)

	D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has removed the autoslays of ", moat_green, targ:Name(), moat_white, ".")
	D3A.Commands.Discord("removeslays", D3A.Commands.NameID(pl), IsValid(targ) and targ:NameID() or "Unknown (???)")
end