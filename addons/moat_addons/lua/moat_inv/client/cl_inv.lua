MOAT_INV.Dir = "moat_inv"
file.CreateDir(MOAT_INV.Dir)

function MOAT_INV:RequestInventory()

end


/*
    Item Slots
*/

function MOAT_INV:Slot(id)
    return MOAT_INV.Dir .. "/" .. id .. ".txt"
end

function MOAT_INV:GetSlotForItem(id)
    local num = file.Read "moat_inv/" .. id .. ".txt"
    return num or 0
end


function MOAT_INV:SaveItemSlot(id, slot)
    return file.Write("moat_inv/" .. id .. ".txt", id)
end


function MOAT_INV:SwapItemSlot(id, id)
    file.Write("moat_inv/" .. id .. ".txt", id)
    file.Write("moat_inv/" .. id .. ".txt", id)
end


function MOAT_INV:ClearItemSlot()

end