local PLAYER = FindMetaTable "Player"
print 'drops loaded'

function m_GetRandomTalent(talent_lvl, talent_name, talent_melee)
	local talent_tbl = {}
	local moat_fourth_talent = false

	if (talent_lvl > 3) then
		talent_lvl = 3
		moat_fourth_talent = true
	end


	if (talent_name ~= "random") then
		for k, v in pairs(MOAT_TALENTS) do
			if (string.lower(talent_name) == string.lower(v.Name)) then
				talent_tbl = table.Copy(v)
				break
			end
		end
	else
		for k, v in RandomPairs(MOAT_TALENTS) do
			if (talent_lvl == v.Tier and v.NotUnique) then
				if (talent_melee and not v.Melee) then continue end
				if (not talent_melee and v.MeleeOnly) then continue end
				talent_tbl = table.Copy(v)
				break
			end
		end
	end

	if (moat_fourth_talent) then
		talent_tbl.LevelRequired = {min = 40, max = 50}
	end

	if (not talent_tbl.Tier) then
		talent_tbl.Tier = 5
	end

	return talent_tbl
end

local COSMETIC_TYPES = {
	["Hat"] = true,
	["Mask"] = true,
	["Model"] = true,
	["Effect"] = true,
	["Body"] = true,
	["Melee"] = true
}

