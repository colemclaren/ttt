print("loadout loaded")

util.AddNetworkString("MOAT_UPDATE_WEP")
util.AddNetworkString("MOAT_UPDATE_OTHER_WEP")
util.AddNetworkString("MOAT_NET_SPAWN")
util.AddNetworkString("MOAT_UPDATE_WEP_CACHE")
util.AddNetworkString("MOAT_UPDATE_OTHER_WEP_CACHE")

MOAT_LOADOUT = {}

-- We only need to know if the weapon is a unique or a tier, nothing else
local item_kind_codes = {
    ["tier"] = "1"
}

function MOAT_LOADOUT.ResetPowerupAbilities(ply)
    if (not IsValid(ply)) then return end
    
    ply:SetJumpPower(160)
    ply.JumpHeight = 160
    ply:SetMaxHealth(100)
    ply.MaxHealth = 100
    ply:SetHealth(100)
    ply.ExtraXP = 1
end

function MOAT_LOADOUT.GetLoadout(ply)
    local tbl = {}

    for i = 1, 5 do
        if (MOAT_INVS and MOAT_INVS[ply] and MOAT_INVS[ply]["l_slot" .. i]) then
            tbl[i] = table.Copy(MOAT_INVS[ply]["l_slot" .. i])
        else
            tbl[i] = nil
            continue
        end

        if (not tbl[i].c) then
            tbl[i] = {}
            continue
        else
            tbl[i].item = m_GetItemFromEnumWithFunctions(tbl[i].u)

            if (tbl[i].t) then
                tbl[i].Talents = {}

                for k, v in ipairs(tbl[i].t) do
                    tbl[i].Talents[k] = m_GetTalentFromEnumWithFunctions(v.e)
                end
            end

            if (tbl[i] and tbl[i].item and (tbl[i].item.Kind == "Other" or tbl[i].item.Kind == "Unique")) then
                if (tbl[i].item.WeaponClass) then
                    tbl[i].w = tbl[i].item.WeaponClass
                end    
            end
        end
    end

    return tbl[1], tbl[2], tbl[3], tbl[4], tbl[5]
end

function m_GetLoadout(ply)
    return MOAT_LOADOUT.GetLoadout(ply)
end

function MOAT_LOADOUT.GetCosmetics(ply)
    local tbl = {}

    for i = 6, 10 do
        tbl[i] = table.Copy(MOAT_INVS[ply]["l_slot" .. i]) or {}

        if (not tbl[i].c) then
            tbl[i] = {}
            continue
        else
            tbl[i].item = m_GetItemFromEnumWithFunctions(tbl[i].u)
        end
    end

    return tbl[6], tbl[7], tbl[8], tbl[9], tbl[10]
end

