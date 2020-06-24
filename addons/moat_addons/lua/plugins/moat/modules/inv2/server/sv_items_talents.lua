print("talents loaded")

local plyMeta = FindMetaTable('Player')

function m_ApplyTalentsToWeapon(wep, talent_tbl)
    local talent_enum = talent_tbl.e
    local talent_mods = talent_tbl.m or {}
    local talent_servertbl = m_GetTalentFromEnumWithFunctions(talent_enum)

    if (talent_servertbl.ModifyWeapon) then
        talent_servertbl:ModifyWeapon(wep, talent_mods)
    end

	if (talent_servertbl.SuppressBullet) then
		if (not wep.SuppressBullet) then
			wep.SuppressBullet = {c = 0}
		end

		if (not wep.Modifications) then
			wep.Modifications = {}
		end

		wep.SuppressBullet.c = wep.SuppressBullet.c + 1
		wep.SuppressBullet[wep.SuppressBullet.c] = talent_servertbl
		wep.Modifications[wep.SuppressBullet.c] = talent_mods
	end
end

function m_ApplyTalentMods(wep, loadout_table)
    local weapon_lvl = wep.level

    for k, v in ipairs(loadout_table.t) do
        if (weapon_lvl >= v.l) then
            m_ApplyTalentsToWeapon(wep, v)
        end
    end
end

hook.Add("TTTPlayerSpeed", "moat_ApplyWeaponWeight", function(ply, slowed)
    if (ply:IsValid()) then
        local new_speed = (cur_random_round == "Fast") and 2 or 1

        if (ply:GetActiveWeapon() and ply:GetActiveWeapon().GetWeightMod) then
            new_speed = new_speed * (1 - ply:GetActiveWeapon():GetWeightMod() / 100)
        end

        if (MOAT_POWERUPTABLE[ply]) then
            if (MOAT_POWERUPTABLE[ply].item) then
                if (MOAT_POWERUPTABLE[ply].item.Name == "Marathon Runner") then
                    local powerup_mods = MOAT_POWERUPTABLE[ply].s or {}
                    local powerup_servertbl = MOAT_POWERUPTABLE[ply].item
                    new_speed = new_speed * (1 + ((powerup_servertbl.Stats[1].min + ((powerup_servertbl.Stats[1].max - powerup_servertbl.Stats[1].min) * math.min(1, powerup_mods[1]))) / 100))
                end
            end
        end
        
        if (ply.moatFrozen && ply.moatFrozenSpeed) && (ply:canBeMoatFrozen()) then
            local percentage = 1 - ply.moatFrozenSpeed
            new_speed = new_speed * percentage
        end

        if (ply:HasEquipmentItem(EQUIP_HERMES_BOOTS)) then
            if (ply:GetInfo("moat_hermes_boots") == "1" ) then
                new_speed = new_speed * 1.2
            end
        end

        if (ply.SpeedMod) then
            new_speed = new_speed * ply.SpeedMod
        end

        if (ply.speedforce) then
            new_speed = new_speed * ply.speedforce
        end

        return new_speed
    end
end)


function m_ApplyTalentsToWeaponOnDeath(vic, inf, att, talent_tbl)
    local talent_enum = talent_tbl.e
    local talent_mods = talent_tbl.m or {}
    local talent_servertbl = m_GetTalentFromEnumWithFunctions(talent_enum)

    if (talent_servertbl.OnPlayerDeath) then
        talent_servertbl:OnPlayerDeath(vic, inf, att, talent_mods)
    end
end

hook.Add("PlayerDeath", "moat_ApplyDeathTalents", function(vic, inf, att)
	if (vic == att) then
		return
	end
    if (not vic:IsValid() or not (att and att:IsValid() and att:IsPlayer())) then return end
    if (not inf:IsValid() or not (inf and inf:IsValid())) then return end
    if (not inf:IsWeapon()) then inf = att:GetActiveWeapon() end
	if (vic:GetJester() or att:GetJester()) then return end
    if (not inf.Talents) then return end

    local weapon_lvl = inf.level

    for k, v in ipairs(inf.Talents) do
        if (weapon_lvl >= v.l) then
            m_ApplyTalentsToWeaponOnDeath(vic, inf, att, v)
        end
    end
end)

hook.Add("PlayerShouldTakeDamage", "godmode", function(vic, att)
    if (IsValid(att) and att:IsPlayer() and att ~= vic and (vic:HasGodMode() or not gmod.GetGamemode():AllowPVP())) then
        return false
    end
end)

function m_ApplyTalentsToWeaponDuringDamage(dmginfo, victim, attacker, talent_tbl)
    if (not hook.Run("PlayerShouldTakeDamage", victim, attacker)) then
        return
    end

	local dmg = dmginfo:GetDamage()
	if (dmg <= 0) then return end

    if (hook.Run("m_ShouldPreventWeaponHitTalent", attacker, victim)) then
        return
    end

    local talent_enum = talent_tbl.e
    local talent_mods = talent_tbl.m or {}
    local talent_servertbl = m_GetTalentFromEnumWithFunctions(talent_enum)

    if (talent_servertbl.OnPlayerHit) then
        talent_servertbl:OnPlayerHit(victim, attacker, dmginfo, talent_mods)
    end
