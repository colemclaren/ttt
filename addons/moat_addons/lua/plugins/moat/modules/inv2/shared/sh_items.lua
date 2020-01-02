local meta = FindMetaTable("Player")
MOAT_DROPTABLE = MOAT_DROPTABLE or {}
MOAT_BODY_ITEMS = MOAT_BODY_ITEMS or {}
MOAT_COLLECT = {}

function m_AddDroppableItem(item_table, item_kind)
    local tbl = {}
    tbl = item_table
    tbl.Kind = item_kind

	if (tbl.Name and not tbl.NameExact) then
		tbl.Name = string.Title(tbl.Name)
	end

	if (tbl.Description and not tbl.DescExact) then
		tbl.Description = string.Grammarfy(tbl.Description, not (tbl.Description:EndsWith"!" or tbl.Description:EndsWith"?" or tbl.Description:EndsWith"."))
	end

	if (SERVER and item_table.Collection) then
		if (not MOAT_COLLECT[item_table.Collection]) then MOAT_COLLECT[item_table.Collection] = {} end
		tbl.Rarity = (tbl.Rarity == 9 and 9) or (tbl.Rarity == 8 and 8) or tbl.Rarity
		tbl.Kind = (tbl.Kind == "tier" and "tier") or tbl.Kind

		local str = string ("\n",
			"mi.Item(" .. tbl.ID .. ")\n",
			"	" .. ":SetRarity (" .. tbl.Rarity .. ")\n",
			"	" .. ":SetType \"" .. tbl.Kind .. "\"\n",
			"	" .. ":SetName \"" .. tbl.Name .. "\"\n")
		
		if (tbl.NameColor) then
			str = string (str, "	" .. ":SetColor {", tbl.NameColor.r, ", ", tbl.NameColor.g, ", ", tbl.NameColor.b, "}\n")
		end

		if (tbl.NameEffect) then
			str = string (str, "	" .. ":SetEffect \"", tbl.NameEffect, "\"\n")
		end

		if (tbl.Description) then
			str = string (str, "	" .. ":SetDesc \"", tbl.Description, "\"\n")
		end

		if (tbl.Image) then
			str = string (str, "	" .. ":SetImage \"", tbl.Image, "\"\n")
		end

		if (tbl.Model) then
			str = string (str, "	" .. ":SetModel \"", tbl.Model, "\"\n")
		end

		if (tbl.Skin) then
			str = string (str, "	" .. ":SetSkin (", tbl.Skin, ")\n")
		end

		if (tbl.WeaponClass) then
			str = string (str, "	" .. ":SetWeapon \"", tbl.WeaponClass, "\"\n")
		end

		if (tbl.Stats) then
			str = string (str, "	" .. ":SetStats (", tbl.MinStats or table.Count(tbl.Stats), ", ", tbl.MaxStats or table.Count(tbl.Stats), ")\n")

			local def = tbl.Kind == "Melee" and "Melee" or "Gun"
			for k, v in pairs(tbl.Stats) do
				if ((tbl.Kind == "tier" or tbl.Kind == "Tier" or tbl.Kind == "Unique") and mi.Stat.Roster[k]) then
					if (mi.Stat.Roster[k].Defaults[def] and mi.Stat.Roster[k].Defaults[def][tbl.Rarity]) then
						if (mi.Stat.Roster[k].Defaults[def][tbl.Rarity].Min == v.min and mi.Stat.Roster[k].Defaults[def][tbl.Rarity].Max == v.max) then
							continue
						end
					end
				end

				str = string (str, "		" .. ":SetStat (", isnumber(k) and k or '"' .. k .. '"', ", ", v.min, ", ", v.max, ")\n")
			end
		end

		if (tbl.Talents) then
			str = string (str, "	" .. ":SetTalents (", tbl.MinTalents or table.Count(tbl.Talents), ", ", tbl.MaxTalents or table.Count(tbl.Talents), ")\n")

			for k, v in pairs(tbl.Talents) do
				if (v == "random") then continue end
				str = string (str, "		" .. ":SetTalent (", k, ", \"", v, "\")\n")
			end
		end

		if (tbl.ModifyClientsideModel and file_str) then
			local par = tbl.Bone or tbl.Attachment

			local needle = "ITEM:ModifyClientsideModel"
			local sf = string.find(file_str, needle)

			local ms = string.sub(file_str, sf + string.len(needle), string.len(file_str))
			ms = string.Replace(ms, "( ", "(")
			ms = string.Replace(ms, " )", ")")

			local tb, fs = string.Split(ms, "\n"), ""
			for i = 1, #tb do
				tb[i] = string.Trim(tb[i])

				if (string.len(tb[i]) <= 1) then
					continue
				end

				fs = fs .. "		" .. tb[i] .. "\n"
			end

			fs = string.sub(fs, 1, -2) .. ")"
			fs = string.Replace(fs, "		end)", "	" .. "end)")
			fs = string.Replace(fs, "		(", "(")
			
			str = string (str, "	" .. ":SetRender (\"", par, "\", function", string.sub(fs, 1, -2) .. ")", "\n")
		end

		if (tbl.Collection) then
			str = string (str, "	" .. ":SetCollection \"", tbl.Collection, "\"\n\n")
		end

		if (tbl.Price) then
			str = string (str, "	" .. ":SetShop (", tbl.Price, ", ", tbl.Active and "true" or "false", ")\n")
			MOAT_COLLECT[item_table.Collection].Crate = str
		else
			table.insert(MOAT_COLLECT[item_table.Collection], {String = str, Rarity = tbl.Rarity})
		end
	end

    MOAT_DROPTABLE[tbl.ID] = tbl

	if (item_kind == "Body") then
		MOAT_BODY_ITEMS[tbl.ID] = true 
	end
    --table.insert(MOAT_DROPTABLE, tbl)
