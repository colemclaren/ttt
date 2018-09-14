COMMAND.Name = "Removeslays"

COMMAND.Flag = "t"
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supplement)
	local plname = (((pl and pl.rcon) or IsValid(pl)) and pl:Name()) or "Console"
	
	local targ = supplement[1]

	Damagelog:SetSlays(pl, targ:SteamID(), 0, "gay", targ)

	D3A.Chat.Broadcast2(pl, moat_cyan, plname, moat_white, " has removed the autoslays of ", moat_green, targ:Name(), moat_white, ".")
	D3A.Commands.Discord("removeslays", (((pl and pl.rcon) or IsValid(pl)) and pl:NameID()) or D3A.Console, IsValid(targ) and targ:NameID() or "Unknown (???)")
end