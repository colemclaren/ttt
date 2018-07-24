if SERVER then
	dlogs:EventHook("DoPlayerDeath")
else
	dlogs:AddFilter("filter_show_suicides", DAMAGELOG_FILTER_BOOL, true)
	dlogs:AddColor("color_suicides", Color(25, 25, 220, 255))
end

local event = {}

event.Type = "KILL"

function event:DoPlayerDeath(ply, attacker, dmginfo)
	local class = attacker:GetClass()
	if ((IsValid(attacker) and ((attacker:IsPlayer() and attacker == ply) or class == "prop_physics" or class == "func_physbox"))) or attacker:IsWorld() and not (dmginfo:IsDamageType(DMG_DROWN) or (ply.IsGhost and ply:IsGhost())) then
		dlogs.SceneID = dlogs.SceneID + 1
		local scene = dlogs.SceneID
		dlogs.SceneRounds[scene] = dlogs.CurrentRound
		local tbl = {
			[1] = ply:GetdlogsID(),
			[2] = scene
		}
		if scene then
			timer.Simple(0.6, function()
				dlogs.Death_Scenes[scene] = table.Copy(dlogs.Records)
			end)
		end
		self.CallEvent(tbl)
		ply.rdmInfo = {
			time = dlogs.Time,
			round = dlogs.CurrentRound,
		}
		ply.rdmSend = true
	end
end

function event:ToString(v, roles)
	local info = dlogs:InfoFromID(roles, v[1])
	return string.format(TTTLogTranslate(GetDMGLogLang, "SomethingKilled"), info.nick, dlogs:StrRole(info.role))
end

function event:IsAllowed(tbl)
	return dlogs.filter_settings["filter_show_suicides"]
end

function event:Highlight(line, tbl, text)
	return table.HasValue(dlogs.Highlighted, tbl[1])
end

function event:GetColor(tbl)
	return dlogs:GetColor("color_suicides")
end

function event:RightClick(line, tbl, roles, text)
	line:ShowTooLong(true)
	local ply = dlogs:InfoFromID(roles, tbl[1])
	line:ShowCopy(true, { ply.nick, util.SteamIDFrom64(ply.steamid64) })
	line:ShowDeathScene(tbl[1], tbl[1], tbl[2])
end

dlogs:AddEvent(event)
