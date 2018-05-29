--init
util.AddNetworkString "MOAT_INV.Swap"

local m_SlotToLoadout = {}
m_SlotToLoadout[WEAPON_MELEE] = 3
m_SlotToLoadout[WEAPON_PISTOL] = 2
m_SlotToLoadout[WEAPON_HEAVY] = 1

local function m_GetLoadoutSlot(ITEM_TBL)
    local item = m_GetItemFromEnumWithFunctions(ITEM_TBL.u)
    if (ITEM_TBL.c == nil) then return true end
    if (item.Kind == "Power-Up") then return 4 end
    if (item.Kind == "Other") then return 5 end
    if (item.Kind == "Hat") then return 6 end
    if (item.Kind == "Mask") then return 7 end
    if (item.Kind == "Body") then return 8 end
    if (item.Kind == "Effect") then return 9 end
    if (item.Kind == "Model") then return 10 end

    return m_SlotToLoadout[weapons.Get(ITEM_TBL.w).Kind]
end

net.Receive("MOAT_INV.Swap", function(len, pl)
    local new_wep = net.ReadUInt(32)
    local inv = MOAT_INVS[pl]
    local index, w
    for id, wep in pairs(inv) do
        if (istable(wep) and id ~= "credits" and wep.c == new_wep) then
            index = id
            w = wep
            break
        end
    end

    local slotid
    if (new_wep == 0) then
        slotid = net.ReadByte()
    elseif (w) then
        slotid = m_GetLoadoutSlot(w)
    else
        return
    end
    slotid = -slotid

    local query = MOAT_INV:CreateQuery("UPDATE mg_items SET slotid = NULL WHERE slotid = ? AND ownerid = ?;", slotid, pl)
    if (new_wep ~= 0 and w) then
        query = query .. MOAT_INV:CreateQuery("UPDATE mg_items SET slotid = ? WHERE ownerid = ? AND id = ?;", slotid, pl, new_wep)
    end print"a"

    MOAT_INV:SQLQuery(query, function(data)
        -- empty the loadout slot
        print(w)
        if (not w) then
            local slot_found
            for i = 1, self:GetMaxSlots() do
                if (not inv["slot"..i].c) then
                    slot_found = i
                    break
                end
            end
            if (not slot_found) then
                slot_found = self:GetNWInt("MOAT_MAX_INVENTORY_SLOTS") + 1
                self:SetNWInt("MOAT_MAX_INVENTORY_SLOTS", slot_found)
            end

            inv["l_slot"..-slotid] = MOAT_INV:Blank()
            inv["slot"..slot_found] = w
            print(inv["l_slot"..-slotid].c)
            return
        end
        inv["l_slot"..-slotid], inv[index] = w, inv["l_slot"..-slotid]
            print(inv["l_slot"..-slotid].c)
    end)
end)