MOAT_INV.Dir = "moat_inv/i"
MOAT_INV.Dir2 = "moat_inv/s"
MOAT_INV.Dir3 = "moat_inv/l"

file.CreateDir(MOAT_INV.Dir)
file.CreateDir(MOAT_INV.Dir2)
file.CreateDir(MOAT_INV.Dir3)


/*
    Item Stats
*/

function MOAT_INV:GetStats(id)
    local s = cookie.GetString("moat_inv" .. id, "")
    return util.JSONToTable(s)
end

function MOAT_INV:SaveStats(id, tbl)
    local s = util.TableToJSON(tbl)
    return cookie.Set("moat_inv" .. id, s)
end

/*
    Item Slots
*/

function MOAT_INV:Slot(id)
    return self.Dir .. "/" .. id .. ".txt"
end

function MOAT_INV:Item(slot)
    return self.Dir2 .. "/" .. slot .. ".jpg"
end

function MOAT_INV:ItemL(slot)
    return self.Dir2 .. "/" .. slot .. ".png"
end

function MOAT_INV:Locked(id)
    return self.Dir3 .. "/" .. id .. ".png"
end


function MOAT_INV:GetSlotForItem(id)
    return file.Read(self:Slot(id)) or 0
end

function MOAT_INV:SaveItemSlot(id, slot)
    return file.Write(self:Slot(id), slot)
end

function MOAT_INV:SwapItemSlot(id, id2)
    local slot1, slot2 = self:GetSlotForItem(id), self:GetSlotForItem(id2)
    return file.Write(self:Slot(id), slot2), file.Write(self:Slot(id2), slot1)
end

function MOAT_INV:ClearItemSlot(id)
    return file.Write(self:Slot(id), "")
end



function MOAT_INV:GetItemForSlot(slot)
	local id = file.Read(self:Item(slot))
    return id == "" and 0 or id
end

function MOAT_INV:SlotExists(slot)
    return file.Exists(self:Item(slot), "DATA")
end

function MOAT_INV:SaveSlotItem(slot, id)
    return file.Write(self:Item(slot), id)
end

function MOAT_INV:SwapSlotItem(slot, slot2)
    local id, id2 = self:GetItemForSlot(slot), self:GetItemForSlot(slot2)
    return file.Write(self:Item(slot2), id), file.Write(self:Item(slot), id2)
end

function MOAT_INV:ClearSlotItem(slot)
    return file.Write(self:Item(slot), "")
end

function MOAT_INV:AddSlotItem(slot, id)
    return file.Write(self:Item(slot), id)
end

function MOAT_INV:SaveSlotItemL(slot, id)
    return file.Write(self:ItemL(slot), id)
end


function MOAT_INV:AddLocked(id)
	return file.Write(self:Locked(id), "")
end

function MOAT_INV:RemoveLocked(id)
	return file.Delete(self:Locked(id))
end

function MOAT_INV:IsLocked(id)
	return file.Exists(self:Locked(id), "DATA")
end

function MOAT_INV:HandleSlotLocks()
	local dir = self.Dir2 .. "/"

	for _, s in pairs(file.Find(dir .. "*.png", "DATA")) do
		local id = file.Read(dir .. s:sub(1, -5) .. ".jpg")
		if (not id) then continue end
		file.Delete(dir .. s)
		self:AddLocked(id)
	end
end

function MOAT_INV:GetOurSlots()
	if (self.CachedSlots and self.CachedSlots[1] and self.CachedSlots[2]) then
		return self.CachedSlots[1], self.CachedSlots[2]
	end

	local num, tbl = 0, {s = {}, c = {}}
	for k, s in pairs(file.Find(self.Dir2 .. "/*.jpg", "DATA")) do
		local id = tonumber(s:sub(1, -5))
		if (not id) then continue end
		num = id > num and id or num
	end

	if (num < self.Config.MinSlots) then num = self.Config.MinSlots end

	for i = -10, num do
		if (i == 0) then continue end
		if (not self:SlotExists(i)) then self:ClearSlotItem(i) end
		local id = tonumber(self:GetItemForSlot(i))
		if (tbl.c[id]) then id = 0 end

		tbl.s[i] = id
		if (id == 0) then continue end

		tbl.c[id] = i
	end

	self.CachedSlots = {num, tbl}
	return num, tbl
end

function MOAT_INV:CreateNewSlot(num)
	if (not self.CachedSlots) then self:GetOurSlots() end
	num = num or (self.CachedSlots[1] + 1)

	self:ClearSlotItem(num)
	self.CachedSlots[1] = num
	self.CachedSlots[2].s[num] = 0

	m_Inventory[num] = {}
	if (IsValid(MOAT_INV_BG)) then
        m_CreateNewInvSlot(num)
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

function MOAT_INV:GetEmptySlot(sn, st, r)
	if (not sn or not st) then sn, st = self:GetOurSlots() end

	local ns, i1, i2, i3 = 0, 1, sn, 1
	if (r) then i1, i2, i3 = sn, 1, -1 end

	for i = i1, i2, i3 do
		if (st.s[i] == 0) then
			ns = i
			break
		end
	end

	return ns
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