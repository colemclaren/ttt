print("loadout loaded")

function table.removeFunctions(tbl)
    for k,v in pairs(tbl) do
        if isfunction(v) then
            tbl[k] = nil
        elseif istable(v) then
            table.removeFunctions(v)
        end
    end
end

FindMetaTable "Player".HasWeapon2 = FindMetaTable "Player".HasWeapon2 or FindMetaTable "Player".HasWeapon
-- crowbars and friends
FindMetaTable "Player".HasWeapon = function(ply, class)
    for i, w in pairs(ply:GetWeapons()) do
        if (w:GetClass() == class) then
            return true
        end
    end
    return ply:HasWeapon2(class)
end

util.AddNetworkString("MOAT_UPDATE_WEP")
util.AddNetworkString("MOAT_UPDATE_OTHER_WEP")
util.AddNetworkString("MOAT_NET_SPAWN")
util.AddNetworkString("MOAT_UPDATE_WEP_CACHE")
util.AddNetworkString("MOAT_UPDATE_OTHER_WEP_CACHE")

util.AddNetworkString("MOAT_UPDATE_WEP_PAINT")
util.AddNetworkString("MOAT_UPDATE_WEP_PAINT_LATE")

util.AddNetworkString("MOAT_UPDATE_PLANETARIES")
util.AddNetworkString("MOAT_UPDATE_PLANETARIES_LATE")

MOAT_LOADOUT = {}

-- We only need to know if the weapon is a unique or a tier, nothing else
local item_kind_codes = {
    ["tier"] = "1"
}

function MOAT_LOADOUT.ResetPowerupAbilities(ply)
    if (not IsValid(ply)) then return end
    
    ply:SetJumpPower(160)
    ply.JumpHeight = 160

	local max = 100
	if (max ~= 100) then
		D3A.Chat.SendToPlayer2(ply,
		Color(255, 0, 255), "[Head's up!] ",
		Color(255, 255, 255), "Base health is ",
		Color(0, 255, 0), "200 HP ",
		Color(255, 255, 255), "for ",
		Color(0, 255, 255), "today only",
		Color(255, 255, 255), "! ",
		Color(255, 255, 0), "(testing ends in " .. util.FormatTime(1575187200, os.time(), true) .. ")")
	end

	if (cur_random_round and cur_random_round == "High HP") then
		max = 500
	end

    ply:SetMaxHealth(max)
    ply.MaxHealth = max
    ply:SetHealth(max)

    ply.ExtraXP = 1
	ply.CreditGoblin = nil
	ply.SilentPower = nil
	if (ply:GetNW2Bool("SilentPower", false)) then
		ply:SetNW2Bool("SilentPower", false)
	end
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
            tbl[i].item = GetItemFromEnumWithFunctions(tbl[i].u, tbl[i])

            if (tbl[i] and tbl[i].item and (tbl[i].item.Kind == "Special" or tbl[i].item.Kind == "Unique")) then
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
            tbl[i].item = GetItemFromEnumWithFunctions(tbl[i].u)
        end
    end

    return tbl[6], tbl[7], tbl[8], tbl[9], tbl[10]
end

function MOAT_LOADOUT.ApplyWeaponMods(wep, loadout_tbl, item)
    local itemtbl = table.Copy(loadout_tbl)

    if (wep.ItemName) then
        wep.PrintName = wep.ItemName
    end

    -- if (itemtbl.n) then
    --     wep.PrintName = "\"" .. itemtbl.n:Replace("''", "'") .. "\""
    -- elseif (item and item.Name and wep.PrintName and wep.ClassName and wep.PrintName == util.GetWeaponName(wep.ClassName)) then
    --     if (item.Kind and item.Kind == "tier") then
    --         wep.PrintName = string(item.Name, " ", wep.PrintName)
    --     else
    --         wep.PrintName = item.Name
    --     end
    -- end

    wep.PrintName = GetItemName(itemtbl) or "Holstered"
	wep:SetRealPrintName(wep.PrintName)

    if (itemtbl.s) then
        for s_idx, mult in pairs(itemtbl.s) do
            local mod = MODS.Accessors[s_idx]
            if (not mod) then
                print("s_idx fail: ", s_idx)
                continue
            end

            if (not mod:ValidForWeapon(wep)) then
                print("mod invalid: " .. wep:GetClass() .. " s_idx: " .. s_idx)
                continue
            end

            mult = mod:GetFromStats(itemtbl.item.Stats, mult)

            mod:Set(wep, mult)
        end
    end

	if (itemtbl.t) then
		itemtbl.Talents = GetItemTalents(itemtbl)

        wep.Talents = table.Copy(itemtbl.t)
        wep.level = itemtbl.s.l
        wep.exp = itemtbl.s.x
        m_ApplyTalentMods(wep, itemtbl)
    end

	wep.ItemStats = itemtbl or {}

    return wep