end

function m_ApplyTalentsToWeaponScalingDamage(dmginfo, victim, attacker, hitgroup, talent_tbl)
    local talent_enum = talent_tbl.e
    local talent_mods = talent_tbl.m or {}
    local talent_servertbl = m_GetTalentFromEnumWithFunctions(talent_enum)

    if (talent_servertbl.ScalePlayerDamage) then
        talent_servertbl:ScalePlayerDamage(victim, attacker, dmginfo, hitgroup, talent_mods)
    end
end

local allowedDmgTypes = {
	DMG_BULLET,
	DMG_CLUB
}

function m_CheckDamageMods(ent, dmginfo)
    if (not IsValid(ent) or not ent:IsPlayer()) then return false end
    local attacker = dmginfo:GetAttacker()

    if (not IsValid(attacker) or not attacker:IsPlayer()) then return false end
    if (GetRoundState() == ROUND_PREP or ent:GetJester() or attacker:GetJester()) then return false end

    -- Check damage types
    local goodType = false
    for _, type in pairs(allowedDmgTypes) do
        if (dmginfo:IsDamageType(type)) then
            goodType = true
            break
        end
    end
    if (not goodType) then return false end
	
    if (not IsValid(attacker:GetActiveWeapon())) then return false end
	
    return true
end

hook.Add("EntityTakeDamage", "moat_ApplyDamageMods", function(ent, dmginfo)
    if (not m_CheckDamageMods(ent, dmginfo)) then return end

    local attacker = dmginfo:GetAttacker()
    local weapon_tbl = attacker:GetActiveWeapon()
    if (not weapon_tbl.Talents) then return end
    local weapon_lvl = weapon_tbl.level

    for k, v in ipairs(weapon_tbl.Talents) do
        if (weapon_lvl >= v.l) then
            m_ApplyTalentsToWeaponDuringDamage(dmginfo, ent, attacker, v)
        end
    end
	
	if (ent.Fortified) then
		dmginfo:SetDamage(dmginfo:GetDamage() * ent.Fortified)
	end
	
	if (ent.Soften) then
		dmginfo:SetDamage(dmginfo:GetDamage() * ent.Soften)
	end
end)

function m_ApplyTalentsToWeaponDuringSwitch(ply, wep, talent_tbl, isto)
    local talent_enum = talent_tbl.e
    local talent_mods = talent_tbl.m or {}
    local talent_servertbl = m_GetTalentFromEnumWithFunctions(talent_enum)

    if (talent_servertbl.OnWeaponSwitch) then
        talent_servertbl:OnWeaponSwitch(ply, wep, isto, talent_mods)
    end
end

hook.Add("PlayerSwitchWeapon", "moat_ApplySwitchMods", function(ply, oldw, neww)
    if (oldw:IsValid() and oldw.Talents) then
        local weapon_lvl = oldw.level

        for k, v in ipairs(oldw.Talents) do
            if (weapon_lvl >= v.l) then
                m_ApplyTalentsToWeaponDuringSwitch(ply, oldw, v, false)
            end
        end
    end

    if (neww:IsValid() and neww.Talents) then
        local weapon_lvl = neww.level

        for k, v in ipairs(neww.Talents) do
            if (weapon_lvl >= v.l) then
                m_ApplyTalentsToWeaponDuringSwitch(ply, neww, v, true)
            end
        end
    end
end)

hook.Add("ScalePlayerDamage", "moat_ApplyScaleDamageMods", function(ply, hitgroup, dmginfo)
    if (not m_CheckDamageMods(ply, dmginfo)) then return end

    local attacker = dmginfo:GetAttacker()
    local weapon_tbl = attacker:GetActiveWeapon()
    if (not weapon_tbl.Talents) then return end
    local weapon_lvl = weapon_tbl.level

    for k, v in ipairs(weapon_tbl.Talents) do
        if (weapon_lvl >= v.l) then
            m_ApplyTalentsToWeaponScalingDamage(dmginfo, ply, attacker, hitgroup, v)
        end
    end
end)

function m_ApplyTalentsToWeaponOnFire(attacker, weapon_tbl, dmginfo, talent_tbl)
    local talent_enum = talent_tbl.e
    local talent_mods = talent_tbl.m or {}
    local talent_servertbl = m_GetTalentFromEnumWithFunctions(talent_enum)

    if (talent_servertbl.OnWeaponFired) then
		local t = talent_servertbl:OnWeaponFired(attacker, weapon_tbl, dmginfo, talent_mods)
		if (t == nil) then return end
		return t
    end
end

hook.Add("EntityFireBullets", "moat_ApplyFireMods", function(ent, dmginfo)
	if (not IsValid(ent) or not ent:IsPlayer()) then
		return
	end

	if (ent:GetJester()) then
		return
	end

	local wpn = ent:GetActiveWeapon()
    if (IsValid(wpn) and wpn.Talents) then
		for k, v in ipairs(wpn.Talents) do
			if (wpn.level >= v.l) then
				m_ApplyTalentsToWeaponOnFire(ent, wpn, dmginfo, v)
				--m_GetTalentFromEnumWithFunctions(talent_enum)
			end
		end

		return
	end
end)

