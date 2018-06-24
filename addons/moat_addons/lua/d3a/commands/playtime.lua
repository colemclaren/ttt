COMMAND.Name = "Playtime"
COMMAND.Flag = D3A.Config.Commands.PlayTime
COMMAND.AdminMode = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)
	local datiem = supp[1]:GetDataVar("timePlayed")
	local id = supp[1]:SteamID64()

	local c = D3A.Time.Joins[id]
	if (c) then
		local add = math.max(1, SysTime() - c)
		add = math.Round(add) or 1
		
		datiem = datiem + add
	end

	D3A.Chat.SendToPlayer2(pl, moat_cyan, supp[1]:Name(), moat_white, " has played for ", moat_green, D3A.FormatTimeSingle(datiem), moat_white, ".")
end