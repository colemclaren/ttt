local HTTP = HTTP

local url = CreateConVar("ttt_dmglogs_discordurl", "", FCVAR_PROTECTED + FCVAR_LUA_SERVER, "TTTDamagelogs - Discord Webhook URL")
local disabled = Damagelog.DiscordWebhookMode == 0
local noadmins = Damagelog.DiscordWebhookMode == 1

local limit
local reset = 0

local function post(embed)
	local now = os.time(os.date("!*t"))

	if limit == 0 and now < reset then
		local function tcb()
			post(data)
		end
		timer.Simple(reset - now, tcb)
	end

	local function cb(_, _, headers)
		limit = headers["X-RateLimit-Remaining"]
		reset = headers["X-RateLimit-Reset"]
	end

	HTTP({
		method = "POST",
		url = "http://107.191.51.43:3000/rdm",
		body = util.TableToJSON(embed),
		type = "application/json",
		success = cb
	})
end

local srvr = string.Explode("]", string.Explode("Moat ", GetHostName())[2])[1]:Trim()

function Damagelog:DiscordMessage(report, adminOnline)
	--if disabled or adminOnline and noadmins then return end
	return
	/*
	local data = {
		author = {name = TTTLogTranslate(nil, "ReportCreated")},
		title = TTTLogTranslate(nil, "webhook_ServerInfo"):format("dev", game.GetMap(), report.round),
		fields = {
			{
				name = TTTLogTranslate(nil, "Victim"),
				value = "["..report.victim_nick:gsub("([%*_~<>\\@%]])", "\\%1").."](".."https://steamcommunity.com/profiles/"..util.SteamIDTo64(report.victim)..")",
				inline = true
			},
			{
				name = TTTLogTranslate(nil, "ReportedPlayer"),
				value = "["..report.attacker_nick:gsub("([%*_~<>\\@%]])", "\\%1").."](".."https://steamcommunity.com/profiles/"..util.SteamIDTo64(report.attacker)..")",
				inline = true
			},
			{
				name = TTTLogTranslate(nil, "VictimsReport"),
				value = report.message:gsub("([%*_~<>\\@[])", "\\%1")
			},
			{
				name = "Quick Connect",
				value = "[" .. srvr .. "](steam://connect/" .. game.GetIPAddress() .. ")",
				inline = true
			}
		},
		color = 3447003
	}

	if not noadmins then data.footer = {text = TTTLogTranslate(nil, adminOnline and "webhook_AdminsOnline" or "webhook_NoAdminsOnline")} end*/

	--post(data)
end

local avaurl = "https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/?key=13E8032658377F036842094BDD9E7000&steamids="
local role_to_string = {}
role_to_string[0] = "Innocent"
role_to_string[1] = "Traitor"
role_to_string[2] = "Detective"

local function PostToDiscord(t)
	t.server = srvr
	t.serverip = game.GetIPAddress()
	t.victimurl = "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/fe/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb_full.jpg"
	t.attackerurl = "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/fe/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb_full.jpg"
	t.victim64 = util.SteamIDTo64(t.victim)
	t.attacker64 = util.SteamIDTo64(t.attacker)
	t.attacker_role = "Unknown"
	t.victim_role = "Unknown"
	t.footer = TTTLogTranslate(nil, "webhook_ServerInfo"):format(srvr, game.GetMap(), t.round)

	if (t.logs and t.logs.roles) then
		for k, v in ipairs(t.logs.roles) do
			if (v.steamid64 == t.victim64) then
				t.victim_role = role_to_string[v.role] or "Unknown"
			end

			if (v.steamid64 == t.attacker64) then
				t.attacker_role = role_to_string[v.role] or "Unknown"
			end
		end
	end


	http.Fetch(avaurl .. t.victim64 .. "%20" .. t.attacker64, function(b)
		local r = util.JSONToTable(b)
		if (not r or not r.response or not r.response.players) then return end
		if (r.response.players[1]) then t.victimurl = r.response.players[1]["avatarfull"] end
		if (r.response.players[2]) then t.attackerurl = r.response.players[2]["avatarfull"] end

		PrintTable(t)

		post(t)
	end, function(e) post(t) end)
end

hook.Add("TTTDLog_Decide", "moat.discord.damagelog", function(ply, att, forgive, index, adminOnline)
	if disabled or adminOnline and noadmins then return end

	if (not Damagelog or not Damagelog.Reports) then return end
	if (Damagelog.Reports.Current and Damagelog.Reports.Current[index]) then
		PostToDiscord(Damagelog.Reports.Current[index])
	elseif (Damagelog.Reports.Previous and Damagelog.Reports.Previous[index]) then
		PostToDiscord(Damagelog.Reports.Previous[index])
	end
end)