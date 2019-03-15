COMMAND.Name = "Perma"

COMMAND.Flag = "m"
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"string", "Name/SteamID"}, {"string", "Reason"}}

COMMAND.Run = function(pl, args, supplement)
	local plname = D3A.Commands.Name(pl)
	local plstid = (((pl and pl.rcon) or IsValid(pl)) and pl:SteamID()) or "CONSOLE"

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
			D3A.Chat.SendToPlayer2(targpl, moat_red, plname .. " (" .. plstid .. ") attempted to use Ban on you.")
			return false
		end
	end

	if (((pl and pl.rcon) or IsValid(pl)) and (pl:SteamID() == targstid) and !pl:HasAccess("*")) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "You can't ban yourself.")
		return false
	end

	D3A.Bans.IsBanned(targstid, function(Banned, Bans)
		if (Banned and Bans.Current) then
			if (IsValid(pl) and !pl:HasAccess("A")) then
				D3A.Chat.SendToPlayer2(pl, moat_red, targstid .. " is already banned (Administrator access required to update a ban)")
				return
			end

			local reason = table.concat(args, " ", 2)
			
			D3A.Bans.BanPlayer(targstid, plstid, 1, "perm", reason, Bans.Current.time, function()
				D3A.Chat.Broadcast2(pl, moat_cyan, targstid .. "'s", moat_white, " ban was updated by ", moat_cyan, plname, moat_white, " to ", moat_green, "permanent", moat_white, ". Reason: ", moat_green, reason, moat_white, ".")
				local msg = "" .. ((targpl and targpl:Name()) or "N/A") .. " (" .. targstid .. ")'s *ban was updated* by " .. plname .. " (" .. plstid .. ") to permanent. Reason: " .. reason .. "."

				D3A.Commands.Discord("ban_update", (IsValid(targpl) and targpl:NameID()) or targstid, plname .. " (" .. plstid .. ")", "permanent", reason)
			end)
		else
			local reason = table.concat(args, " ", 2)
		
			D3A.Bans.BanPlayer(targstid, plstid, 1, "perm", reason, false, function()
				D3A.Chat.Broadcast2(pl, moat_cyan, ((targpl and targpl:Name()) or targstid), moat_white, " was banned permanently by ", moat_cyan, plname, moat_white, ". Reason: ", moat_green, reason, moat_white, ".")
				local msg = "" .. ((targpl and targpl:Name()) or "N/A") .. " (" .. targstid .. ") was *banned permanently* by " .. plname .. " (" .. plstid .. "). Reason: " .. reason .. "."
				
				D3A.Commands.Discord("ban", (IsValid(targpl) and targpl:NameID()) or targstid, plname .. " (" .. plstid .. ")", "permanent", reason)
			end)
		end
	end)
end
