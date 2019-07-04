function cdn.Texture(key, cb, params)
	if (cdn.Cache[key] == nil) then
		return cdn.Fetch(key, "materials", ".vtf", function(object)
			return "../data/" .. object
		end, function(object, data)
			return file.Write(object, data)
		end, cb)
	end

	return cdn.Cache[key]
end