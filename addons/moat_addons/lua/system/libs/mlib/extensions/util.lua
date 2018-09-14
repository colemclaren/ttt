local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
function util.Base64Decode(data)
	return data:gsub("[^"..b.."=]", ""):gsub(".", function(x)
		if (x == "=") then
			return ""
		end

		local r, f = "", b:find(x) - 1
		for i = 6, 1, -1 do
			r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0")
		end

		return r
	end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
		if (#x ~= 8) then
			return ""
		end

		local c = 0
		for i = 1, 8 do
			c = c + (x:sub(i, i) == "1" and 2 ^ (8 - i) or 0)
		end

		return string.char(c)
	end)
end

local DateCache = {}
function util.NiceDate(days)
	days = days or 0

	if (DateCache[days]) then
		return DateCache[days]
	end

	DateCache[days] = os.date("%B %d, %Y", os.time() + (days * 86400))

	return DateCache[days]
end

function util.UTCTime()
	return os.date("!%r", os.time())
end