local function m_CalculateLevel(cur_lvl, cur_exp, exp_to_add)
    local new_level, new_xp = cur_lvl, cur_exp

    if ((cur_exp + exp_to_add) < (cur_lvl * 100)) then
        return new_level, math.max(0, new_xp + exp_to_add)
    end

    new_xp = new_xp + exp_to_add
    while new_xp >= (new_level * 100) do
        new_xp = new_xp - (new_level * 100)
        new_level = new_level + 1
    end

    return new_level, new_xp
end

function m_UpdateItemLevel(weapon_tbl, attacker, exp_to_add)
    local unique_item_id = weapon_tbl.UniqueItemID
    local inv_item = nil

    for i = 1, 10 do
        if (MOAT_INVS[attacker]["l_slot" .. i] and MOAT_INVS[attacker]["l_slot" .. i].c) then
            if (MOAT_INVS[attacker]["l_slot" .. i].c == unique_item_id) then
                inv_item = MOAT_INVS[attacker]["l_slot" .. i]
                break
            end
        end
    end

    if (not inv_item) then
        for i = 1, attacker:GetMaxSlots() do
            if (MOAT_INVS[attacker]["slot" .. i] and MOAT_INVS[attacker]["slot" .. i].c) then
                if (MOAT_INVS[attacker]["slot" .. i].c == unique_item_id) then
                    inv_item = MOAT_INVS[attacker]["slot" .. i]
                    break
                end
            end
        end
        if (not inv_item) then return end
    end

    local cur_exp = inv_item.s.x
    local cur_lvl = inv_item.s.l
    local new_level, new_xp = m_CalculateLevel(cur_lvl, cur_exp, exp_to_add)

    inv_item.s.l = new_level
    inv_item.s.x = math.Round(new_xp)

    local level_upgrades = new_level - cur_lvl
    local we_saved = false
    if (level_upgrades > 0) then
        for i = 1, level_upgrades do
            if ((cur_lvl + i) % 2 == 0) then
                local crates = m_GetActiveCrates()
                local crate = crates[math.random(1, #crates)].Name
                if (player.GetCount() > 4) then
                    attacker:m_DropInventoryItem(crate, "hide_chat_obtained", false, false)
                end
                we_saved = true
            end
        end
    end

    net.Start("MOAT_UPDATE_EXP")
    net.WriteLong(tonumber(unique_item_id))
    net.WriteDouble(inv_item.s.l)
    net.WriteDouble(inv_item.s.x)
    net.Send(attacker)

    if (not we_saved) then m_SaveInventory(attacker) end
end

hook.Add("PlayerDeath", "moat_updateWeaponLevels", function(victim, inflictor, attacker)
    if (not attacker:IsValid() or not attacker:IsPlayer() or GetGlobal("MOAT_MINIGAME_ACTIVE")) then return end
	if (attacker == victim) then return end

    local wep_used = attacker:GetActiveWeapon()
    if (IsValid(inflictor) and (inflictor.MaxHoldTime or inflictor.UniqueItemID)) then wep_used = inflictor end

    if (wep_used.Talents and wep_used.PrimaryOwner == attacker) then
        local exp_to_add = 0

        local vic_killer = victim:IsTraitor() or victim:GetRole() == ROLE_KILLER
        local att_killer = attacker:IsTraitor() or attacker:GetRole() == ROLE_KILLER
	
		if (victim:GetRole() == attacker:GetRole()) then
            exp_to_add = -35
		elseif (victim:GetJester() or attacker:GetJester()) then
            exp_to_add = -75
        elseif ((vic_killer and attacker:GetDetective()) or (att_killer and victim:GetDetective())) then
            exp_to_add = 75
        elseif (vic_killer and not att_killer) then
            exp_to_add = 50
        elseif (att_killer and not vic_killer) then
            exp_to_add = 35
        end

        if (exp_to_add ~= 0 and GetRoundState() == ROUND_ACTIVE) then
            m_UpdateItemLevel(wep_used, attacker, (exp_to_add * XP_MULTIPYER) * attacker.ExtraXP)
        end
    end
end)

concommand.Add("moat_hermes_boots_toggle", function(pl)
    if (IsValid(pl)) then
        local herm = pl:GetInfo("moat_hermes_boots")

        if (herm == "1") then
            pl:ConCommand("moat_hermes_boots 0")
        else
            pl:ConCommand("moat_hermes_boots 1")
        end
    end
end)

hook.Add("PlayerSay", "Moat.Talents.PlayerSay", function(pl)
	if (pl.Talent_Muted) then 
		return ""
	end
end)

hook.Add("PlayerCanHearPlayersVoice", "Moat.Talents.PlayerCanHearPlayersVoice", function(listener, talker)
	if (talker.Talent_Muted) then 
		return false
	end
end)