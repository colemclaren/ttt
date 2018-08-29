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

function mi.ReadWeaponFromNetCache()
    return mi.items.data.cache[net.ReadUInt(32)]
end


net.Receive("mi.data.info", function(len)
    while (net.ReadBool()) do
        local tbl = net.ReadBool() and mi.items.data.items or mi.items.data.talents
        local ind = net.ReadUInt(32)
        tbl[ind] = net.ReadTable()
    end
end)

net.Receive("mi.purge", function()
    if (mi.AllowSlotLoad) then
        mi.AllowSlotLoad()
    else
        mi.AllowSlotLoad = true
    end
end)

net.Receive("mi.send.inv.item", function(len)
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

net.Receive("mi.item.info", function()
	while (net.ReadBool()) do
        mi.ReadWeaponFromNet()
    end
end)