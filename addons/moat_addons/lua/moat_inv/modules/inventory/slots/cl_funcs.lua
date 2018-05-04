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
    return file.Read(self:Item(slot)) or 0
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

function MOAT_INV:GetSlots()
	return file.Find(self.Dir2 .. "/*.jpg", "DATA")
end