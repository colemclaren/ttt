
local insurance = {}
function insurance:__newindex(k, v)
	assert(type(v) ~= "nil", "value is nil")

	if (isnumber(k)) then
		for i = 1, k - 1 do
			if (not self[i]) then
				rawset(self, i, {})
			end
		end

		self.len = math.max(k, self.len)
	end

	rawset(self, k, v)
end

function CreateSlots(num)
	local tbl = {len = num}

	for i = 1, num do
		tbl[i] = {}
	end

	setmetatable(tbl, insurance)

	return tbl
end

m_Inventory = CreateSlots(40)
m_Loadout = CreateSlots(10)
m_Trade = {}

function m_ClearInventory()
	m_Inventory = CreateSlots(LocalPlayer():GetNW2Int("MOAT_MAX_INVENTORY_SLOTS", 40))
	m_Loadout = CreateSlots(10)
	m_Trade = {}
end

m_ItemCache = m_ItemCache or {}
m_TalentData = m_TalentData or {}
m_ItemData = m_ItemData or {}
m_ItemsLoaded = m_ItemsLoaded or false

function m_ReadWeaponFromNet(self)
	self = self or {}
	if (not net.ReadBool()) then
		return self
	end

	self.c = net.ReadLong(32)
	self.u = net.ReadLong(32)

	if (net.ReadBool()) then
		self.w = net.ReadString()
	end

	while (true) do
		local statid = net.ReadByte()
		if (statid == 0) then
			break
		end

		self.s = self.s or {}
		self.s[statid] = net.ReadFloat()
		if (mi.Stat.OldChars and mi.Stat.OldChars[statid] and self.w) then
			self.s[mi.Stat.OldChars[statid]] = self.s[statid]
			self.s[statid] = nil
		end
	end

	while (true) do
		local tier = net.ReadByte()
		if (tier == 0) then
			break
		end

		self.t = self.t or {}
		local tierdata = {}
		self.t[tier] = tierdata
		tierdata.e = net.ReadShort()
		tierdata.l = net.ReadShort()

		for i = 1, 255 do
			if (not net.ReadBool()) then
				break
			end

			tierdata.m = tierdata.m or {}
			tierdata.m[i] = net.ReadFloat()
		end
	end

	if (net.ReadBool()) then
		self.p1 = net.ReadShort()
	end
	if (net.ReadBool()) then
		self.p2 = net.ReadShort()
	end
	if (net.ReadBool()) then
		self.p3 = net.ReadShort()
	end

	if (net.ReadBool()) then
		self.n = net.ReadString()
	end

	self.item = m_ItemData[self.u]
	if (self.item.Kind == "Other" and self.item.WeaponClass) then
		self.w = self.item.WeaponClass
	end

	if (self.t) then
		self.Talents = {}
		for k, v in ipairs(self.t) do
			self.Talents[k] = m_TalentData[v.e]
		end
	end

	m_ItemCache[self.c] = self

	return self
end

function m_ReadWeaponFromNetCache()
	return m_ItemCache[net.ReadUInt(32)]
end

