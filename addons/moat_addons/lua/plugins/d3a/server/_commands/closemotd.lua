COMMAND.Name = "CloseMOTD"

COMMAND.Flag = "t"
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supplement)
	local plname = D3A.Commands.Name(pl)
	local plstid = (((pl and pl.rcon) or IsValid(pl)) and pl:SteamID()) or "CONSOLE"

	local targ = args[1]:upper()
	local time = supplement[2]

	local targpl, targstid = D3A.FindPlayer(targ)
	if (not targpl and string.sub(targ, 1, 8) != "STEAM_0:") then
		return D3A.Chat.SendToPlayer2(pl, moat_red, "Unknown player: " .. targ)
	elseif (not targpl) then
		targstid = targ
	else
		targstid = targpl:SteamID()

		if (not moat.Ranks.CheckWeight(pl, targpl)) then
			D3A.Chat.SendToPlayer2(pl, moat_red, "Player's rank is equal or greater weight than yours!")

			return D3A.Chat.SendToPlayer2(targpl, moat_red, plname .. " (" .. plstid .. ") attempted to use Close MOTD on you.")
		end
	end

	D3A.Chat.SendToPlayer2(targpl, moat_red, string (D3A.Commands.Name(pl) .. " closed your motd."))
	D3A.Chat.SendToPlayer2(pl, moat_red, string ("You closed the motd for " .. D3A.Commands.Name(targpl) .. "."))

	D3A.Commands.Discord("closemotd", D3A.Commands.NameID(pl), IsValid(targpl) and targpl:NameID())

	return net.Do("motd", function() net.WriteInt(-1, 32) end, targpl)
end