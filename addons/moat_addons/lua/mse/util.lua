-- store colors here so we don't have to call Color() every frame in draw hooks
-- aka optimization :)
MSE.Colors = {
	White = Color(255, 255, 255, 255),
	Green = Color(0, 255, 0, 255),
	Blue = Color(51, 153, 255, 255),
	Cyan = Color(0, 200, 255, 255),
	Pink = Color(255, 0, 255, 255),
	Red = Color(255, 0, 0, 255),
	Black = Color(0, 0, 0, 255),
	LightRed = Color(255, 50, 50, 255)
}


function MSE.Print(Text)
	MsgC(MSE.Colors.White, "MSE", MSE.Colors.Blue, " | ", MSE.Colors.White, Text, "\n")
end

function MSE.FindPlayer(info, begin)
	if (not info or info == "") then return nil end
	local pls = player.GetAll()

	for k = 1, #pls do -- Proven to be faster than pairs loop.
		local v = pls[k]
		if (tonumber(info) == v:UserID()) then
			return v
		end

		if (info == v:SteamID()) then
			return v
		end

		local findname = string.find(v:Name():lower(), tostring(info):lower(), 1, true)
		if ((begin and findname and findname == 1) or (not begin and findname)) then
			return v
		end
	end
	return nil
end

function MSE.PlayerCount()
	local n = 0
	
	for k, v in pairs(player.GetAll()) do
		if (v:Team() ~= TEAM_SPEC) then n = n + 1 end
	end

	return n
end


function MSE.FormatTime(x, y)
	x = x or os.time()
	y = y or os.time()

	local diff = x - y
	local str = " second"

	if (diff < 60) then
		return diff .. ((str and diff == 1) or (str .. "s"))
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

	return "Unknown"
end

function MSE.FormatTimeSingle(x)
	local diff = x or 0
	local str = " second"

	if (diff < 60) then
		return diff .. ((str and diff == 1) or (str .. "s"))
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

	return "Unknown"
end