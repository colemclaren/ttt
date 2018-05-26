
local function needs_testing()
	return error("function needs testing")
end

local function steamid()
	return LocalPlayer():SteamID64()
end

/*
    Item Slots
*/

function MOAT_INV:GetSlotForItem(id, fn)
	needs_testing()
	local query = self.SQL:CreateQuery("SELECT slotid FROM mg_slots WHERE c = ? AND steamid = ?;", id, steamid())
	self.SQL:Query(query, function(succ)
		return fn(succ)
	end)
end

function MOAT_INV:Item(slot, fn)
	local query = self.SQL:CreateQuery("SELECT c FROM mg_slots WHERE slotid = ? AND steamid = ?;", slot, steamid())
	self.SQL:Query(query, function(succ)
		return fn(succ and tonumber(succ.c) or nil)
	end)
end

function MOAT_INV:ItemL(slot, fn)
	assert(slot < 0, "Loadout slot incorrect value")
	self:Item(slot, fn)
end

function MOAT_INV:SaveItemLSlot(id, slot, fn)
	assert(slot < 0, "Loadout slot incorrect value")
	self:SaveItemSlot(id, slot, fn)
end


function MOAT_INV:SaveItemSlot(id, slot, fn)
	local query = self.SQL:CreateQuery("REPLACE INTO mg_slots (slotid, c, steamid) values (?, ?, ?)", slot, id, steamid())
	self.SQL:Query(query, fn)
end

function MOAT_INV:SwapItemSlot(id, id2, fn)
	self:GetOurItems(function(sn, cache)
		self:SwapSlotItem(cache.c[id], cache.c[id2])
	end)
end

function MOAT_INV:ClearItemSlot(id, fn)
	needs_testing()
	local query = self.SQL:CreateQuery("DELETE FROM mg_slots WHERE c = ? AND steamid = ?;", id, steamid())
	self.SQL:Query(query, fn)
end

function MOAT_INV:GetItemForSlot(slot, fn)
	local query = self.SQL:CreateQuery("SELECT c FROM mg_slots WHERE slotid = ? AND steamid = ?;", slot, steamid())
	self.SQL:Query(query, function(d)
		return fn(d and tonumber(d.c) or 0)
	end)
end

function MOAT_INV:SlotExists(slot, fn)
	local query = self.SQL:CreateQuery("SELECT c FROM mg_slots WHERE slotid = ? AND steamid = ?;", slot, steamid())
	self.SQL:Query(query, function(d)
		return fn(d and not not d[1] or false)
	end)
end

function MOAT_INV:SaveSlotItem(slot, id, fn)
	self:SlotExists(slot, function(exists)
		assert(not exists, "slot already exists!")
		local query = self.SQL:CreateQuery([[
			INSERT INTO mg_slots (c, slotid, steamid) VALUES (?, ?, ?);
		]], id, slot, steamid())
		self.SQL:Query(query, fn)
	end)
end

function MOAT_INV:SwapSlotItem(slot, slot2, fn)
	self:GetOurSlots(function(max, cache)
		local item1, item2 = cache.s[slot], cache.s[slot2]
		local query = self.SQL:CreateQuery([[
			UPDATE mg_slots SET c = ?item2 WHERE slotid = ?slot1 AND steamid = ?steamid;
			UPDATE mg_slots SET c = ?item1 WHERE slotid = ?slot2 AND steamid = ?steamid;
		]], {
			slot1 = slot,
			slot2 = slot2,
			item1 = item1,
			item2 = item2,
			steamid = steamid()
		})

		cache.s[slot], cache.s[slot2] = item2, item1
		cache.c[item1], cache.c[item2] = slot2, slot

		self.SQL:Query(query, fn)
	end)
end

function MOAT_INV:ClearSlotItem(slot, fn)
	needs_testing()
	local query = self.SQL:CreateQuery("DELETE FROM mg_slots WHERE slotid = ? AND steamid = ?;", slot, steamid())
	self.SQL:Query(query, fn)
end

function MOAT_INV:AddSlotItem(slot, id, fn)
	self:SaveSlotItem(slot, id, fn)
end

function MOAT_INV:SaveSlotItemL(slot, id, fn)
	assert(slot < 0)
	self:SaveSlotItem(slot, id, fn)
