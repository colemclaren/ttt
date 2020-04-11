function mlogs:saveserver()
	self:q("INSERT INTO {database}.mlogs_servers (serverip, hostname) VALUES (?, ?);", self.ip, self.hostname, function() self:servers() end)
end

function mlogs:servers()
	self:q("SELECT sid FROM {database}.mlogs_servers WHERE serverip = ?;", self.ip, function(r)
		if (not r[1]) then self:saveserver() return end

		local sid = r[1].sid
		if (not sid) then self:saveserver() return end

		self.serverid = sid
		self:loaded()

		self:q("UPDATE {database}.mlogs_servers SET hostname = ? WHERE sid = ?;", self.hostname, self.serverid)
	end)
end

hook("mlogs.sql", function(s)
	s.hostname = s.hostname_parse(GetHostName())
	if (not s.hostname or s.hostname:Trim():len() < 5) then s.hostname = GetHostName() end

	s:servers()
end)