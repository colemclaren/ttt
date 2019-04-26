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
	local tbl = net.ReadTable()
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

	local ITEM_NAME_FULL = m_GetFullItemName(tbl)
	if (not ITEM_NAME_FULL) then return end

	local has, grammar = islp and " have" or " has", vowels[ITEM_NAME_FULL:sub(1, 1):lower()] and " an " or " a "
	if (ITEM_NAME_FULL:sub(1, 2):lower() == "a " or ITEM_NAME_FULL:sub(1, 4):lower() == "the ") then grammar = " " end
	table.insert(tab, Color(255, 255, 255))
	table.insert(tab, has .. " obtained" .. grammar)

	local da_rarity = math.min(tbl.item.Rarity, 8)
	local item_color = tbl.item.NameColor or rarity_names[da_rarity][2] or Color(255, 255, 255)
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
	if (not GetConVar "moat_disable_rare_warnings":GetBool()) then
			
		Derma_Query("You just dropped an " .. (da_rarity == 6 and "uncommon" or "extremely rare") .. " item (" .. ITEM_NAME_FULL .. ")\n" ..
			"Before trading this item you should get it price checked on our discord. https://discord.gg/moatgaming", "Rare Item Notice",
			"OK", function() end,
			"Open Discord", function()
				gui.OpenURL "https://discord.gg/moatgaming"
			end
		)
	end

	-- net.Start("MOAT_CHAT_OBTAINED_VERIFY")
	-- net.WriteBool(v or false)
	-- net.WriteString(ply:Nick() .. " (" .. ply:SteamID() .. ") has obtained" .. grammar .. ITEM_NAME_FULL)
	-- net.WriteTable(tbl)
	-- net.WriteString(tbl.w and util.GetWeaponName(tbl.w) or "")
	-- net.SendToServer()
end)