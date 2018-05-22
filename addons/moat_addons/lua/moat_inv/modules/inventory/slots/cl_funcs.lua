MOAT_INV.Dir = "moat_inv/i"
MOAT_INV.Dir2 = "moat_inv/s"
MOAT_INV.Dir3 = "moat_inv/l"

file.CreateDir(MOAT_INV.Dir)
file.CreateDir(MOAT_INV.Dir2)
file.CreateDir(MOAT_INV.Dir3)

/*
    Item Slots
*/

function MOAT_INV:GetSlotForItem(id, fn)
	local query = self.SQL:CreateQuery("SELECT slotid FROM mg_slots WHERE c = ?;", id)
	self.SQL:Query(query, function(succ)
		return fn(succ)
	end)
end

function MOAT_INV:Item(slot, fn)
	local query = self.SQL:CreateQuery("SELECT c FROM mg_slots WHERE slotid = ?;", slot)
	self.SQL:Query(query, function(succ)
		return fn(succ and succ.c or nil)
	end)
end

function MOAT_INV:ItemL(slot, fn)
	self:Item(slot, fn)
end

function MOAT_INV:Locked(id, fn)
	local query = self.SQL:CreateQuery("SELECT locked FROM mg_slots WHERE c = ?;", id)
	self.SQL:Query(query, function(succ)
		return fn(succ and succ.c or nil)
	end)
end

function MOAT_INV:SaveItemLSlot(id, slot, fn)
	self:SaveItemSlot(id, slot, fn)
end


function MOAT_INV:SaveItemSlot(id, slot, fn)
	local query = self.SQL:CreateQuery("REPLACE INTO mg_slots (slotid, c) values (?, ?)", slot, id)
	self.SQL:Query(query, fn)
end

function MOAT_INV:SwapItemSlot(id, id2, fn)
	local query = self.SQL:CreateQuery([[
		DROP TABLE IF EXISTS lookup;
		CREATE TEMP TABLE lookup (k int unsigned not null, val tinyint unsigned not null, primary key(k));
		INSERT INTO lookup (k, val) values (
			SELECT slotid, 1 from mg_slots where c = ?slot1,
			SELECT slotid, 2 from mg_slots where c = ?slot2
		);
		UPDATE mg_slots SET c = ?slot2 WHERE slotid = (SELECT k FROM lookup WHERE val = 1);
		UPDATE mg_slots SET c = ?slot1 WHERE slotid = (SELECT k FROM lookup WHERE val = 2);
	]], {
		slot1 = id,
		slot2 = id2
	})

	self.SQL:Query(query, fn)
end

function MOAT_INV:ClearItemSlot(id, fn)
	local query = self.SQL:CreateQuery("DELETE FROM mg_slots WHERE c = ?;", id)
	self.SQL:Query(query, fn)
end

function MOAT_INV:GetItemForSlot(slot, fn)
	local query = self.SQL:CreateQuery("SELECT c FROM mg_slots WHERE slotid = ?;", slot)
	self.SQL:Query(query, function(d)
		return fn(d and d.c or 0)
	end)
end

function MOAT_INV:SlotExists(slot, fn)
	local query = self.SQL:CreateQuery("SELECT 1 FROM mg_slots WHERE slotid = ?;", slot)
	self.SQL:Query(query, function(d)
		return fn(not not d)
	end)
end

function MOAT_INV:SaveSlotItem(slot, id, fn)
	local query = self.SQL:CreateQuery("REPLACE mg_slots SET c = ? where slotid = ?;", id, slot)
	self.SQL:Query(query, fn)
end

function MOAT_INV:SwapSlotItem(slot, slot2, fn)
	local query = self.SQL:CreateQuery([[
		DROP TABLE IF EXISTS lookup;
		CREATE TEMP TABLE lookup (k int unsigned not null, val tinyint unsigned not null, primary key(k));
		INSERT INTO lookup (k, val) values (
			SELECT c, 1 from mg_slots where slotid = ?slot1,
			SELECT c, 2 from mg_slots where slotid = ?slot2
		);
		UPDATE mg_slots SET c = (SELECT k FROM lookup WHERE val = 2) WHERE slotid = ?slot1;
		UPDATE mg_slots SET c = (SELECT k FROM lookup WHERE val = 1) WHERE slotid = ?slot2;
	]], {
		slot1 = slot,
		slot2 = slot2
	})

	self.SQL:Query(query, fn)
end

function MOAT_INV:ClearSlotItem(slot, fn)
	local query = self.SQL:CreateQuery("DELETE FROM mg_slots WHERE slotid = ?;", slot)
	self.SQL:Query(query, fn)
end

function MOAT_INV:AddSlotItem(slot, id, fn)
	self:SaveSlotItem(slot, id, fn)
end

function MOAT_INV:SaveSlotItemL(slot, id, fn)
	self:SaveSlotItem(slot, id, fn)
end


function MOAT_INV:AddLocked(id, fn)
	local query = self.SQL:CreateQuery("UPDATE mg_items SET locked = true WHERE c = ?;", id)
	self.SQL:Query(query, fn)
end

function MOAT_INV:RemoveLocked(id, fn)
	local query = self.SQL:CreateQuery("UPDATE mg_items SET locked = false WHERE c = ?;", id)
	self.SQL:Query(query, fn)
end

function MOAT_INV:IsLocked(id, fn)
	local query = self.SQL:CreateQuery("SELECT locked FROM mg_items WHERE c = ?;", id)
	self.SQL:Query(query, function(d)
		fn(d and d.locked or false)
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

	local query = self.SQL:CreateQuery("SELECT slotid, c FROM mg_items WHERE steamid = ?;", LocalPlayer():SteamID64())

	self.SQL:Query(query, function(data)
		local cache = {
			c = {}, -- id -> slot
			s = {}, -- slot -> id
		}
		local max = self.Config.MinSlots
		for _, dat in pairs(data) do
			max = math.max(dat.slotid, dat)
			cache.c[dat.c] = dat.slotid
			cache.s[dat.slotid] = dat.c
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
	if (not sn or not st) then 
		self:GetOurSlots(function(sn, st)
			local starts, ends, step = 1, sn, 1
			if (r) then
				starts, ends, step = sn, 1, -1
			end

			for i = starts, ends, step do
				if (st.s[i] == 0) then
					return i
				end
			end

			return ns
		end) 
	end

end

function MOAT_INV:GetSlotForID(id)
	local sn, st = self:GetOurSlots()
	if (st.c[id]) then return st.c[id] end

	local ns = self:GetEmptySlot(sn, st)
	if (ns == 0) then
		ns = sn + 1
		self:CreateNewSlot(ns)
	end

	self.CachedSlots[1] = ns
	self.CachedSlots[2].c[id] = ns
	self.CachedSlots[2].s[ns] = id

	self:AddSlotItem(ns, id)
	return ns
end



function MOAT_INV:ConvertFilesToSQL()

end

concommand.Add("moat_files_sql", function() MOAT_INV:ConvertFilesToSQL() end)