if SERVER then
	dlogs:EventHook("TTTToggleDisguiser")
	dlogs:EventHook("TTTBeginRound")
	dlogs:EventHook("TTTTraitorButtonActivated")
	dlogs:EventHook("TTTBoughtRoleT")
	dlogs:EventHook("Initialize")
else
	dlogs:AddFilter("filter_show_disguises", DAMAGELOG_FILTER_BOOL, false)
	dlogs:AddFilter("filter_show_teleports", DAMAGELOG_FILTER_BOOL, true)
	dlogs:AddFilter("filter_show_traps", DAMAGELOG_FILTER_BOOL, true)
	dlogs:AddFilter("filter_show_psroles", DAMAGELOG_FILTER_BOOL, true)
	dlogs:AddColor("color_misc", Color(0, 179, 179, 255))
end

local event = {}

event.Type = "MISC"

function event:TTTToggleDisguiser(ply, state)
	if ply.NoDisguise then return end
	local timername = "DisguiserTimer_"..tostring(ply:SteamID())
	if not timer.Exists(timername) then
		ply.DisguiseUses = 1
		ply.DisguiseTimer = 10
		timer.Create(timername, 1, 0, function()
			if not IsValid(ply) then
				timer.Remove(timername)
			else
				ply.DisguiseTimer = ply.DisguiseTimer - 1
				if ply.DisguiseTimer <= 0 then
					timer.Remove(timername)
				end
				if ply.DisguiseUses > 6 then
					ply.NoDisguise = true
					self.CallEvent({
						[1] = 3,
						[2] = ply:GetdlogsID()
					})
					timer.Remove(timername)
				end
			end
		end)
	else
		if ply.DisguiseUses and ply.DisguiseTimer then
			ply.DisguiseUses = ply.DisguiseUses + 1
			ply.DisguiseTimer = ply.DisguiseTimer + 1
		end
	end
	self.CallEvent({
		[1] = 1,
		[2] = ply:GetdlogsID(),
		[3] = state
	})
end


function event:TTTBeginRound()
	for k,v in ipairs(player.GetHumans()) do
		if v.NoDisguise then
			v.NoDisguise = false
		end
	end
end

function event:TTTTraitorButtonActivated(btn, ply)
	if not IsValid(ply) or not ply:IsActive() then return end
	self.CallEvent({
		[1] = 4,
		[2] = ply:GetdlogsID(),
		[3] = btn:GetDescription()
	})
end

function event:TTTBoughtRoleT(ply)
	if not IsValid(ply) or not ply:IsActive() then return end
	self.CallEvent({
		[1] = 5,
		[2] = ply:GetdlogsID()
	})
end

function event:Initialize()
	local weap = weapons.GetStored("weapon_ttt_teleport")
	local old_func = weap.TakePrimaryAmmo
	weap.TakePrimaryAmmo = function(wep, count)
		self.CallEvent({
			[1] = 2,
			[2] = wep.Owner:GetdlogsID()
		})
		if old_func then
			return old_func(wep, count)
		else
			return wep.BaseClass.TakePrimaryAmmo(wep, count)
		end
	end
end

function event:ToString(v, roles)
	local ply = dlogs:InfoFromID(roles, v[2])
	if v[1] == 1 then
		return string.format(TTTLogTranslate(GetDMGLogLang, "DisguiserAct"), ply.nick, dlogs:StrRole(ply.role), v[3] and TTTLogTranslate(GetDMGLogLang, "enabled") or TTTLogTranslate(GetDMGLogLang, "disabled"))
	elseif v[1] == 2 then
		return string.format(TTTLogTranslate(GetDMGLogLang, "Teleported"), ply.nick, dlogs:StrRole(ply.role))
	elseif v[1] == 3 then
		return string.format(TTTLogTranslate(GetDMGLogLang, "DisguiserSpam"), ply.nick, dlogs:StrRole(ply.role))
	elseif v[1] == 4 then
		return string.format(TTTLogTranslate(GetDMGLogLang, "TrapActivated"), ply.nick, v[3])
	elseif v[1] == 5 then
		return string.format(TTTLogTranslate(GetDMGLogLang, "RoundBought"), ply.nick)
	end
end

function event:IsAllowed(tbl)
	if (tbl[1] == 1 or tbl[1] == 3) and not dlogs.filter_settings["filter_show_disguises"] then return false end
	if tbl[1] == 2 and not dlogs.filter_settings["filter_show_teleports"] then return false end
	if tbl[1] == 4 and not dlogs.filter_settings["filter_show_traps"] then return false end
	if tbl[1] == 5 and not dlogs.filter_settings["filter_show_psroles"] then return false end
	return true
end

function event:Highlight(line, tbl, text)
	return table.HasValue(dlogs.Highlighted, tbl[2])
end

function event:GetColor(tbl)
	return dlogs:GetColor("color_misc")
end

function event:RightClick(line, tbl, roles, text)
	line:ShowTooLong(true)
	local ply = dlogs:InfoFromID(roles, tbl[2])
	line:ShowCopy(true, { ply.nick, util.SteamIDFrom64(ply.steamid64) })
end

dlogs:AddEvent(event)