end

local MOAT_ITEM_FOLDER = "plugins/moat/modules/_items/items"

local MOAT_ITEM_FOLDERS = {
    ["tier"] = "tiers",
    ["Unique"] = "uniques",
    ["Power-Up"] = "powerups",
    ["Hat"] = "hats",
    ["Mask"] = "masks",
    ["Model"] = "models",
    ["Crate"] = "crates",
    ["Melee"] = "melees",
    ["Effect"] = "effects",
    ["Body"] = "body",
    ["Special"] = "other",
    ["Usable"] = "usables"
}

function m_CreatePaints()
	for k , v in pairs(MOAT_PAINT.Tints) do
		local tbl = {}
        tbl.Name = v[1]
        tbl.ID = k
        tbl.Description = "Right click this tint to use it on a weapon"
        tbl.Rarity = v[3]
        tbl.Clr = v[2]
        tbl.Collection = "Paint Collection"
        tbl.PaintVer = 1
        tbl.Image = v[4] or "https://cdn.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
        tbl.ItemCheck = 11
        function tbl:ItemUsed(pl, slot, item)
            m_TintItem(pl, slot, item, self.ID)
        end

		if (tbl.Name and tbl.Name == "Pure White Tint") then
			tbl.NotDroppable = true
		end

        m_AddDroppableItem(tbl, "Usable")
	end

	for k, v in pairs(MOAT_PAINT.Paints) do
		local tbl = {}
        tbl.Name = v[1]
        tbl.ID = k
        tbl.Description = "Right click this paint to use it on an item"
        tbl.Rarity = v[3]
        tbl.Clr = v[2]
        tbl.Collection = "Paint Collection"
        tbl.PaintVer = 2
        tbl.Image = v[4] or "https://cdn.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
        tbl.ItemCheck = 10
        function tbl:ItemUsed(pl, slot, item)
            m_PaintItem(pl, slot, item, self.ID)
        end

        m_AddDroppableItem(tbl, "Usable")
	end

	for k, v in pairs(MOAT_PAINT.Skins) do
        local tbl = {}
        tbl.Name = v[1]
        tbl.ID = k
        tbl.Description = "Right click this skin to use it on a weapon"
        tbl.Rarity = v[3]
        tbl.Texture = v[2]
        tbl.Collection = v[5] or "Paint Collection"
        tbl.PaintVer = 2
        tbl.Image = v[4] or "https://cdn.moat.gg/f/2198b5d9d5c8a1e35fe2a4c833556fd6.png"
        tbl.ItemCheck = 12
        function tbl:ItemUsed(pl, slot, item)
            m_TextureItem(pl, slot, item, self.ID)
        end

        m_AddDroppableItem(tbl, "Usable")
    end
end

local COSMETIC_TYPES = {
    ["Hat"] = true,
    ["Mask"] = true, 
    ["Model"] = true, 
    ["Effect"] = true, 
    ["Body"] = true, 
    ["Melee"] = true
}

function m_InitializeItems()
    for type, folder in pairs(MOAT_ITEM_FOLDERS) do
        for _, filename in pairs(file.Find(MOAT_ITEM_FOLDER .. "/" .. folder .. "/*.lua", "LUA")) do
            ITEM = {}

			if (SERVER) then
				AddCSLuaFile(MOAT_ITEM_FOLDER .. "/" .. folder .. "/" .. filename)
			end

            include(MOAT_ITEM_FOLDER .. "/" .. folder .. "/" .. filename)
			if (ITEM.ID) then
				m_AddDroppableItem(ITEM, type)
			end

			if (type == "Melee" and ITEM.Collection and ITEM.Collection ~= "Melee Collection") then
				if (ITEM.Collection == "Independence Collection" or ITEM.Collection == "Holiday Collection") then
					continue
				end

				local Melee = table.Copy(ITEM)
				if (Melee.Name == "Deep Frying Ban") then
					Melee.NotDroppable = true
				end


				Melee.Collection = "Melee Collection"
				Melee.ID = ITEM.ID + 10000

				m_AddDroppableItem(Melee, type)
			end
        end
    end

	if (SERVER) then
		AddCSLuaFile(MOAT_ITEM_FOLDER .. "/paints/load.lua")
	end

    include(MOAT_ITEM_FOLDER .. "/paints/load.lua")
    m_CreatePaints()
    -- boom beep items loooooaded
