MOAT_INV.Dir = "moat_inv/i"
MOAT_INV.Dir2 = "moat_inv/s"

file.CreateDir(MOAT_INV.Dir)

function MOAT_INV:RequestInventory()

end

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
    return MOAT_INV.Dir .. "/" .. id .. ".txt"
end

function MOAT_INV:Item(slot)
    return MOAT_INV.Dir2 .. "/" .. slot .. ".txt"
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
    return file.Delete(self:Slot(id))
end



function MOAT_INV:GetItemForSlot(slot)
    return file.Read(self:Item(slot)) or 0
end

function MOAT_INV:SaveSlotItem(id, slot)
    return file.Write(self:Item(slot), id)
end

function MOAT_INV:SwapSlotItem(slot, slot2)
    local id, id2 = self:GetItemForSlot(slot), self:GetItemForSlot(slot2)
    return file.Write(self:Item(slot2), id), file.Write(self:Item(slot), id2)
end

function MOAT_INV:ClearSlotItem(slot)
    return file.Delete(self:Item(slot))
end