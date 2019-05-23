COMMAND.Name = "Warn"
COMMAND.Flag = "t"
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true
COMMAND.Args = {{"string", "Name/SteamID"}, {"string", "Reason"}}

COMMAND.Run = function(pl, args, supplement)
	local plname = D3A.Commands.Name(pl)
	local plstid64 = (((pl and pl.rcon) or IsValid(pl)) and pl:SteamID64()) or "0"
	local plstid = (((pl and pl.rcon) or IsValid(pl)) and pl:SteamID()) or "0"
	local targ = args[1]:upper()
	local targpl = supplement[1] or D3A.FindPlayer(targ)
	local targstid

	if (!targpl and string.sub(targ, 1, 8) != "STEAM_0:") then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Unknown player: " .. targ)
		return
	elseif (!targpl) then
		targstid = targ
	else
		targstid = targpl:SteamID()

		if (not moat.Ranks.CheckWeight(pl, targpl)) then
			D3A.Chat.SendToPlayer2(pl, moat_red, "Player's rank is equal or greater weight than yours!")
			return false
		end
	end

	if (((pl and pl.rcon) or IsValid(pl)) and (pl:SteamID() == targstid) and !pl:HasAccess("*")) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "You can't warn yourself.")
		return false
	end

	targstid = util.SteamIDTo64(targstid)

	local reason = table.concat(args, " ", 2)
	D3A.NewWarning(targstid, plstid64, targpl and targpl:Name() or "John Doe", plname, reason, function()
		D3A.Chat.Broadcast2(pl, moat_cyan, ((targpl and targpl:Name()) or targstid), moat_white, " was warned by ", moat_cyan, plname, moat_white, ". Reason: ", moat_green, reason, moat_white, ".")

		if (IsValid(targpl)) then
			D3A.WarnPlayer(targpl)
		end

		D3A.Commands.Discord("warn", (IsValid(targpl) and targpl:NameID()) or targstid, plname .. " (" .. plstid .. ")", reason)
	end)
end