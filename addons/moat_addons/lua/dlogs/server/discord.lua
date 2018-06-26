local HTTP = HTTP
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

	/*HTTP({
		method = "POST",
		url = "http://107.191.51.43:3000/rdm",
		body = util.TableToJSON(embed),
		type = "application/json",
		success = cb
	})*/
end

local srvr = string.Explode("]", string.Explode("Moat ", GetHostName())[2])[1]:Trim()
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

		post(t)
	end, function(e) post(t) end)
end

hook.Add("dlogs_Discord", "dlogs.Discord", function(ply, att, forgive, index)
	if (dlogs:AdminOnline()) then return end

	if (not dlogs or not dlogs.Reports) then return end
	if (dlogs.Reports.Current and dlogs.Reports.Current[index]) then
		PostToDiscord(dlogs.Reports.Current[index])
	elseif (dlogs.Reports.Previous and dlogs.Reports.Previous[index]) then
		PostToDiscord(dlogs.Reports.Previous[index])
	end
end)