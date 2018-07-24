if SERVER then
	dlogs:EventHook("dlogs_AslayHook")
else
	dlogs:AddFilter("filter_show_aslays", DAMAGELOG_FILTER_BOOL, true)
	dlogs:AddColor("colors_aslays", Color(255, 128, 128, 255))
end

local event = {}
event.Type = "ASLAY"

function event:dlogs_AslayHook(ply)
	local tbl = {
		[1] = ply:GetdlogsID()
	}

	self.CallEvent(tbl)
end

function event:ToString(v, roles)
	local ply = dlogs:InfoFromID(roles, v[1])

	return string.format(TTTLogTranslate(GetDMGLogLang, "AutoSlain"), ply.nick, dlogs:StrRole(ply.role))
end

function event:IsAllowed(tbl)
	return dlogs.filter_settings["filter_show_aslays"]
end

function event:Highlight(line, tbl, text)
	return table.HasValue(dlogs.Highlighted, tbl[1])
end

function event:GetColor(tbl)
	return dlogs:GetColor("colors_aslays")
end

function event:RightClick(line, tbl, roles, text)
	line:ShowTooLong(true)
	local ply = dlogs:InfoFromID(roles, tbl[1])
	line:ShowCopy(true, {ply.nick, util.SteamIDFrom64(ply.steamid64)})
end

dlogs:AddEvent(event)
