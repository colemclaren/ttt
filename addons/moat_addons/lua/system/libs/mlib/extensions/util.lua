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

function util.SafeSteamID(str)
	return string.gsub(str or '', '[^%w:_]', '') or ''
end

function util.FormatTime(x, y)
	x = x or os.time()
	y = y or os.time()

	local diff = math.max(0, x - y)
	local str = " second"
	if (diff == 0) then return "a moment" end

	if (diff < 60) then
		return diff .. ((diff == 1 and str) or (str .. "s"))
	elseif (diff < 3600) then
		local mins = math.Round(diff/60)
		str = " minute"

		return mins .. ((mins == 1 and str) or (str .. "s"))
	elseif (diff < 86400) then
		local hrs = math.Round(diff/3600)
		str = " hour"

		return hrs .. ((hrs == 1 and str) or (str .. "s"))
	else
		local days = math.Round(diff/86400)
		str = " day"

		return days .. ((days == 1 and str) or (str .. "s"))
	end

	return "a moment"
end

function util.FormatTimeSingle(x)
	return util.FormatTime(x, 0)
end

function util.FormatTimeNow(y)
	return util.FormatTime(os.time(), y)
end

function util.Upper(str)
	return string.gsub(" " .. str, "%W%l", string.upper):sub(2)
end

local wep_names = {}
function util.GetWeaponName(str)
	if (not str) then
		return str
	end

	if (wep_names[str]) then
		return wep_names[str]
	end

	local wep = weapons.Get(str)
	if (not wep) then
		return str
	end

	wep_names[str] = wep and wep.PrintName or str

	return wep_names[str]
end