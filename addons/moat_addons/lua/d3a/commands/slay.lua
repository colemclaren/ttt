COMMAND.Name = "Slay"

COMMAND.Flag = D3A.Config.Commands.Slay
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)

	if supp[1]:Alive() then supp[1]:Kill() end

	D3A.Chat.Broadcast2(moat_cyan, pl:Name(), moat_white, " has slain ", moat_green, supp[1]:Name(), moat_white, ".")
end