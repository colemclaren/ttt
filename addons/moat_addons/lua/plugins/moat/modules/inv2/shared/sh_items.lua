MOAT_DROPTABLE = MOAT_DROPTABLE or {}
MOAT_BODY_ITEMS = MOAT_BODY_ITEMS or {}
MOAT_ENDANGERED = MOAT_ENDANGERED or {}
MOAT_COLLECT = {} -- auto collect garbage

if (CLIENT) then
    COSMETIC_ITEMS = {}
	MOAT_BODY_ITEMS = {}
    function m_AddCosmeticItem(item_tbl, item_kind)
        local tbl = item_tbl
        tbl.Kind = item_kind
		if (item_kind == "Body") then
			MOAT_BODY_ITEMS[tbl.ID] = true 
		end

		if (tbl.Model) then
            util.PrecacheModel(tbl.Model)
        end

        COSMETIC_ITEMS[tbl.ID] = tbl
    end

    function m_GetCosmeticItemFromEnum(item_id)
        return table.Copy(COSMETIC_ITEMS[item_id])
    end
end

local file_str
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

	-- generated for droptable.lua
	if (SERVER and tbl.Collection) then
		if (not MOAT_COLLECT[tbl.Collection]) then MOAT_COLLECT[tbl.Collection] = {} end
		tbl.Rarity = (tbl.Rarity == 9 and 9) or (tbl.Rarity == 8 and 8) or tbl.Rarity
		tbl.Kind = (tbl.Kind == "tier" and "tier") or tbl.Kind

		local str = string ("\n",
			"mi.Item(" .. tbl.ID .. ")\n",
			"	" .. ":SetRarity (" .. tbl.Rarity .. ")\n",
			"	" .. ":SetType \"" .. tbl.Kind .. "\"\n",
			"	" .. ":SetName \"" .. tbl.Name .. "\"\n")

		if (tbl.NotDroppable) then
			str = string (str, "	" .. ":NotDroppable (", tostring(tbl.NotDroppable), ")\n")
		end

		if (tbl.NameColor) then
			str = string (str, "	" .. ":SetColor {", tbl.NameColor.r, ", ", tbl.NameColor.g, ", ", tbl.NameColor.b, "}\n")
		end

		if (tbl.NameEffect) then
			str = string (str, "	" .. ":SetEffect \"", tbl.NameEffect, "\"\n")
		end

		if (tbl.Description) then
			str = string (str, "	" .. ":SetDesc \"", tbl.Description:Replace('"', '\\"'), "\"\n")
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

		if (tbl.Clr) then
			str = string (str, "	" .. ":SetClr {", tbl.Clr.r or tbl.Clr[1], ", ", tbl.Clr.g or tbl.Clr[2], ", ", tbl.Clr.b or tbl.Clr[3], "}\n")
		end

		if (tbl.Texture) then
			str = string (str, "	" .. ":SetTexture \"", tbl.Texture, "\"\n")
		end

		if (tbl.PaintVer) then
			str = string (str, "	" .. ":SetPaintVer (", tbl.PaintVer, ")\n")
		end

		if (tbl.ItemCheck) then
			str = string (str, "	" .. ":SetItemCheck (", tbl.ItemCheck, ")\n")
		end

		if (tbl.EffectColor) then
			str = string (str, "	" .. ":SetEffectColor {", tbl.EffectColor.r or tbl.EffectColor[1], ", ", tbl.EffectColor.g or tbl.EffectColor[2], ", ", tbl.EffectColor.b or tbl.EffectColor[3], "}\n")
		end

		if (tbl.EffectSize) then
			str = string (str, "	" .. ":SetEffectSize (", tbl.EffectSize, ")\n")
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

		if (tbl.ItemUsed and tbl.Name and tbl.Name:EndsWith("Tint")) then
			str = string (str, "	" .. ":ItemUsed (function(pl, slot, item) m_TintItem(pl, slot, item, self.ID) end)", "\n")
		elseif (tbl.ItemUsed and tbl.Name and tbl.Name:EndsWith("Paint")) then
			str = string (str, "	" .. ":ItemUsed (function(pl, slot, item) m_PaintItem(pl, slot, item, self.ID) end)", "\n")
		elseif (tbl.ItemUsed and tbl.Name and tbl.Name:EndsWith("Skin")) then
			str = string (str, "	" .. ":ItemUsed (function(pl, slot, item) m_TextureItem(pl, slot, item, self.ID) end)", "\n")
		elseif (tbl.ItemUsed and file_str) then
			local needle = "ITEM:ItemUsed"
			local sf = string.find(file_str, needle)
			if (not sf) then sf = string.find(file_str, "ITEM.ItemUsed") end
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
			
			local str2 = string (str, "	" .. ":ItemUsed (function", string.sub(fs, 1, -2) .. ")", "\n")
			str = string(str, string.Replace(str2, "function		= ", ""))
		end

		if (tbl.OnPlayerSpawn and file_str) then
			local needle = "ITEM:OnPlayerSpawn"
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
			
			str = string (str, "	" .. ":OnPlayerSpawn (function", string.sub(fs, 1, -2) .. ")", "\n")
		end

		if (tbl.OnDamageTaken and file_str) then
			local needle = "ITEM:OnDamageTaken"
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
			
			str = string (str, "	" .. ":OnDamageTaken (function", string.sub(fs, 1, -2) .. ")", "\n")
		end

		if (tbl.OnBeginRound and file_str) then
			local needle = "ITEM:OnBeginRound"
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
			
			str = string (str, "	" .. ":OnBeginRound (function", string.sub(fs, 1, -2) .. ")", "\n")
		end

		if (tbl.ScalePlayerDamage and file_str) then
			local needle = "ITEM:ScalePlayerDamage"
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
			
			str = string (str, "	" .. ":ScalePlayerDamage (function", string.sub(fs, 1, -2) .. ")", "\n")
		end

		if (tbl.Collection) then
			str = string (str, "	" .. ":SetCollection \"", tbl.Collection, "\"\n")
		end

		if (tbl.Price) then
			if (tbl.NewItem) then
				if (tbl.ShopDesc) then
					str = string (str, "	" .. ":SetShop (", tbl.Price, ", ", tbl.Active and "true" or "false", ", ", tbl.NewItem, ", '", tbl.ShopDesc, "')\n")
				else
					str = string (str, "	" .. ":SetShop (", tbl.Price, ", ", tbl.Active and "true" or "false", ", ", tbl.NewItem, ")\n")
				end
			else
				if (tbl.ShopDesc) then
					str = string (str, "	" .. ":SetShop (", tbl.Price, ", ", tbl.Active and "true" or "false", ", '", tbl.ShopDesc, "')\n")
				else
					str = string (str, "	" .. ":SetShop (", tbl.Price, ", ", tbl.Active and "true" or "false", ")\n")
				end
			end

			MOAT_COLLECT[tbl.Collection].Crate = str
		else
			table.insert(MOAT_COLLECT[tbl.Collection], {String = str, Rarity = tbl.Rarity})
		end
	end

	if (tbl.Endangered and tbl.Collection) then
		MOAT_ENDANGERED[tbl.Collection] = tbl.Endangered
	end

	if (item_kind == "Body") then
		MOAT_BODY_ITEMS[tbl.ID] = true 
	end

	MOAT_DROPTABLE[tbl.ID] = tbl
