util.AddNetworkString "MOAT_INIT_WEPS"

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
		local a = net.ReadString()
		local b = net.ReadString()
		local c = net.ReadString()

		check_if_insert_alts(db, a, b, c, pl:SteamID64())
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