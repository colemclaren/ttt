function net.InvsBroadcast(sid, ply)
	local clients = {}
	for k, v in ipairs(player.GetAll()) do
		if (v.InventoryOpen or (sid and v:SteamID64() == sid) or (ply and (isstring(ply) and v:SteamID64() == ply or v == ply))) then
			table.insert(clients, v)
		end
	end

	return net.Send(clients)
end

function m_WriteWeaponToNet(self)
	if (self and istable(self)) then
		print "writing..."
	end

    net.WriteBool(not not self.c)
    if (not self.c) then
        return
    end

    net.WriteLong(self.c, 32)
    net.WriteLong(self.u, 32)

    net.WriteBool(not not self.w)
    if (self.w) then
		net.WriteString(isstring(self.w) and self.w or tostring(mi:WepFromID(self.w)))
    end


    -- item stats
    if (self.s) then
        for statid, modifier in pairs(self.s.real_data or self.s) do
            net.WriteByte(statid)
            net.WriteFloat(modifier)
        end
    end
    net.WriteByte(0)


    -- item talents
    if (self.t) then
        for tier, data in pairs(self.t.real_data or self.t) do
			net.WriteByte(tier)
            net.WriteShort(data.e)
            net.WriteShort(data.l)

            local mods = data.m
            for i = 1, 255 do
                if (not mods[i]) then
                    break
                end

                net.WriteBool(true)
                net.WriteFloat(mods[i])
            end

            net.WriteBool(false)
        end
    end
    net.WriteByte(0)


    -- item paints
    net.WriteBool(not not self.p1)
    if (self.p1) then
        net.WriteShort(self.p1)
    end

    net.WriteBool(not not self.p2)
    if (self.p2) then
        net.WriteShort(self.p2)
    end

    net.WriteBool(not not self.p3)
    if (self.p3) then
        net.WriteShort(self.p3)
    end


    -- item nickname
    net.WriteBool(not not self.n)
    if (self.n) then
        net.WriteString(self.n)
    end
end