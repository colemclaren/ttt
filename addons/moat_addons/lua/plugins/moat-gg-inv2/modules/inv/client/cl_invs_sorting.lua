function mi:SortTest()
    local function sort(tbl, empty)
        local function value(item)
            -- slotid is from 0 to 10
            local itemid_max = 100000
            local slot_max = 11
            local tier_max = 10

            local itemid_mult = 1
            local tier_mult   = itemid_max * itemid_mult
            local slot_mult   = tier_mult * tier_max

            return item.tier * tier_mult + (slot_max - item.slot) * slot_mult + item.itemid * itemid_mult
        end
        table.sort(tbl, function(item1, item2)
            local v1, v2 = value(item1), value(item2)
            if (v1 == v2) then
                if (item1.w and item2.w) then
                    return item1.w > item2.w
                else
                    return not not item1.w
                end
            end
            return v1 > v2
        end)

        local i = 2
        local last_tier, last_slot
        local function should_fill(item)
            local ltier, lslot = last_tier, last_slot
            last_tier, last_slot = item.tier, item.slot
            return ltier ~= last_tier or lslot ~= last_slot
        end

        should_fill(tbl[1])
        while (tbl[i]) do
            local item = tbl[i]
            if (should_fill(item)) then
                local pos = (i - 1) % 5 + 1
                for _ = pos, 5 do
                    table.insert(tbl, i, empty)
                    i = i + 1
                end
            end
            i = i + 1
        end
    end

    self:SortSlots(sort, function(tbl)
        self:GetOurSlots(function(max, items)
            local needed = {}
            local slotwep = {}
            for id in pairs(items.c) do
                needed[id] = true
            end
            for i, item in ipairs(tbl) do
                assert(item.id, "No item id")
                if (item.id == 0) then
                    continue
                end
                assert(needed[item.id], "Duplicate or nonexisting item")
                assert(items.s[item.slotid] == item.id, "Item slot mismatch")
                slotwep[i] = item.id
                needed[item.id] = nil
            end
            self:CreateNewSlots_CompleteRows(#tbl - max, function()
                local it = table.Copy(items)
                for slot, id in pairs(slotwep) do
                    -- since we don't update sql we don't need a callback
                    local from, to = it.c[id], slot
                    if (from == to) then
                        continue
                    end
                    m_SwapInventorySlots(M_INV_SLOT[from], to, nil, true)

                    local fid, tid = it.s[from], it.s[to]
                    it.s[to], it.s[from] = fid, tid
                    it.c[fid] = to
                    if (tid ~= 0) then
                        it.c[tid] = from
                    end
                end
                self:MassSwapInventory(slotwep, function()
                    print "done"
                end)
            end)
        end)
    end)
end

function mi:SortSlots(sort, callback)
	needs_testing()
	
	self:GetOurSlots(function(_, items)
		local sorting_table = {}

		for slotid, weaponid in pairs(items.s) do
			-- skip loadout
			if (slotid < 0) then
				continue
			end

			local wpn = m_ItemCache[weaponid]

			if (not wpn) then
				continue
			end

			local friendly = {}
			friendly.id = weaponid

			--[[ -- Do people need stats?
			if (wpn.s) then
				friendly.Stats = {}
				for statid, statval in pairs(wpn.s) do
					friendly.Stats[self:GetStatName(statid)] = statval
				end
			end
			]]

			friendly.itemid = wpn.u
			friendly.w = wpn.w

			assert(wpn.item, "No item for weapon")

			friendly.tier = wpn.item.Rarity or ''
			friendly.slot = mi.GetLoadoutSlot(wpn) or ''

			friendly.slotid = slotid
			friendly.rand = math.random()

			table.insert(sorting_table, friendly)
		end
		local empty = setmetatable({}, {__newindex = {}, __index  = {c = ''}})
		sort(sorting_table, empty)

		callback(sorting_table)
	end)
end

function mi:MassSwapInventory(new_slots, fn)
	return self:GetOurSlots(function(max, cache)
		for k in pairs(cache.slots) do
			cache.slots[k] = new_slots[k] or 0
		end

		for slot, id in pairs(new_slots) do
			cache.ids[id] = slot
		end

		local query = "DELETE FROM " .. ck .. " WHERE slotid > 0;\n"
		local template = "INSERT INTO " .. ck .. " (id, slotid, steamid) VALUES "
		local values_template = "(?, ?, ?!)"
		local cur_values = {}

		for slotid, weaponid in pairs(new_slots) do
			table.insert(cur_values, self.SQL:CreateQuery(values_template, weaponid, slotid, steamid()))
			if (#cur_values == 500) then
				query = query..template..table.concat(cur_values, ",\n")..";\n"
				cur_values = {}
			end
		end

		query = query..template..table.concat(cur_values, ",\n")..";\n"

		self.SQL:Query(query, fn)
	end)
end