end
m_InitializeItems()

concommand.Add("_reloaditems", function(pl)
	if (IsValid(pl)) then return end
	m_InitializeTalents()
	m_InitializeItems()
end)

concommand.Add("moat_finditemid",function(ply)
    if (IsValid(ply)) then return end

	local id = 0
    for i = 1,10000 do
        if (not MOAT_DROPTABLE[i] and id <= 100) then
            print("Unused: ITEM.ID = " .. i)
			id = id + 1
        end
    end
end)

concommand.Add("_reloadtalents", function(pl)
	if (IsValid(pl)) then return end
	m_InitializeTalents()
end)

local crate_cache = {}

function GetCrateContents(crate_collection)
    if (crate_cache[crate_collection]) then
        return crate_cache[crate_collection]
    end

    local contents = {}

    for k, v in pairs(MOAT_DROPTABLE) do
        if (v.Collection == crate_collection and v.Kind ~= "Crate") then
            if (not contents[tostring(v.Kind)]) then
                contents[tostring(v.Kind)] = {}
            end

            local title = v.Name or "NAME ERROR"
            local col = v.NameColor or nil
            local eff = v.NameEffect or nil
            local rar = v.Rarity or 1
            local mdl = v.Model or nil
            local skn = v.Skin or nil
            local iid = v.ID or nil

            table.insert(contents[tostring(v.Kind)], {
                name = title,
                color = col,
                effect = eff,
                rarity = rar,
                model = mdl,
                iskin = skn,
                id = iid
            })
        end
    end

    crate_cache[crate_collection] = contents

    return contents
end

local item_cache = {}
function GetItemFromEnum(ienum)
    if (ienum and item_cache[ienum]) then
		return item_cache[ienum]
    end

    local item_tbl = table.Copy(MOAT_DROPTABLE[ienum]) or {}

    item_tbl.OnPlayerSpawn = nil
    item_tbl.ModifyClientsideModel = nil
    item_tbl.DynamicModifyClientsideModel = nil
    item_tbl.EffectColor = nil
    item_tbl.EffectSize = nil
    item_tbl.OnDamageTaken = nil
    item_tbl.OnBeginRound = nil
    item_tbl.ScalePlayerDamage = nil
    item_tbl.ItemUsed = nil

    if (item_tbl.Kind == "Crate") then
        item_tbl.Contents = GetCrateContents(item_tbl.Collection)
    end

    if (ienum) then
        item_cache[ienum] = item_tbl
    end
    
    return item_tbl
end

local item_cache2 = {}
function GetItemFromEnumWithFunctions(ienum)
    if (ienum and item_cache2[ienum]) then
        return item_cache2[ienum]
    end

    local item_tbl = table.Copy(MOAT_DROPTABLE[ienum]) or {}

    if (item_tbl.Kind == "Crate") then
        item_tbl.Contents = GetCrateContents(item_tbl.Collection)
    end

    if (ienum) then item_cache2[ienum] = item_tbl end

    return item_tbl
end

function GetItemName(data)
	local ITEM_NAME_FULL = ""

    if (data and data.item and data.item.Kind == "tier") then
        local ITEM_NAME = util.GetWeaponName(data.w)

        if (string.EndsWith(ITEM_NAME, "_name")) then
            ITEM_NAME = string.sub(ITEM_NAME, 1, ITEM_NAME:len() - 5)
            ITEM_NAME = string.upper(string.sub(ITEM_NAME, 1, 1)) .. string.sub(ITEM_NAME, 2, ITEM_NAME:len())
        end

        ITEM_NAME_FULL = data.item.Name .. " " .. ITEM_NAME

        if ((data.item and data.item.Rarity or 0) == 0 and data.item.ID and data.item.ID ~= 7820 and data.item.ID ~= 7821) then
            ITEM_NAME_FULL = ITEM_NAME
        end
    else
        ITEM_NAME_FULL = data.item and data.item.Name or "Error with Item Name"
    end
	
	if (data and data.item and data.item.Kind ~= "Unique" and data.Talents and data.Talents[1] and (data.Talents[1].Suffix or data.Talents[1].Name)) then
		local suffix = (data.Talents[5] and (data.Talents[5].Suffix or data.Talents[5].Name)) or (data.Talents[4] and (data.Talents[4].Suffix or data.Talents[4].Name)) or (data.Talents[3] and (data.Talents[3].Suffix or data.Talents[3].Name)) or (data.Talents[2] and (data.Talents[2].Suffix or data.Talents[2].Name)) or (data.Talents[1].Suffix or data.Talents[1].Name)
		ITEM_NAME_FULL = ITEM_NAME_FULL .. " of " .. suffix
	end

	if (data.n) then
		ITEM_NAME_FULL = data.n:Replace("''", "'") -- "\"" .. data.n:Replace("''", "'") .. "\""
	end

	ITEM_NAME_FULL = string.format(ITEM_NAME_FULL, "@", "#")

	return ITEM_NAME_FULL
end