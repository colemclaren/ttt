function mlogs.FindPlayer(info)
	if (not info or info == "") then return nil end
	local pls = player.GetAll()

	for k = 1, #pls do
		local v = pls[k]
		if (info == v:SteamID64()) then
			return v
		end

		if (info == v:SteamID()) then
			return v
		end
	end
	return nil
end

function mlogs.AliveCount()
	local pls, n = player.GetAll(), 0

	for k = 1, #pls do
		local v = pls[k]
		if (v:Team() == TEAM_SPEC) then continue end
		n = n + 1
	end
	return n
end

function mlogs.FormatTime(x, y)
	x = x or os.time()
	y = y or os.time()

	local diff = math.max(0, x - y)
	local str = " second"
	if (diff == 0) then return " a moment" end

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

	return " a moment"
end

function mlogs.FormatTimeSingle(x)
	return mlogs.FormatTime(x, 0)
end

function mlogs.FormatTimeNow(y)
	return mlogs.FormatTime(os.time(), y)
end

function mlogs:AdminOnline()
	local pls = player.GetAll()

	for k = 1, #pls do
		local v = pls[k]
		if (v:CanUseLogsManager()) then return true end
	end

	return false
end

function mlogs:GetStaff()
	local pls, staff = player.GetAll(), {}

	for i = 1, #pls do
		local v = pls[i]
		if (v:CanUseLogsManager()) then
			table.insert(staff, v)
		end
	end

	return staff
end

function mlogs.DontLog()
	return (GetRoundState() ~= ROUND_ACTIVE or GetGlobal("MOAT_MINIGAME_ACTIVE"))
end

function mlogs.DontSlay()
	return (GetGlobal("MOAT_MINIGAME_ACTIVE"))
end

function mlogs.GetRoles()
	local pls, roles, n = player.GetAll(), {}, 0

	for i = 1, #pls do
		if (not IsValid(pls[i])) then continue end
		if (pls[i]:Team() == TEAM_SPEC) then continue end

		n = n + 1
		roles[n] = {mlogs.PlayerID(pls[i]), pls[i]:GetRole() or 0}
	end

	return n, roles
end

function mlogs.FormatNameID(name, steamid)
	return tostring(name or "???") .. " (" .. (util.SteamIDFrom64(tostring(steamid)) or "???") .. ")"
end