end

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
        tbl.Image = v[4] or "https://static.moat.gg/f/dc118c40e7e7f5a37d4d37c5e0533c8a.png"
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
        tbl.Image = v[4] or "https://static.moat.gg/f/ed180ad2d90f58198e6159edde738131.png"
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
        tbl.Image = v[4] or "https://static.moat.gg/f/2198b5d9d5c8a1e35fe2a4c833556fd6.png"
        tbl.ItemCheck = 12
        function tbl:ItemUsed(pl, slot, item)
            m_TextureItem(pl, slot, item, self.ID)
        end

        m_AddDroppableItem(tbl, "Usable")
    end
end

local MOAT_ITEM_FOLDER = "plugins/moat/modules/inv2/data"
function m_InitializeItems()
	if (SERVER) then
		AddCSLuaFile(MOAT_ITEM_FOLDER .. "/droptable.lua")
	end

    include(MOAT_ITEM_FOLDER .. "/droptable.lua")

	if (SERVER) then
		AddCSLuaFile(MOAT_ITEM_FOLDER .. "/paints.lua")
	end

    include(MOAT_ITEM_FOLDER .. "/paints.lua")
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
        if (v.Collection == crate_collection and v.Kind ~= "Crate" and not v.NotDroppable) then
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

    local item_tbl = ienum and table.Copy(MOAT_DROPTABLE[ienum]) or {}
	if (ienum and not item_tbl.Kind) then
		local try = string.gsub(ienum, "2", "1", 1)

		if (MOAT_DROPTABLE[tonumber(try)]) then
			item_tbl = table.Copy(MOAT_DROPTABLE[tonumber(try)]) or {}
		end
	end

    item_tbl.OnPlayerSpawn = nil
    item_tbl.ModifyClientsideModel = nil
    item_tbl.DynamicModifyClientsideModel = nil
    item_tbl.EffectColor = nil
    item_tbl.EffectSize = nil
    item_tbl.OnDamageTaken = nil
    item_tbl.OnBeginRound = nil
    item_tbl.ScalePlayerDamage = nil
    item_tbl.ItemUsed = nil

    if (item_tbl.Kind == "Crate" and CLIENT) then
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
	if (not item_tbl.Kind) then
		local try = string.gsub(ienum, "2", "1", 1)

		if (MOAT_DROPTABLE[tonumber(try)]) then
			item_tbl = table.Copy(MOAT_DROPTABLE[tonumber(try)]) or {}
		end
	end

    if (CLIENT and item_tbl.Kind == "Crate") then
        item_tbl.Contents = GetCrateContents(item_tbl.Collection)
    end

    if (ienum) then item_cache2[ienum] = item_tbl end

    return item_tbl
end

function GetItemName(data)
	local ITEM_NAME_FULL = ""

	if (data and data.u and (not data.item or not data.item.Kind)) then
		data.item = GetItemFromEnum(data.u)
	end

    if (data and data.item and data.item.Kind == "tier") then
        local ITEM_NAME = util.GetWeaponName(data.w or "weapon_ttt_m16")

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

	if (data.n) then
		ITEM_NAME_FULL = data.n:Replace("''", "'") -- "\"" .. data.n:Replace("''", "'") .. "\""
	end

	return ITEM_NAME_FULL
end