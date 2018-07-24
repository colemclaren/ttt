local mt = {}
mt.__index = mt
mt.__newindex = mt

function moat.server(address)
	moat.servers.count = moat.servers.count + 1
	moat.servers.list[moat.servers.count] = setmetatable({
		ip = address,
		shortip = string.Explode(":", address)[1],
		port = string.Explode(":", address)[2],
		status = false
	}, mt)

	return moat.servers.list[moat.servers.count]
end

function mt:nick(str)
	self.name = str

	return self
end

function mt:mid(str)
	self.id = str
	self.url = moat.servers.url:Replace("{id}", str)

	return self
end

function mt:state(str)
	self.status = str

	return self
end