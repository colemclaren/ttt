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

function util.TimeRemaining(x, y)
	x = x or os.time()
	y = y or os.time()

	local diff = math.max(0, x - y)
	local secs = math.floor(diff % 60)
	local mins = math.floor((diff/60) % 60)
	local hours = math.floor((diff/(60*60)) % 24)
	local days = math.floor(diff/(60*60*24))

  	return {["total"] = diff, ["days"] = days, ["hours"] = hours, ["minutes"] = mins, ["seconds"] = secs}
end

function util.FormatTime(x, y, short)
	x = x or os.time()
	y = y or os.time()

	local diff = math.max(0, x - y)
	local str = short and " sec" or " second"
	if (diff == 0) then return short and "0 secs" or "0 seconds" end

	if (diff < 60) then
		return diff .. ((diff == 1 and str) or (str .. "s"))
	elseif (diff < 3600) then
		local mins = math.floor(diff/60)
		str = short and " min" or " minute"

		if (isbool(short) and short == false) then
			mins = string.format("%02d", mins) .. ":" .. string.format("%02d", (diff % 60))
		end

		return mins .. ((mins == 1 and str) or (str .. "s"))
	elseif (diff < 86400) then
		local hrs = math.floor(diff/3600)
		str = short and " hr" or " hour"

		return hrs .. ((hrs == 1 and str) or (str .. "s"))
	else
		local days = math.floor(diff/86400)
		str = " day"

		return days .. ((days == 1 and str) or (str .. "s"))
	end

	return short and "0 secs" or "0 seconds"
end

function util.FormatTimeSingle(x, short)
	return util.FormatTime(x, 0, short)
end

function util.FormatTimeNow(y, short)
	return util.FormatTime(os.time(), y, short)
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

local wep_wmodels = {}
function util.GetWeaponModel(str)
	if (not str) then
		return str
	end

	if (wep_wmodels[str]) then
		return wep_wmodels[str]
	end

	local wep = weapons.Get(str)
	if (not wep) then
		return str
	end

	wep_wmodels[str] = wep and wep.WorldModel or str

	return wep_wmodels[str]
end

local wep_slot = {}
function util.GetWeaponSlot(str)
	if (not str) then
		return str
	end

	if (wep_slot[str]) then
		return wep_slot[str]
	end

	local wep = weapons.Get(str)
	if (not wep) then
		return str
	end

	wep_slot[str] = wep and wep.Slot or str

	return wep_slot[str]
end