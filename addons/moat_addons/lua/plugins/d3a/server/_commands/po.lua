COMMAND.Name = "PO"

COMMAND.Flag = D3A.Config.Commands.PO
COMMAND.AdminMode = true

COMMAND.Args = {{"string", "SteamID"}}

local function PrintBans(pl, sid, Bans, Warns)
	local full_str = (pl.Nick and pl:Nick() or "CONSOLE") .. " (" .. (pl.SteamID and pl:SteamID() or "CONSOLE") .. ") got past offences for " .. sid .. "\n```\n"
	local function dump(str)
		full_str = full_str .. str .. "\n"
		if (IsValid(pl)) then
			pl:PrintMessage(HUD_PRINTCONSOLE, str)
		end
	end

	dump("Past Offences for: " .. sid)
	dump("---------------------------")
	dump(" - " .. #Bans.Active .. " Active Ban(s)")
	dump(" - " .. #Bans.Recent .. " Recent Ban(s)")
	dump(" - " .. #Bans.Past .. " Past Ban(s)")
	dump(" - " .. #Bans.Unbanned .. " Removed Ban(s)")
	dump("---")
	dump(" = " .. Bans.Count .. " Total Ban(s)")
	dump("---------------------------")

	if (Bans.Active and Bans.Active[1]) then
		dump("Active Ban(s) - Player you just looked up is currently banned at this time")
		dump("---------------------------")

		for i = 1, #Bans.Active do
			local b = Bans.Active[i]

			dump("#" .. i .. " on " .. b.time_date .. " :")
			dump("    " .. b.name .. " was banned by " .. b.staff_name .. " (" .. util.SteamIDFrom64(b.staff_steam_id) .. ") for " ..
				(b.length == 0 and "Forever." or (util.FormatTimeSingle(b.length) .. ".")) .. " Reason: " .. b.reason .. ".")
			dump("    Ban will be automatically lifted in approx. " .. util.FormatTimeSingle(b.length + b.time - os.time()) .. ".")
		end

		dump("---------------------------")
	end

	if (Bans.Recent and Bans.Recent[1]) then
		dump("Recent Ban(s) - Players may be penalized for repeat offenses until a ban expires (60 days)")
		dump("---------------------------")

		for i = 1, #Bans.Recent do
			local b = Bans.Recent[i]

			dump("#" .. i .. " on " .. b.time_date)
			dump("    " .. b.name .. " was banned by " .. b.staff_name .. " (" .. util.SteamIDFrom64(b.staff_steam_id) .. ") for " .. 
				(b.length == 0 and "Forever." or (util.FormatTimeSingle(b.length) .. ".")) .. " Reason: " .. b.reason .. ".")
		end

		dump("---------------------------")
	end

	if (Bans.Past and Bans.Past[1]) then
		dump("Past Ban(s) - Player bans you should NOT count as a repeat offense bcuz they're expired")
		dump("---------------------------")

		for i = 1, #Bans.Past do
			local b = Bans.Past[i]

			dump("#" .. i .. " on " .. b.time_date)
			dump("    " .. b.name .. " was banned by " .. b.staff_name .. " (" .. util.SteamIDFrom64(b.staff_steam_id) .. ") for " .. 
				(b.length == 0 and "Forever." or (util.FormatTimeSingle(b.length) .. ".")) .. " Reason: " .. b.reason .. ".")
		end

		dump("---------------------------")
	end

	if (Bans.Unbanned and Bans.Unbanned[1]) then
		dump("Removed Ban(s) - Player was unbanned for these so they dont rly mean anything 90% of the time")
		dump("---------------------------")

		for i = 1, #Bans.Unbanned do
			local b = Bans.Unbanned[i]

			dump("#" .. i .. " on " .. b.time_date)
			dump("    " .. b.name .. " was banned by " .. b.staff_name .. " (" .. util.SteamIDFrom64(b.staff_steam_id) .. ") for " ..
				(b.length == 0 and "Forever." or (util.FormatTimeSingle(b.length) .. ".")) .. " Reason: " .. b.reason .. ".")
			dump("    Unban Reason: " .. b.unban_reason .. ".")
		end
	end

	
	dump("---------------------------")
	dump("All Warns for: " .. sid)
	dump(" - " .. #Warns .. " Total Warn(s)")
	dump("---------------------------")

	table.sort(Warns, function(a,b) return a.time > b.time end)

	for i, warn in ipairs(Warns) do
		dump("#" .. i .. " on " .. warn.time_date)
		dump("    Warned by " .. warn.staff_name .. ". Reason: " .. warn.reason)
	end

	if (IsValid(pl)) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Check Console")
	else
		local msg = string.sub(full_str, 1, 1900)
		if (msg ~= full_str) then
			msg = msg .. "\n```\nMessage was cut off by discord. Please go in-game to view the full po (if u need it)."
		else
			msg = msg .. "\n```"
		end

		discord.Send("Past Offences", msg)
		D3A.Chat.SendToPlayer2(pl, moat_red, "Check #staff-logs")
	end
end

COMMAND.Run = function(pl, args, supp)
	local sid = tostring(args[1]):upper()

	if (string.sub(sid, 1, 8) != "STEAM_0:") then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Please input a SteamID!")
		return
	end

	local Bans, Warns

	local function check_ready()
		if (not Warns or not Bans) then
			print "not ready yet"
			return
		end

		PrintBans(pl, sid, Bans, Warns)
	end

	D3A.Warns.Get(sid, function(warns)
		Warns = warns or {}

		check_ready()
	end)

	D3A.Bans.Get(sid, false, 1, 50, function(bans)
		Bans = bans
		check_ready()
	end)
end