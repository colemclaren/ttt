net.Receive("MOAT_TRADED_ITEMS", function(len)
    local ply = net.ReadEntity()
    local ic = net.ReadInt(32)
    local t = net.ReadTable()

	if (not IsValid(ply) or not IsValid(LocalPlayer())) then
	    return
    end

    local items = {}
    for k,v in pairs(t) do
        if v.c then
            items[#items+1] = v
        end
    end
    if (#items < 1) and (ic == 0) then return end
    if not GetConVar("moat_showtrades"):GetBool() then return end

    local tab = {}
    table.insert(tab, Color(20, 255, 20))
    local has = " traded for "
    local nick = ply:Nick()

    if (IsValid(ply)) then
        table.insert(tab, nick)
    else
        table.insert(tab, "PLAYER")
    end

    table.insert(tab, Color(255, 255, 255))
    table.insert(tab, has)

    if ic ~= 0 then table.insert(items,{_ic = true}) end

    for k,tbl in pairs(items) do
        if (not tbl.c) and (not tbl._ic) then continue end
        if tbl._ic then
            table.insert(tab,Color(255,255,0))
            table.insert(tab,string.Comma(ic) .. " IC")
        else
            local ITEM_NAME_FULL = m_GetFullItemName(tbl)

            local da_rarity = tbl.item.Rarity

            if (da_rarity == 9) then
                da_rarity = 8
            end

            local item_color = tbl.item.NameColor or rarity_names[da_rarity][2]

            table.insert(tab, item_color)
            table.insert(tab, {
                ItemName = ITEM_NAME_FULL,
                IsItem = true,
                item_tbl = tbl
            })
        end

        if k == #items - 1 then
            table.insert(tab, Color(255, 255, 255))
            table.insert(tab, ", and ")
        elseif k ~= #items then
            table.insert(tab, Color(255, 255, 255))
            table.insert(tab, ", ")
        end
    end

    chat.AddText(Material("icon16/new.png"), unpack(tab))
end)