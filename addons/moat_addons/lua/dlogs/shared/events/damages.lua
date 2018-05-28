if SERVER then
	dlogs:EventHook("Initialize")
	dlogs:EventHook("PlayerTakeRealDamage")
else
	dlogs:AddFilter("filter_show_damages", DAMAGELOG_FILTER_BOOL, true)
	dlogs:AddColor("color_team_damages", Color(255, 40, 40))
	dlogs:AddColor("color_damages", Color(0, 0, 0))
end

local event = {}

event.Type = "DMG"
event.IsDamage = true

function event:Initialize()
	local old_func = GAMEMODE.PlayerTakeDamage
	function GAMEMODE:PlayerTakeDamage(ent, infl, att, amount, dmginfo)
		local original_dmg = dmginfo:GetDamage()
		if IsValid(att) then
			old_func(self, ent, infl, att, amount, dmginfo)
		end
		hook.Call("PlayerTakeRealDamage", GAMEMODE, ent, dmginfo, original_dmg)
	end
end

function event:PlayerTakeRealDamage(ent, dmginfo, original_dmg)

	local att = dmginfo:GetAttacker()
	if not (ent.IsGhost and ent:IsGhost()) and ent:IsPlayer() and (IsValid(att) and att:IsPlayer()) and ent != att then
		if math.floor(original_dmg) > 0 then
			local tbl = {
				[1] = ent:GetdlogsID() ,
				[2] = att:GetdlogsID(),
				[3] = math.Round(dmginfo:GetDamage()),
				[4] = dlogs:WeaponFromDmg(dmginfo),
				[5] = math.Round(original_dmg)
			}
			if dlogs:IsTeamkill(ent:GetRole(), att:GetRole()) then
				tbl.icon = { "icon16/exclamation.png" }
			elseif dlogs.Time then
				local found_dmg = false
				for k,v in pairs(dlogs.DamageTable) do
					if type(v) == "table" and dlogs.events[v.id] and dlogs.events[v.id].IsDamage then
						if v.time >= dlogs.Time - 10 and v.time <= dlogs.Time then
							found_dmg = true
							break
						end
					end
				end
				if not found_dmg then
					local first
					local shoots = {}
					for k,v in pairs(dlogs.ShootTables[dlogs.CurrentRound] or {}) do
						if k >= dlogs.Time - 10 and k <= dlogs.Time then
							shoots[k] = v
						end
					end
					for k,v in pairs(shoots) do
						if not first or k < first  then
							first = k
						end
					end
					if shoots[first] then
						for k,v in pairs(shoots[first]) do
							if v[1] == ent:Nick() then
								tbl.icon = { "icon16/error.png", TTTLogTranslate(GetDMGLogLang, "VictimShotFirst") }
							end
						end
					end
				end
			end
			self.CallEvent(tbl)
		end
	end

end

function event:ToString(tbl, roles)

	local weapon = tbl[4]
	weapon = dlogs:GetWeaponName(weapon)
	local karma_reduced = tbl[3] < tbl[5]
	local ent = dlogs:InfoFromID(roles, tbl[1])
	local att = dlogs:InfoFromID(roles, tbl[2])
	local str = string.format(TTTLogTranslate(GetDMGLogLang, "HasDamaged"), att.nick, dlogs:StrRole(att.role), ent.nick, dlogs:StrRole(ent.role), tbl[3])
	if karma_reduced then
		str = str .. string.format(" (%s)", tbl[5])
	end
	return str .. string.format(TTTLogTranslate(GetDMGLogLang, "HPWeapon"), weapon or TTTLogTranslate(GetDMGLogLang, "UnknownWeapon"))

end

function event:IsAllowed(tbl)
	return dlogs.filter_settings["filter_show_damages"]
end

function event:Highlight(line, tbl, text)
	if table.HasValue(dlogs.Highlighted, tbl[1]) or table.HasValue(dlogs.Highlighted, tbl[2]) then
		return true
	end
	return false
end

function event:GetColor(tbl, roles)

	local ent = dlogs:InfoFromID(roles, tbl[1])
	local att = dlogs:InfoFromID(roles, tbl[2])
	if dlogs:IsTeamkill(att.role, ent.role) then
		return dlogs:GetColor("color_team_damages")
	else
		return dlogs:GetColor("color_damages")
	end

end

function event:RightClick(line, tbl, roles, text)

	line:ShowTooLong(true)
	local attackerInfo = dlogs:InfoFromID(roles, tbl[1])
	local victimInfo = dlogs:InfoFromID(roles, tbl[2])
	line:ShowCopy(true, { attackerInfo.nick, util.SteamIDFrom64(attackerInfo.steamid64) }, { victimInfo.nick, util.SteamIDFrom64(victimInfo.steamid64) })
	line:ShowDamageInfos(tbl[2], tbl[1])

end

dlogs:AddEvent(event)
