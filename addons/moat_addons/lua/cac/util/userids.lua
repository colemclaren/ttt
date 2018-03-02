function CAC.IsSteamId (steamId)
	return string.match (steamId, "STEAM_%d+:%d+:%d+") ~= nil
end

function CAC.SteamIdToCommunityId (steamId)
	local x, y, z = string.match (steamId, "STEAM_(%d+):(%d+):(%d+)")
	x = tonumber (x)
	y = tonumber (y)
	z = tonumber (z)
	
	local communityId = z * 2 + y + 1197960265728
	
	return "7656" .. tostring (communityId)
end

function CAC.CommunityIdToSteamId (communityId)
	communityId = string.gsub (communityId, "^7656", "")
	
	communityId = tonumber (communityId)
	communityId = communityId - 1197960265728
	
	local y = communityId % 2
	local z = (communityId - y) * 0.5
	
	return "STEAM_0:" .. y .. ":" .. z
end

function CAC.SteamIdToUniqueId (steamId)
	if steamId == "BOT" or
	   steamId == "NULL" then
		return util.CRC ("Bot01")
	end
	
	if steamId == "STEAM_0:0:0" then
		return "1"
	end
	
	return util.CRC ("gm_" .. steamId .. "_gm")
end