function PLAYER:m_DropInventoryItem(cmd_item, cmd_class, drop_cosmetics, delay_le_saving, hide_chat, dev_talent_tbl)
	local dropped_item, items_to_drop, drop_table = {}, {}, table.Copy(MOAT_DROPTABLE)
	local chosen_rarity = (cmd_item) and tonumber(cmd_item) or mi.Rarity.Get()

	for k, v in pairs(drop_table) do
		if (cmd_item and v.Name and string.lower(v.Name) == string.lower(cmd_item)) then
			table.insert(items_to_drop, v)

			break
		end

		if (v.Rarity == chosen_rarity and (drop_cosmetics == nil or (((not drop_cosmetics[1] and not COSMETIC_TYPES[v.Kind]) or drop_cosmetics[1]) and ((not drop_cosmetics[2] and (v.ID < 6001 or v.ID > 6500)) or drop_cosmetics[2])))) then
			if (MOAT_ENDANGERED[v.Collection] or v.NotDroppable) then continue end

			table.insert(items_to_drop, v)
		end
	end

	if (#items_to_drop <= 0) then
		moat.print 'Drop Error: Inventory Item Not Found!'

		return
	end

	local item_to_drop = items_to_drop[math.random(#items_to_drop)]
	dropped_item.u = item_to_drop.ID

	if (item_to_drop.Kind == "tier" or item_to_drop.Kind == "Unique") then
		dropped_item.s = {}
		local stats_to_apply = 0

		if (item_to_drop.MinStats and item_to_drop.MaxStats) then
			stats_to_apply = math.random(item_to_drop.MinStats, item_to_drop.MaxStats)
		end

		local stats_chosen = 0

		for k, v in RandomPairs(item_to_drop.Stats) do
			if (tostring(k) == "Damage") then
				dropped_item.s.d = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Accuracy") then
				dropped_item.s.a = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Kick") then
				dropped_item.s.k = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Firerate") then
				dropped_item.s.f = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Magazine") then
				dropped_item.s.m = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Range") then
				dropped_item.s.r = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Weight") then
				dropped_item.s.w = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Reloadrate") then
				dropped_item.s.y = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Deployrate") then
				dropped_item.s.z = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Chargerate") then
				dropped_item.s.c = math.Round(math.Rand(0, 1), 3)
			end

			if (stats_to_apply > 0) then
				stats_chosen = stats_chosen + 1
				if (stats_chosen >= stats_to_apply) then break end
			end
		end

		dropped_item.w = ""

		if (MOAT_ENDANGERED[item_to_drop.Collection]) then
			for k, v in RandomPairs(weapons.GetList()) do
				if (v.Base == "weapon_tttbase" and (v.ClassName:StartWith("weapon_ttt_te_") or v.AutoSpawnable)) then
					dropped_item.w = v.ClassName
					break
				end
			end
		elseif (item_to_drop.Name:match '^Titan T') then
			for k, v in RandomPairs(weapons.GetList()) do
				if (v.Base == "weapon_tttbase" and v.ClassName:StartWith("weapon_ttt_te_")) then
					dropped_item.w = v.ClassName
					break
				end
			end
		else
			for k, v in RandomPairs(weapons.GetList()) do
				if (v.AutoSpawnable and v.Base == "weapon_tttbase" and ((item_to_drop.ID == 912 and not v.ViewModelFlip) or item_to_drop.ID ~= 912)) then
					dropped_item.w = v.ClassName
					break
				end
			end
		end

		if (cmd_class and cmd_class ~= "endrounddrop") then
			local weapon_class_found = ""

			for k, v in RandomPairs(weapons.GetList()) do
				if (v.AutoSpawnable and v.Base == "weapon_tttbase") then
					weapon_class_found = v.ClassName
				end

				if (string.lower(v.ClassName) == string.lower(cmd_class)) then
					weapon_class_found = v.ClassName
					break
				end
			end

			dropped_item.w = weapon_class_found
		end

		if (item_to_drop.Kind == "Unique" and item_to_drop.WeaponClass) then
			dropped_item.w = item_to_drop.WeaponClass
		end

		if (item_to_drop.MinTalents and item_to_drop.MaxTalents and item_to_drop.Talents) then
			dropped_item.s.l = 1
			dropped_item.s.x = 0
			dropped_item.t = {}
			local talents_chosen = {}
			local talents_to_loop = dev_talent_tbl or item_to_drop.Talents

			for k, v in ipairs(talents_to_loop) do
				talents_chosen[k] = m_GetRandomTalent(k, v, false)
			end

			for i = 1, table.Count(talents_chosen) do
				local talent_tbl = talents_chosen[i]
				dropped_item.t[i] = {}
				dropped_item.t[i].e = talent_tbl.ID
				dropped_item.t[i].l = math.random(talent_tbl.LevelRequired and talent_tbl.LevelRequired.min or (talent_tbl.Tier * 10), talent_tbl.LevelRequired and talent_tbl.LevelRequired.max or (talent_tbl.Tier * 20))
				dropped_item.t[i].m = {}

				for k, v in ipairs(talent_tbl.Modifications) do
					dropped_item.t[i].m[k] = math.Round(math.Rand(0, 1), 2)
				end
			end
		end
	elseif (item_to_drop.Kind == "Melee") then
		dropped_item.s = {}
		local stats_to_apply = 0

		if (item_to_drop.MinStats and item_to_drop.MaxStats) then
			stats_to_apply = math.random(item_to_drop.MinStats, item_to_drop.MaxStats)
		end

		local stats_chosen = 0

		for k, v in RandomPairs(item_to_drop.Stats) do
			if (tostring(k) == "Damage") then
				dropped_item.s.d = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Firerate") then
				dropped_item.s.f = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Pushrate") then
				dropped_item.s.p = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Force") then
				dropped_item.s.v = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Weight") then
				dropped_item.s.w = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Reloadrate") then
				dropped_item.s.y = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Deployrate") then
				dropped_item.s.z = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Chargerate") then
				dropped_item.s.c = math.Round(math.Rand(0, 1), 3)
			end

			if (stats_to_apply > 0) then
				stats_chosen = stats_chosen + 1
				if (stats_chosen >= stats_to_apply) then break end
			end
		end

		dropped_item.w = ""

		if (item_to_drop.WeaponClass) then
			dropped_item.w = item_to_drop.WeaponClass
		end

		dropped_item.s.l = 1
		dropped_item.s.x = 0
		dropped_item.t = {}
		local talents_chosen = {}
		local melee_talents = item_to_drop.Talents or {}
		local talents_to_loop = {melee_talents[1] or "random", melee_talents[2] or "random", melee_talents[3] or "random"}

		if (dev_talent_tbl) then
			talents_to_loop = dev_talent_tbl
		end

		for k, v in ipairs(talents_to_loop) do
			talents_chosen[k] = m_GetRandomTalent(k, v, true)
		end

		for i = 1, table.Count(talents_chosen) do
			local talent_tbl = talents_chosen[i]
			dropped_item.t[i] = {}
			dropped_item.t[i].e = talent_tbl.ID
			dropped_item.t[i].l = math.random(talent_tbl.LevelRequired and talent_tbl.LevelRequired.min or (talent_tbl.Tier * 10), talent_tbl.LevelRequired and talent_tbl.LevelRequired.max or (talent_tbl.Tier * 20))
			dropped_item.t[i].m = {}

			for k, v in ipairs(talent_tbl.Modifications) do
				dropped_item.t[i].m[k] = math.Round(math.Rand(0, 1), 2)
			end
		end
	elseif ((item_to_drop.Kind == "Power-Up" or item_to_drop.Kind == "Special" or item_to_drop.Kind == "Usable") and item_to_drop.Stats) then
		dropped_item.s = {}

		for i = 1, #item_to_drop.Stats do
			dropped_item.s[i] = math.Round(math.Rand(0, 1), 3)
		end
	end

	dropped_item.c = util.CRC(os.time() .. SysTime())

	hook.Run("PlayerObtainedItem", self, dropped_item)
	local dont_show_chat = false
	delay_le_saving = delay_le_saving or false

	if (cmd_class and cmd_class == "hide_chat_obtained") then
		dont_show_chat = true
	end

	if (hide_chat == true) then
		dont_show_chat = true
	end

	if (dropped_item and dropped_item.u and item_to_drop and item_to_drop.Rarity and not dont_show_chat) then
		if (item_to_drop.Rarity == 6) then
			cdn.PlayURL("https://static.moat.gg/ttt/Stinger_loot_04.wav", .5)
			util.GlobalScreenShake(5, 5, 10, 5000)
		elseif (item_to_drop.Rarity == 7) then
			cdn.PlayURL("https://static.moat.gg/ttt/Stinger_loot_07.wav", .5)
			util.GlobalScreenShake(5, 5, 10, 5000)
		elseif (item_to_drop.Rarity == 8) then
			self:PlayURL("https://static.moat.gg/ttt/Stinger_loot_03.wav", .5)
			self:ScreenShake(5, 5, 10, 5000)
		elseif (item_to_drop.Rarity == 9) then
			cdn.PlayURL("https://static.moat.gg/ttt/Arcana_drop.mp3", .5)
			util.GlobalScreenShake(25, 25, 15, 5000)
		elseif (tonumber(dropped_item.u) == 912 or item_to_drop.Name:match '^Titan T') then
			cdn.PlayURL("https://static.moat.gg/ttt/0deac606259916ecf13fb7aba1b0deeb.mp3", .5)
		end
	end

	if (not delay_le_saving) then delay_le_saving = nil end
	self:m_AddInventoryItem(dropped_item, delay_le_saving, dont_show_chat)
end

local cached_droptable
local cached_itemstodrop = {}
local cached_items = {}
local cached_rarities = {}
local cached_weapons
function m_GetRandomInventoryItem(arg_collection, item)
	if (not cached_droptable) then cached_droptable = table.Copy(MOAT_DROPTABLE) end
	local dropped_item = {}
	local drop_table = cached_droptable
	local items_to_drop = {}

	if (cached_itemstodrop[arg_collection]) then
		items_to_drop = cached_itemstodrop[arg_collection]
	elseif (item and item.Contains) then
		for k, v in pairs(drop_table) do
			if (table.HasValue(item.Contains, v.Collection) and not v.NotDroppable) then
				table.insert(items_to_drop, v)
			end
		end

		cached_itemstodrop[arg_collection] = items_to_drop
	elseif (arg_collection ~= "50/50 Collection") then
		for k, v in pairs(drop_table) do
			if (v.Collection == arg_collection and not v.NotDroppable) then
				table.insert(items_to_drop, v)
			end
		end

		cached_itemstodrop[arg_collection] = items_to_drop
	end

	-- Make sure all the rarities from the collection are set
	local min_rarity = 9
	local max_rarity = 1

	if (cached_rarities[arg_collection]) then
		min_rarity = cached_rarities[arg_collection][1]
		max_rarity = cached_rarities[arg_collection][2]
	elseif (arg_collection ~= "50/50 Collection") then
		for k, v in pairs(items_to_drop) do
			if (v.Rarity > max_rarity) then
				max_rarity = v.Rarity
			end

			if (v.Rarity < min_rarity) then
				min_rarity = v.Rarity
			end
		end

		cached_rarities[arg_collection] = {min_rarity, max_rarity}
	end

	local rarity_chosen
	if (item and item.Rarities) then
		local rand = math.random()
		local cur_low = 0
		for rarity = 1, 9 do
			if (rarity == 8) then
				continue
			end
			local pct = item.Rarities[rarity]
			if (not pct) then
				continue
			end
			
			if (cur_low <= rand and rand < (cur_low + pct)) then
				rarity_chosen = rarity
				break
			end
			cur_low = cur_low + pct
		end
	end

	if (not rarity_chosen) then
		rarity_chosen = 1
		if (item and item.ChosenRarity) then
			rarity_chosen = item.ChosenRarity
		elseif (arg_collection ~= "50/50 Collection") then
			rarity_chosen = mi.Rarity.Get(min_rarity, max_rarity)
		end
	end
	
	local items_from_collection = {Weapons = {}}
	if (arg_collection == "50/50 Collection") then
		rarity_chosen = math.random(1, 100) <= 50 and 5 or 1

		if (cached_items[arg_collection] and cached_items[arg_collection][rarity_chosen]) then
			items_from_collection = cached_items[arg_collection][rarity_chosen]
		else
			for k, v in pairs(drop_table) do
				if (v.Rarity == rarity_chosen and v.Kind ~= "Crate" and not COSMETIC_TYPES[v.Kind] and v.Collection ~= "Easter Collection" and v.Collection ~= "Omega Collection" and v.Collection ~= "Aqua Palm Collection" and v.Collection ~= "Holiday Collection" and not v.NotDroppable) then
					table.insert(items_from_collection, v)
				end
			end

			if (not cached_items[arg_collection]) then cached_items[arg_collection] = {} end
			cached_items[arg_collection][rarity_chosen] = items_from_collection
		end
	else
		if (cached_items[arg_collection] and cached_items[arg_collection][rarity_chosen]) then
			items_from_collection = cached_items[arg_collection][rarity_chosen]
		else
			for k, v in pairs(items_to_drop) do
				if (v.Rarity == rarity_chosen and v.Kind ~= "Crate") then
					table.insert(items_from_collection, v)
				end
			end

			if (not cached_items[arg_collection]) then cached_items[arg_collection] = {} end

			items_from_collection.Weapons = {}

			for _, v in ipairs(items_from_collection) do
				if (v.Kind == "tier" or v.Kind == "Unique") then
					table.insert(items_from_collection.Weapons, v)
				end
			end

			cached_items[arg_collection][rarity_chosen] = items_from_collection
		end
	end

	if (items_from_collection.Weapons and #items_from_collection.Weapons == 0) then
		items_from_collection.Weapons = nil
	end

	local pct = item and item.WeaponForcePercent or 0
	if (items_from_collection.Weapons and math.random() < pct) then
		items_from_collection = items_from_collection.Weapons
	end

	
	if (#items_from_collection > 0) then
		local item_to_drop = items_from_collection[math.random(#items_from_collection)]
		dropped_item.u = item_to_drop.ID

		if (not cached_weapons) then cached_weapons = weapons.GetList() end

		if (item_to_drop.Kind == "tier" or item_to_drop.Kind == "Unique") then
			dropped_item.w = ""

			if (item_to_drop.Collection == "Pumpkin Collection"or item_to_drop.Collection == "Holiday Collection" or item_to_drop.Collection == "Omega Collection" or item_to_drop.Collection == "Aqua Palm Collection") then
				for k, v in RandomPairs(cached_weapons) do
					if (v.Base == "weapon_tttbase" and (v.AutoSpawnable or v.ClassName:StartWith("weapon_ttt_te_"))) then
						dropped_item.w = v.ClassName
						break
					end
				end
			elseif (item_to_drop.Name:match '^Titan T') then
				for k, v in RandomPairs(cached_weapons) do
					if (v.Base == "weapon_tttbase" and v.ClassName:StartWith("weapon_ttt_te_")) then
						dropped_item.w = v.ClassName
						break
					end
				end
			else
				for k, v in RandomPairs(cached_weapons) do
					if (v.AutoSpawnable and v.Base == "weapon_tttbase") then
						dropped_item.w = v.ClassName
						break
					end
				end
			end

			if (item_to_drop.Kind == "Unique" and item_to_drop.WeaponClass) then
				dropped_item.w = item_to_drop.WeaponClass
			end
		end

		if (item_to_drop.Kind == "Melee") then
			dropped_item.w = ""

			if (item_to_drop.WeaponClass) then
				dropped_item.w = item_to_drop.WeaponClass
			end
		end

		dropped_item.c = 1

		return dropped_item
	else
		return {}
	end
end

concommand.Add("moat_drop_item", function(ply, cmd, args)
	if (not moat.isdev(ply)) then return end

	local pl = ply
	if (args[3]) then
		pl = player.GetBySteamID(args[3])
	end
	if (args) then
		pl:m_DropInventoryItem(args[1], args[2])
	else
		pl:m_DropInventoryItem()
	end
end)

function m_AddTestRarity(tbl)
	local chosen_rarity = 1

	for i = 1, #MOAT_RARITIES do
		local chance_to_move = math.random(MOAT_RARITIES[i + 1].Rarity)

		if (chance_to_move ~= MOAT_RARITIES[i + 1].Rarity) then
			chosen_rarity = MOAT_RARITIES[i].ID
			break
		end
	end

	table.insert(tbl, chosen_rarity)
end


local cached_crates = {}

concommand.Add("moat_test_drops", function(ply, cmd, args)
	if (not moat.isdev(ply)) then return end

	local function p(t)
		if (IsValid(ply)) then
			ply:ChatPrint(t)
		else
			print(t)
		end
	end
	
	local crate_name = args[1]
	local amt = tonumber(args[2])
	if (type(amt) ~= "number") then
		p "second argument is count"
		return
	end

	local crate = cached_crates[crate_name]

	if (not crate) then
		for _, item in pairs(MOAT_DROPTABLE) do
			if (item.Name == crate_name) then
				cached_crates[crate_name] = item
				crate = item
			end
		end
	end

	if (not crate) then
		p "Crate doesn't exist"
		return
	end

	local results = {
		Kinds = {},
		Rarities = {}
	}

	for i = 1, amt do
		local item = MOAT_DROPTABLE[m_GetRandomInventoryItem(crate.Collection, crate).u]

		results.Rarities[item.Rarity] = (results.Rarities[item.Rarity] or 0) + 1
		results.Kinds[item.Kind] = (results.Kinds[item.Kind] or 0) + 1
	end

	p " --- RARITIES --- "
	for rarity = 1, 9 do
		local count = results.Rarities[rarity]
		if (count) then
			p("Rarity " .. rarity .. " = " .. string.format("%.05f%%", count / amt * 100))
		end
	end

	p "\n --- KINDS --- "
	for kind, count in pairs(results.Kinds) do
		p("Kind " .. kind .. " = " .. string.format("%.05f%%", count / amt * 100))

	end

	p " --- "
end)

local MOAT_PLAYER_DROPS_CHECK = {}
local MOAT_FORCED_DROPS = {}

local function IsRightful(killer, victim)
	return hook.Run("TTTIsRightfulDamage", killer, victim)
end

hook.Add("DoPlayerDeath", "moat_DropsEndRound", function(ply, att, dmg)
	if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then return end

	if (GetRoundState() == ROUND_ACTIVE and player.GetCount() >= 8 and IsRightful(att, ply)) then
		att.ExtraDropChances = (att.ExtraDropChances or 0) + ((ply:IsTraitor() or ply:IsDetective()) and 2 or 1)
	end
end)

hook.Add("TTTEndRound", "moat_DropsEndRound", function()
	for k, v in pairs(player.GetAll()) do
		if ((v:IsSpec() and not v:IsDeadTerror()) or (not MOAT_PLAYER_DROPS_CHECK[v])) then continue end
		if (MOAT_FORCED_DROPS[v:SteamID()]) then
			v:m_DropInventoryItem(MOAT_FORCED_DROPS[v:SteamID()][1], MOAT_FORCED_DROPS[v:SteamID()][2], {tonumber(v:GetInfo("moat_dropcosmetics")) == 1, tonumber(v:GetInfo("moat_droppaint")) == 1})
			
			continue
		end
		local drop_item = false

		for i = 0, v.ExtraDropChances or 0 do
			if (math.random(3) == 1) then 
				v:m_DropInventoryItem("endrounddrop", "endrounddrop", {tonumber(v:GetInfo("moat_dropcosmetics")) == 1, tonumber(v:GetInfo("moat_droppaint")) == 1})
			end
		end

		v.ExtraDropChances = 0
	end
end)

concommand.Add("moat_end_drop_test", function(ply, cmd, args)
	if (not moat.isdev(ply)) then return end

	ply:m_DropInventoryItem("endrounddrop", "endrounddrop", {tonumber(ply:GetInfo("moat_dropcosmetics")) == 1, tonumber(ply:GetInfo("moat_droppaint")) == 1})
end)

concommand.Add("moat_end_drop", function(ply, cmd, args)
	if (not moat.isdev(ply)) then return end

	local steamid = args[1]
	local item = args[2]
	local class = args[3]

	MOAT_FORCED_DROPS[steamid] = {item, class}
end)

hook.Add("TTTBeginRound", "moat_DropsEndRoundCheck", function()
	MOAT_FORCED_DROPS = {}
	for k, v in pairs(player.GetAll()) do
		MOAT_PLAYER_DROPS_CHECK[v] = false
		v.NotAFK = false
	end
end)

local MOAT_KEYS_TO_CHECK = {
	[IN_ATTACK] = true,
	[IN_ATTACK2] = true,
	[IN_BACK] = true,
	[IN_DUCK] = true,
	[IN_FORWARD] = true,
	[IN_JUMP] = true,
	[IN_MOVELEFT] = true,
	[IN_MOVERIGHT] = true
}

hook.Add("KeyPress", "moat_DropsEndRoundCheckKeys", function(ply, key)
	if (MOAT_KEYS_TO_CHECK[key] and not MOAT_PLAYER_DROPS_CHECK[ply]) then
		MOAT_PLAYER_DROPS_CHECK[ply] = true
		ply.NotAFK = true
	end
end)

function m_TextureItem(pl, wep_slot, itemtbl, paint)
	local ply_item = MOAT_INVS[pl]["slot" .. wep_slot]

	ply_item.p3 = paint
	m_SaveInventory(pl)
	m_SendInvItem(pl, wep_slot)
end

function m_PaintItem(pl, wep_slot, itemtbl, paint)
	local ply_item = MOAT_INVS[pl]["slot" .. wep_slot]

	ply_item.p2 = paint
	m_SaveInventory(pl)
	m_SendInvItem(pl, wep_slot)
end

function m_TintItem(pl, wep_slot, itemtbl, paint)
	local ply_item = MOAT_INVS[pl]["slot" .. wep_slot]

	ply_item.p = paint
	m_SaveInventory(pl)
	m_SendInvItem(pl, wep_slot)
end

function m_ResetTalents(pl, wep_slot, itemtbl)
	local ply_item = MOAT_INVS[pl]["slot" .. wep_slot]
	itemtbl = itemtbl.item

	if ((itemtbl.MinTalents and itemtbl.MaxTalents and itemtbl.Talents) or (itemtbl.Kind and itemtbl.Kind == "Melee")) then
		local old_talents = #ply_item.t

		ply_item.s.l = 1
		ply_item.s.x = 0
		ply_item.t = {}

		local talents_chosen = {}
		local talents_to_loop = itemtbl.Talents

		if (itemtbl.Kind and itemtbl.Kind == "Melee") then
			talents_to_loop = {}
			for i = 1, old_talents do
				table.insert(talents_to_loop, "random")
			end
		end

		for k, v in ipairs(talents_to_loop) do
			talents_chosen[k] = m_GetRandomTalent(k, v, (itemtbl.Kind and itemtbl.Kind == "Melee"))
		end

		for i = 1, table.Count(talents_chosen) do
			local talent_tbl = talents_chosen[i]
			ply_item.t[i] = {}
			ply_item.t[i].e = talent_tbl.ID
			ply_item.t[i].l = math.random(talent_tbl.LevelRequired and talent_tbl.LevelRequired.min or (talent_tbl.Tier * 10), talent_tbl.LevelRequired and talent_tbl.LevelRequired.max or (talent_tbl.Tier * 20))
			ply_item.t[i].m = {}

			for k, v in ipairs(talent_tbl.Modifications) do
				ply_item.t[i].m[k] = math.Round(math.Rand(0, 1), 2)
			end
		end
	end

	m_SaveInventory(pl)
	m_SendInvItem(pl, wep_slot)
end

function m_AssignDogLover(pl, wep_slot, itemtbl)
	local ply_item = MOAT_INVS[pl]["slot" .. wep_slot]
	local talent_index = 2

	if (not ply_item.t) then
		ply_item.s.l = 1
		ply_item.s.x = 0
		ply_item.t = {}

		talent_index = 1
	end

	ply_item.t[talent_index] = {}
	ply_item.t[talent_index].e = 154
	ply_item.t[talent_index].l = math.random(15, 20)
	ply_item.t[talent_index].m = {}
	ply_item.t[talent_index].m[1] = math.Round(math.Rand(0, 1), 2)
	ply_item.t[talent_index].m[2] = math.Round(math.Rand(0, 1), 2)

	m_SaveInventory(pl)
	m_SendInvItem(pl, wep_slot)
end

function m_ResetStats(pl, wep_slot, itemtbl)
	local ply_item = MOAT_INVS[pl]["slot" .. wep_slot]
	itemtbl = itemtbl.item

	if (itemtbl.Kind == "tier" or itemtbl.Kind == "Unique") then
		local saved_level = nil

		if (ply_item.s and ply_item.s.l) then
			saved_level = {ply_item.s.l, ply_item.s.x}
		end

		ply_item.s = {}

		if (saved_level) then
			ply_item.s.l = saved_level[1]
			ply_item.s.x = saved_level[2]
		end

		local stats_to_apply = 0

		if (itemtbl.MinStats and itemtbl.MaxStats) then
			stats_to_apply = math.random(itemtbl.MinStats, itemtbl.MaxStats)
		end

		local stats_chosen = 0

		for k, v in RandomPairs(itemtbl.Stats) do
			if (tostring(k) == "Damage") then
				ply_item.s.d = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Accuracy") then
				ply_item.s.a = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Kick") then
				ply_item.s.k = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Firerate") then
				ply_item.s.f = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Magazine") then
				ply_item.s.m = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Range") then
				ply_item.s.r = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Weight") then
				ply_item.s.w = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Reloadrate") then
				ply_item.s.y = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Deployrate") then
				ply_item.s.z = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Chargerate") then
				ply_item.s.c = math.Round(math.Rand(0, 1), 3)
			end

			if (stats_to_apply > 0) then
				stats_chosen = stats_chosen + 1
				if (stats_chosen >= stats_to_apply) then break end
			end
		end
	elseif (itemtbl.Kind == "Melee") then
		local saved_level = nil

		if (ply_item.s and ply_item.s.l) then
			saved_level = {ply_item.s.l, ply_item.s.x}
		end

		ply_item.s = {}

		if (saved_level) then
			ply_item.s.l = saved_level[1]
			ply_item.s.x = saved_level[2]
		end

		local stats_to_apply = 0

		if (itemtbl.MinStats and itemtbl.MaxStats) then
			stats_to_apply = math.random(itemtbl.MinStats, itemtbl.MaxStats)
		end

		local stats_chosen = 0

		for k, v in RandomPairs(itemtbl.Stats) do
			if (tostring(k) == "Damage") then
				ply_item.s.d = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Firerate") then
				ply_item.s.f = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Pushrate") then
				ply_item.s.p = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Force") then
				ply_item.s.v = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Weight") then
				ply_item.s.w = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Reloadrate") then
				ply_item.s.y = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Deployrate") then
				ply_item.s.z = math.Round(math.Rand(0, 1), 3)
			elseif (tostring(k) == "Chargerate") then
				ply_item.s.c = math.Round(math.Rand(0, 1), 3)
			end

			if (stats_to_apply > 0) then
				stats_chosen = stats_chosen + 1
				if (stats_chosen >= stats_to_apply) then break end
			end
		end
	elseif ((itemtbl.Kind == "Power-Up" or itemtbl.Kind == "Special" or itemtbl.Kind == "Usable") and itemtbl.Stats) then
		local saved_level = nil

		if (ply_item.s and ply_item.s.l) then
			saved_level = {ply_item.s.l, ply_item.s.x}
		end

		ply_item.s = {}

		if (saved_level) then
			ply_item.s.l = saved_level[1]
			ply_item.s.x = saved_level[2]
		end

		for i = 1, #itemtbl.Stats do
			ply_item.s[i] = math.Round(math.Rand(0, 1), 3)
		end
	end

	m_SaveInventory(pl)
	m_SendInvItem(pl, wep_slot)
end

util.AddNetworkString "OldMelee.Reset"
function m_OldMeleeReset(pl, slot, class)
	local ply_inv = MOAT_INVS[pl]

	if (not ply_inv) then
		return false
	end

	if (not ply_inv["slot" .. slot] or not ply_inv["slot" .. slot].c or not ply_inv["slot" .. slot].s) then
		return false
	end

	if (tonumber(ply_inv["slot" .. slot].c) ~= class) then
		return false
	end


	if (ply_inv["slot" .. slot].u == 17699) then
		if (ply_inv["slot" .. slot].s.p and ply_inv["slot" .. slot].s.w) then
			return false
		end
	elseif (not ply_inv["slot" .. slot].s.p or ply_inv["slot" .. slot].s.w) then
		return false
	end

	local item_chosen = table.Copy(ply_inv["slot" .. slot])
	item_chosen.item = GetItemFromEnumWithFunctions(ply_inv["slot" .. slot].u)
	if (not item_chosen) then return false end

	m_ResetStats(pl, slot, item_chosen)
	m_SendInvItem(pl, slot)

	m_FinishUsableItem(pl, {Name = "your free stat re-roll! Your melee now has Weight!"})
	
	pl.MeleeRolling = false
	return true
end

net.Receive("OldMelee.Reset", function(l, pl)
	local slot = net.ReadDouble()
	local class = net.ReadDouble()

	if (pl.MeleeRolling) then
		return
	end

	pl.MeleeRolling = true

	local isnew = m_OldMeleeReset(pl, slot, class)
	if (not isnew) then
		net.Start("moat.comp.chat")
		net.WriteString("Something went wrong while updating your melee, please reconnect and try again!")
		net.WriteBool(true)
		net.Send(pl)

		pl.MeleeRolling = false
	end
end)