end


function MOAT_INV:AddLocked(id, fn)
	local query = self.SQL:CreateQuery("UPDATE mg_slots SET locked = 1 WHERE c = ? AND steamid = ?;", id, steamid())
	self.SQL:Query(query, fn)
end

function MOAT_INV:RemoveLocked(id, fn)
	local query = self.SQL:CreateQuery("UPDATE mg_slots SET locked = 0 WHERE c = ? AND steamid = ?;", id, steamid())
	self.SQL:Query(query, fn)
end

function MOAT_INV:IsLocked(id, fn)
	local query = self.SQL:CreateQuery("SELECT locked FROM mg_slots WHERE c = ? AND steamid = ?;", id, steamid())
	self.SQL:Query(query, function(d)
		fn(d and d[1] and d[1].locked == "1" or false)
	end)
end

MOAT_INV.SlotCache = {}

function MOAT_INV:GetOurSlots(fn)
	if (self.CachedSlots and self.CachedSlots[1] and self.CachedSlots[2]) then
		return fn(self.CachedSlots[1], self.CachedSlots[2])
	end

	if (next(self.SlotCache) ~= nil) then
		table.insert(self.SlotCache, fn)
		return
	end

	self.SlotCache = {fn}

	local query = self.SQL:CreateQuery("SELECT slotid, c FROM mg_slots WHERE steamid = ?;", steamid())

	self.SQL:Query(query, function(data)
		if (not data) then
			data = {}
		end
		local cache = {
			c = {}, -- id -> slot
			s = {}, -- slot -> id
		}
		local max = self.Config.MinSlots
		for _, dat in pairs(data) do
			local slotid = tonumber(dat.slotid)
			max = math.max(slotid, max)
			cache.c[tonumber(dat.c)] = slotid
			cache.s[slotid] = tonumber(dat.c)
		end

		for i = -10, max do
			if (not cache.s[i]) then
				cache.s[i] = 0
			end
		end
		self.CachedSlots = {
			max,
			cache
		}

		for i = 1, #self.SlotCache do
			self:GetOurSlots(self.SlotCache[i])
		end
	end)
end

-- c = id -> slot
-- s = slot -> id

function MOAT_INV:CreateNewSlot(num)
	if (not self.CachedSlots) then
		self:GetOurSlots(function(max, cache)
			local new = num or max + 1
			self:ClearSlotItem(num)
			self.CachedSlots = math.max(max, new)
			cache[2].s[num] = 0

			m_Inventory[num] = {}
			if (IsValid(MOAT_INV_BG)) then
				m_CreateNewInvSlot(num)
			end
		end)
	end
end

function MOAT_INV:RemoveEmptySlot()
assert(false)
	local num = self:GetEmptySlot(nil, nil, true)
	if (num == 0 or self.CachedSlots[2].s[num] ~= 0) then return end

	self.CachedSlots[1] = self.CachedSlots[1] - 1
	self.CachedSlots[2].s[num] = nil

	m_Inventory[num] = nil
	if (IsValid(MOAT_INV_BG)) then
		m_RemoveInvSlot(num)
	end
end

function MOAT_INV:GetEmptySlot(sn, st, r, fn)
	local function Internal(sn, st)
		local starts, ends, step = 1, sn, 1
		if (r) then
			starts, ends, step = sn, 1, -1
		end

		for i = starts, ends, step do
			if (st.s[i] == 0) then
				return fn(i)
			end
		end

		local new_max = sn + 1
		self.CachedSlots[1] = new_max
		st.s[new_max] = 0
		return fn(new_max)
	end
	if (not sn or not st) then
		return self:GetOurSlots(Internal)
	else
		return Internal(sn, st)
	end
end

function MOAT_INV:GetSlotForID(id, fn)
	assert(id ~= 0, "id is 0")
	self:GetOurSlots(function(sn, st)
		if (st.c[id]) then return fn(st.c[id]) end

		self:GetEmptySlot(sn, st, false, function(ns)
			st.c[id] = ns
			st.s[ns] = id

			self:AddSlotItem(ns, id, function()
				return fn(ns)
			end)
		end)
	end)
end