COMMAND.Name = "Perma"

COMMAND.Flag = "t"
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"string", "Name/SteamID"}, {"string", "Reason"}}

COMMAND.Run = function(pl, args, supplement)
	local plname = (pl:IsValid() and pl:Name()) or "Console"
	local plstid = (pl:IsValid() and pl:SteamID()) or "CONSOLE"

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
		
		if (!D3A.Ranks.CheckWeight(pl, targpl)) then
			D3A.Chat.SendToPlayer2(pl, moat_red, "Player's rank is equal or greater weight than yours!")
			D3A.Chat.SendToPlayer2(targpl, moat_red, plname .. " (" .. plstid .. ") attempted to use Ban on you.")
			return false
		end
	end
	
	D3A.Bans.GetBans(targstid, function(Bans)
		if (Bans.Current) then
			if (!pl:HasAccess("S")) then
				D3A.Chat.SendToPlayer2(pl, moat_red, targstid .. " is already banned ('S' access required to update a ban)")
				return
			end

			local reason = table.concat(args, " ", 2)
			
			D3A.Bans.BanPlayer(targstid, plstid, 1, "perm", reason, Bans.Current.time, function()
				D3A.Chat.Broadcast2(moat_cyan, targstid .. "'s", moat_white, " ban was updated by ", moat_cyan, plname, moat_white, " to ", moat_green, "permanent", moat_white, ". Reason: ", moat_green, reason, moat_white, ".")
				local msg = "" .. ((targpl and targpl:Name()) or "N/A") .. " (" .. targstid .. ")'s *ban was updated* by " .. plname .. " (" .. plstid .. ") to permanent. Reason: " .. reason .. "."
				SVDiscordRelay.SendToDiscordRaw("Ban bot",false,msg,"https://discordapp.com/api/webhooks/393120753593221130/bPZTXCj5fjQgHJCOKDPbUj4Btq5EtqkZSKV-ewwaLwESwZEEc7fBHBWuIbe8np2FG8Jn")
			end)
		else
			local reason = table.concat(args, " ", 2)
		
			D3A.Bans.BanPlayer(targstid, plstid, 1, "perm", reason, false, function()
				D3A.Chat.Broadcast2(moat_cyan, ((targpl and targpl:Name()) or targstid), moat_white, " was banned permanently by ", moat_cyan, plname, moat_white, ". Reason: ", moat_green, reason, moat_white, ".")
				local msg = "" .. ((targpl and targpl:Name()) or "N/A") .. " (" .. targstid .. ") was *banned permanently* by " .. plname .. " (" .. plstid .. "). Reason: " .. reason .. "."
				SVDiscordRelay.SendToDiscordRaw("Ban bot",false,msg,"https://discordapp.com/api/webhooks/393120753593221130/bPZTXCj5fjQgHJCOKDPbUj4Btq5EtqkZSKV-ewwaLwESwZEEc7fBHBWuIbe8np2FG8Jn")
			end)
		end
	end)
end
