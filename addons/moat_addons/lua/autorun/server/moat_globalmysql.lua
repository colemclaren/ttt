require "mysqloo"

MOATSQL = MOATSQL or {}
MOATSQL_ServerIP = GetConVarString("ip") .. ":" .. GetConVarString("hostport")
MOATSQL_Config = {
	host = "gamedb.moat.gg",
	database = "forum",
	username = "moat",
	password = "Cox81#iVdeyiL#uH#4N8k^Q!Tk0TNYtY",
	port = 3306
}

-- This is ONLY for the Dallas servers that have a direct link with the web server.
MOATSQL_DirectLinkServers = {
	["208.103.169.30:27015"] = true, -- TTT #1
	["208.103.169.31:27015"] = true, -- TTT #2
	["208.103.169.28:27015"] = true, -- TTT #3
	["208.103.169.31:27017"] = true, -- TTT #4
	["208.103.169.43:27015"] = true, -- TTT #5
	["208.103.169.43:27017"] = true, -- TTT #6
	["208.103.169.43:27019"] = true, -- TTT #7
	["208.103.169.43:27020"] = true, -- TTT #8
	["208.103.169.29:27015"] = true, -- TTT Minecraft #1
	["208.103.169.31:27016"] = true, -- TTT Minecraft #2
	["208.103.169.43:27016"] = true, -- TTT Minecraft #3
	["208.103.169.43:27018"] = true  -- TTC Terror City Beta
}

if (MOATSQL_DirectLinkServers[MOATSQL_ServerIP]) then
	MOATSQL_Config.host = "direct-link-web"
end

MOATSQL = mysqloo.connect(MOATSQL_Config.host, MOATSQL_Config.username, MOATSQL_Config.password, MOATSQL_Config.database, MOATSQL_Config.port)
MOATSQL.onConnected = function(db)
	if (db.setCharacterSet) then
		db:setCharacterSet "utf8mb4"
	end

	hook.Run("SQLConnected", db)
end
MOATSQL.onConnectionFailed = function(db, err) hook.Run("SQLConnectionFailed", db, err) end
MOATSQL:connect()

timer.Create("moat_sql_no_disconnecto", 180, 0, function()
    local q = MOATSQL:query("SELECT max_slots FROM moat_inventory WHERE steamid = 'STEAM_0:0:46558052'")
    q:start()
end)