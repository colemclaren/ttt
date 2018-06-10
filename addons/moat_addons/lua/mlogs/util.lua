local PLAYER = FindMetaTable "Player"
file.CreateDir "mlogs"

mlogs.cfg.Groups = mlogs.cfg.Groups or {}
mlogs.cfg.ManagerGroups = mlogs.cfg.ManagerGroups or {}

function mlogs.cfg:AddGroup(group, active, manager)
	self.cfg.Groups[group] = active
	self.cfg.ManagerGroups[group] = manager
end

function PLAYER:mlogsCanUse()
	local grp = self:GetUserGroup()
	if (mlogs.cfg.Groups[grp] == nil) then return GetRoundState() == ROUND_ACTIVE end
	if (not mlogs.cfg.Groups[grp] and self:IsSpec()) then return false end
	return true
end

function PLAYER:mlogsCanUseManager()
	return mlogs.cfg.ManagerGroups[self:GetUserGroup()]
end

function PLAYER:mlogsID()
	return self:SteamID64() or (self:IsBot() and "77777777777" .. self:Nick():sub(4))
end

mlogs.Colors = {
	White = Color(255, 255, 255, 255),
	Green = Color(0, 255, 0, 255),
	Blue = Color(51, 153, 255, 255),
	Cyan = Color(0, 200, 255, 255),
	Pink = Color(255, 0, 255, 255),
	Red = Color(255, 0, 0, 255),
	Black = Color(0, 0, 0, 255),
	LightRed = Color(255, 50, 50, 255)
}

function mlogs.Print(msg)
	MsgC(mlogs.Colors.Red, "mLogs", mlogs.Colors.LightRed, " | ", mlogs.Colors.White, msg, "\n")
end

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

function mlogs.ActiveCount()
	local pls, n = player.GetAll(), 0

	for k = 1, #pls do
		local v = pls[k]
		if (v:Team() == TEAM_SPEC) then continue end
		n = n + 1
	end
	return n
end

function mlogs.FormatTimeSingle(x)
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

function mlogs:AdminOnline()
	local pls = player.GetAll()

	for k = 1, #pls do
		local v = pls[k]
		if (v:mlogsCanUseManager()) then return true end
	end

	return false
end

mlogs.hooks = mlogs.hooks or {}
function mlogs:hook(id, cb)
	self.hooks[id] = self.hooks[id] and self.hooks[id] + 1 or 1
	hook.Add(id, "mlogs." .. id .. "." .. self.hooks[id], cb)
	return self.hooks[id]
end

function mlogs:dehook(id, num)
	hook.Remove(id, "mlogs." .. id .. "." .. num)
end

if (SERVER) then return end

local zerod = math.rad(0)
function mlogs.DrawCircle(x, y, radius, seg)
	local cir, cur = {{x = x, y = y, u = 0.5, v = 0.5}}, 1

	for i = 0, seg do
		cur = cur + 1

		local a = math.rad((i/seg) * -360)
		cir[cur] = {x = x + math.sin(a) * radius, y = y + math.cos(a) * radius, u = math.sin(a) / 2 + 0.5, v = math.cos(a) / 2 + 0.5}
	end

	cur = cur + 1
	cir[cur] = {x = x + math.sin(zerod) * radius, y = y + math.cos(zerod) * radius, u = math.sin(zerod) / 2 + 0.5, v = math.cos(zerod) / 2 + 0.5}
	surface.DrawPoly(cir)
end