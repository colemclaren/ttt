print("crates loaded")
MOAT_CRATES = {}
MOAT_CRATESAVE = {}
MOAT_CRATEROLLED = {}

net.Receive("MOAT_VERIFY_CRATE", function(len, ply)
	-- if (shop_net_spam(ply, "MOAT_VERIFY_CRATE")) then return end

    local item_class = net.ReadDouble()
    local fast_open = net.ReadBool()
    local crate_id = 0
    local found_item = false
    local slot_found = 0
    for i = 1, ply:GetMaxSlots() do
        if (MOAT_INVS[ply]["slot" .. i] and MOAT_INVS[ply]["slot" .. i].c) then
            if (tonumber(MOAT_INVS[ply]["slot" .. i].c) == item_class) then
                found_item = true
                slot_found = i
                crate_id = MOAT_INVS[ply]["slot" .. i].u
                break
            end
        end
    end

    if (not found_item) then return end
    local da_item = GetItemFromEnum(crate_id)

    if (fast_open and da_item and da_item.Price) then 
        m_RemoveInventoryItem(ply, slot_found, item_class, 1)

        local crate_collection = GetItemFromEnum(crate_id).Collection

        local tbl2 = m_GetRandomInventoryItem(crate_collection)
        tbl2.item = GetItemFromEnum(tbl2.u)

        if (tbl2.w) then
            ply:m_DropInventoryItem(tbl2.item.Name, tbl2.w)
        else
            ply:m_DropInventoryItem(tbl2.item.Name)
        end

        return 
    end

    if (da_item and not da_item.Price) then
        return
    end

    MOAT_CRATESAVE[ply] = {}
    MOAT_CRATES[ply] = crate_id
    net.Start("MOAT_VERIFY_CRATE")
    net.WriteDouble(item_class)
    net.WriteDouble(slot_found)
    net.Send(ply)
end)

net.Receive("MOAT_INIT_CRATE", function(len, ply)
	-- if (shop_net_spam(ply, "MOAT_INIT_CRATE")) then return end
    local crate_id = MOAT_CRATES[ply]

    if (not crate_id) then
        RunConsoleCommand("mga", "perma", ply:SteamID(), "Exploiting (EBADOMEGA63)")
        return
    end

    local crate_collection = GetItemFromEnum(crate_id).Collection

    for i = 1, 100 do
        timer.Simple(i * 0.01, function()
            local tbl2 = m_GetRandomInventoryItem(crate_collection)
            net.Start("MOAT_ITEMS_CRATE")
            net.WriteTable(tbl2)
            net.Send(ply)

            if (i == 3) then
                MOAT_CRATESAVE[ply] = tbl2
            end
        end)
    end

    if (not MOAT_CRATEROLLED[ply]) then
        MOAT_CRATEROLLED[ply] = false
    end
end)

net.Receive("MOAT_CRATE_OPEN", function(len, ply)
	-- if (shop_net_spam(ply, "MOAT_CRATE_OPEN")) then return end

    local slot = net.ReadDouble()
    local class = net.ReadDouble()
    local crate = net.ReadDouble()

    m_RemoveInventoryItem(ply, slot, class, crate)

    local item = {}

    if (MOAT_CRATESAVE[ply]) then
        item = MOAT_CRATESAVE[ply]
    end

    MOAT_CRATEROLLED[ply] = true

    if (item ~= {} and MOAT_CRATES[ply]) then
        local save_item = {}
        save_item.u = item.u

        if (item.w) then
            save_item.w = item.w
        end

        m_SaveRollItem(ply:SteamID(), save_item)
    end
end)

net.Receive("MOAT_CRATE_DONE", function(len, ply)
    local itemtbl = {}

    if (MOAT_CRATESAVE[ply]) then
        itemtbl = MOAT_CRATESAVE[ply]
    end

    if (itemtbl ~= {} and MOAT_CRATES[ply] and MOAT_CRATESAVE[ply] and MOAT_CRATEROLLED[ply]) then
		itemtbl.item = GetItemFromEnum(itemtbl.u)
	
        if (itemtbl.w) then
            m_RemoveRollSave(ply:SteamID())
            ply:m_DropInventoryItem(itemtbl.item.Name, itemtbl.w)
        else
            m_RemoveRollSave(ply:SteamID())
            ply:m_DropInventoryItem(itemtbl.item.Name)
        end

        MOAT_CRATESAVE[ply] = nil
        MOAT_CRATES[ply] = nil
        MOAT_CRATEROLLED[ply] = nil
    end
end)