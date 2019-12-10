net.Receive("MOAT_LINK_ITEM", function(len)
    local ply = Entity(net.ReadDouble())
    local tbl = net.ReadTable()
	
	if (not IsValid(ply) or not IsValid(LocalPlayer())) then
		return
	end

	if (ply:Team() == TEAM_SPEC and LocalPlayer():Team() ~= TEAM_SPEC) then
		return
	end

    local tab = {}

    if (IsValid(ply) and ply:Team() == TEAM_SPEC) then
        table.insert(tab, Color(255, 30, 40))
        table.insert(tab, "*DEAD* ")
    end

	table.insert(tab, IsValid(ply) and ply or "Console")
    table.insert(tab, Color(255, 255, 255))
    table.insert(tab, ": ")

	local ITEM_NAME_FULL = GetItemName(tbl)
    table.insert(tab, {
        ItemName = ITEM_NAME_FULL,
        IsItem = true,
        item_tbl = tbl
    })

    chat.AddText(unpack(tab))
end)

net.Receive("MOAT_CHAT_LINK_ITEM", function(len)
    local ply = net.ReadEntity()
    local str = net.ReadTable()
    local amt = net.ReadUInt(4)

    local itemtbl = {}

    for i = 1, amt do
        local tbl = net.ReadTable()
        itemtbl[tbl.id] = tbl
    end

	if (not IsValid(ply) or not IsValid(LocalPlayer())) then
		return
	end

	if (ply:Team() == TEAM_SPEC and LocalPlayer():Team() ~= TEAM_SPEC) then
		return
	end

	local tab = {}

	if (IsValid(ply) and ply:Team() == TEAM_SPEC) then
        table.insert(tab, Color(255, 30, 40))
        table.insert(tab, "*DEAD* ")
    end

	table.insert(tab, IsValid(ply) and ply or "Console")
    table.insert(tab, Color(255, 255, 255))
    table.insert(tab, ": ")

    for k, v in pairs(str) do
        if (itemtbl[v]) then
        	str[k] = itemtbl[v]
        end
    end

    for i = 1, #str do
        table.insert(tab, Color(255, 255, 255))
        if (isstring(str[i])) then
            table.insert(tab, str[i])
        else
            local ITEM_NAME_FULL = GetItemName(str[i])
            table.insert(tab, {
                ItemName = ITEM_NAME_FULL,
                IsItem = true,
                item_tbl = str[i]
            })
        end
    end

    chat.AddText(unpack(tab))
end)