net.Receive("MOAT_SEND_INV_ITEM", function(len)
	local max = IsValid(LocalPlayer()) and LocalPlayer():GetNW2Int("MOAT_MAX_INVENTORY_SLOTS", 40) or NUMBER_OF_SLOTS
    local key = net.ReadString()

	if (key == "0") then
		for i = 1, max do
			if (not m_Inventory[i] or not m_Inventory[i].c) then
				m_Inventory[i] = {decon = false}
			end
		end

		for i = 1, 10 do
			if (not m_Loadout[i] or not m_Loadout[i].c) then
				m_Loadout[i] = {}
			end
		end

		if (m_CreateInventorySlots) then
			m_HandleLayoutSpacing(true)
			m_CreateInventorySlots()
		end

		net.Start "bounty.refresh"
		net.SendToServer()

		return
	end

    local tbl = net.ReadTable()
    local slot = 0

	if (tbl.u) then
		tbl.item = GetItemFromEnum(tbl.u, tbl)
	end

	tbl.Talents = GetItemTalents(tbl)

    if (tbl and tbl.item and tbl.item.Kind == "Special" and tbl.item.WeaponClass) then
        tbl.w = tbl.item.WeaponClass
    end

    if (string.StartWith(key, "l")) then
        slot = tonumber(string.sub(key, 2, #key))
        m_Loadout[slot] = {}
        m_Loadout[slot] = tbl

        if (slot >= 6 and slot <= 8 and m_Loadout[slot] and m_Loadout[slot].u) then
            m_SendCosmeticPositions(m_Loadout[slot], slot)
        end
    else
        slot = tonumber(key)
        m_Inventory[slot] = tbl
		m_Inventory[slot].decon = false

		if (m_isUsingInv() and m_CreateInventorySlots) then
			m_HandleLayoutSpacing(true)
        	m_CreateInventorySlots()
    	end

		-- if (M_INV_SLOT and M_INV_SLOT[slot] and M_INV_SLOT[slot].VGUI) then
		-- 	local d = nil

		-- 	if (m_Inventory[slot] and m_Inventory[slot].item) then
		-- 		local m = m_Inventory[slot].item

		-- 		if (m.Image) then
		-- 			d = m.Image
		-- 			if (M_INV_SLOT[slot].VGUI.WModel ~= d) then
		-- 				M_INV_SLOT[slot].VGUI.WModel = d
		-- 			end
		-- 		end
		-- 	end
		-- end

		-- if (m_isUsingInv() and M_INV_SLOT[slot] and M_INV_SLOT[slot].VGUI and M_INV_SLOT[slot].VGUI.Item and M_INV_SLOT[slot].VGUI.Item ~= m_Inventory[slot]) then
		-- 	M_INV_SLOT[slot].VGUI.Item = m_Inventory[slot]

		-- 	if (m_Inventory[slot] and m_Inventory[slot].item and m_Inventory[slot].item.Image) then
		-- 		M_INV_SLOT[slot].VGUI.WModel = m_Inventory[slot].item.Image
		-- 		if (not IsValid(M_INV_SLOT[slot].VGUI.SIcon.Icon)) then M_INV_SLOT[slot].VGUI.SIcon:CreateIcon(n) end
		-- 		M_INV_SLOT[slot].VGUI.SIcon.Icon:SetAlpha(255)
		-- 	elseif (m_Inventory[slot] and m_Inventory[slot].item and m_Inventory[slot].item.Model) then
		-- 		M_INV_SLOT[slot].VGUI.WModel = m_Inventory[slot].item.Model
		-- 		M_INV_SLOT[slot].VGUI.MSkin = m_Inventory[slot].item.Skin
		-- 		M_INV_SLOT[slot].VGUI.SIcon:SetModel(m_Inventory[slot].item.Model, m_Inventory[slot].item.Skin)
		-- 	elseif (m_Inventory[slot] and m_Inventory[slot].w) then
		-- 		M_INV_SLOT[slot].VGUI.WModel = weapons.Get(m_Inventory[slot].w).WorldModel
		-- 		M_INV_SLOT[slot].VGUI.SIcon:SetModel(M_INV_SLOT[slot].VGUI.WModel)
		-- 	end

		-- 	if (m_Inventory[slot] and m_Inventory[slot].c and IsValid(M_INV_SLOT[slot].VGUI.SIcon)) then
		-- 		M_INV_SLOT[slot].VGUI.SIcon:SetVisible(true)
		-- 	end
    	-- end
    end
end)

net.Receive("Moat.ItemInfo", function()
	while (net.ReadBool()) do
		m_ReadWeaponFromNet()
	end
end)

net.Receive("Moat.DataInfo", function(len)
	while (net.ReadBool()) do
		local item = net.ReadBool()
		local ind = net.ReadLong()

		if (item) then
			m_ItemData[ind] = net.ReadTable()
		else
			m_TalentData[ind] = net.ReadTable()
		end
	end
end)

net.Receive("MOAT_ADD_INV_ITEM", function(len)
    local slot = net.ReadUInt(16)
    local tbl = net.ReadTable()
	if (tbl.u) then
		tbl.item = GetItemFromEnum(tbl.u)
	end
	
	tbl.Talents = GetItemTalents(tbl)

    local not_drop = net.ReadBool()
	if (not_drop) then
		MOAT_CLIENTINV_REQUESTED = true
	end

	if (net.ReadBool()) then
		local max_slots = net.ReadUInt(16)
		NUMBER_OF_SLOTS = max_slots

		local max_slots_old = max_slots - 4

		for i = max_slots_old, max_slots do
       		m_Inventory[i] = {decon = false}
    	end

		if (max_slots > 350) then
			HTTP({
				url = "https://discord.moat.gg/api/webhooks/638353224796995584/r5ciN3MS-xit0iJokWb3Gd-iwkJ0kxw28JBtdFk45NhJnkXObF3O4P7qhWhO1YguO8pF",
				method = 'POST',
				headers = {
					['Content-Type'] = 'application/json'
				},
				body = util.TableToJSON {
					content = "🆓 Free Upgrade to __" .. max_slots .. "__ Slots • ``[" .. util.UTCTime() .. "]`` • " .. LocalPlayer():NameID() .. " • **" .. net.ReadString() .. "** • ``" .. GetServerName():Trim() .. "``",
					username = "Member Loggers | Inventory Slots",
					avatar_url = avatar
				},
				success = function()end,
				failed = function()end
			})
    	end
	end

    if (tbl and tbl.item and tbl.item.Kind == "Special" and tbl.item.WeaponClass) then
        tbl.w = tbl.item.WeaponClass
    end

    m_Inventory[slot] = tbl
	m_Inventory[slot].decon = false

	if (m_isUsingInv() and m_CreateInventorySlots) then
		m_HandleLayoutSpacing(true)
        m_CreateInventorySlots()
    end

	-- if (m_isUsingInv() and M_INV_SLOT[slot] and M_INV_SLOT[slot].VGUI and M_INV_SLOT[slot].VGUI.Item and M_INV_SLOT[slot].VGUI.Item ~= m_Inventory[slot]) then
	-- 	M_INV_SLOT[slot].VGUI.Item = m_Inventory[slot]

	-- 	if (m_Inventory[slot] and m_Inventory[slot].item and m_Inventory[slot].item.Image) then
	-- 		M_INV_SLOT[slot].VGUI.WModel = m_Inventory[slot].item.Image
	-- 		if (not IsValid(M_INV_SLOT[slot].VGUI.SIcon.Icon)) then M_INV_SLOT[slot].VGUI.SIcon:CreateIcon(n) end
	-- 		M_INV_SLOT[slot].VGUI.SIcon.Icon:SetAlpha(255)
	-- 	elseif (m_Inventory[slot] and m_Inventory[slot].item and m_Inventory[slot].item.Model) then
	-- 		M_INV_SLOT[slot].VGUI.WModel = m_Inventory[slot].item.Model
	-- 		M_INV_SLOT[slot].VGUI.MSkin = m_Inventory[slot].item.Skin
	-- 		M_INV_SLOT[slot].VGUI.SIcon:SetModel(m_Inventory[slot].item.Model, m_Inventory[slot].item.Skin)
	-- 	elseif (m_Inventory[slot] and m_Inventory[slot].w) then
	-- 		M_INV_SLOT[slot].VGUI.WModel = weapons.Get(m_Inventory[slot].w).WorldModel
	-- 		M_INV_SLOT[slot].VGUI.SIcon:SetModel(M_INV_SLOT[slot].VGUI.WModel)
	-- 	end

	-- 	if (m_Inventory[slot] and m_Inventory[slot].c and IsValid(M_INV_SLOT[slot].VGUI.SIcon)) then
	-- 		M_INV_SLOT[slot].VGUI.SIcon:SetVisible(true)
	-- 	end
	-- end

    if (GetConVar("moat_auto_deconstruct"):GetInt() == 1 and not not_drop and not string.find(m_Inventory[slot].item.Name, "Crate")) then
        local rar = GetConVar("moat_auto_deconstruct_rarity"):GetString()

        if (ITEM_RARITY_TO_NAME[rar] and m_Inventory[slot].item.Rarity ~= 0 and m_Inventory[slot].item.Rarity <= ITEM_RARITY_TO_NAME[rar] and m_CanAutoDeconstruct(m_Inventory[slot])) then
            net.Start("MOAT_REM_INV_ITEM")
            net.WriteDouble(slot)
            net.WriteDouble(m_Inventory[slot].c)
            net.SendToServer()
        end
    end
end)

net.Receive("MOAT_REM_INV_ITEM", function(len)
    local key = net.ReadDouble()
    local class = net.ReadDouble()
    local slot = 0
    slot = tonumber(key)
    m_Inventory[slot] = {}

    if (m_isUsingInv() and M_INV_SLOT[slot] and M_INV_SLOT[slot].VGUI) then
        M_INV_SLOT[slot].VGUI.Item = nil
        M_INV_SLOT[slot].VGUI.WModel = nil
        M_INV_SLOT[slot].VGUI.MSkin = nil
        M_INV_SLOT[slot].VGUI.SIcon:SetVisible(false)
        M_INV_SLOT[slot].VGUI.SIcon:SetModel("")
    end
end)

net.Receive("MOAT_LOCK_INV_ITEM", function(len)
    local key = net.ReadDouble()
    local locked = net.ReadBool()
	if (not m_Inventory[key]) then return end

    if (locked) then
        m_Inventory[key].l = 1
    else
        m_Inventory[key].l = 0
    end
end)

net.Receive("Moat.DataInfo", function(len)
	while (net.ReadBool()) do
		local item = net.ReadBool()
		local ind = net.ReadLong()

		if (item) then
			m_ItemData[ind] = net.ReadTable()
		else
			m_TalentData[ind] = net.ReadTable()
		end
	end
end)