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

	local plname = D3A.Commands.Name(pl)
	local plstid = (((pl and pl.rcon) or IsValid(pl)) and pl:SteamID()) or "CONSOLE"
	
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

	if (IsValid(pl) and pl:IsUserGroup("trialstaff") and banlen > 604800) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Trial Staff can only ban a maximum of 1 week!")
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

			local useunit = (time != 1 and unit .. "s") or unit
			local reason = table.concat(args, " ", 4)

			D3A.Bans.BanPlayer(targstid, plstid, time, unit, reason, Bans.Current.time, function()
				D3A.Chat.Broadcast2(pl, moat_cyan, targstid .. "'s", moat_white, " ban was updated by ", moat_cyan, plname, moat_white, " to ", moat_green, time .. " " .. useunit, moat_white, ". Reason: ", moat_green, reason, moat_white, ".")
				local msg = "" .. ((targpl and targpl:Name()) or "N/A") .. " (" .. targstid .. ")'s *ban was updated* by " .. plname .. " (" .. plstid .. ") to " .. time .. " " .. useunit .. ". Reason: " .. reason .. "."

				D3A.Commands.Discord("ban_update", (IsValid(targpl) and targpl:NameID()) or targstid, plname .. " (" .. plstid .. ")", time .. " " .. useunit, reason)
			end)
		else
			local useunit = (time != 1 and unit .. "s") or unit
			local reason = table.concat(args, " ", 4)

			D3A.Bans.BanPlayer(targstid, plstid, time, unit, reason, false, function()
				D3A.Chat.Broadcast2(pl, moat_cyan, ((targpl and targpl:Name()) or targstid), moat_white, " was banned by ", moat_cyan, plname, moat_white, " for ", moat_green, time .. " " .. useunit, moat_white, ". Reason: ", moat_green, reason, moat_white, ".")
				local msg = "" .. ((targpl and targpl:Name()) or "N/A") .. " (" .. targstid .. ") was *banned* by " .. plname .. " (" .. plstid .. ") for " .. time .. " " .. useunit .. ". Reason: " .. reason .. "."

				D3A.Commands.Discord("ban", (IsValid(targpl) and targpl:NameID()) or targstid, plname .. " (" .. plstid .. ")", time .. " " .. useunit, reason)
			end)
		end
	end)
end