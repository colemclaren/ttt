function mlogs:saveserver()
	self:q("INSERT INTO {database}.mlogs_servers (serverip, hostname) VALUES (?, ?);", self.ip, GetHostName(), self.servers)
end

function mlogs:servers()
	self:q("SELECT sid FROM {database}.mlogs_servers WHERE serverip = ?;", self.ip, function(r)
		if (not r or not r[1]) then mlogs:savemap() return end
		local sid = r[1].sid
		if (not sid) then mlogs:saveserver() return end

		mlogs.serverid = sid
		self:q("UPDATE {database}.mlogs_maps SET hostname = ? WHERE sid = ?;", GetHostName(), mlogs.serverid)
	end)
end

mlogs:hook("mlogs.sql", function()
	mlogs:servers()
end)