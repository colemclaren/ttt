local steamid, needs_testing, ck = function()
	return LocalPlayer():SteamID64()
end, function()
	return error("function needs testing")
end, mi.Config.CacheKey

/*
	Item Slots
*/

function mi:LookupSlot(id, fn)
	local query = self.SQL:CreateQuery("SELECT slotid, locked FROM " .. ck .. " WHERE id = ? AND steamid = ?!;", id, steamid())
	self.SQL:Query(query, function(succ)
		return fn(succ and succ[1] and tonumber(succ[1].slotid) or nil, succ and succ[1] and succ[1].locked and succ[1].locked == "1")
	end)
end

function mi:LookupItem(slot, fn)
	local query = self.SQL:CreateQuery("SELECT id, locked FROM " .. ck .. " WHERE slotid = ? AND steamid = ?!;", tonumber(slot), steamid())
	self.SQL:Query(query, function(succ)
		return fn(succ and succ[1] and tonumber(succ[1].id) or nil)
	end)
end


function mi:SaveItemSlot(id, slot, locked, fn)
	local query = self.SQL:CreateQuery("REPLACE INTO " .. ck .. " (slotid, id, locked, steamid) values (?, ?, ?, ?!)", tonumber(slot), id, locked, steamid())
	self.SQL:Query(query, fn)
end

function mi:SwapItemSlot(id, id2, fn)
	self:GetOurItems(function(sn, cache)
		self:SwapSlotItem(cache.ids[id], cache.ids[id2])
	end)
end

function mi:DeleteItemSlot(id, fn)
	local query = self.SQL:CreateQuery("DELETE FROM " .. ck .. " WHERE id = ? AND steamid = ?!;", id, steamid())
	self.SQL:Query(query, fn)
end

function mi:SlotExists(slot, fn)
	local query = self.SQL:CreateQuery("SELECT id, locked FROM " .. ck .. " WHERE slotid = ? AND steamid = ?!;", tonumber(slot), steamid())
	self.SQL:Query(query, function(d)
		if (d and d[1] and d[1].id ~= "0" and d[1].id ~= 0) then
			return fn(true)
		else
			return fn(false)
		end
	end)
end

function mi:SaveSlotItem(slot, id, locked, fn)
	return self:SlotExists(slot, function(exists)
		if (exists) then
			return
		end

		local query = self.SQL:CreateQuery([[
			REPLACE INTO ]] .. ck .. [[ (id, slotid, locked, steamid) VALUES (?, ?, ?, ?!);
		]], id, tonumber(slot), isbool(locked) and (locked and "1" or "0") or locked, steamid())

		return self.SQL:Query(query, function()
			if (not M_INV_SLOT[slot]) then
				return self:GetOurSlots(function(max)
					return self:CreateNewSlots_CompleteRows(slot - max, fn)
				end)
			elseif (fn) then
				return fn()
			end
		end)
	end)
end

function mi:SwapSlotItem(slot, slot2, fn)
	slot, slot2 = tostring(slot), tostring(slot2)
	return self:GetOurSlots(function(max, cache)
		local item1, item2 = cache.slots[slot], cache.slots[slot2]
	
		if (item1 == 0) then
			assert(item2 ~= 0, "never should happen")

			return self:SwapSlotItem(slot2, slot, fn)
		end

		local locked1, locked2 = cache.locks[item1] == "1" or "0", cache.locks[item2] == "1" or "0"
		local query = self.SQL:CreateQuery(item2 ~= 0 and [[
			UPDATE ]] .. ck .. [[ SET id = ?item2, locked = ?locked2 WHERE slotid = ?slot1 AND steamid = ?!steamid;
			UPDATE ]] .. ck .. [[ SET id = ?item1, locked = ?locked1 WHERE slotid = ?slot2 AND steamid = ?!steamid;
		]] or [[
			DELETE FROM ]] .. ck ..[[ WHERE slotid = ?slot1 and steamid = ?steamid!;
			REPLACE INTO ]] .. ck .. [[ (id, locked, slotid, steamid) VALUES (?item1, ?!locked1, ?slot2, ?!steamid);
		]], {
			slot1 = tonumber(slot),
			slot2 = tonumber(slot2),
			locked1 = locked1,
			locked2 = locked2,
			item1 = item1,
			item2 = item2,
			steamid = steamid()
		})

		return self.SQL:Query(query, function()
			self.CachedSlots.Cache.slots[slot], self.CachedSlots.Cache.slots[slot2] = item2, item1
			self.CachedSlots.Cache.ids[item1], self.CachedSlots.Cache.ids[item2] = slot2, slot
			self.CachedSlots.Cache.locks[item1], self.CachedSlots.Cache.locks[item2] = locked2, locked1

			return fn and fn(self.CachedSlots.Max, self.CachedSlots.Cache) or nil
		end)
	end)
end

function mi:ClearSlotItem(slot, fn)
	local query = self.SQL:CreateQuery("DELETE FROM " .. ck .. " WHERE slotid = ? AND steamid = ?!;", tonumber(slot), steamid())
	self.SQL:Query(query, fn)
end

function mi:AddSlotItem(slot, id, locked, fn)
	self:SaveSlotItem(slot, id, locked, fn)
end

function mi:AddLocked(id, fn)
	local query = self.SQL:CreateQuery("UPDATE " .. ck .. " SET locked = 1 WHERE id = ? AND steamid = ?!;", id, steamid())
	self.SQL:Query(query, fn)
end

function mi:RemoveLocked(id, fn)
	local query = self.SQL:CreateQuery("UPDATE " .. ck .. " SET locked = 0 WHERE id = ? AND steamid = ?!;", id, steamid())
	self.SQL:Query(query, fn)
end

