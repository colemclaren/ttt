COMMAND.Name = "Ban"

COMMAND.Flag = "t"
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"string", "Name/SteamID"}, {"number", "length"}, {"string", "TimeUnit"}, {"string", "Reason"}}

COMMAND.Run = function(pl, args, supplement)
	local units = {}
		units["seconds"] = "second"
		units["minutes"] = "minute"
		units["hours"] = "hour"
		units["days"] = "day"
		units["weeks"] = "week"
		units["months"] = "month"
		units["years"] = "year"
		
	local unit = args[3]:lower()
	if (units[unit]) then unit = units[unit]
	elseif (!table.HasValue(units, unit)) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Invalid unit of time! Please use seconds/minutes/hours/days/weeks/months/years!")
		return
	end

	local plname = (pl:IsValid() and pl:Name()) or "Console"
	local plstid = (pl:IsValid() and pl:SteamID()) or "CONSOLE"
	
	local targ = args[1]:upper()
	local time = supplement[1]

	local units2 = {}
	units2["perm"] = 0
	units2["second"] = 1
	units2["minute"] = 60
	units2["hour"] = 3600
	units2["day"] = 86400
	units2["week"] = 604800
	units2["month"] = 2419200
	units2["year"] = 29030400
	local banlen = time * units2[unit]

	if (pl:IsValid() and pl:IsUserGroup("trialstaff") and banlen > 172800) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Trial Staff can only ban a maximum of 2 days!")
		return
	end
	
	local targpl = D3A.FindPlayer(targ)
	
	local targstid

	if (time == 0) then
		D3A.Commands.Parse(pl, "perma", {args[1], table.concat(args, " ", 4)})
		return
	end

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
			if (!pl:HasAccess("A")) then
				D3A.Chat.SendToPlayer2(pl, moat_red, targstid .. " is already banned (Administrator access required to update a ban)")
				return
			end
			
			local useunit = (time != 1 and unit .. "s") or unit
			local reason = table.concat(args, " ", 4)
			
			D3A.Bans.BanPlayer(targstid, plstid, time, unit, reason, Bans.Current.time, function()
				D3A.Chat.Broadcast2(moat_cyan, targstid .. "'s", moat_white, " ban was updated by ", moat_cyan, plname, moat_white, " to ", moat_green, time .. " " .. useunit, moat_white, ". Reason: ", moat_green, reason, moat_white, ".")
				local msg = "" .. ((targpl and targpl:Name()) or "N/A") .. " (" .. targstid .. ")'s *ban was updated* by " .. plname .. " (" .. plstid .. ") to " .. time .. " " .. useunit .. ". Reason: " .. reason .. "."
				SVDiscordRelay.SendToDiscordRaw("Ban bot",false,msg,"https://discordapp.com/api/webhooks/393120753593221130/bPZTXCj5fjQgHJCOKDPbUj4Btq5EtqkZSKV-ewwaLwESwZEEc7fBHBWuIbe8np2FG8Jn")
			end)
		else
			local useunit = (time != 1 and unit .. "s") or unit
			local reason = table.concat(args, " ", 4)
		
			D3A.Bans.BanPlayer(targstid, plstid, time, unit, reason, false, function()
				D3A.Chat.Broadcast2(moat_cyan, ((targpl and targpl:Name()) or targstid), moat_white, " was banned by ", moat_cyan, plname, moat_white, " for ", moat_green, time .. " " .. useunit, moat_white, ". Reason: ", moat_green, reason, moat_white, ".")
				local msg = "" .. ((targpl and targpl:Name()) or "N/A") .. " (" .. targstid .. ") was *banned* by " .. plname .. " (" .. plstid .. ") for " .. time .. " " .. useunit .. ". Reason: " .. reason .. "."
				SVDiscordRelay.SendToDiscordRaw("Ban bot",false,msg,"https://discordapp.com/api/webhooks/393120753593221130/bPZTXCj5fjQgHJCOKDPbUj4Btq5EtqkZSKV-ewwaLwESwZEEc7fBHBWuIbe8np2FG8Jn")
			end)
		end
	end)
end