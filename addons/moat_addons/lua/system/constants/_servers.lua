moat.includesh "_mt/servers.lua"

-- constant server ip/info cause configs and constants and stuff rely on it
SERVER_SHORTIP = GetConVarString "ip"
SERVER_PORT = GetConVarString "hostport"
SERVER_IP = SERVER_SHORTIP .. ":" .. SERVER_PORT
SERVER_ISDEV = false -- we set/decide this at the end of this file

-- network of mg servers
moat.servers = moat.servers or {}
moat.servers.list = {}
moat.servers.listip = {}
moat.servers.count = 0
moat.servers.url = "{id}.moat.gg"
moat.servers.getcache = {}
moat.servers.get = function(str)
	-- just return the table if no search string
	if (not str) then return moat.servers.list end

	-- use cache if we have it
	if (moat.servers.getcache[str]) then return moat.servers.list[str] end

	local t
	for i = 1, moat.servers.count do
		if (not moat.servers.list[i]) then continue end
		local srv = moat.servers.list[i]

		if (srv.id == str) then t = srv break end
		if (srv.ip == str) then t = srv break end
		if (srv.name == str) then t = srv break end
		if (srv.url == str) then t = srv break end
	end

	-- just use the first server's info
	if (not t) then t = moat.servers.list[1] end
	moat.servers.getcache[str] = t
	return t
end

moat.server "208.103.169.30:27015"
	:nick "TTT #1"
	:mid "ttt"

moat.server "208.103.169.31:27015"
	:nick "TTT #2"
	:mid "ttt2"

moat.server "208.103.169.28:27015"
	:nick "TTT #3"
	:mid "ttt3"

moat.server "208.103.169.31:27017"
	:nick "TTT #4"
	:mid "ttt4"

moat.server "208.103.169.43:27015"
	:nick "TTT #5"
	:mid "ttt5"

moat.server "208.103.169.43:27017"
	:nick "TTT #6"
	:mid "ttt6"

moat.server "208.103.169.43:27019"
	:nick "TTT #7"
	:mid "ttt7"

moat.server "208.103.169.43:27020"
	:nick "TTT #8"
	:mid "ttt8"

moat.server "208.103.169.54:27015"
	:nick "TTT #9"
	:mid "ttt9"

moat.server "208.103.169.54:27017"
	:nick "TTT #10"
	:mid "ttt10"

moat.server "208.103.169.54:27018"
	:nick "TTT #11"
	:mid "ttt11"

moat.server "208.103.169.54:27020"
	:nick "TTT #12"
	:mid "ttt12"

moat.server "208.103.169.29:27015"
	:nick "TTT Minecraft #1"
	:mid "ttt-mc"

moat.server "208.103.169.31:27016"
	:nick "TTT Minecraft #2"
	:mid "ttt-mc2"

moat.server "208.103.169.43:27016"
	:nick "TTT Minecraft #3"
	:mid "ttt-mc3"

moat.server "208.103.169.54:27016"
	:nick "TTT Minecraft #4"
	:mid "ttt-mc4"

moat.server "208.103.169.54:27019"
	:nick "TTT Minecraft #5"
	:mid "ttt-mc5"

moat.server "208.103.169.43:27018"
	:nick "TTC Terror City Beta"
	:mid "beta"

moat.server "64.94.101.132:27015"
	:nick "TTT LA"
	:mid "ttt-la"

moat.server "208.103.169.204:27021"
	:nick "TTT EU"
	:mid "ttt-eu"


-- UK01
moat.server "208.103.169.205:27015"
	:nick "TTT EU #1"
	:mid "ttt-eu1"
	:state "Coming Soon"

moat.server "208.103.169.205:27017"
	:nick "TTT EU #2"
	:mid "ttt-eu2"
	:state "Coming Soon"

moat.server "208.103.169.205:27018"
	:nick "TTT EU #3"
	:mid "ttt-eu3"
	:state "Coming Soon"

moat.server "208.103.169.205:27020"
	:nick "TTT EU #4"
	:mid "ttt-eu4"
	:state "Coming Soon"

moat.server "208.103.169.205:27016"
	:nick "TTT EU Minecraft #1"
	:mid "ttt-eumc1"
	:state "Coming Soon"

moat.server "208.103.169.205:27019"
	:nick "TTT EU Minecraft #2"
	:mid "ttt-eumc2"
	:state "Coming Soon"

for i = 1, moat.servers.count do
	if (not moat.servers.list[i] or not moat.servers.list[i].ip) then continue end
	moat.servers.listip[moat.servers.list[i].ip] = true
end

SERVER_ISDEV = SERVER and not moat.servers.listip[SERVER_IP]