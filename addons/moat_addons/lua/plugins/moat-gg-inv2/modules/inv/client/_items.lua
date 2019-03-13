/*
mi.items = mi.items or {
	loaded = false,
	trade = {},
	inv = CreateSlots(40),
	loadout = CreateSlots(10),
	data = {talents = {}, items = {}, cache = {}}
}

function mi.items.clear()
	mi.items.inv = CreateSlots(40)
	mi.items.loadout = CreateSlots(10)
	mi.items.trade = {}
end

function mi.ReadWeaponFromNetCache()
    return mi.items.data.cache[net.ReadUInt(32)]
end

function mi.ReadWeaponFromNet(self)
    self = self or {}
    if (not net.ReadBool()) then
        return self
    end
    self.c = net.ReadUInt(32)
    self.u = net.ReadUInt(32)

    if (net.ReadBool()) then
        self.w = net.ReadString()
    end

    while (true) do
        local statid = net.ReadType()
        if (not statid) then
            break
        end
        self.s = self.s or {}
        self.s[statid] = net.ReadFloat()
    end

    while (true) do
        local tier = net.ReadUInt(8)
        if (tier == 255) then
            break
        end
        self.t = self.t or {}
        local tierdata = {}
        self.t[tier] = tierdata
        tierdata.e = net.ReadUInt(16)
        tierdata.l = net.ReadUInt(16)
        for i = 1, 255 do
            if (not net.ReadBool()) then
                break
            end
            tierdata.m = tierdata.m or {}
            tierdata.m[i] = net.ReadFloat()
        end
    end

    net.WriteBool(not not self.p1)
    if (net.ReadBool()) then
        self.p1 = net.ReadUInt(16)
    end
    if (net.ReadBool()) then
        self.p2 = net.ReadUInt(16)
    end
    if (net.ReadBool()) then
        self.p3 = net.ReadUInt(16)
    end

    net.WriteBool(not not self.n)
    if (net.ReadBool()) then
        self.n = net.WriteString()
    end

    self.item = mi.items.data.items[self.u]
    if (self.item.Kind == "Other" and self.item.WeaponClass) then
        self.w = self.item.WeaponClass
    end

    if (self.t) then
        self.Talents = {}
        for k, v in ipairs(self.t) do
            self.Talents[k] = mi.items.data.talents[v.e]
        end
    end

    mi.items.data.cache[self.c] = self

    return self
end

net.Receive("Moat.SendInvItem", function(len)
	local loadout = net.ReadBool()
    local i = net.ReadUInt(32)

    while (net.ReadBool()) do
        local slot = i
        local wep = mi.ReadWeaponFromNetCache()

        mi:GetOurSlots(function()
            if (wep.c) then
                mi:IsLocked(wep.c, function(locked)
                    wep.l = locked and 1 or nil
                end)
            end

            if (loadout) then
                mi.items.loadout[slot] = wep

                if (slot >= 6 and slot <= 8 and mi.items.loadout[slot] and mi.items.loadout[slot].u) then
                    m_SendCosmeticPositions(mi.items.loadout[slot], slot)
                end
            else
                local function Internal(slot)
                    mi.items.inv[slot] = wep

                    if (M_INV_SLOT and M_INV_SLOT[slot] and M_INV_SLOT[slot].VGUI and M_INV_SLOT[slot].VGUI.WModel) then
                        local d = nil

                        if (mi.items.inv[slot] and mi.items.inv[slot].item) then
                            local m = mi.items.inv[slot].item

                            if (m.Image) then
                                d = m.Image
                                if (M_INV_SLOT[slot].VGUI.WModel ~= d) then
                                    M_INV_SLOT[slot].VGUI.WModel = d
                                end
                            end
                        end
                    end
                end

                if (wep.c) then
                    mi:GetSlotForID(wep.c, Internal)
                else
                    Internal(slot)
                end
            end
        end)
        i = i + 1
    end
end)

net.Receive("Moat.ItemInfo", function()
	while (net.ReadBool()) do
        mi.ReadWeaponFromNet()
    end
end)

net.Receive("Moat.DataInfo", function(len)
    while (net.ReadBool()) do
        local tbl = net.ReadBool() and mi.items.data.items or mi.items.data.talents
        local ind = net.ReadUInt(32)
        tbl[ind] = net.ReadTable()
    end
end)

net.Receive("Moat.Purge", function()
    if (mi.AllowSlotLoad) then
        mi.AllowSlotLoad()
    else
        mi.AllowSlotLoad = true
    end
end)

net.Receive("Moat.AddInvItem", function(len)
    local tbl = mi.ReadWeaponFromNetCache()
    local not_drop = net.ReadBool()
    mi:GetSlotForID(tbl.c, function(slot)
        mi.items.inv[slot] = tbl
        if (m_isUsingInv() and M_INV_SLOT[slot] and M_INV_SLOT[slot].VGUI) then
			M_INV_SLOT[slot].VGUI.Item = mi.items.inv[slot]

			if (mi.items.inv[slot].item.Image) then
				M_INV_SLOT[slot].VGUI.WModel = mi.items.inv[slot].item.Image
				if (not IsValid(M_INV_SLOT[slot].VGUI.SIcon.Icon)) then M_INV_SLOT[slot].VGUI.SIcon:CreateIcon(n) end
				M_INV_SLOT[slot].VGUI.SIcon.Icon:SetAlpha(255)
			elseif (mi.items.inv[slot].item.Model) then
				M_INV_SLOT[slot].VGUI.WModel = mi.items.inv[slot].item.Model
				M_INV_SLOT[slot].VGUI.MSkin = mi.items.inv[slot].item.Skin
				M_INV_SLOT[slot].VGUI.SIcon:SetModel(mi.items.inv[slot].item.Model, mi.items.inv[slot].item.Skin)
			else
				M_INV_SLOT[slot].VGUI.WModel = weapons.Get(mi.items.inv[slot].w).WorldModel
				M_INV_SLOT[slot].VGUI.SIcon:SetModel(M_INV_SLOT[slot].VGUI.WModel)
			end

			M_INV_SLOT[slot].VGUI.SIcon:SetVisible(true)
		end

        if (GetConVar("moat_auto_deconstruct"):GetInt() == 1 and not not_drop and not string.find(mi.items.inv[slot].item.Name, "Crate")) then
            local rar = GetConVar("moat_auto_deconstruct_rarity"):GetString()

            if (ITEM_RARITY_TO_NAME[rar] and mi.items.inv[slot].item.Rarity ~= 0 and mi.items.inv[slot].item.Rarity <= ITEM_RARITY_TO_NAME[rar] and m_CanAutoDeconstruct(m_Inventory[slot])) then
                net.Start("Moat.RemInvItem")
                	net.WriteUInt(mi.items.inv[slot].c, 32)
                	net.WriteByte(0)
                net.SendToServer()
            end
        end
    end)
end)
*/