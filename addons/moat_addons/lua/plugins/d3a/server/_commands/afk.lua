COMMAND.Name = "afk"

COMMAND.Flag = "t"
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)
	supp[1]:ConCommand("ttt_spectator_mode 1")

	D3A.Chat.Broadcast2(pl, moat_cyan, pl:Name(), moat_white, " has afk'd ", moat_green, supp[1]:Name(), moat_white, ".")
	D3A.Commands.Discord("afk", (((pl and pl.rcon) or IsValid(pl)) and pl:NameID()) or D3A.Console, IsValid(supp[1]) and supp[1]:NameID())
end