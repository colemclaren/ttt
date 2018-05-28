util.AddNetworkString "MOAT_INV.SendStats"

function MOAT_INV:NetworkStats(pl, to)
	net.Start "MOAT_INV.SendStats"

		net.WriteEntity(pl)
		for statid, statdata in pairs(self.Stats) do
			net.WriteByte(statid:byte(1, 1))
			net.WriteUInt(statdata.ply_data[pl], 32)
		end
		net.WriteByte(0)

	return to and net.Send(to) or net.Broadcast()
end

function MOAT_INV.SendStats(_, pl)
	for _, p in ipairs(player.GetAll()) do
		if (p == pl) then continue end

		MOAT_INV:NetworkStats(p, pl)
	end
end
net.Receive("MOAT_INV.SendStats", MOAT_INV.SendStats)

function MOAT_INV:SaveStat(id, var, val, cb)
	self:SQLQuery("call saveStat(?, ?, ?);", id, var, val, function()
		if (cb) then cb() end
	end)
end

function MOAT_INV.LoadStats(pl)
	pl:LoadStats(function(d)
		if (not IsValid(pl)) then return end
		if (not d or not d[1]) then
			pl:NewPlayer()
			// Create New Player & Convert Inventory
			return
		end

		for i = 1, #d do
			pl["SetStat" .. d[i].var](pl, d[i].val)
		end

		MOAT_INV:NetworkStats(pl)

		-- temp
		m_SendInventoryToPlayer(pl)
	end)
end
hook.Add("PlayerAuthed", "MOAT_INV.LoadStats", MOAT_INV.LoadStats)