end

function m_ApplyWeaponMods(wep, loadout_tbl, item)
    if (loadout_tbl.p3 and ItemIsSkin(loadout_tbl.p3)) then
        wep:SetSkinID(loadout_tbl.p3)
    end
    if (loadout_tbl.p2 and ItemIsPaint(loadout_tbl.p2)) then
        wep:SetPaintID(loadout_tbl.p2)
    elseif (loadout_tbl.p and ItemIsTint(loadout_tbl.p)) then
        wep:SetTintID(loadout_tbl.p)
    end

    return MOAT_LOADOUT.ApplyWeaponMods(wep, loadout_tbl, item)
end

function MOAT_LOADOUT.ApplyOtherModifications(tbl, loadout_tbl, item)
    local wep = tbl
    local itemtbl = table.Copy(loadout_tbl)

    if (wep.ItemName) then
        wep.PrintName = wep.ItemName
    end

    if (item and item.Name and wep.PrintName and wep.ClassName and wep.PrintName == util.GetWeaponName(wep.ClassName)) then
        if (item.Kind and item.Kind == "tier") then
            wep.PrintName = string(item.Name, " ", wep.PrintName)
        else
            wep.PrintName = item.Name
        end

        wep.ItemName = wep.PrintName
    end

    if (itemtbl and itemtbl.item and itemtbl.item.Stats and itemtbl.s and #itemtbl.s > 0) then
        wep.InventoryModifications = {}

        for i = 1, #itemtbl.s do
            wep.InventoryModifications[i] = itemtbl.item.Stats[i].min + ((itemtbl.item.Stats[i].max - itemtbl.item.Stats[i].min) * math.min(1, itemtbl.s[i]))
        end
    end
end

loadout_weapon_indexes = {}
local loadout_other_indexes = {}
local loadout_cosmetic_indexes = {}
MOAT_MODEL_EDIT_POS = MOAT_MODEL_EDIT_POS or {}
loadout_model_cache = {}
function MOAT_LOADOUT.SaveLoadedWeapons()
    loadout_other_indexes = {}
    loadout_weapon_indexes = {}
    loadout_cosmetic_indexes = {}
	loadout_model_cache = {}
end
hook.Add("TTTPrepareRound", "moat_SaveLoadedWeapons", MOAT_LOADOUT.SaveLoadedWeapons)


function MOAT_LOADOUT.HasCosmeticInLoadout(ply, id)
    local return_val = false
    local item_tbl = {}

    if (isnumber(id)) then

        for k, v in ipairs(loadout_cosmetic_indexes) do
            if (v[1] == ply:EntIndex() and v[2] == id) then
                return_val = true
                item_tbl = GetItemFromEnumWithFunctions(id)
                break
            end
        end
    else
        for k, v in ipairs(loadout_cosmetic_indexes) do
            local cosmetic_tbl = GetItemFromEnumWithFunctions(v[2])

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
    if (hook.Run("MoatInventoryShouldGiveLoadout", ply)) then return end
    if (not IsValid(ply)) then return end

    local loadout_table = {
        ["Primary"] = pri_wep,
        ["Secondary"] = sec_wep,
        ["Melee"] = melee_wep,
        ["Power-Up"] = powerup,
        ["Special"] = tactical
    }

    if (not is_reequip) then
        MOAT_LOADOUT.ResetPowerupAbilities(ply)
        local l_ply = ply
        if (l_ply:IsBot()) then
            l_ply = player.GetHumans()[1] or l_ply
        end
        local cos_head, cos_mask, cos_body, cos_effect, cos_model = MOAT_LOADOUT.GetCosmetics(l_ply)

        local cosmetic_table = {
            ["Hat"] = cos_head,
            ["Mask"] = cos_mask,
            ["Body"] = cos_body,
            ["Effect"] = cos_effect,
            ["Model"] = cos_model
        }

        for k, v in pairs(cosmetic_table) do
            if k == "Effect" then
                if not v.item then continue end
                if tonumber(v.u) == 920 then
                    mg_tesla(ply)
                    continue
                end
            end
            if (v.c) then
                local paint, skinz = v.p or v.p2 or 0, v.p2 and 1 or v.p3 or 0
				if (paint > 0 and not GetPaintColor(paint)) then paint = 0 end
				if (skinz > 1 and not ItemIsSkin(v.p3)) then skinz = 0 end

                if (k == "Model") then
                    MOAT_LOADOUT.SetPlayerModel(ply, v)
                    continue
                end

                net.Start("MOAT_APPLY_MODELS")
                net.WritePlayer(ply)
                net.WriteUInt(v.u, 16)
                net.WriteUInt(paint, 16)
				net.WriteUInt(skinz, 16)

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

				if (not loadout_cosmetic_indexes[ply]) then
					loadout_cosmetic_indexes[ply] = {}
				end
				
				loadout_cosmetic_indexes[ply][k] = {Player = ply:EntIndex(), Model = v.u, Paint = paint, Skin = skinz}
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

        if (k == "Special") then
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
                local item_old = table.Copy(v.item)
                -- v.item = GetItemFromEnum(v.u)

                MOAT_LOADOUT.ApplyOtherModifications(wpn_tbl, v, v.item)

                net.Start("MOAT_UPDATE_OTHER_WEP")
                net.WriteUInt(v3:EntIndex(), 16)
                net.WriteString(wpn_tbl.ItemName or wpn_tbl.PrintName or "NAME_ERROR0")
                net.WriteTable(v or {})
                net.Send(ply)

				if (v.t) then
                	v.Talents = GetItemTalents(v)
            	end

                loadout_other_indexes[v3:EntIndex()] = {owner = ply:EntIndex(), info = v, name = wpn_tbl.ItemName or wpn_tbl.PrintName}

                v.item = item_old
                v3.c = v.c
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
            local item_old = table.Copy(v.item)
            -- v.item = GetItemFromEnum(v.u)

            m_ApplyWeaponMods(v3, v, v.item)
			local wpn_tbl = v3:GetTable()

            local clipsize = wpn_tbl.Primary.ClipSize
            local defaultclip = wpn_tbl.Primary.DefaultClip
            local add_ammo = clipsize
            if (defaultclip > clipsize) then
                add_ammo = add_ammo + defaultclip - clipsize
                defaultclip = clipsize
            end
            -- v3:SetClip1(defaultclip)
            wpn_tbl.UniqueItemID = v.c
            wpn_tbl.PrimaryOwner = ply

            net.Start("MOAT_UPDATE_WEP")
            net.WriteUInt(v3:EntIndex(), 16)
            net.WriteTable(v or {})

            local sent = false
            if (v.item and v.item.Rarity == 9) then
                sent = true
                net.Broadcast()
            else
                net.Send(ply)
            end

			if (v.t) then
            	v.Talents = GetItemTalents(v)
           	end

            loadout_weapon_indexes[v3:EntIndex()] = {
                name = wpn_tbl.ItemName or wpn_tbl.PrintName,
                stats = {
                    wpn_tbl.Primary.Damage or 0,
                    wpn_tbl.Primary.Delay or 0,
                    wpn_tbl.Primary.ClipSize or 0,
                    wpn_tbl.Primary.Recoil or 0,
                    wpn_tbl.Primary.Cone or 0,
                    wpn_tbl.PushForce or 0,
                    wpn_tbl.Secondary.Delay or 0,
                    wpn_tbl.Primary.ConeX or 0,
                    wpn_tbl.Primary.ConeY or 0,
					wpn_tbl.ReloadSpeed or 0,
					wpn_tbl.DeploySpeed or 0
                },
                owner = ply:EntIndex(),
                info = v,
                net = sent
            }

			if ((not v.s or (v.s and not v.s.m)) and wpn_tbl.Primary.Ammo and wpn_tbl.Primary.ClipSize and IsValid(v3:GetOwner())) then
				v3:SetClip1(wpn_tbl.Primary.ClipSize)
				ply:GiveAmmo(wpn_tbl.Primary.ClipSize * 2, wpn_tbl.Primary.Ammo, true)
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
    -- if (GetRoundState() == ROUND_WAIT) then return end

    net.Start("MOAT_NET_SPAWN")
    net.Send(ply)

    local idx = ply:EntIndex()
    timer.Create("moat_CheckLoadoutSpawn" .. idx, 1, 0, function()
        if (not IsValid(ply)) then timer.Remove("moat_CheckLoadoutSpawn" .. idx) return end

        local l_ply = ply
        if (l_ply:IsBot()) then
            l_ply = player.GetHumans()[1] or l_ply
        end

        local pri_wep, sec_wep, melee_wep, powerup, tactical = m_GetLoadout(l_ply)

        if (pri_wep and sec_wep and melee_wep and powerup and tactical) then
            m_GivePlayerLoadout(ply, pri_wep, sec_wep, melee_wep, powerup, tactical)
            timer.Remove("moat_CheckLoadoutSpawn" .. idx)
        end
    end)
end
hook.Add("PlayerSpawn", "moat_GiveLoadout", MOAT_LOADOUT.GiveLoadout)

function MOAT_LOADOUT.LoadLoadedLoadouts(ply)
    /*if (table.Count(loadout_weapon_indexes) < 1) then return end

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
        net.WriteTable(v[2])
        net.Send(ply)
    end*/
end
hook.Add("PlayerInitialSpawn", "moat_LoadLoadedLoadouts", MOAT_LOADOUT.LoadLoadedLoadouts)


function MOAT_LOADOUT.LoadCosmeticLoadouts(ply)
	for _, pl in pairs(player.GetAll()) do
		if (pl:Team() == TEAM_SPEC or not loadout_cosmetic_indexes[pl]) then continue end

		for k, v in pairs(loadout_cosmetic_indexes[pl]) do 
			net.Start("MOAT_APPLY_MODELS")
        	net.WritePlayer(pl)
        	net.WriteUInt(v.Model, 16)
        	net.WriteUInt(v.Paint, 16)
			net.WriteUInt(v.Skin, 16)

			if (MOAT_MODEL_EDIT_POS[pl] and MOAT_MODEL_EDIT_POS[pl][v.Model]) then
				net.WriteBool(true)
				net.WriteDouble(MOAT_MODEL_EDIT_POS[pl][v.Model][1])
				net.WriteDouble(MOAT_MODEL_EDIT_POS[pl][v.Model][2])
				net.WriteDouble(MOAT_MODEL_EDIT_POS[pl][v.Model][3])
				net.WriteDouble(MOAT_MODEL_EDIT_POS[pl][v.Model][4])
				net.WriteDouble(MOAT_MODEL_EDIT_POS[pl][v.Model][5])
				net.WriteDouble(MOAT_MODEL_EDIT_POS[pl][v.Model][6])
			else
				net.WriteBool(false)
			end

			net.Send(ply)
		end

		if (not loadout_model_cache[pl] or not MOAT_INVS[pl] or not MOAT_INVS[pl]["l_slot10"]) then
			continue
		end

		local c, s = MOAT_INVS[pl]["l_slot10"].p2 or MOAT_INVS[pl]["l_slot10"].p or 0, MOAT_INVS[pl]["l_slot10"].p3 or 0
		if (c > 0 and not GetPaintColor(c)) then c = 0 end
		if (s > 1 and not ItemIsSkin(s)) then s = 0 end

		net.Start "MOAT_SKINZ"
			net.WritePlayer(pl)
			net.WriteUInt(c, 16)
			net.WriteUInt(MOAT_INVS[pl]["l_slot10"].p2 and 1 or s, 16)
		net.Send(ply)
	end	
end
hook.Add("PlayerInitialSpawn", "moat_LoadCosmeticLoadouts", MOAT_LOADOUT.LoadCosmeticLoadouts)

--[[-------------------------------------------------------------------------
Custom Model Positioning
---------------------------------------------------------------------------]]

util.AddNetworkString("MOAT_UPDATE_MODEL_POS")
util.AddNetworkString("MOAT_UPDATE_MODEL_POS_SINGLE")

local clamp_table = {
	[1] = { -180, 180 },
	[2] = { -180, 180 },
	[3] = {  0.8, 1.2 },
	[4] = { -2.5, 2.5 },
	[5] = { -2.5, 2.5 },
	[6] = { -2.5, 2.5 }
}

function MOAT_LOADOUT.UpdateModelPos(_, ply)
	local item_id = net.ReadUInt(16)
	local pos_table = {}
	for i = 1, #clamp_table do
		pos_table[i] = math.Clamp(net.ReadDouble(), clamp_table[i][1], clamp_table[i][2])
		
		if (i == 1 and item_id and MOAT_BODY_ITEMS and MOAT_BODY_ITEMS[item_id]) then
			pos_table[i] = 0
		end
	end

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


function MOAT_LOADOUT.UpdateModelPosSingle(_, ply)
	local item_id = net.ReadUInt(16)
	local slider_id = net.ReadUInt(8)
	if (slider_id > #clamp_table or slider_id == 0) then return end

	local item_pos = math.Clamp(net.ReadDouble(), clamp_table[slider_id][1], clamp_table[slider_id][2])
	if (slider_id and slider_id == 1 and item_id and MOAT_BODY_ITEMS and MOAT_BODY_ITEMS[item_id]) then
		item_pos = 0
	end

	if (not MOAT_MODEL_EDIT_POS[ply]) then
		MOAT_MODEL_EDIT_POS[ply] = {}
	end

	MOAT_MODEL_EDIT_POS[ply][item_id][slider_id] = item_pos
end
net.Receive("MOAT_UPDATE_MODEL_POS_SINGLE", MOAT_LOADOUT.UpdateModelPosSingle)

--[[-------------------------------------------------------------------------
Gamemode Fixes
---------------------------------------------------------------------------]]
util.AddNetworkString "MOAT_SKINZ"
util.AddNetworkString "MOAT_SKINZ_RESET"
function MOAT_LOADOUT.SetPlayerModel(ply, item_tbl)
	if (item_tbl and item_tbl.item and item_tbl.item.CustomSpawn and item_tbl.item.OnPlayerSpawn) then
		item_tbl.item:OnPlayerSpawn(ply)
	end

	ply:SetModel(item_tbl.item.Model or GAMEMODE.playermodel or GetRandomPlayerModel() or "models/player/phoenix.mdl")
	timer.Simple(0, function() if (IsValid(ply)) then ply:SetModel(item_tbl.item.Model) end end)

    if (MOAT_INVS[ply] and MOAT_INVS[ply]["l_slot10"] and (MOAT_INVS[ply]["l_slot10"].p or MOAT_INVS[ply]["l_slot10"].p2 or MOAT_INVS[ply]["l_slot10"].p3)) then
        local col = GetPaintColor(MOAT_INVS[ply]["l_slot10"].p2 or MOAT_INVS[ply]["l_slot10"].p)
		if (col and col[2]) then
			col = col[2]

			ply:SetRenderMode(RENDERMODE_TRANSALPHA)
			ply:SetColor(Color(col[1], col[2], col[3], 255))
			ply:SetPlayerColor(Vector(col[1]/255, col[2]/255, col[3]/255))

			local c, s = MOAT_INVS[ply]["l_slot10"].p2 or MOAT_INVS[ply]["l_slot10"].p or 0, MOAT_INVS[ply]["l_slot10"].p3 or 0
			if (c > 0 and not GetPaintColor(c)) then c = 0 end
			if (s > 1 and not ItemIsSkin(s)) then s = 0 end

			net.Start "MOAT_SKINZ"
				net.WritePlayer(ply)
				net.WriteUInt(c, 16)
				net.WriteUInt((MOAT_INVS[ply]["l_slot10"].p2 and not MODELS_COLORABLE[item_tbl.item.Model]) and 1 or s, 16)
			net.Broadcast()
			
			loadout_model_cache[ply] = {Player = ply:EntIndex(), Model = c, Paint = c, Skin = (MOAT_INVS[ply]["l_slot10"].p2 and not MODELS_COLORABLE[item_tbl.item.Model]) or s}

			return
		else
			ply:SetRenderMode(RENDERMODE_TRANSALPHA)
			ply:SetColor(Color(255, 255, 255, 255))
			ply:SetPlayerColor(Vector(1, 1, 1))
		end
	else
		ply:SetRenderMode(RENDERMODE_TRANSALPHA)
		ply:SetColor(Color(255, 255, 255, 255))
		ply:SetPlayerColor(Vector(1, 1, 1))
	end
	
	net.Start "MOAT_SKINZ_RESET"
		net.WritePlayer(ply)
	net.Send(ply)
end

hook.Add("PostGamemodeLoaded", "moat_OverwritePlayermodel", function()
    function GAMEMODE:PlayerSetModel(ply)
		if (hook.Run("MoatInventoryShouldGiveLoadout", ply)) then
			if (ply.Skeleton) then
				ply:SetModel("models/player/skeleton.mdl")
			else
				ply:SetModel(GAMEMODE.playermodel or GetRandomPlayerModel() or "models/player/phoenix.mdl")
			end

			if (IsValid(MOAT_BOSS_CUR) and GetGlobal("MOAT_MINIGAME_ACTIVE") and GetGlobal("MOAT_MINIGAME_ACTIVE") == "Stalker Boss" and ply == MOAT_BOSS_CUR) then
				ply:SetRenderMode(RENDERMODE_TRANSALPHA)
				ply:SetColor(Color(255, 255, 255, 0))
				ply:SetPlayerColor(Vector(0, 0, 0))
			else
				ply:SetRenderMode(RENDERMODE_TRANSALPHA)
				ply:SetColor(Color(255, 255, 255, 255))
				ply:SetPlayerColor(Vector(1, 1, 1))

			end

			return
		end
		
        if (MOAT_INVS[ply] and MOAT_INVS[ply]["l_slot10"] and MOAT_INVS[ply]["l_slot10"].u) then
			local lt = table.Copy(MOAT_INVS[ply]["l_slot10"])
			if (lt) then
				lt.item = GetItemFromEnumWithFunctions(MOAT_INVS[ply]["l_slot10"].u)
        		return MOAT_LOADOUT.SetPlayerModel(ply, lt)
			end
        end

		ply:SetModel(GAMEMODE.playermodel or GetRandomPlayerModel() or "models/player/phoenix.mdl")
		if (IsValid(MOAT_BOSS_CUR) and GetGlobal("MOAT_MINIGAME_ACTIVE") and GetGlobal("MOAT_MINIGAME_ACTIVE") == "Stalker Boss" and ply == MOAT_BOSS_CUR) then
			ply:SetRenderMode(RENDERMODE_TRANSALPHA)
			ply:SetColor(Color(255, 255, 255, 0))
			ply:SetPlayerColor(Vector(0, 0, 0))
		else
			ply:SetRenderMode(RENDERMODE_TRANSALPHA)
			ply:SetColor(Color(255, 255, 255, 255))
			ply:SetPlayerColor(Vector(1, 1, 1))
		end
    end

    function GAMEMODE:TTTPlayerSetColor(ply)
		if (hook.Run("MoatInventoryShouldGiveLoadout", ply)) then
			if (IsValid(MOAT_BOSS_CUR) and GetGlobal("MOAT_MINIGAME_ACTIVE") and GetGlobal("MOAT_MINIGAME_ACTIVE") == "Stalker Boss" and ply == MOAT_BOSS_CUR) then
				ply:SetRenderMode(RENDERMODE_TRANSALPHA)
				ply:SetColor(Color(255, 255, 255, 0))
				ply:SetPlayerColor(Vector(0, 0, 0))
			else
				ply:SetRenderMode(RENDERMODE_TRANSALPHA)
				ply:SetColor(Color(255, 255, 255, 255))
				ply:SetPlayerColor(Vector(1, 1, 1))
			end

			return
		end
	
		if (MOAT_INVS[ply] and MOAT_INVS[ply]["l_slot10"] and (MOAT_INVS[ply]["l_slot10"].p2 or MOAT_INVS[ply]["l_slot10"].p)) then
			local col = GetPaintColor(MOAT_INVS[ply]["l_slot10"].p2 or MOAT_INVS[ply]["l_slot10"].p)
            if (col and col[2]) then
				ply:SetRenderMode(RENDERMODE_TRANSALPHA)
				ply:SetColor(Color(col[2][1], col[2][2], col[2][3], 255))
            	ply:SetPlayerColor(Vector(col[2][1]/255, col[2][2]/255, col[2][3]/255))
			else
				ply:SetRenderMode(RENDERMODE_TRANSALPHA)
				ply:SetColor(Color(255, 255, 255, 255))
				ply:SetPlayerColor(Vector(1, 1, 1))
			end
        else
			ply:SetRenderMode(RENDERMODE_TRANSALPHA)
			ply:SetColor(Color(255, 255, 255, 255))
			ply:SetPlayerColor(Vector(1, 1, 1))
		end
    end
end)

hook.Add("TTTPlayerColor", "moat_ResetPlayerColor", function() return Color(61, 87, 105) end) -- Set the default player color (paint for items coming soon)


--[[-------------------------------------------------------------------------
Loadout Networking
---------------------------------------------------------------------------]]
local function NetworkRegularWeapon(wep)
    local tbl = loadout_weapon_indexes[wep:EntIndex()]
    if (tbl.net) then return end
    if (GetRoundState() == ROUND_ACTIVE) then tbl.net = true end

    net.Start("MOAT_UPDATE_WEP")
    net.WriteUInt(wep:EntIndex(), 16)
    net.WriteTable(tbl.info or {})
    net.Broadcast()
end

local function NetworkOtherWeapon(wep)
    local tbl = loadout_other_indexes[wep:EntIndex()]
    if (GetRoundState() ~= ROUND_PREP and tbl.net) then return end
    if (GetRoundState() == ROUND_ACTIVE) then tbl.net = true end

    net.Start("MOAT_UPDATE_OTHER_WEP")
    net.WriteUInt(wep:EntIndex(), 16)
    net.WriteString(tbl.name or "NAME_ERROR3")
    net.WriteTable(tbl.info)
    net.Broadcast()
end

function NetworkWeaponStats(wep)
    if (not IsValid(wep)) then return end

    if (loadout_other_indexes[wep:EntIndex()]) then NetworkOtherWeapon(wep) end
    if (loadout_weapon_indexes[wep:EntIndex()]) then NetworkRegularWeapon(wep) end
end

hook.Add("PlayerDroppedWeapon", "moat_NetworkWeapons", function(pl, wep)
    NetworkWeaponStats(wep)
end)

hook.Add("PlayerDeath", "moat_NetworkWeapons", function(pl, inf, att)
    if (IsValid(inf) and inf:IsWeapon() and inf.ItemStats) then
        NetworkWeaponStats(inf)
        return
    end

    if (IsValid(att) and att:IsPlayer()) then
        local wep = att:GetActiveWeapon()
        if (IsValid(wep) and wep.ItemStats) then
            NetworkWeaponStats(wep)
        end
    end
end)
