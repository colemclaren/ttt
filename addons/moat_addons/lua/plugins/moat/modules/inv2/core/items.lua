MOAT_DROPTABLE = {}
MOAT_COLLECT = {}



function m_AddDroppableItem(item_table, item_kind, file_str)
    local tbl = {}
    tbl = item_table
    tbl.Kind = item_kind

	if (SERVER and item_table.Collection) then
		if (not MOAT_COLLECT[item_table.Collection]) then MOAT_COLLECT[item_table.Collection] = {} end
		tbl.Rarity = (tbl.Rarity == 9 and 8) or (tbl.Rarity == 8 and 10) or tbl.Rarity
		tbl.Kind = (tbl.Kind == "tier" and "Tier") or tbl.Kind

		local str = string ("\n",
			"inv.Item(" .. tbl.ID .. ")\n",
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
				if ((tbl.Kind == "tier" or tbl.Kind == "Tier" or tbl.Kind == "Unique") and inv.Stat.Roster[k]) then
					if (inv.Stat.Roster[k].Defaults[def] and inv.Stat.Roster[k].Defaults[def][tbl.Rarity]) then
						if (inv.Stat.Roster[k].Defaults[def][tbl.Rarity].Min == v.min and inv.Stat.Roster[k].Defaults[def][tbl.Rarity].Max == v.max) then
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

		if (tbl.ModifyClientsideModel) then
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
end

local MOAT_ITEM_FOLDER = "plugins/moat/modules/_items/items"
local MOAT_TALENT_FOLDER = "plugins/moat/modules/_items/talents"

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
    ["Other"] = "other",
    ["Usable"] = "usables"
}

function m_CreatePaints()
    local last_id = 6001
    for i = 1, #MOAT_PAINT.Colors do
        local tbl = {}
        tbl.Name = MOAT_PAINT.Colors[i][1] .. " Tint"
        tbl.ID = last_id
        tbl.Description = "Right click a weapon to use this it on it"
        tbl.Rarity = MOAT_PAINT.Colors[i][3]
        tbl.Clr = MOAT_PAINT.Colors[i][2]
        --tbl.NameColor = Color(MOAT_PAINT.Colors[i][2][1], MOAT_PAINT.Colors[i][2][2], MOAT_PAINT.Colors[i][2][3])
        tbl.Collection = "Paint Collection"
        tbl.PaintVer = 1
        tbl.Image = "https://moat.gg/assets/img/tint64.png"
        tbl.ItemCheck = 11
        function tbl:ItemUsed(pl, slot, item)
            m_TintItem(pl, slot, item, self.ID)
        end

		if (tbl.Name and tbl.Name == "Pure White Tint") then
			tbl.NotDroppable = true
		end

        m_AddDroppableItem(tbl, "Usable")

        last_id = last_id + 1
    end

    for i = 1, #MOAT_PAINT.Colors do
        local tbl = {}
        tbl.Name = MOAT_PAINT.Colors[i][1] .. " Paint"
        tbl.ID = last_id
        tbl.Description = "Right click a item to use this paint on it"
        tbl.Rarity = MOAT_PAINT.Colors[i][3]
        tbl.Clr = MOAT_PAINT.Colors[i][2]
        --tbl.NameColor = Color(MOAT_PAINT.Colors[i][2][1], MOAT_PAINT.Colors[i][2][2], MOAT_PAINT.Colors[i][2][3])
        tbl.Collection = "Paint Collection"
        tbl.PaintVer = 2
        tbl.Image = "https://moat.gg/assets/img/paint64.png"
        tbl.ItemCheck = 10
        function tbl:ItemUsed(pl, slot, item)
            m_PaintItem(pl, slot, item, self.ID)
        end

        m_AddDroppableItem(tbl, "Usable")

        last_id = last_id + 1
    end

    for i = 1, #MOAT_PAINT.Textures do
        local tbl = {}
        tbl.Name = MOAT_PAINT.Textures[i][1] .. " Texture"
        tbl.ID = last_id
        tbl.Description = "Right click a weapon to use this texture on it"
        tbl.Rarity = MOAT_PAINT.Textures[i][3]
        tbl.Texture = MOAT_PAINT.Textures[i][2]
        --tbl.NameColor = Color(MOAT_PAINT.Colors[i][2][1], MOAT_PAINT.Colors[i][2][2], MOAT_PAINT.Colors[i][2][3])
        tbl.Collection = "Paint Collection"
        tbl.PaintVer = 2
        tbl.Image = "https://moat.gg/assets/img/texture64.png"
        tbl.ItemCheck = 12
        function tbl:ItemUsed(pl, slot, item)
            m_TextureItem(pl, slot, item, self.ID)
        end

        m_AddDroppableItem(tbl, "Usable")

        last_id = last_id + 1
    end
end

function m_InitializeItems()
    for type, folder in pairs(MOAT_ITEM_FOLDERS) do
        for _, filename in pairs(file.Find(MOAT_ITEM_FOLDER .. "/" .. folder .. "/*.lua", "LUA")) do
            ITEM = {}
            include(MOAT_ITEM_FOLDER .. "/" .. folder .. "/" .. filename)
            m_AddDroppableItem(ITEM, type, file.Read(MOAT_ITEM_FOLDER .. "/" .. folder .. "/" .. filename, "LUA"))
        end
    end

    include(MOAT_ITEM_FOLDER .. "/paints/load.lua")
    m_CreatePaints()
    -- boom beep items loooooaded
end
timer.Simple(5, function() m_InitializeItems() end)

concommand.Add("_reloaditems", function(pl)
	if (IsValid(pl)) then return end
	m_InitializeTalents()
end)

local MOAT_TALENT_FOLDER = "plugins/moat/modules/_items/talents"

MOAT_TALENTS = {}

function m_AddTalent(talent_tbl)
    MOAT_TALENTS[talent_tbl.ID] = talent_tbl
end

function m_InitializeTalents()
	for k, v in pairs(file.Find(MOAT_TALENT_FOLDER .. "/*.lua", "LUA")) do
    	TALENT = {}
    	include(MOAT_TALENT_FOLDER .. "/" .. v)
    	MsgC(Color(255, 255, 0), "[mInventory] Loaded Talent: " .. TALENT.Name .. "\n")
    	m_AddTalent(TALENT)
	end
end
m_InitializeTalents()

concommand.Add("moat_finditemid",function(ply)
    if (IsValid(ply)) then return end
    for i = 1,10000 do
        if (not MOAT_DROPTABLE[i]) then
            print("Unused: ITEM.ID = " .. i)
            break
        end
    end
end)

concommand.Add("_reloadtalents", function(pl)
	if (IsValid(pl)) then return end
	m_InitializeTalents()
end)
