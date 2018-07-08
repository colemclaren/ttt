-- shared file for constant globals
-- keep big tables in the /constants folder
-- use sh_/sv_/cl_ to control realms, its called after this file

-- all moat servers
MOAT_SERVERS = MOAT_SERVERS or {}
MOAT_SERVERS.Servers = {}
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
		if (not MOAT_SERVERS[i]) then continue end
		local srv = MOAT_SERVERS[i]

		if (srv.id == str) then t = srv break end
		if (srv.ip == str) then t = srv break end
		if (srv.name == str) then t = srv break end
		if (srv.url == str) then t = srv break end
	end

	assert(t, "couldn't find server from servers table")

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
end