function mi:IsLocked(id, fn)
	local query = self.SQL:CreateQuery("SELECT locked FROM " .. ck .. " WHERE id = ? AND steamid = ?!;", id, steamid())
	self.SQL:Query(query, function(d)
		fn(d and d[1] and tostring(d[1].locked) == "1" or false)
	end)
end

function mi:GetOurSlots(fn)
	if (self.CachedSlots and self.CachedSlots.Max and self.CachedSlots.Cache) then
		return fn(self.CachedSlots.Max, self.CachedSlots.Cache)
	end

	if (self.SlotCache) then
		table.insert(self.SlotCache, fn)

		return
	end

	self.SlotCache = {fn}
	
	local query = self.SQL:CreateQuery("SELECT slotid, id, locked FROM " .. ck .. " WHERE steamid = ?!;", steamid())
	local function Internal()
		self.SQL:Query(query, function(data)
			if (not data) then
				data = {}
			end

			local cache = {
				ids = {}, -- id -> slot
				slots = {}, -- slot -> id
				locks = {}, -- id -> lock
			}

			local max = self.Config.MinSlots
			for _, dat in ipairs(data) do
				local id, slotid, locked = tonumber(dat.id), tostring(dat.slotid), dat.locked

				if (not m_ItemCache[id]) then
					continue
				end

				max = math.max(tonumber(slotid), max)
				
				cache.ids[id] = slotid
				cache.slots[slotid] = id
				cache.locks[id] = locked
			end

			for i = -10, max do
				if (not cache.slots[tostring(i)]) then
					cache.slots[tostring(i)] = 0
				end
			end

			self.CachedSlots = {
				Max = max,
				Cache = cache
			}

			for i = 1, #self.SlotCache do
				self:GetOurSlots(self.SlotCache[i])
			end
		end)
	end

	return Internal()
end

-- c = id -> slot
-- s = slot -> id

function mi:CreateNewSlots_CompleteRows(num, fn)
	return self:GetOurSlots(function(max)
		local needed = math.ceil((max + num) / mi.Config.ColumnCount) * mi.Config.ColumnCount - max
	
		for i = 1, needed do
			self:CreateNewSlot()
		end

		if (fn) then
			return fn()
		end
	end)
end

function mi:CreateNewSlot()
	return self:GetOurSlots(function(max, cache)
		local new = max + 1

		self:ClearSlotItem(new)
		self.CachedSlots.Max = math.max(max, new)
		self.CachedSlots.Cache.slots[tostring(new)] = 0

		m_Inventory[new] = {}

		if (IsValid(MOAT_INV_BG)) then
			m_CreateNewInvSlot(new)
		end
	end)
end

function mi:GetEmptySlot(max, cache, reverse, fn)
	local function Internal(max, cache)
		local starts, ends, step = 1, max, 1
		if (reverse) then
			starts, ends, step = max, 1, -1
		end

		for i = starts, ends, step do
			if (cache.slots[tostring(i)] == 0) then
				return fn(i)
			end
		end

		local new_max = max + 1
		cache.slots[tostring(new_max)] = 0

		if (not M_INV_SLOT[new_max]) then
			self:GetOurSlots(function(max)
				self:CreateNewSlots_CompleteRows(new_max - max, function()
					return fn(tostring(new_max))
				end)
			end)
		else
			return fn(tostring(new_max))
		end
	end

	if (not max or not cache) then
		return self:GetOurSlots(Internal)
	else
		return Internal(max, cache)
	end
end

function mi:GetSlotForID(id, fn)
	self:GetOurSlots(function(max, cache)
		if (cache.ids[id]) then
			return fn(cache.ids[id], cache.locks[id])
		end

		self:GetEmptySlot(max, cache, false, function(slot)
			slot = tostring(slot)
			
			cache.ids[id] = slot
			cache.locks[id] = false
			cache.slots[slot] = id

			self:AddSlotItem(slot, id, false, function()
				return fn(slot, false)
			end)
		end)
	end)
end

function mi:RemoveItemSlot(slot, fn)
	self:GetOurSlots(function(max, cache)
		local query = self.SQL:CreateQuery("DELETE FROM " .. ck .. " WHERE slotid = ? AND steamid = ?!", tonumber(slot), steamid())
		self.SQL:Query(query, function()
			self.CachedSlots.Cache.ids[self.CachedSlots.Cache.slots[tostring(slot)]] = nil
			self.CachedSlots.Cache.slots[tostring(slot)] = 0

			m_Inventory[slot] = {}

			if (m_isUsingInv() and M_INV_SLOT[slot] and M_INV_SLOT[slot].VGUI) then
				M_INV_SLOT[slot].VGUI.Item = nil
				M_INV_SLOT[slot].VGUI.WModel = nil
				M_INV_SLOT[slot].VGUI.MSkin = nil
				M_INV_SLOT[slot].VGUI.SIcon:SetVisible(false)
				M_INV_SLOT[slot].VGUI.SIcon:SetModel("")
			end

			if (fn) then
				return fn()
			end
		end)
	end)
end

function mi.UpdateSlots()
	local int, str = net.ReadShort(), 0

	net.ReadArray(function(int)
		local slot = net.ReadInt(16)
		local item = net.ReadLong()
		local lock = net.ReadBool()

		mi:SaveSlotItem(tostring(slot), item, lock and "1" or "0")
		mi.CachedSlots = nil
	end, int)
end
net.Receive("mi.UpdateSlots", mi.UpdateSlots)

function mi.CreateSlotTable()
	mi.SQL:Query([[
		CREATE TABLE IF NOT EXISTS ]] .. ck .. [[ (
			id int not null,
			locked boolean default 0,
			slotid int not null,
			steamid bigint unsigned not null,
			primary key(steamid, slotid)
		);
	]])
end
hook("InventoryPrepare", mi.CreateSlotTable)