util.AddNetworkString "mi.Swap"
local m_SlotToLoadout = {}
hook.Add("Initialize", "mi.Swap", function()
    m_SlotToLoadout[WEAPON_MELEE] = 3
    m_SlotToLoadout[WEAPON_PISTOL] = 2
    m_SlotToLoadout[WEAPON_HEAVY] = 1
end)
if (WEAPON_MELEE) then
    m_SlotToLoadout[WEAPON_MELEE] = 3
    m_SlotToLoadout[WEAPON_PISTOL] = 2
    m_SlotToLoadout[WEAPON_HEAVY] = 1
end

local function m_GetLoadoutSlot(ITEM_TBL)
    local item = m_GetItemFromEnumWithFunctions(ITEM_TBL.u)
    if (ITEM_TBL.c == nil) then return end
    if (item.Kind == "Power-Up") then return 4 end
    if (item.Kind == "Other") then return 5 end
    if (item.Kind == "Hat") then return 6 end
    if (item.Kind == "Mask") then return 7 end
    if (item.Kind == "Body") then return 8 end
    if (item.Kind == "Effect") then return 9 end
    if (item.Kind == "Model") then return 10 end
    if (not ITEM_TBL.w) then return end

    return m_SlotToLoadout[weapons.Get(ITEM_TBL.w).Kind]
end

net.Receive("mi.Swap", function(len, pl)
    local new_wep = net.ReadUInt(32)
    local inv = MOAT_INVS[pl]
    local index, w

    local slotid
    if (new_wep == 0) then
        slotid = net.ReadByte()
    else
        for i = 1, pl:GetMaxSlots() do
            local id = "slot"..i
            local wep = inv[id]
            if (istable(wep) and id ~= "credits" and wep.c == new_wep) then
                index = id
                w = wep
                break
            end
        end
        if (not w) then
            return
        end
        slotid = m_GetLoadoutSlot(w)
        if (not slotid) then
            return
        end
    end

    slotid = -slotid

    local query = mi:CreateQuery("UPDATE mg_items SET slotid = NULL WHERE slotid = ? AND ownerid = ?;", slotid, pl)
    if (new_wep ~= 0) then
        query = query .. mi:CreateQuery("UPDATE mg_items SET slotid = ? WHERE ownerid = ? AND id = ?;", slotid, pl, new_wep)
    end

    mi:SQLQuery(query, function(data)
        -- empty the loadout slot
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

            inv["l_slot"..-slotid] = mi:Blank()
            inv["slot"..slot_found] = w
            return
        end
        inv["l_slot"..-slotid], inv[index] = w, inv["l_slot"..-slotid]
    end)
end)