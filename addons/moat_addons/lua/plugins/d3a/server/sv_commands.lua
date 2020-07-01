D3A.Commands = {}
D3A.Commands.Stored = {} 

function D3A.Commands.Name(pl)
	return ((pl and pl.rcon) or IsValid(pl)) and pl:Nick() or "Console"
end

function D3A.Commands.NameID(pl)
	return ((pl and pl.rcon) or IsValid(pl)) and pl:NameID() or "Console (CONSOLE)"
end

function D3A.Commands.Load()
	local files = {
		'adminmode.lua',
		"afk.lua",
		"afkun.lua",
		"autoslay.lua",
		"autoslayid.lua",
		"ban.lua",
		"ban_perma.lua",
		"block.lua",
		"boost.lua",
		"bring.lua",
		"cleardecals.lua",
		"closemotd.lua",
		"crashban.lua",
		"comp.lua",
		"discord.lua",
		"forcemotd.lua",
		"freeze.lua",
		"gift.lua",
		"goto.lua",
		"kick.lua",
		"luarun.lua",
		"luaruncl.lua",
		"map.lua",
		"menu.lua",
		"motd.lua",
		"mutechat.lua",
		"mutevoice.lua",
		"noinvis.lua",
		"nolag.lua",
		"pa.lua",
		"playtime.lua",
		"pm.lua",
		"po.lua",
		"rcon.lua",
		"reconnect.lua",
		"reload.lua",
		"remove_title.lua",
		"removeslays.lua",
		"respawn.lua",
		"return.lua",
		"rewards.lua",
		"send.lua",
		"setgroup.lua",
		"sethealth.lua",
		"slay.lua",
		"snap.lua",
		"stopsounds.lua",
		"stripweapons.lua",
		"tele.lua",
		"trade_ban.lua",
		"trade_unban.lua",
		"trades.lua",
		"unban.lua",
		"unblock.lua",
		"voicebattery.lua",
		"vote.lua",
		"votekick.lua",
		"votekick_ban.lua",
		"votekick_unban.lua",
		"warn.lua",
		"wipe.lua",
	}

	for k, v in ipairs(files) do
		COMMAND = {}
		
		include(D3A.Config.Path .. "server/_commands/" .. v)
		
		COMMAND.Flag = COMMAND.Flag or ""
		COMMAND.Args = COMMAND.Args or {}
		
		D3A.Commands.Stored[string.lower(COMMAND.Name)] = table.Copy(COMMAND) 
	end
	
	D3A.Print("Commands loaded. Count: " .. table.Count(D3A.Commands.Stored))
end
D3A.Commands.Load()
concommand.Add("_reloadcommands", function(p) if (!p:IsPlayer() or p:HasAccess("*")) then D3A.Commands.Load() end end)

function D3A.Commands.CheckArgs(pl, cmd, args)
	local margs = cmd.Args
	local err
	local supp = {}
	
	if ((pl and not pl.rcon) and pl:IsPlayer() and !pl:HasAccess(cmd.Flag)) then
		err = "'" .. cmd.Flag .. "' access required!"
	end
	
	if (!err) then
		for k, v in pairs(margs) do
			if (!args[k]) then
				err = "_"
				break
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

function D3A.Commands.Parse(pl, cmd, args) -- cmd is the actual command here
	for k, v in pairs(D3A.Commands.Stored) do if (v.Alias and v.Alias == cmd) then cmd = v.Name:lower(); break; end end

	if (D3A.Commands.Stored[cmd]) then
		local cmd = D3A.Commands.Stored[cmd]
		local supp
		
		if (cmd.CheckArgs) then
			supp = cmd.CheckArgs(pl, cmd, args)
		else
			supp = D3A.Commands.CheckArgs(pl, cmd, args)
		end
		
		if (supp) then
			cmd.Run(pl, args, supp)
		end
	else
		if (cmd == "help" and not pl.rcon) then
			pl:PrintMessage(HUD_PRINTCONSOLE, "\n\nMGA | Your available commands:\n")
			for i, l in pairs(D3A.Commands.Stored) do
				if (!pl:HasAccess(l.Flag or "")) then continue end
				local usage = l.Name .. " - "
				for k, v in pairs(l.Args) do
					usage = usage .. "[" .. v[1] .. ":" .. v[2] .. "] "
				end
				pl:PrintMessage(HUD_PRINTCONSOLE, usage)
			end
			pl:PrintMessage(HUD_PRINTCONSOLE, "\n\n")
			D3A.Chat.SendToPlayer2(pl, moat_red, "Look in console to review your commands.")
		else
			D3A.Chat.SendToPlayer2(pl, moat_red, "Unknown command: " .. cmd)
		end
	end

	local sid, name = "0", "Console"
	local command, jargs = cmd or "", util.TableToJSON(args or {}) or ""
	
	if ((pl and pl.rcon) or IsValid(pl)) then
		sid = pl:SteamID64()
		name = pl:Nick()
	end

	D3A.MySQL.FormatQuery("INSERT INTO player_logs (steam_id, name, cmd, args) VALUES (#, #, #, #);", sid, utf8.force(name), command, jargs)
