if SERVER then
	dlogs:EventHook("TTTBodyFound")
else
	dlogs:AddFilter("filter_show_bodies", DAMAGELOG_FILTER_BOOL, true)
	dlogs:AddColor("color_found_bodies", Color(127,0,255))
end

local event = {}

event.Type = "BODY"

function event:TTTBodyFound(ply, deadply, rag)
	local tbl = {
		[1] = ply:GetdlogsID()
	}
	if IsValid(deadply) then
		table.insert(tbl, deadply:GetdlogsID())
	else
		local nick = CORPSE.GetPlayerNick(rag, TTTLogTranslate(GetDMGLogLang, "DisconnectedPlayer"))
		for k,v in pairs(dlogs.Roles[#dlogs.Roles]) do
			if v.nick == nick then
				table.insert(tbl, k)
				break
			end
		end
	end
	self.CallEvent(tbl)
end

function event:ToString(v, roles)
	local ply = dlogs:InfoFromID(roles, v[1])
	local deadply = dlogs:InfoFromID(roles, v[2] or -1)
	return string.format(TTTLogTranslate(GetDMGLogLang, "BodyIdentified"), ply.nick, dlogs:StrRole(ply.role), deadply.nick, dlogs:StrRole(deadply.role))
end

function event:IsAllowed(tbl)
	return dlogs.filter_settings["filter_show_bodies"]
end

function event:Highlight(line, tbl, text)
	if table.HasValue(dlogs.Highlighted, tbl[1]) or table.HasValue(dlogs.Highlighted, tbl[2]) then
		return true
	end
	return false
end

function event:GetColor(tbl)
	return dlogs:GetColor("color_found_bodies")
end

function event:RightClick(line, tbl, roles, text)
	line:ShowTooLong(true)
	local ply = dlogs:InfoFromID(roles, tbl[1])
	line:ShowCopy(true,{ ply.nick, util.SteamIDFrom64(ply.steamid64) })
end

dlogs:AddEvent(event)