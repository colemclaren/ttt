------------------------------------
--
-- 	Obtained Item Chat Message
--
------------------------------------

ITEM_RARITY_WARNING = false

local rarities = {
    ["Worn"] = 1,
    ["Standard"] = 2,
    ["Specialized"] = 3,
    ["Superior"] = 4,
    ["High-End"] = 5,
    ["Ascended"] = 6,
    ["Cosmic"] = 7
}

local vowels = {
	["a"] = true,
	["e"] = true,
	["i"] = true,
	["o"] = true,
	["u"] = true
}

net.Receive("MOAT_OBTAIN_ITEM", function(len)
	local v = net.ReadBool()
	local ply = Entity(net.ReadDouble())
	-- local tbl = net.ReadTable()
	local tbl = m_ReadWeaponFromNet()
	-- tbl.Talents = GetItemTalents(tbl)
	-- if (tbl.u) then
	-- 	tbl.item = GetItemFromEnum(tbl.u)
	-- end
	
	local gift = net.ReadBool()

	if (not IsValid(ply) or not IsValid(LocalPlayer())) then
		return
	end

	local islp, rar = ply == LocalPlayer(), GetConVar("moat_chat_obtain_rarity")
	if (not rar) then return end
	rar = rar:GetString()

	if (not islp and rarities[rar] and tbl and tbl.item and tbl.item.Rarity and tbl.item.Rarity < rarities[rar]) then
		return
	end

	local tab = {}
	table.insert(tab, Color(20, 255, 20))

	local nick = islp and "You" or ply:Nick()
	table.insert(tab, IsValid(ply) and nick or "PLAYER")

	local ITEM_NAME_FULL = GetItemName(tbl)
	if (not ITEM_NAME_FULL) then return end

	local has, grammar = islp and " have" or " has", vowels[ITEM_NAME_FULL:sub(1, 1):lower()] and " an " or " a "
	if (ITEM_NAME_FULL:sub(1, 2):lower() == "a " or ITEM_NAME_FULL:sub(1, 4):lower() == "the ") then grammar = " " end
	table.insert(tab, Color(255, 255, 255))
	table.insert(tab, has .. " obtained" .. grammar)

	local da_rarity = math.min(tbl.item.Rarity, 8)
	local item_color = tbl.item.NameColor or rarity_names[da_rarity][2]:Copy() or Color(255, 255, 255)
	table.insert(tab, item_color)
	table.insert(tab, {
		ItemName = ITEM_NAME_FULL,
		IsItem = true,
		item_tbl = tbl
	})

	if (gift) then
		table.insert(tab, Color(255, 255, 255))
		table.insert(tab, " as a ")

		table.insert(tab, Color(255, 255, 0))
		table.insert(tab, "gift")
	end

	chat.AddText(Material("icon16/new.png"), unpack(tab))
	if (not islp) then return end

	chat.AddText(Color(255, 255, 255), "Press ", Color(20, 255, 20), "I", Color(255, 255, 255), " to view your inventory!")
	if (da_rarity < 6) then return end

	-- TODO: add customization in menu to disable this
	if (not GetConVar "moat_disable_rare_warnings":GetBool() and not ITEM_RARITY_WARNING) then
		ITEM_RARITY_WARNING = true

		Derma_Query("You just dropped an " .. (da_rarity == 6 and "uncommon" or "extremely rare") .. " item (" .. ITEM_NAME_FULL .. ")\n" ..
			"Before trading this item you should get it price checked on our discord. https://moat.chat", "Rare Item Notice",
			"Open Discord", function() gui.OpenURL "https://moat.chat" ITEM_RARITY_WARNING = false end, "Got it")
	end

	-- net.Start("MOAT_CHAT_OBTAINED_VERIFY")
	-- net.WriteBool(v or false)
	-- net.WriteString(ply:Nick() .. " (" .. ply:SteamID() .. ") has obtained" .. grammar .. ITEM_NAME_FULL)
	-- net.WriteTable(tbl)
	-- net.WriteString(tbl.w and util.GetWeaponName(tbl.w) or "")
	-- net.SendToServer()
end)

------------------------------------
--
-- 	Item Linking Chat Message
--
------------------------------------

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

------------------------------------
--
-- 	Traded Items Chat Message
--
------------------------------------

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
            local ITEM_NAME_FULL = GetItemName(tbl)

            local da_rarity = tbl.item.Rarity

            if (da_rarity == 9) then
                da_rarity = 8
            end

            local item_color = tbl.item.NameColor or rarity_names[da_rarity][2]:Copy()

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