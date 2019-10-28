COMMAND.Name = "Slay"

COMMAND.Flag = D3A.Config.Commands.Slay
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)

	if supp[1]:Alive() then supp[1]:Kill() end

	D3A.Chat.Broadcast2(moat_cyan, D3A.Commands.Name(pl), moat_white, " has slain ", moat_green, supp[1]:Name(), moat_white, ".")
	D3A.Commands.Discord("slay", D3A.Commands.NameID(pl), IsValid(supp[1]) and supp[1]:NameID())
end