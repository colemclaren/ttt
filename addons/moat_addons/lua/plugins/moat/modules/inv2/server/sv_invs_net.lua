local StatIDToKey, StatKeyToID = {[1] = 0, [2] = 1, [3] = 2, [4] = 3, [5] = 4, [6] = 5, [7] = 6,[8] = 7, [9] = 8, [10] = 9, 
[11] = "a", [12] = "b", [13] = "c", [14] = "d", [15] = "e", [16] = "f", [17] = "g", [18] = "h", [19] = "i", [20] = "j", [21] = "k", [22] = "l", [23] = "m",
[24] = "n", [25] = "o", [26] = "p", [27] = "q", [28] = "r", [29] = "s", [30] = "t", [31] = "u", [32] = "v", [33] = "w", [34] = "x", [35] = "y", [36] = "z"},
{[0] = 1, [1] = 2, [2] = 3, [3] = 4, [4] = 5, [5] = 6, [6] = 7, [7] = 8, [8] = 9, [9] = 10, ["0"] = 1, ["1"] = 2, ["2"] = 3, ["3"] = 4, ["4"] = 5, ["5"] = 6, ["6"] = 7, ["7"] = 8, ["8"] = 9, ["9"] = 10,
["a"] = 11, ["b"] = 12, ["c"] = 13, ["d"] = 14, ["e"] = 15, ["f"] = 16, ["g"] = 17, ["h"] = 18, ["i"] = 19,  ["j"] = 20, ["k"] = 21,["l"] = 22, ["m"] = 23, ["n"] = 24, ["o"] = 25, ["p"] = 26, ["q"] = 27,
["r"] = 28, ["s"] = 29, ["t"] = 30, ["u"] = 31, ["v"] = 32, ["w"] = 33, ["x"] = 34, ["y"] = 35, ["z"] = 36}

function m_StatKeyToID(str)
	return StatKeyToID[str]
end

function m_StatIDToKey(num)
	return StatIDToKey[num]
end

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
		-- print "writing..."
	end

	net.WriteBool(not not self.c)
	if (not self.c) then
		return
	end

	-- item unique id
	net.WriteLong(self.c)
	-- item droptable id
	net.WriteLong(self.u)

	net.WriteBool(not not self.w)
	if (self.w) then
		net.WriteString(self.w)
	end

	-- item paints
	net.WriteBool(not not self.p)
	if (self.p) then
		net.WriteShort(self.p)
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

	-- item locked
	net.WriteBool(self.l and self.l == 1)

	-- item stats
	net.WriteByte(self.s and math.max(1, table.Count(self.s)) or 1)
	-- print("stats", self.s and math.max(1, table.Count(self.s)) or 1)
	if (self.s) then
		for statid, modifier in pairs(self.s) do
			net.WriteByte(m_StatKeyToID(statid))
			-- print("statid", m_StatKeyToID(statid))
			net.WriteFloat(modifier)
			-- print("statid", m_StatKeyToID(statid), modifier)
		end
	end
	net.WriteByte(0)

	-- item talents
	net.WriteByte(self.t and table.Count(self.t) or 0)
	-- print("talents", self.t and table.Count(self.t) or 0)
	if (self.t and table.Count(self.t) > 0) then
		for tier, data in pairs(self.t) do
			net.WriteShort(tier)
			net.WriteShort(data.e)
			net.WriteShort(data.l)

			local mods = data.m
			for i = 1, 31 do
				if (not mods[i]) then
					break
				end

				net.WriteBool(true)
				net.WriteFloat(mods[i])
			end

			net.WriteBool(false)
		end
	end
	net.WriteShort(0)
end