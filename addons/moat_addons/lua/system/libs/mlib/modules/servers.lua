local band = bit.band
local rshift = bit.rshift
local concat = table.concat
local str_split = string.Split

Server = Server or {
	Name = GetHostName(),
	ID = false,
	URL = false,
	Index = 200,
	ConnectURL = false,
	IsDev = true
}

function Server.BuildAddress()
	local hostip = tonumber(GetConVarString "hostip")
	local port = GetConVarString "hostport"
	if (not hostip or not port) then
		return 
	end
	
	local ipt, ip = {}
	ipt[1] = rshift(band(hostip, 0xFF000000), 24)
	ipt[2] = rshift(band(hostip, 0x00FF0000), 16)
	ipt[3] = rshift(band(hostip, 0x0000FF00), 8)
	ipt[4] = band(hostip, 0x000000FF)
	ip = concat(ipt, ".")

	Server.ShortIP = ip
	Server.Port = port
	Server.IP = ip .. ":" .. port
end
Server.BuildAddress()

----
-- our server's nick name, ex:
-- TTT Minecraft #2
----
GetServerName = function()
	return Server.Name or GetHostName()
end

----
-- our server's full ip, ex:
-- 208.103.169.28:27015
----
GetServerIP = function()
	if (not Server.IP) then
		Server.BuildAddress()
	end

	return Server.IP or "hewwo server ip ?? uwu"
end

----
-- our server's steam connect url, ex:
-- steam://connect/ttt-mc2.moat.gg:27016
----
GetServerURL = function()
	return Server.ConnectURL or (Servers.SteamURL .. GetServerIP())
end


local servers = {
	n = 0,
	List = {
		IP = {},
		Name = {},
		ID = {}
	},
	Roster = {},
	DefaultPort = 27015,
	Name = "Moat TTT",
	URL = ".moat.gg",
	SteamURL = "steam://connect/"
}

function servers.Get(str)
	if (not str) then
		return servers.Roster
	end

	local tb = servers.List
	return tb.IP[str] or tb.Name[str] or tb.ID[str]
end

function servers.Setup(name, url, def_port)
	servers.Name = name or "Garry's Mod"
	servers.URL = url or ""
	servers.DefaultPort = def_port or 27015

	return servers
end

function servers.GetTable()
	return servers
end


local sv_mt = {}
sv_mt.__index = sv_mt
sv_mt.__newindex = sv_mt

function servers.Register(address)
	servers.n = servers.n + 1

	if (not Server.IP) then
		Server.BuildAddress()
	end

	if (GetServerIP() and GetServerIP() == address) then
		Server.Index = servers.n
		Server.IsDev = false
	end

	local ip_split = str_split(address, ":")
	local self = setmetatable({
		Index = servers.n,
		IP = ip_split[1] .. ":" .. ip_split[2],
		ShortIP = ip_split[1],
		Port = ip_split[2],
		Status = false,
		ThisServer = (GetServerIP() and GetServerIP() == address),
		URL = servers.URL .. (ip_split[2] == "27015" and "" or ":" .. ip_split[2])
	}, sv_mt)

	servers.Roster[servers.n] = self
	return self:UpdateList()
end

function sv_mt:SetName(str)
	self.Name = str

	return self:UpdateList()
end

function sv_mt:SetID(str)
	self.ID = str
	self.URL = str .. self.URL
	self.ConnectURL = servers.SteamURL .. self.URL

	return self:UpdateList()
end

function sv_mt:SetState(str)
	self.State = str

	return self:UpdateList()
end

function sv_mt:UpdateList()
	servers.List.IP[self.IP] = self

	if (self.Name) then
		if (self.ThisServer) then
			Server.Index = self.Index or Server.Index
			Server.Name = self.Name or Server.Name
		end

		servers.List.Name[self.Name] = self
	end

	if (self.ID) then
		if (self.ThisServer) then
			Server.ID = self.ID or Server.ID
			Server.URL = self.URL or Server.URL
			Server.ConnectURL = self.ConnectURL or Server.ConnectURL
		end

		servers.List.ID[self.ID] = self
	end

	return self
end

Servers = setmetatable(servers, {
	__call = function(self, ...) return self.Register(...) end
})