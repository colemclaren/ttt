local PLAYER = FindMetaTable "Player"
file.CreateDir "damagelog"

dlogs.Config.User_rights = dlogs.Config.User_rights or {}
dlogs.Config.RDM_Manager_Rights = dlogs.Config.RDM_Manager_Rights or {}

function dlogs.Config:AddGroup(group, rights, rdm_manager)
	self.Config.User_rights[group] = rights
	self.Config.RDM_Manager_Rights[group] = rdm_manager
end

function PLAYER:CanUsedlogs()
	local priv, rnd = dlogs.Config.User_rights[self:GetUserGroup()], GetRoundState() ~= ROUND_ACTIVE
	return (priv <= 2 and rnd) or (priv == 3 and (priv or self:IsSpec())) or priv == 4
end

function PLAYER:CanUseRDMManager()
	return dlogs.Config.RDM_Manager_Rights[self:GetUserGroup()]
end

function PLAYER:dlogsID()
	return self:SteamID64() or (self:IsBot() and "77777777777" .. self:Nick():sub(4))
end

dlogs.Colors = {
	White = Color(255, 255, 255, 255),
	Green = Color(0, 255, 0, 255),
	Blue = Color(51, 153, 255, 255),
	Cyan = Color(0, 200, 255, 255),
	Pink = Color(255, 0, 255, 255),
	Red = Color(255, 0, 0, 255),
	Black = Color(0, 0, 0, 255),
	LightRed = Color(255, 50, 50, 255)
}

function dlogs.Print(Text)
	MsgC(dlogs.Colors.Red, "MDL", dlogs.Colors.LightRed, " | ", dlogs.Colors.White, Text, "\n")
end

function dlogs.FindPlayer(info, begin)
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

		local findname = string.find(v:Nick():lower(), tostring(info):lower(), 1, true)
		if ((begin and findname and findname == 1) or (not begin and findname)) then
			return v
		end
	end
	return nil
end

function dlogs.PlayerCount()
	local n = 0
	
	for k, v in pairs(player.GetAll()) do
		if (v:Team() ~= TEAM_SPEC) then n = n + 1 end
	end

	return n
end

function dlogs.FormatTimeSingle(x)
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

function dlogs:AdminOnline()
	local pls = player.GetAll()

	for k = 1, #pls do
		local v = pls[k]
		if (v:CanUseRDMManager()) then return true end
	end

	return false
end