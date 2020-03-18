function mlogs:savemap()
	self:q("INSERT INTO {database}.mlogs_maps (map) VALUES (?);", game.GetMap(), function() self:maps() end)
end

function mlogs:maps()
	self:q("SELECT mid FROM {database}.mlogs_maps WHERE map = ?;", game.GetMap(), function(r)
		if (not r[1]) then self:savemap() return end

		local mid = r[1].mid
		if (not mid) then self:savemap() return end

		self.mapid = mid
		self:loaded()
	end)
end

hook("mlogs.sql", function(s)
	s:maps()
end)