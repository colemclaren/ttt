-- global server ips cause configs and constants and stuff rely on it
SERVER_SHORTIP = GetConVarString "ip"
SERVER_PORT = GetConVarString "hostport"
SERVER_IP = SERVER_SHORTIP .. ":" .. SERVER_PORT
SERVER_ISDEV = false -- we set/decide this at the end of this file

MOAT_SERVERS = MOAT_SERVERS or {}
MOAT_SERVERS.Servers = {}
MOAT_SERVERS.ServersIP = {}
MOAT_SERVERS.Count = 0
MOAT_SERVERS.QuickLink = "{id}.moat.gg"
MOAT_SERVERS.GetCache = {}
MOAT_SERVERS.Get = function(str)
	-- just return the table if no search string
	if (not str) then return MOAT_SERVERS.Servers end

	-- use cache if we have it
	if (MOAT_SERVERS.GetCache[str]) then return MOAT_SERVERS.GetCache[str] end

	local t
	for i = 1, MOAT_SERVERS.Count do
		if (not MOAT_SERVERS.Servers[i]) then continue end
		local srv = MOAT_SERVERS.Servers[i]

		if (srv.id == str) then t = srv break end
		if (srv.ip == str) then t = srv break end
		if (srv.name == str) then t = srv break end
		if (srv.url == str) then t = srv break end
	end

	MOAT_SERVERS.GetCache[str] = t
	return t
end

MOAT_SERVERS.Register = function(ip, info)
	local server = {}
	server["ip"] = ip
	server["shortip"] = string.Explode(":", ip)[1]
	server["port"] = string.Explode(":", ip)[2]
	server["id"] = info.id
	server["name"] = info.name
	server["status"] = info.status or false
	server["url"] = MOAT_SERVERS.QuickLink:Replace("{id}", info.id)

	MOAT_SERVERS.Count = MOAT_SERVERS.Count + 1
	MOAT_SERVERS.Servers[MOAT_SERVERS.Count] = server
	MOAT_SERVERS.ServersIP[ip] = server
end

MOAT_SERVERS.Register("208.103.169.30:27015", {
	name = "TTT #1",
	id = "ttt"
})

MOAT_SERVERS.Register("208.103.169.31:27015", {
	name = "TTT #2",
	id = "ttt2"
})

MOAT_SERVERS.Register("208.103.169.28:27015", {
	name = "TTT #3",
	id = "ttt3"
})

MOAT_SERVERS.Register("208.103.169.31:27017", {
	name = "TTT #4",
	id = "ttt4"
})

MOAT_SERVERS.Register("208.103.169.43:27015", {
	name = "TTT #5",
	id = "ttt5"
})

MOAT_SERVERS.Register("208.103.169.43:27017", {
	name = "TTT #6",
	id = "ttt6"
})

MOAT_SERVERS.Register("208.103.169.43:27019", {
	name = "TTT #7",
	id = "ttt7"
})

MOAT_SERVERS.Register("208.103.169.43:27020", {
	name = "TTT #8",
	id = "ttt8"
})

MOAT_SERVERS.Register("208.103.169.29:27015", {
	name = "TTT Minecraft #1",
	id = "ttt-mc"
})

MOAT_SERVERS.Register("208.103.169.31:27016", {
	name = "TTT Minecraft #2",
	id = "ttt-mc2"
})

MOAT_SERVERS.Register("208.103.169.43:27016", {
	name = "TTT Minecraft #3",
	id = "ttt-mc3"
})

MOAT_SERVERS.Register("208.103.169.43:27018", {
	name = "TTC Terror City Beta",
	id = "beta"
})

MOAT_SERVERS.Register("64.94.101.132:27015", {
	name = "TTT LA",
	id = "ttt-la"
})

MOAT_SERVERS.Register("208.103.169.204:27021", {
	name = "TTT EU",
	id = "ttt-eu"
})


-- US03
MOAT_SERVERS.Register("208.103.169.54:27015", {
	name = "TTT #9",
	id = "ttt9",
	status = "Coming Soon"
})

MOAT_SERVERS.Register("208.103.169.54:27017", {
	name = "TTT #10",
	id = "ttt10",
	status = "Coming Soon"
})

MOAT_SERVERS.Register("208.103.169.54:27018", {
	name = "TTT #11",
	id = "ttt11",
	status = "Coming Soon"
})

MOAT_SERVERS.Register("208.103.169.54:27020", {
	name = "TTT #12",
	id = "ttt12",
	status = "Coming Soon"
})

MOAT_SERVERS.Register("208.103.169.54:27016", {
	name = "TTT Minecraft #4",
	id = "ttt-mc4",
	status = "Coming Soon"
})

MOAT_SERVERS.Register("208.103.169.54:27019", {
	name = "TTT Minecraft #5",
	id = "ttt-mc5",
	status = "Coming Soon"
})


-- UK01
MOAT_SERVERS.Register("208.103.169.205:27015", {
	name = "TTT EU #1",
	id = "ttt-eu1",
	status = "Coming Soon"
})

MOAT_SERVERS.Register("208.103.169.205:27017", {
	name = "TTT EU #2",
	id = "ttt-eu2",
	status = "Coming Soon"
})

MOAT_SERVERS.Register("208.103.169.205:27018", {
	name = "TTT EU #3",
	id = "ttt-eu3",
	status = "Coming Soon"
})

MOAT_SERVERS.Register("208.103.169.205:27020", {
	name = "TTT EU #4",
	id = "ttt-eu4",
	status = "Coming Soon"
})

MOAT_SERVERS.Register("208.103.169.205:27016", {
	name = "TTT EU Minecraft #1",
	id = "ttt-eumc1",
	status = "Coming Soon"
})

MOAT_SERVERS.Register("208.103.169.205:27019", {
	name = "TTT EU Minecraft #2",
	id = "ttt-eumc2",
	status = "Coming Soon"
})

-- if we aren't on a registered server, automatically assume we're on a dev server
if (not MOAT_SERVERS.ServersIP[SERVER_IP]) then
	SERVER_ISDEV = true
end