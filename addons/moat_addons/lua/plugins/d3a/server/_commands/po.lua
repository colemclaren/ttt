COMMAND.Name = "PO"

COMMAND.Flag = D3A.Config.Commands.PO
COMMAND.AdminMode = true

COMMAND.Args = {{"string", "SteamID"}}

COMMAND.Run = function(pl, args, supp)
	local sid = tostring(args[1]):upper()

	if (string.sub(sid, 1, 8) != "STEAM_0:") then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Please input a SteamID!")
		return
	end

	local Bans, Warns

	local function PrintBans(pl, sid, Bans, Warns)
		local full_str = (pl.Nick and pl:Nick() or "CONSOLE") .. " (" .. (pl.SteamID and pl:SteamID() or "CONSOLE") .. ") got past offences for " .. sid .. "\n```\n"
		local function dump(str, clr)
			full_str = full_str .. str .. "\n"
			if (IsValid(pl)) then
				D3A.Chat.SendToPlayer2(pl, clr or moat_red, str)
				--  pl:PrintMessage(HUD_PRINTCONSOLE, str)
			else
				MsgC(moat_red, str .. "\n")
			end
		end

		dump("Past Offences for: " .. sid, moat_green)
		dump("---------------------------", moat_blue)
		dump(" - " .. #Bans.Active .. " Active Ban(s)", #Bans.Active == 0 and moat_cyan or moat_red)
		dump(" - " .. #Bans.Recent .. " Recent Ban(s)", #Bans.Recent == 0 and moat_yellow or moat_orange)
		dump(" - " .. #Bans.Past .. " Past Ban(s)",  moat_purple)
		dump(" - " .. #Bans.Unbanned .. " Removed Ban(s)", moat_pink)
		dump("---", moat_blue)
		dump(" = " .. Bans.Count .. " Total Ban(s)", moat_green)
		dump("---------------------------", moat_blue)

		if (Bans.Active and Bans.Active[1]) then
			dump("Active Ban(s) - Player you just looked up is currently banned at this time", moat_cyan)
			dump("---------------------------", moat_blue)

			for i = 1, #Bans.Active do
				local b = Bans.Active[i]

				dump("#" .. i .. " on " .. b.time_date .. " :", #Bans.Active == 0 and moat_cyan or moat_red)
				dump("    " .. b.name .. " was banned by " .. b.staff_name .. " (" .. util.SteamIDFrom64(b.staff_steam_id) .. ") for " ..
					(b.length == 0 and "Forever." or (util.FormatTimeSingle(b.length) .. ".")) .. " Reason: " .. b.reason .. ".")
				dump("    Ban will be automatically lifted in approx. " .. util.FormatTimeSingle(b.length + b.time - os.time()) .. ".", moat_green)
			end

			dump("---------------------------", moat_blue)
		end

		if (Bans.Recent and Bans.Recent[1]) then
			dump("Recent Ban(s) - Players may be penalized for repeat offenses until a ban expires (60 days)", #Bans.Recent == 0 and moat_yellow or moat_orange)
			dump("---------------------------", moat_blue)

			for i = 1, #Bans.Recent do
				local b = Bans.Recent[i]

				dump("#" .. i .. " on " .. b.time_date, #Bans.Recent == 0 and moat_yellow or moat_orange)
				dump("    " .. b.name .. " was banned by " .. b.staff_name .. " (" .. util.SteamIDFrom64(b.staff_steam_id) .. ") for " .. 
					(b.length == 0 and "Forever." or (util.FormatTimeSingle(b.length) .. ".")) .. " Reason: " .. b.reason .. ".")
			end

			dump("---------------------------", moat_blue)
		end

		if (Bans.Past and Bans.Past[1]) then
			dump("Past Ban(s) - Player bans you should NOT count as a repeat offense bcuz they're expired", moat_yellow)
			dump("---------------------------", moat_blue)

			for i = 1, #Bans.Past do
				local b = Bans.Past[i]

				dump("#" .. i .. " on " .. b.time_date, moat_blue)
				dump("    " .. b.name .. " was banned by " .. b.staff_name .. " (" .. util.SteamIDFrom64(b.staff_steam_id) .. ") for " .. 
					(b.length == 0 and "Forever." or (util.FormatTimeSingle(b.length) .. ".")) .. " Reason: " .. b.reason .. ".", moat_yellow)
			end

			dump("---------------------------", moat_blue)
		end

		if (Bans.Unbanned and Bans.Unbanned[1]) then
			dump("Removed Ban(s) - Player was unbanned for these so they dont rly mean anything 90% of the time", moat_pink)
			dump("---------------------------", moat_blue)

			for i = 1, #Bans.Unbanned do
				local b = Bans.Unbanned[i]

				dump("#" .. i .. " on " .. b.time_date, moat_blue)
				dump("    " .. b.name .. " was banned by " .. b.staff_name .. " (" .. util.SteamIDFrom64(b.staff_steam_id) .. ") for " ..
					(b.length == 0 and "Forever." or (util.FormatTimeSingle(b.length) .. ".")) .. " Reason: " .. b.reason .. ".", moat_pink)
				dump("    Unban Reason: " .. b.unban_reason .. ".", moat_red)
			end
		end

		
		dump("---------------------------", moat_blue)
		dump("All Warns for: " .. sid, moat_green)
		dump(" - " .. #Warns .. " Total Warn(s)", moat_yellow)
		dump("---------------------------", moat_blue)

		table.sort(Warns, function(a,b) return a.time > b.time end)

		for i, warn in ipairs(Warns) do
			dump("#" .. i .. " on " .. warn.time_date, moat_blue)
			dump("    Warned by " .. warn.staff_name .. ". Reason: " .. warn.reason, moat_red)
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

	D3A.Bans.Get(sid, false, 0, 50, function(bans)
		Bans = bans or {}
		D3A.Warns.Get(sid, false, 0, 50, function(warns)
			Warns = warns or {}
			PrintBans(pl, sid, Bans, Warns)
		end)
	end)
end