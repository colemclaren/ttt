
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
	m_Inventory = CreateSlots(LocalPlayer():GetSlots())
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

net.Receive("Moat.SendInvItem", function(len)
	local loadout = net.ReadBool()
	local i = net.ReadLong()

	while (net.ReadBool()) do
		local wep = net.ReadUInt(32)
		print(wep, m_ItemCache[wep])
		wep = m_ItemCache[wep]

		if (loadout) then
			print(i)
			PrintTable(wep)
			m_Loadout[i] = wep

			if (i >= 6 and i <= 8 and m_Loadout[i] and m_Loadout[i].c) then
				m_SendCosmeticPositions(m_Loadout[i], i)
			end

			i = i + 1
			continue
		end

		mi:LookupSlot(wep.c, function(slotid, locked)
			print(wep.c, slotid, locked)
			if (slotid and tonumber(slotid)) then
				if (tonumber(slotid) < 0) then
					local id = wep.c

					mi:GetOurSlots(function(max, cache)
						mi:GetEmptySlot(max, cache, false, function(slot)
							local new_slot = tostring(slot)
							
							mi.CachedSlots.Cache.ids[id] = slot
							mi.CachedSlots.Cache.slots[new_slot] = id
							m_Inventory[slot] = wep

							mi:AddSlotItem(new_slot, id, false, function() end)
						end)
					end)

					if (slotid >= 6 and slotid <= 8 and m_Loadout[slotid] and m_Loadout[slotid].u) then
						m_SendCosmeticPositions(m_Loadout[slotid], slotid)
					end
				else
					slotid = tonumber(slotid)
					m_Inventory[slotid] = wep

					if (M_INV_SLOT and M_INV_SLOT[slotid] and M_INV_SLOT[slotid].VGUI and M_INV_SLOT[slotid].VGUI.WModel) then
						local d = nil

						if (m_Inventory[slotid] and m_Inventory[slotid].item) then
							local m = m_Inventory[slotid].item

							if (m.Image) then
								d = m.Image
								if (M_INV_SLOT[slotid].VGUI.WModel ~= d) then
									M_INV_SLOT[slotid].VGUI.WModel = d
								end
							end
						end
					end
				end
			end
		end)

		i = i + 1
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

net.Receive("Moat.Purge", function()
	for i = 1, LocalPlayer():GetSlots() do
		if (not m_Inventory[i]) then
			m_Inventory[i] = {}
		end
	end
end)

net.Receive("Moat.AddInvItem", function(len)
	local tbl = m_ReadWeaponFromNetCache()
	local not_drop = net.ReadBool()
	mi:GetSlotForID(tbl.c, function(slot)
		m_Inventory[slot] = tbl
		if (m_isUsingInv() and M_INV_SLOT[slot] and M_INV_SLOT[slot].VGUI) then
			M_INV_SLOT[slot].VGUI.Item = m_Inventory[slot]

			if (m_Inventory[slot].item.Image) then
				M_INV_SLOT[slot].VGUI.WModel = m_Inventory[slot].item.Image
				if (not IsValid(M_INV_SLOT[slot].VGUI.SIcon.Icon)) then M_INV_SLOT[slot].VGUI.SIcon:CreateIcon(n) end
				M_INV_SLOT[slot].VGUI.SIcon.Icon:SetAlpha(255)
			elseif (m_Inventory[slot].item.Model) then
				M_INV_SLOT[slot].VGUI.WModel = m_Inventory[slot].item.Model
				M_INV_SLOT[slot].VGUI.MSkin = m_Inventory[slot].item.Skin
				M_INV_SLOT[slot].VGUI.SIcon:SetModel(m_Inventory[slot].item.Model, m_Inventory[slot].item.Skin)
			else
				M_INV_SLOT[slot].VGUI.WModel = weapons.Get(m_Inventory[slot].w).WorldModel
				M_INV_SLOT[slot].VGUI.SIcon:SetModel(M_INV_SLOT[slot].VGUI.WModel)
			end

			M_INV_SLOT[slot].VGUI.SIcon:SetVisible(true)
		end

		if (GetConVar("moat_auto_deconstruct"):GetInt() == 1 and not not_drop and not string.find(m_Inventory[slot].item.Name, "Crate")) then
			local rar = GetConVar("moat_auto_deconstruct_rarity"):GetString()

			if (ITEM_RARITY_TO_NAME[rar] and m_Inventory[slot].item.Rarity ~= 0 and m_Inventory[slot].item.Rarity <= ITEM_RARITY_TO_NAME[rar] and m_CanAutoDeconstruct(m_Inventory[slot])) then
				net.Start("Moat.RemInvItem")
					net.WriteUInt(m_Inventory[slot].c, 32)
					net.WriteByte(0)
				net.SendToServer()
			end
		end
	end)
end)

net.Receive("Moat.RemInvItem", function(len)
	local c = net.ReadUInt(32)
	local slot
	for k, v in pairs(m_Inventory) do
		if (v.c == c) then
			slot = k
			break
		end
	end
	if (not slot) then
		error("couldn't find id "..c)
	end

	mi:RemoveItemSlot(slot, function() end)
end)

hook.Add("InitPostEntity", 'Moat.LoadData', function()
	net.Start 'Moat.LoadData'
	net.SendToServer()
end)