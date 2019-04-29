util.AddNetworkString "MOAT_INIT_WEPS"

local nvidia_asn = {
	[11414] = true,
	[60977] = true,
	[38834] = true,
	[38564] = true,
	[50889] = true
}

local function Query_Error(q, err, sql)
	print("error on query `" .. sql .. "`: " .. err)
end

function QueryIP(ipv4, cb)
	local db = SERVER_SITE_DATA
	if (db) then
		local a, b, c, d = ipv4:match("^(%d+)%.(%d+)%.(%d+)%.(%d+)")
		local ipu32 = a * 2^24 + b * 2^16 + c * 2^8 + d
		local q = db:query("SELECT AS_number, AS_description FROM server_site_data.ip_info WHERE range_start <= " .. ipu32 .. " AND " .. ipu32 .. " <= range_end;");
		q.onError = function(q, err, sql)
			Query_Error(q, err, sql)
			cb(false)
		end
		function q:onSuccess(data)
			if (not data or not data[1]) then
				cb(false)
				return
			end
			cb(data)
		end
		q:start()
	else
		return cb(false)
	end
end

local function alts_query(str, cb)
	local q = MINVENTORY_MYSQL:query(str)
	function q:onError(err)
		ServerLog("MOAT ALT ERROR | " .. err .. "\n")
	end

	function q:onSuccess(d)
		if (cb) then cb(d) end
	end

	q:start()
end

local function check_if_alts_banned(d, id)
	local banned_already = false

	for i = 1, #d do
		local alt = d[i]["CAST(steamid64 AS CHAR)"]

		D3A.Bans.IsBanned(util.SteamIDFrom64(alt), function(isbanned, data)
			if isbanned and not banned_already then
				RunConsoleCommand("mga", "perma", util.SteamIDFrom64(id), "[Automated] Detected Alt Account of Banned Player: " .. util.SteamIDFrom64(alt))
				banned_already = true
			end
		end)

	end
end

local function check_should_ban(alt, pl)
	D3A.Bans.IsBanned(util.SteamIDFrom64(alt), function(isbanned, data)
		if isbanned then
			RunConsoleCommand("mga", "perma", util.SteamIDFrom64(pl), "[Automated] Detected Alt Account of Banned Player: " .. util.SteamIDFrom64(alt))
		end
	end)
end

local function check_actual_alts(db, a, b, c, id)
	alts_query("SELECT CAST(steamid64 AS CHAR) FROM moat_alt WHERE (fp1 = " .. db:escape(a) .. " OR fp2 = " .. db:escape(b) .. " OR fp3 = " .. db:escape(c) .. ") AND NOT steamid64 = " .. db:escape(id), function(d)
		if (d and d[1]) then
			check_if_alts_banned(d, id)
		end
	end)
end

local function check_if_insert_alts(db, a, b, c, id)
	alts_query("SELECT fp1 FROM moat_alt WHERE steamid64 = " .. db:escape(id), function(d)
		if (d and d[1]) then
			check_actual_alts(db, a, b, c, id)
		else
			alts_query("INSERT INTO moat_alt (steamid64, fp1, fp2, fp3) VALUES (" .. db:escape(id) .. "," .. db:escape(a) .. "," .. db:escape(b) .. "," .. db:escape(c) .. ")", function(d)
				check_actual_alts(db, a, b, c, id)
			end)
		end
	end)
end
local ban_reasons = {
	"[Automated] We don't allow family shared accounts on our servers, sorry!",
	"[Automated] We don't allow people that haven't setup their profile on our servers, sorry! Make an unban request on the forums after you setup your profile to be unbanned."
}
local function ban_from_steam(id, rsn)
	local sid = util.SteamIDFrom64(id)
	if (rsn == 2) then
		RunConsoleCommand("mga", "perma", sid, ban_reasons[rsn])
	end
	game.KickID(sid, ban_reasons[rsn])
end

