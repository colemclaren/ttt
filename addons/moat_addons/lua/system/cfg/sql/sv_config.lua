-- for sql config
local mysql = {
	host = SERVER and "gamedb.moat.gg" or "", -- "gamedb.moat.gg",
	database = SERVER and "forum" or "",
	username = SERVER and "gmc" or "",
	password = SERVER and "C7CCR@QxGr4R9FFFImYVKciUFQ*N" or "",
	port = SERVER and 3306 or 420
}

-- This is ONLY for the Dallas servers that have a direct link with the web server.
mysql.directlink = {
	-- Dallas Node 1 in ID order
	["208.103.169.28:27015"] = true, -- TTT #3
	["208.103.169.29:27015"] = true, -- TTT Minecraft #1
	["208.103.169.30:27015"] = true, -- TTT #1
	["208.103.169.31:27015"] = true, -- TTT #2
	["208.103.169.31:27016"] = true, -- TTT Minecraft #2
	["208.103.169.31:27017"] = true, -- TTT #4

	-- Dallas Node 2 in ID order
	["208.103.169.43:27015"] = true, -- TTT #5
	["208.103.169.43:27016"] = true, -- TTT Minecraft #3
	["208.103.169.43:27017"] = true, -- TTT #6
	["208.103.169.43:27018"] = true, -- TTC Terror City Beta
	["208.103.169.43:27019"] = true, -- TTT #7
	["208.103.169.43:27020"] = true, -- TTT #8

	-- Dallas Node 3 in ID order
	["208.103.169.54:27015"] = true, -- TTT #9
	["208.103.169.54:27016"] = true, -- TTT Minecraft #4
	["208.103.169.54:27017"] = true, -- TTT #10
	["208.103.169.54:27018"] = true, -- TTT #11
	["208.103.169.54:27019"] = true, -- TTT Minecraft #5
	["208.103.169.54:27020"] = true, -- TTT #12
}

if (not Server.IP) then
	Server.BuildAddress()
end

if (Server.IP and mysql.directlink[Server.IP]) then
	-- mysql.host = "direct-link-web"
end

moat.cfg.sql = mysql