function MOAT_LOADOUT.SetPlayerModel(ply, item_tbl)
    if (item_tbl.item.OnPlayerSpawn) then
        item_tbl.item:OnPlayerSpawn(ply)
    end

    if (MOAT_INVS and MOAT_INVS[ply] and MOAT_INVS[ply]["l_slot10"] and MOAT_INVS[ply]["l_slot10"].p2 and MOAT_PAINT) then
        local col = MOAT_PAINT.Colors[MOAT_INVS[ply]["l_slot10"].p2 - (#MOAT_PAINT.Colors) - 6000][2]
        ply:SetColor(Color(col[1], col[2], col[3], 255))
        ply:SetPlayerColor(Vector(col[1]/255, col[2]/255, col[3]/255))
    end
end

function MOAT_LOADOUT.SaveLoadedWeapons()
    loadout_weapon_indexes = {}
    loadout_cosmetic_indexes = {}
end
hook.Add("TTTBeginRound", "moat_SaveLoadedWeapons", MOAT_LOADOUT.SaveLoadedWeapons)

function MOAT_LOADOUT.ApplyWeaponMods(tbl, loadout_tbl, w)
    local wep = tbl
    local itemtbl = table.Copy(loadout_tbl)

    if (itemtbl.s) then
        if (itemtbl.s.d) then
            wep.Primary.Damage = wep.Primary.Damage * (1 + ((itemtbl.item.Stats.Damage.min + ((itemtbl.item.Stats.Damage.max - itemtbl.item.Stats.Damage.min) * itemtbl.s.d)) / 100))
        end

        if (itemtbl.s.f) then
            wep.Primary.Delay = wep.Primary.Delay * (1 - ((itemtbl.item.Stats.Firerate.min + ((itemtbl.item.Stats.Firerate.max - itemtbl.item.Stats.Firerate.min) * itemtbl.s.f)) / 100))
        end

        if (itemtbl.s.m) then
            wep.Primary.ClipSize = math.Round(wep.Primary.ClipSize * (1 + ((itemtbl.item.Stats.Magazine.min + ((itemtbl.item.Stats.Magazine.max - itemtbl.item.Stats.Magazine.min) * itemtbl.s.m)) / 100)))
            wep.Primary.DefaultClip = wep.Primary.ClipSize
            wep.Primary.ClipMax = (wep.Primary.DefaultClip * 3)
        end

        if (itemtbl.s.a) then
            wep.Primary.Cone = wep.Primary.Cone * (1 - ((itemtbl.item.Stats.Accuracy.min + ((itemtbl.item.Stats.Accuracy.max - itemtbl.item.Stats.Accuracy.min) * itemtbl.s.a)) / 100))
        end

        if (itemtbl.s.k) then
            wep.Primary.Recoil = wep.Primary.Recoil * (1 + ((itemtbl.item.Stats.Kick.min + ((itemtbl.item.Stats.Kick.max - itemtbl.item.Stats.Kick.min) * itemtbl.s.k)) / 100))
        end

        if (itemtbl.s.w) then
            wep.weight_mod = 1 + ((itemtbl.item.Stats.Weight.min + ((itemtbl.item.Stats.Weight.max - itemtbl.item.Stats.Weight.min) * itemtbl.s.w)) / 100)
            w:SetNWFloat("weight_mod", wep.weight_mod)
        end

        if (itemtbl.s.r) then
            wep.range_mod = 1 + ((itemtbl.item.Stats.Range.min + ((itemtbl.item.Stats.Range.max - itemtbl.item.Stats.Range.min) * itemtbl.s.r)) / 100)
        end

        if (itemtbl.s.v) then
            wep.PushForce = wep.PushForce * (1 + ((itemtbl.item.Stats.Force.min + ((itemtbl.item.Stats.Force.max - itemtbl.item.Stats.Force.min) * itemtbl.s.v)) / 100))
        end

        if (itemtbl.s.p) then
            wep.Secondary.Delay = wep.Secondary.Delay * (1 - ((itemtbl.item.Stats.Pushrate.min + ((itemtbl.item.Stats.Pushrate.max - itemtbl.item.Stats.Pushrate.min) * itemtbl.s.p)) / 100))
        end
    end

    if (itemtbl.t) then
        wep.Talents = table.Copy(itemtbl.t)
        wep.level = itemtbl.s.l
        wep.exp = itemtbl.s.x
        m_ApplyTalentMods(wep, itemtbl)
    end

    wep.ItemStats = itemtbl or {}

    return wep
end

function m_ApplyWeaponMods(tbl, loadout_tbl)
    return MOAT_LOADOUT.ApplyWeaponMods(tbl, loadout_tbl)
end

function MOAT_LOADOUT.ApplyOtherModifications(tbl, loadout_tbl)
    local wep = tbl
    local itemtbl = table.Copy(loadout_tbl)

    if (itemtbl and itemtbl.item and itemtbl.item.Stats and itemtbl.s and #itemtbl.s > 0) then
        wep.InventoryModifications = {}

        for i = 1, #itemtbl.s do
            wep.InventoryModifications[i] = itemtbl.item.Stats[i].min + ((itemtbl.item.Stats[i].max - itemtbl.item.Stats[i].min) * itemtbl.s[i])
        end
    end
end

local loadout_weapon_indexes = {}
local loadout_cosmetic_indexes = {}
MOAT_MODEL_EDIT_POS = MOAT_MODEL_EDIT_POS or {}

function MOAT_LOADOUT.SaveLoadedWeapons()
    loadout_weapon_indexes = {}
    loadout_cosmetic_indexes = {}
end
hook.Add("TTTPrepareRound", "moat_SaveLoadedWeapons", MOAT_LOADOUT.SaveLoadedWeapons)


function MOAT_LOADOUT.HasCosmeticInLoadout(ply, id)
    local return_val = false
    local item_tbl = {}

    if (isnumber(id)) then
        for k, v in ipairs(loadout_cosmetic_indexes) do
            if (v[1] == ply:EntIndex() and v[2] == id) then
                return_val = true
                item_tbl = m_GetItemFromEnumWithFunctions(id)
                break
            end
        end
    else
        for k, v in ipairs(loadout_cosmetic_indexes) do
            local cosmetic_tbl = m_GetItemFromEnumWithFunctions(v[2])

            if (v[1] == ply:EntIndex() and cosmetic_tbl.Kind == id) then
                return_val = true
                item_tbl = cosmetic_tbl
                break
            end
        end
    end

    return return_val, item_tbl
end

--[[
hook.Add( "PlayerSetModel", "moat_SetPlayerModel", function( ply )

    local has_item, tbl = m_HasCosmeticInLoadout( ply, "Model" )

    if ( has_item ) then

        ply:SetModel( tbl.Model )

    end

end )]]
-- Hook wasn't doing it for whatever reason, so just overwrited default... (That above code)

MOAT_LOADOUT.UpdateWepCache = {}
MOAT_LOADOUT.UpdateOtherWepCache = {}

function MOAT_LOADOUT.GivePlayerLoadout(ply, pri_wep, sec_wep, melee_wep, powerup, tactical, is_reequip)
    if (hook.Call("MoatInventoryShouldGiveLoadout", nil, ply)) then return end
    if (not IsValid(ply)) then return end

    local loadout_table = {
        ["Primary"] = pri_wep,
        ["Secondary"] = sec_wep,
        ["Melee"] = melee_wep,
        ["Power-Up"] = powerup,
        ["Other"] = tactical
    }

    if (not is_reequip) then
        MOAT_LOADOUT.ResetPowerupAbilities(ply)
        local cos_head, cos_mask, cos_body, cos_effect, cos_model = MOAT_LOADOUT.GetCosmetics(ply)

        local cosmetic_table = {
            ["Hat"] = cos_head,
            ["Mask"] = cos_mask,
            ["Body"] = cos_body,
            ["Effect"] = cos_effect,
            ["Model"] = cos_model
        }

        for k, v in pairs(cosmetic_table) do
            if (v.c) then
                local paint = 0
                if (v.p) then paint = v.p - 6000 end
                if (v.p2) then paint = v.p2 - 6000 end

                table.insert(loadout_cosmetic_indexes, {ply:EntIndex(), v.u, paint})

                if (k == "Model") then
                    MOAT_LOADOUT.SetPlayerModel(ply, v)
                    continue
                end
                    
                net.Start("MOAT_APPLY_MODELS")
                net.WriteUInt(ply:EntIndex(), 16)
                net.WriteUInt(v.u, 16)
                net.WriteUInt(paint, 8)

                if (MOAT_MODEL_EDIT_POS[ply] and MOAT_MODEL_EDIT_POS[ply][v.u]) then
                    net.WriteBool(true)
                    net.WriteDouble(MOAT_MODEL_EDIT_POS[ply][v.u][1])
                    net.WriteDouble(MOAT_MODEL_EDIT_POS[ply][v.u][2])
                    net.WriteDouble(MOAT_MODEL_EDIT_POS[ply][v.u][3])
                    net.WriteDouble(MOAT_MODEL_EDIT_POS[ply][v.u][4])
                    net.WriteDouble(MOAT_MODEL_EDIT_POS[ply][v.u][5])
                    net.WriteDouble(MOAT_MODEL_EDIT_POS[ply][v.u][6])
                else
                    net.WriteBool(false)
                end

                net.Broadcast()
            end
        end
    end

    for k, v in pairs(loadout_table) do
        if (k == "Power-Up") then
            if (v.c) then
                m_ApplyPowerUp(ply, v)
            end

            continue
        end

        if (k == "Other") then
            if (v.c) then
                local weapon_table = {}

                if (v.w) then
                    weapon_table = weapons.Get(v.w)
                else
                    continue
                end

                for k2, v2 in pairs(ply:GetWeapons()) do
                    if (v2.Kind == weapon_table.Kind) then
                        ply:StripWeapon(v2.ClassName)
                    end
                end

                local v3 = ply:Give(v.w)
                local wpn_tbl = v3:GetTable()

                MOAT_LOADOUT.ApplyOtherModifications(wpn_tbl, v)

                net.Start("MOAT_UPDATE_OTHER_WEP")
                net.WriteUInt(v3:EntIndex(), 16)
                net.WriteDouble(ply:EntIndex())

                local item_old = table.Copy(v.item)
                v.item = m_GetItemFromEnum(v.u)

                net.WriteTable(v)
                net.Broadcast()

                table.insert(loadout_weapon_indexes, {v3:EntIndex(), v})
                v.item = item_old
            end

            continue
        end

        if (v.c) then
            local weapon_table = {}

            if (v.w) then
                weapon_table = weapons.Get(v.w)
            end

            for k2, v2 in pairs(ply:GetWeapons()) do
                if (v2.Kind == weapon_table.Kind) then
                    ply:StripWeapon(v2.ClassName)
                end
            end

            local v3 = ply:Give(v.w)
            local wpn_tbl = v3:GetTable()

            wpn_tbl = v3:GetTable()
            MOAT_LOADOUT.ApplyWeaponMods(wpn_tbl, v, v3)
            v3:SetClip1(wpn_tbl.Primary.DefaultClip)
            wpn_tbl.UniqueItemID = v.c
            wpn_tbl.PrimaryOwner = ply

            net.Start("MOAT_UPDATE_WEP")
            net.WriteUInt(v3:EntIndex(), 16)
            net.WriteDouble(wpn_tbl.Primary.Damage or 0)
            net.WriteDouble(wpn_tbl.Primary.Delay or 0)
            net.WriteDouble(wpn_tbl.Primary.ClipSize or 0)
            net.WriteDouble(wpn_tbl.Primary.Recoil or 0)
            net.WriteDouble(wpn_tbl.Primary.Cone or 0)
            net.WriteDouble(wpn_tbl.PushForce or 0)
            net.WriteDouble(wpn_tbl.Secondary.Delay or 0)
            net.WriteDouble(ply:EntIndex())
            local kind_addition = ""

            if (item_kind_codes[v.item.Kind]) then
                kind_addition = item_kind_codes[v.item.Kind]
            end

            local item_old = table.Copy(v.item)
            v.item = {}
            v.item = m_GetItemFromEnum(v.u)

            if (v.t) then
                v.Talents = {}

                for k5, v5 in ipairs(v.t) do
                    v.Talents[k5] = m_GetTalentFromEnum(v5.e)
                end
            end

            net.WriteTable(v)
            net.Broadcast()
            table.insert(loadout_weapon_indexes, {v3:EntIndex(), v})

            if (wpn_tbl.Primary.Ammo and wpn_tbl.Primary.ClipSize and ply:GetAmmoCount(wpn_tbl.Primary.Ammo) < wpn_tbl.Primary.ClipSize) then
                ply:GiveAmmo(wpn_tbl.Primary.ClipSize, wpn_tbl.Primary.Ammo, true)
            end

            v.item = item_old
        end
    end
end

function m_GivePlayerLoadout(ply, pri_wep, sec_wep, melee_wep, powerup, tactical, is_reequip)
    return MOAT_LOADOUT.GivePlayerLoadout(ply, pri_wep, sec_wep, melee_wep, powerup, tactical, is_reequip)
end

function MOAT_LOADOUT.GiveLoadout(ply)
    if (ply:IsSpec()) then return end
    if (GetRoundState() == ROUND_WAIT) then return end
    local pri_wep, sec_wep, melee_wep, powerup, tactical = m_GetLoadout(ply)

    net.Start("MOAT_NET_SPAWN")
    net.Send(ply)

    timer.Create("moat_CheckLoadoutSpawn" .. ply:EntIndex(), 1, 0, function()
        local pri_wep, sec_wep, melee_wep, powerup, tactical = m_GetLoadout(ply)

        if (pri_wep and sec_wep and melee_wep and powerup and tactical) then
            m_GivePlayerLoadout(ply, pri_wep, sec_wep, melee_wep, powerup, tactical)
            timer.Remove("moat_CheckLoadoutSpawn" .. ply:EntIndex())
        end
    end)
end
hook.Add("PlayerSpawn", "moat_GiveLoadout", MOAT_LOADOUT.GiveLoadout)

function MOAT_LOADOUT.LoadLoadedLoadouts(ply)
    if (table.Count(loadout_weapon_indexes) < 1) then return end

    for k, v in pairs(loadout_weapon_indexes) do
        if (not Entity(v[1]):IsValid()) then continue end
        if (not v[1]) then continue end
        local wpn_tbl = Entity(v[1]).Weapon
        local wpn_dmg = 0
        if (not wpn_tbl) then continue end

        if (wpn_tbl.Primary.Damage) then
            wpn_dmg = wpn_tbl.Primary.Damage
        end

        local wpn_delay = 0

        if (wpn_tbl.Primary.Delay) then
            wpn_delay = wpn_tbl.Primary.Delay
        end

        local wpn_clip = 0

        if (wpn_tbl.Primary.ClipSize) then
            wpn_clip = wpn_tbl.Primary.ClipSize
        end

        local wpn_recoil = 0

        if (wpn_tbl.Primary.Recoil) then
            wpn_recoil = wpn_tbl.Primary.Recoil
        end

        local wpn_cone = 0

        if (wpn_tbl.Primary.Cone) then
            wpn_cone = wpn_tbl.Primary.Cone
        end

        local wpn_force = 0

        if (wpn_tbl.PushForce) then
            wpn_force = wpn_tbl.PushForce
        end

        local wpn_delay2 = 0

        if (wpn_tbl.Secondary.Delay) then
            wpn_delay2 = wpn_tbl.Secondary.Delay
        end

        local wpn_ownerindex = 0

        if (wpn_tbl.PrimaryOwner) then
            wpn_ownerindex = wpn_tbl.PrimaryOwner:EntIndex()
        end

        net.Start("MOAT_UPDATE_WEP")
        net.WriteUInt(v[1], 16)
        net.WriteDouble(wpn_dmg)
        net.WriteDouble(wpn_delay)
        net.WriteDouble(wpn_clip)
        net.WriteDouble(wpn_recoil)
        net.WriteDouble(wpn_cone)
        net.WriteDouble(wpn_force)
        net.WriteDouble(wpn_delay2)
        net.WriteDouble(wpn_ownerindex)
        net.WriteTable(v[2])
        net.Send(ply)
    end
end
hook.Add("PlayerInitialSpawn", "moat_LoadLoadedLoadouts", MOAT_LOADOUT.LoadLoadedLoadouts)


function MOAT_LOADOUT.LoadCosmeticLoadouts(ply)
    if (table.Count(loadout_cosmetic_indexes) < 1) then return end

    for k, v in pairs(loadout_cosmetic_indexes) do
        if (not ents.GetByIndex(v[1]):IsValid()) then continue end
        net.Start("MOAT_APPLY_MODELS")
        net.WriteDouble(v[1])
        net.WriteDouble(v[2])
        net.WriteUInt(v[3], 8)
        net.Send(ply)
    end
end
hook.Add("PlayerInitialSpawn", "moat_LoadCosmeticLoadouts", MOAT_LOADOUT.LoadCosmeticLoadouts)

--[[-------------------------------------------------------------------------
Custom Model Positioning
---------------------------------------------------------------------------]]

util.AddNetworkString("MOAT_UPDATE_MODEL_POS")

function MOAT_LOADOUT.UpdateModelPos(_, ply)
    local item_id = net.ReadUInt(16)
    local pos_table = {
        [1] = math.Clamp(net.ReadDouble(), -180, 180),
        [2] = math.Clamp(net.ReadDouble(), -180, 180),
        [3] = math.Clamp(net.ReadDouble(), 0.8, 1.2),
        [4] = math.Clamp(net.ReadDouble(), -2.5, 2.5),
        [5] = math.Clamp(net.ReadDouble(), -2.5, 2.5),
        [6] = math.Clamp(net.ReadDouble(), -2.5, 2.5)
    }

    if (not MOAT_MODEL_EDIT_POS[ply]) then
        MOAT_MODEL_EDIT_POS[ply] = {}
    end

    MOAT_MODEL_EDIT_POS[ply][item_id] = {
        pos_table[1],
        pos_table[2],
        pos_table[3],
        pos_table[4],
        pos_table[5],
        pos_table[6]
    }
end
net.Receive("MOAT_UPDATE_MODEL_POS", MOAT_LOADOUT.UpdateModelPos)


--[[-------------------------------------------------------------------------
Gamemode Fixes
---------------------------------------------------------------------------]]

hook.Add("PostGamemodeLoaded", "moat_OverwritePlayermodel", function()
    function GAMEMODE:PlayerSetModel(ply)
        local mdl = GAMEMODE.playermodel or "models/player/phoenix.mdl"
        local has_item, tbl = MOAT_LOADOUT.HasCosmeticInLoadout(ply, "Model")

        if (has_item) then
            mdl = tbl.Model
        end

        util.PrecacheModel(mdl)
        ply:SetModel(mdl)
        ply:SetColor(COLOR_WHITE)

        if (MOAT_INVS and MOAT_INVS[ply] and MOAT_INVS[ply]["l_slot10"] and MOAT_INVS[ply]["l_slot10"].p2 and MOAT_PAINT) then
            local col = MOAT_PAINT.Colors[MOAT_INVS[ply]["l_slot10"].p2 - (#MOAT_PAINT.Colors) - 6000][2]
            ply:SetColor(Color(col[1], col[2], col[3], 255))
            ply:SetPlayerColor(Vector(col[1]/255, col[2]/255, col[3]/255))
        end
    end

    function GAMEMODE:TTTPlayerSetColor(ply)
        local clr = COLOR_WHITE
        if (MOAT_INVS and MOAT_INVS[ply] and MOAT_INVS[ply]["l_slot10"] and MOAT_INVS[ply]["l_slot10"].p2 and MOAT_PAINT) then
            local col = MOAT_PAINT.Colors[MOAT_INVS[ply]["l_slot10"].p2 - (#MOAT_PAINT.Colors) - 6000][2]
            ply:SetColor(Color(col[1], col[2], col[3], 255))
            ply:SetPlayerColor(Vector(col[1]/255, col[2]/255, col[3]/255))
        else
            ply:SetPlayerColor(Vector(1, 1, 1))
        end
    end
end)

hook.Add("TTTPlayerColor", "moat_ResetPlayerColor", function() return Color(61, 87, 105) end) -- Set the default player color (paint for items coming soon)