local function steam_api(pl)
	local id = pl:SteamID64()
	local cn = cookie.GetNumber(id .. "steam_family", 0)

	if (cn == 2) then return end

	http.Fetch(string.format("http://api.steampowered.com/IPlayerService/IsPlayingSharedGame/v0001/?key=%s&format=json&steamid=%s&appid_playing=4000", "13E8032658377F036842094BDD9E7000", id),
		function(body)
			local lender = util.JSONToTable(body).response.lender_steamid
			if (lender ~= "0") then
				check_should_ban(lender, id)
			else
				cookie.Set(id .. "steam_family", 2)
			end
		end,
		function(err) ServerLog("Steam API Fail: " .. err .. "\n") end)

	/*if (cn > 0) then return end

	http.Fetch(string.format("http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=%s&format=json&steamids=%s", "13E8032658377F036842094BDD9E7000", id),
		function(body)
			local setup = util.JSONToTable(body).response.players[1].profilestate
			if (not setup) then
				ban_from_steam(id, 2)
			else
				cookie.Set(id .. "steam_family", 1)
			end
		end,
		function(err) ServerLog("Steam API Fail: " .. err .. "\n") end)*/
end

hook.Add("PlayerInitialSpawn", "MOAT_BAN_FAMILY_SHARE", steam_api)



local function moat_alts()
    local db = MINVENTORY_MYSQL

    alts_query [[
    	CREATE TABLE IF NOT EXISTS `moat_alt`(
    		`steamid64` BIGINT(20) NOT NULL,
    		`fp1` INT NOT NULL,
    		`fp2` BIGINT(20) NOT NULL,
    		`fp3` BIGINT(20) NOT NULL,
    		PRIMARY KEY (`steamid64`)
    	);
    ]]

	net.Receive("MOAT_INIT_WEPS", function(_, pl)
		if (pl.AltsInitiated) then
			return
		end
		pl.AltsInitiated = true

		local a = net.ReadString()

		if (not tonumber(a)) then
			pl:Kick("Failure to adhere to circumstances.")
			return
		end

		local b = net.ReadString()

		if (b ~= "blunt" and not tonumber(b)) then
			pl:Kick("Failure to adhere to circumstances.(2)")
			return
		end

		local c = net.ReadString()

		if (not tonumber(c)) then
			pl:Kick("Failure to adhere to circumstances.(3)")
			return
		end

		pl.alt_data = {a,b,c}

		local ip = pl:IPAddress()

		local tries_left = 5

		local function got_data(data)
			if (not IsValid(pl)) then
				return
			end

			if (data) then
				for i, asn in ipairs(data) do
					if (nvidia_asn[asn.AS_number]) then
						discord.Send("ASN Check", string.format("`%s` connected from `%s` with ASN from `%s` (`%i`) -  ignored", pl:SteamID64(), pl:IPAddress(), asn.AS_description, asn.AS_number))
						return
					end
				end
				print(pl:Nick() .. " <" .. pl:IPAddress() .. "> connected from " .. data[1].AS_description)
			elseif (not Server.IsDev) then
				tries_left = tries_left - 1
				if (tries_left < 0) then
					discord.Send("ASN Check", string.format("`%s` connected from `%s` with no ASN", pl:SteamID64(), pl:IPAddress()))
					return
				else
					QueryIP(ip, data)
					return
				end
			end

			check_if_insert_alts(db, a, b, c, pl:SteamID64())
		end

		QueryIP(ip, got_data)
	end)
end

--[[-------------------------------------------------------------------------
Hacky as fuck sql stuff
---------------------------------------------------------------------------]]

local function c()
    return MINVENTORY_MYSQL and MINVENTORY_MYSQL:status() == mysqloo.DATABASE_CONNECTED
end

if MINVENTORY_MYSQL then
    if c() then
        moat_alts()
    end
end

hook.Add("InitPostEntity", "AltsSQLDB",function()
    if (not c()) then 
        timer.Create("CheckAltsDB",1,0,function()
            if c() then
                moat_alts()
                timer.Destroy("CheckAltsDB")
            end
        end)
    else
        moat_alts()
    end
end)