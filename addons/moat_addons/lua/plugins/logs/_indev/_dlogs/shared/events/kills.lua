if SERVER then
	dlogs:EventHook("DoPlayerDeath")
else
	dlogs:AddFilter("filter_show_kills", DAMAGELOG_FILTER_BOOL, true)
	dlogs:AddColor("color_team_kills", Color(255, 40, 40))
	dlogs:AddColor("color_kills", Color(255, 128, 0, 255))
end

local event = {}

event.Type = "KILL"

function event:DoPlayerDeath(ply, attacker, dmginfo)
	if IsValid(attacker) and attacker:IsPlayer() and attacker != ply and not (attacker.IsGhost and attacker:IsGhost()) then
		local scene = false
		dlogs.SceneID = dlogs.SceneID + 1
		scene = dlogs.SceneID
		dlogs.SceneRounds[scene] = dlogs.CurrentRound
		local tbl = {
			[1] = attacker:GetdlogsID(),
			[2] = ply:GetdlogsID(),
			[3] = dlogs:WeaponFromDmg(dmginfo),
			[4] = scene
		}
		self.CallEvent(tbl)
		if scene then
			timer.Simple(0.6, function()
				dlogs.Death_Scenes[scene] = table.Copy(dlogs.Records)
			end)
		end
		if GetRoundState() == ROUND_ACTIVE then
			net.Start("dlogs.Ded")
			if attacker:GetRole() == ROLE_TRAITOR and (ply:GetRole() == ROLE_INNOCENT or ply:GetRole() == ROLE_DETECTIVE) then
				net.WriteUInt(0,1)
			else
				net.WriteUInt(1,1)
				net.WriteString(attacker:Nick())
			end
			net.Send(ply)
			ply:SetNW2Entity("dlogs.Killer", attacker)
		end
	end
end

function event:ToString(v, roles)
	local weapon = v[3]
	weapon = dlogs:GetWeaponName(weapon)
	local attackerInfo = dlogs:InfoFromID(roles, v[1])
	local victimInfo = dlogs:InfoFromID(roles, v[2])
	return string.format(TTTLogTranslate(GetDMGLogLang, "HasKilled"), attackerInfo.nick, dlogs:StrRole(attackerInfo.role), victimInfo.nick, dlogs:StrRole(victimInfo.role), weapon or TTTLogTranslate(GetDMGLogLang, "UnknownWeapon"))

end

function event:IsAllowed(tbl)
	return dlogs.filter_settings["filter_show_kills"]
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
	if dlogs:IsTeamkill(ent.role, att.role) then
		return dlogs:GetColor("color_team_kills")
	else
		return dlogs:GetColor("color_kills")
	end

end

function event:RightClick(line, tbl, roles, text)
	local attackerInfo = dlogs:InfoFromID(roles, tbl[1])
	local victimInfo = dlogs:InfoFromID(roles, tbl[2])
	line:ShowTooLong(true)
	line:ShowCopy(true, { attackerInfo.nick, util.SteamIDFrom64(attackerInfo.steamid64) }, { victimInfo.nick, util.SteamIDFrom64(victimInfo.steamid64) })
	line:ShowDamageInfos(tbl[1], tbl[2])
	line:ShowDeathScene(tbl[2], tbl[1], tbl[4])
end

dlogs:AddEvent(event)
