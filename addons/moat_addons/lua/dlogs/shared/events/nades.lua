if SERVER then
	dlogs:EventHook("Initialize")
else
	dlogs:AddFilter("filter_show_nades", DAMAGELOG_FILTER_BOOL, true)
	dlogs:AddColor("color_nades", Color(0, 128, 0, 255))
end

local event = {}

event.Type = "NADE"

function event:Initialize()
	for k,v in pairs(weapons.GetList()) do
		if v.Base == "weapon_tttbasegrenade" then
			v.CreateGrenade = function(gren, src, ang, vel, angimp, ply)
				local tbl = {
					[1] = gren.Owner:GetdlogsID(),
					[2] = gren:GetClass()
				}
				self.CallEvent(tbl)
				return gren.BaseClass.CreateGrenade(gren, src, ang, vel, angimp, ply)
			end
		end
	end
end

function event:ToString(v, roles)
	local weapon = dlogs:GetWeaponName(v[2]) or tostring(v[2])
	local ply = dlogs:InfoFromID(roles, v[1])
	return string.format(TTTLogTranslate(GetDMGLogLang, "NadeThrown"), ply.nick, dlogs:StrRole(ply.role), weapon)
end

function event:IsAllowed(tbl)
	return dlogs.filter_settings["filter_show_nades"]
end

function event:Highlight(line, tbl, text)
	return table.HasValue(dlogs.Highlighted, tbl[1])
end

function event:GetColor(tbl)
	return dlogs:GetColor("color_nades")
end

function event:RightClick(line, tbl, roles, text)
	line:ShowTooLong(true)
	local ply = dlogs:InfoFromID(roles, tbl[1])
	line:ShowCopy(true, { ply.nick, util.SteamIDFrom64(ply.steamid64) })
end

dlogs:AddEvent(event)
