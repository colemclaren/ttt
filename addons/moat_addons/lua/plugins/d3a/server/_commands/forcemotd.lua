COMMAND.Name = "ForceMOTD"

COMMAND.Flag = "t"
COMMAND.AdminMode = true
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"player", "Name/SteamID"}, {"number", "length", 0}, {"string", "TimeUnit", "seconds"}}

COMMAND.CheckArgs = function(pl, cmd, args)
	local margs = cmd.Args
	local err
	local supp = {}

	if ((pl and not pl.rcon) and pl:IsPlayer() and !pl:HasAccess(cmd.Flag)) then
		err = "'" .. cmd.Flag .. "' access required!"
	end

	if (!err) then
		for k, v in pairs(margs) do
			if (!args[k]) then
				if (v[3]) then
					table.insert(supp, tonumber(args[k]))
				else
					err = "_"
					break
				end
			end
			
			if (v[1] == "number") then
				if (tostring(tonumber(args[k])) != args[k]) then
					err = "_"
					break
				else
					table.insert(supp, tonumber(args[k]))
				end
			elseif (v[1] == "player") then
				local targ = D3A.FindPlayer(args[k])
				if (targ) then
					if (cmd.CheckRankWeight and not moat.Ranks.CheckWeight(pl, targ)) then
						err = "Player's rank is equal or greater weight than yours!"
						D3A.Chat.SendToPlayer2(targ, moat_red, pl:Name() .. " (" .. pl:SteamID() .. ") attempted to use " .. cmd.Name .. " on you.")
						break
					end
					table.insert(supp, targ)
				else err = "Unknown player " .. args[k] .. "." break end
			elseif (v[1] == "string") then
				args[k] = tostring(args[k])
			end
		end
	end
	
	if (err) then
		if (err == "_") then
			err = "Usage: " .. cmd.Name .. " "
			for k, v in pairs(margs) do
				err = err .. "[" .. v[1] .. ":" .. v[2] .. "] "
			end
		end

		D3A.Chat.SendToPlayer2(pl, moat_red, err)
		return false
	end
	
	return supp
end

COMMAND.Run = function(pl, args, supplement)
	local units = {
		["seconds"] = "second",
		["minutes"] = "minute",
		["hours"] = "hour",
		["days"] = "day",
		["weeks"] = "week",
		["months"] = "month",
		["years"] = "year"
	}
		
	local unit = args[3]:lower()
	if (units[unit]) then unit = units[unit]
	elseif (!table.HasValue(units, unit)) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Invalid unit of time! Please use seconds / minutes / hours / days / weeks / months / years.")
		return
	end

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

			return D3A.Chat.SendToPlayer2(targpl, moat_red, plname .. " (" .. plstid .. ") attempted to use Force MOTD on you.")
		end
	end

	local units2 = {
		["perm"] = 0,
		["second"] = 1,
		["minute"] = 60,
		["hour"] = 3600,
		["day"] = 86400,
		["week"] = 604800,
		["month"] = 2419200,
		["year"] = 29030400
	}

	local len = (((pl and pl.rcon) or IsValid(pl)) and ((pl:SteamID() == targstid and pl:HasAccess("*")) or pl:SteamID() ~= targstid)) and time * units2[unit] or 0
	if (IsValid(pl) and (len > 600 or len < 1) and not pl:HasAccess("*")) then
		return D3A.Chat.SendToPlayer2(pl, moat_red, "Staff can only force the motd for 10 minutes!")
	else
		D3A.Chat.Broadcast2(pl, moat_cyan, string ("Prof. ", D3A.Commands.Name(pl), " "), 
			moat_white, "rewarded ", moat_green, targpl:Name() .. " ", 
			moat_white, "with an motd for ", moat_green, string (time, " ", (time != 1 and unit .. "s") or unit, ""), moat_white, ".")

		D3A.Commands.Discord("forcemotd", D3A.Commands.NameID(pl), IsValid(targpl) and targpl:NameID(), time .. " " .. (time ~= 1 and unit .. "s" or unit))

		return net.Do("motd", function() net.WriteInt(len, 32) end, targpl)
	end
end

util.AddNetworkString "motd"
hook("ShowSpare1", function(ply)
	net.Do("motd", function() net.WriteInt(0, 32) end, ply)
end)