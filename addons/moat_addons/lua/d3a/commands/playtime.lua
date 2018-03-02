COMMAND.Name = "Playtime"
COMMAND.Flag = D3A.Config.Commands.PlayTime
COMMAND.AdminMode = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)
	local datiem = supp[1]:GetDataVar("timePlayed")

	D3A.Chat.SendToPlayer2(pl, moat_cyan, supp[1]:Name(), moat_white, " has played for ", moat_green, D3A.FormatTimeSingle(datiem), moat_white, ".")
end