end

local function parseQuotes(args)
	local startk, endk
	for k, v in pairs(args) do
		if (v[1] == "\"") then
			startk = k
		elseif (startk and v[#v] == "\"") then
			endk = k
			break
		end
	end
	
	if (startk and endk) then
		args[startk] = string.sub(table.concat(args, " ", startk, endk), 2, -2)
		local num = endk - startk
		for i=1, num do
			table.remove(args, startk + 1)
		end
		
		args = parseQuotes(args)
	end
	
	return args
end

function D3A.Commands.PlayerSay(pl, text, teamchat)
	if (!text[1]) then return end -- This bug shouldn't happen.

	text = string.Trim(text)
	
	if (text[1] == "/" or text[1] == "!") then
		if (text[2] == "a" and text[3] == " ") then
			D3A.Chat.AdminChat(pl, string.sub(text, 4));
		
			return "";
		end
		
		text = string.sub(text, 2)
		
		if (text == "") then
			D3A.Commands.ConCommand(pl, "D3A", {})
		else
			local explode = string.Explode(" ", text)
			local cmd = string.lower(explode[1])

			if (table.HasValue(D3A.Config.IgnoreChatCommands, cmd)) or (DarkRP and DarkRP.getChatCommands()[cmd]) then -- Thanks for being a hacky shitty gamemode DarkRP!
				return
			end

			table.remove(explode, 1)
			
			local args = parseQuotes(explode)
			D3A.Commands.Parse(pl, cmd, args)
		end
		
		return ""
	elseif (text[1] == "@") then
		-- Admin chat
		D3A.Chat.AdminChat(pl, string.sub(text, 2))
		return ""
	end
end
hook.Add("PlayerSay", "D3A.Commands.PlayerSay", D3A.Commands.PlayerSay)

function D3A.Commands.ConCommand(pl, cmd, args)
	if (!args[1]) then
		D3A.Chat.SendToPlayer(pl, "D3A " .. (D3A.Version or "") .. " modded to MGA running on " .. GAMEMODE.Name .. " " .. (GAMEMODE.Version or ""), "NORM")
	else
		local cmd = string.lower(tostring(args[1]))
		table.remove(args, 1)
		
		for k, v in pairs(args) do
			if (string.upper(tostring(v)) == "STEAM_0") and (args[k+4]) then
				args[k] = table.concat(args, "", k, k+4)
				table.remove(args, k+1)
				table.remove(args, k+1)
				table.remove(args, k+1)
				table.remove(args, k+1)
				break
			end
		end
		
		D3A.Commands.Parse(pl, cmd, args)
	end
end
		
concommand.Add("D3A", D3A.Commands.ConCommand)
concommand.Add(D3A.Alias, D3A.Commands.ConCommand)
concommand.Add(string.sub(D3A.Alias, 1, 1), D3A.Commands.ConCommand)

D3A.DiscordLogs = {
	["afk"] = {"Player AFK", "`%s` has afk'd `%s`.", "🛌"},
	["unafk"] = {"Player AFK", "`%s` has unafk'd `%s`.", "🏃‍"},
	["aslay"] = {"Player ASlay", "`%s` has added *%s* autoslays to `%s` with the reason: *%s*.", "☠"},
	["removeslays"] = {"Player ASlay", "`%s` has removed the autoslays of `%s`.", "😇"},
	["block"] = {"Player Blocked", "`%s` blocked communications with `%s`.", "✋"},
	["unblock"] = {"Player Blocked", "`%s` has unblocked communications with `%s`.", "👌"},
	["bring"] = {"Player Teleported", "`%s` has teleported `%s` to them.", "⬇"},
	["cleardecals"] = {"Cleared Decals", "`%s` has cleared the decals.", "🌪"},
	["closemotd"] = {"Closed MOTD", "`%s` has closed the MOTD for `%s`.", "📖"},
	["forcemotd"] = {"Forced MOTD", "`%s` has forced the MOTD to open on `%s` for *%s*.", "📖"},
	["goto"] = {"Player Teleported", "`%s` has teleported to `%s`.", "➡"},
	["kick"] = {"Player Kicked", "`%s` has kicked `%s`. Reason: *%s*.", "💃"},
	["map"] = {"Map Forced", "`%s` has changed the map to *%s*.", "🌎"},
	["mute"] = {"Player Muted", "`%s` has muted `%s`'s chat.", "🙈"},
	["unmute"] = {"Player Muted", "`%s` has unmuted `%s`'s chat.", "🙉"},
	["gag"] = {"Player Gagged", "`%s` has gagged `%s`'s voice.", "🙊"},
	["ungag"] = {"Player Gagged", "`%s` has ungagged `%s`'s voice.", "🙉"},
	["noinvis"] = {"Invisible Players", "`%s` has fixed any invisible players.", "🥋"},
	["nolag"] = {"Lag Prevention", "`%s` has frozen everything to prevent server lag.", "☃"},
	["pa"] = {"PA to Players", "`%s` wrote: `[STAFF] %s`", "📢"},
	["reconnect"] = {"Player Reconnected", "`%s` has forced `%s` to reconnect.", "♻"},
	["removetitle"] = {"Player Title", "`%s` has removed the scoreboard title of `%s`, which was changed by *%s*.", "✏"},
	["return"] = {"Player Teleported", "`%s` has returned `%s`.", "⬅"},
	["setgroup"] = {"Player Rank", "`%s` has set the rank of `%s` to *%s*.", "💇‍"},
	["wipe"] = {"Player Wiped", "`%s` has wiped *%s*.", "☢️"},
	["slay"] = {"Player Slain", "`%s` has slain `%s`.", "💀"},
	["votekick"] = {"Votekick Started", "`%s` has started a votekick on `%s`.", "⛳"},
	["votekick_pass"] = {"Votekick Passed", "`%s` has been votekicked by `%s`.", "🏌️‍", "votekick"},
	["tele"] = {"Player Teleported", "`%s` has teleported `%s`.", "↗"},
	["votekickban"] = {"Player Votekick Banned", "`%s` has added `%s` to the votekick ban list. Reason: *%s*.", "😒", "votekickban"},
	["votekickban_update"] = {"Player Votekick Banned", "`%s`'s votekick ban was updated by `%s`. Reason: *%s*.", "😒"},
	["votekickunban"] = {"Player Votekick Unbanned", "`%s` has removed the votekick ban for `%s`.", "🤨"},
	["tradeban"] = {"Player Trade Banned", "`%s` has added `%s` to the trade ban list. Reason: *%s*.", "😒", "tradeban"},
	["tradeban_update"] = {"Player Trade Banned", "`%s`'s trade ban was updated by `%s`. Reason: *%s*.", "😒"},
	["tradeunban"] = {"Player Trade Unbanned", "`%s` has removed the trade ban for `%s`.", "🤨"},
	["unban"] = {"Player Unbanned", "`%s` has unbanned `%s`. Reason: *%s*.", "🌈"},
	["ban"] = {"Player Banned", "`%s` was banned by `%s` for *%s*. Reason: *%s*.", "🌩"},
	["ban_update"] = {"Player Banned [Updated]", "`%s`'s ban was updated by `%s` to *%s*. Reason: *%s*.", "🌧", "ban"},
	["voicebattery"] = {"Voice Battery", "`%s` has *enabled* the voice battery.", "🤐"},
	["novoicebattery"] = {"Voice Battery", "`%s` has *disabled* the voice battery.", "🙂"},
	["warn"] = {"Player Warned", "`%s` was warned by `%s`. Reason: *%s*.", "⚠"}
}

function D3A.Commands.Discord(...)
	local args = {n = select("#", ...), ...}
	if (not args[1] or not D3A.DiscordLogs[args[1]]) then
		return
	end

	local msg = D3A.DiscordLogs[args[1]]
	if (not msg) then
		return
	end

	local str, emoji = msg[2], msg[3] or "🙂"
	if (msg[4]) then
		args[1] = msg[4]
	end

	local header = emoji .. " `[" .. util.UTCTime() .. "]` • " .. msg[1] .. " • *!" .. args[1] .. "* • `" .. GetServerName() .. "`"
	if (args[2]) then
		str = string.format(str, unpack(args, 2))
	end

	slack.Send("MGA Log", header .. "\n | " .. str)
end