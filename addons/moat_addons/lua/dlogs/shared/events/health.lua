if SERVER then
	dlogs:EventHook("TTTPlayerUsedHealthStation")
	dlogs:EventHook("TTTEndRound")
else
	dlogs:AddFilter("filter_show_healthstation", DAMAGELOG_FILTER_BOOL, false)
	dlogs:AddColor("color_heal", Color(0, 255, 128))
end

local event = {}
local usages = {}

event.Type = "HEAL"

function event:TTTPlayerUsedHealthStation(ply, ent, healed)
	if not (ply.IsGhost and ply:IsGhost()) and ply:IsPlayer() then
		if usages[ply:SteamID()] == nil then
			local timername = "HealTimer_"..tostring(ply:SteamID())
			timer.Create(timername, 5, 0, function()
				if not IsValid(ply) then
					timer.Remove(timername)
				elseif usages[ply:SteamID()] > 0 then
					self:Store(ply, ent, usages[ply:SteamID()])
					usages[ply:SteamID()] = 0
				else
					usages[ply:SteamID()] = nil
					self:RemoveTimer(ply:SteamID())
				end
			end)

			self:Store(ply, ent, healed)
			usages[ply:SteamID()] = 0
		else
			usages[ply:SteamID()] = usages[ply:SteamID()] + healed
		end
	end
end

function event:Store(ply, ent, healed)
	local tbl = {
		[1] = ply:GetdlogsID(),
		[2] = healed
	}
	local placer = ent:GetPlacer()
	local validOwner = IsValid(placer)
	if validOwner then
		table.insert(tbl, true)
		table.insert(tbl, placer:GetdlogsID())
	else
		table.insert(tbl, false)
	end
	self.CallEvent(tbl)
end

function event:RemoveTimer(id)
	local timername = "HealTimer_"..tostring(id)
	if timer.Exists(timername) then
		timer.Remove(timername)
	end
end

function event:TTTEndRound()
	for k,_ in pairs(usages) do
		self:RemoveTimer(k)
	end
end

function event:ToString(tbl, roles)
	local ply = dlogs:InfoFromID(roles, tbl[1])
	local healerNick
	if tbl[3] then
		local healer = dlogs:InfoFromID(roles, tbl[4])
		healerNick = healer.nick.." ["..dlogs:StrRole(healer.role).."]"
	else
		healerNick = TTTLogTranslate(GetDMGLogLang, "healerNick")
	end
	return string.format(TTTLogTranslate(GetDMGLogLang, "HealthStationHeal"), ply.nick, dlogs:StrRole(ply.role), tbl[2], healerNick)
end

function event:IsAllowed(tbl)
	return dlogs.filter_settings["filter_show_healthstation"]
end

function event:Highlight(line, tbl, text)
	if table.HasValue(dlogs.Highlighted, tbl[1]) or table.HasValue(dlogs.Highlighted, tbl[2]) then
		return true
	end
	return false
end

function event:GetColor(tbl)
	return dlogs:GetColor("color_heal")
end

function event:RightClick(line, tbl, roles, text)
	line:ShowTooLong(true)
	local ply = dlogs:InfoFromID(roles, tbl[1])
	if tbl[3] then
		local healer = dlogs:InfoFromID(roles, tbl[4])
		line:ShowCopy(true,{ ply.nick, util.SteamIDFrom64(ply.steamid64) }, { healer.nick, util.SteamIDFrom64(healer.steamid64) })
	else
		line:ShowCopy(true,{ ply.nick, util.SteamIDFrom64(ply.steamid64) })
	end
end

dlogs:AddEvent(event)
