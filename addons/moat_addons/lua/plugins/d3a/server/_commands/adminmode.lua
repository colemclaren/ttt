COMMAND.Name = "AdminMode"

COMMAND.AdminMode = true
COMMAND.Flag = "t"

COMMAND.Args = {}

COMMAND.Run = function(pl, args, supp)
	local pid = (((pl and pl.rcon) or IsValid(pl)) and pl:SteamID64()) or "0"
	if (IsValid(pl) and pl:GetNW2Bool("adminmode", false)) then
		D3A.Chat.SendToPlayer2(pl, moat_cyan, "You", moat_white, " have ", moat_green, "disabled", moat_white, " admin mode. Rank is now public.")
		Db("UPDATE player SET rank_expire = NULL WHERE steam_id = ?;", pid)
		pl:SetNW2Bool("adminmode", false)
	elseif (IsValid(pl)) then
		D3A.Chat.SendToPlayer2(pl, moat_cyan, "You", moat_white, " have ", moat_green, "enabled", moat_white, " admin mode. Rank is now private.")
		Db("UPDATE player SET rank_expire = 0 WHERE steam_id = ?;", pid)
		pl:SetNW2Bool("adminmode", true)
	end
end