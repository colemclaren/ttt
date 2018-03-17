print("shop loaded")

local active_crates = {}

function m_GetActiveCrates()
    if (active_crates[1]) then
        return active_crates
    end

    active_crates = {}

    for k, v in pairs(MOAT_DROPTABLE) do
        if (v.Kind ~= "Crate" and v.Kind ~= "Usable") then continue end

        if (v.Active and v.Name ~= "Pumpkin Crate" and v.Name ~= "Santa's Present" and v.Name ~= "Holiday Crate" and v.Name ~= "Empty Gift Package") then
            table.insert(active_crates, v)
        end
    end

    return active_crates
end

local active_crates2 = {}

function m_GetActiveCratesShop()
    if (active_crates2[1]) then
        return active_crates2
    end

    active_crates2 = {}

    for k, v in pairs(MOAT_DROPTABLE) do
        if (v.Kind ~= "Crate" and v.Kind ~= "Usable") then continue end

        if (v.Active) then
            table.insert(active_crates2, v)
        end
    end

    return active_crates2
end

local crate_by_id = {}

function m_GetCrateByID(crate_id)
    local crate = {}

    if (crate_by_id[crate_id]) then return crate_by_id[crate_id] end

    for k, v in pairs(MOAT_DROPTABLE) do
        if (v.Kind ~= "Crate" and v.Kind ~= "Usable") then continue end

        if (v.Active and v.ID == crate_id) then
            crate = table.Copy(v)
            break
        end
    end

    crate_by_id[crate_id] = crate

    return crate
end

function m_SendShop(ply)
    local active_crate = m_GetActiveCratesShop()
    if (active_crate == {}) then return end

    for k, v in pairs(table.Copy(active_crate)) do
        v.ItemUsed = nil
        timer.Simple(0.01, function()
            if (ply:IsValid()) then
                net.Start("MOAT_GET_SHOP")
                net.WriteTable(v)
                net.Send(ply)
            end
        end)
    end
end

net.Receive("MOAT_GET_SHOP", function(len, ply)
    m_SendShop(ply)
end)

net.Receive("MOAT_BUY_ITEM", function(len, ply)
    local crate_id = net.ReadDouble()
    local crate_amt = math.Clamp(net.ReadUInt(8), 1, 50)
    local crate_tbl = m_GetCrateByID(crate_id)

    if (crate_tbl == {}) then
        ply:SendLua([[chat.AddText( Color( 255, 0, 0 ), "Error verifying item in shop." )]])

        return
    end

    if (not crate_tbl.Price or not crate_amt) then return end

    if (not ply:m_HasIC(crate_tbl.Price * crate_amt)) then
        ply:SendLua([[chat.AddText( Material( "icon16/exclamation.png" ), Color( 255, 0, 0 ), "You don't have enough inventory credits to purchase this item!" )]])

        return
    end

    ply:m_TakeIC(crate_tbl.Price * crate_amt)
    for i = 1, crate_amt do
        if (not ply:IsValid()) then return end
        ply:m_DropInventoryItem(crate_tbl.Name, "hide_chat_obtained", false, crate_amt > 1)
        if (i == crate_amt and crate_amt > 1) then 
            ply:SendLua([[chat.AddText( Material( "icon16/exclamation.png" ), Color( 0, 255, 0 ), "Successfully purchased ]] .. crate_amt .. [[ ]] .. crate_tbl.Name .. [['s from the shop!")]])
            m_SaveInventory(ply)
        end
    end
end)

hook.Add("PlayerInitialSpawn", "moat_sendshop", function(ply)
    m_SendShop(ply)
end)

local PLAYR = FindMetaTable("Player")

function PLAYR:DropXmas(num)
    for i = 1, num do
        self:m_DropInventoryItem("Holiday Crate", "hide_chat_obtained")
    end
end