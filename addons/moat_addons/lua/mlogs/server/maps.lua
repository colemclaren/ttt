function mlogs:savemap()
	self:q("INSERT INTO {database}.mlogs_maps (map) VALUES (?);", self.maps)
end

function mlogs:maps()
	self:q("SELECT mid FROM {database}.mlogs_maps WHERE map = ?;", function(r)
		if (not r or not r[1]) then mlogs:savemap() return end
		local mid = r[1].mid
		if (not mid) then mlogs:savemap() return end

		mlogs.mapid = mid
	end)
end

mlogs:hook("mlogs.sql", function()
	mlogs:maps()
end)