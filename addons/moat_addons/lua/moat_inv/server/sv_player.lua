util.AddNetworkString "MOAT_INV.SendStats"

function MOAT_INV.SendStats(_, pl)
	for _, p in ipairs(player.GetAll()) do
		if (p == pl) then continue end

		net.Start "MOAT_INV.SendStats"
			net.WriteEntity(p)
			for i = 1, MOAT_INV.Stats.n do
				net.WriteUInt(MOAT_INV.Stats[i][p], 32)
			end
		net.Send(pl)
	end
end
net.Receive("MOAT_INV.SendStats", MOAT_INV.SendStats)

function MOAT_INV:SaveStat(id, var, val, cb)
	//to-do: make procedure
	self:SQLQuery("insert into mg_players (id, var, val) values (?!, ?, ?) on duplicate key update val=?;", id, var, val, val, function()
		if (cb) then cb() end
	end)
end

function MOAT_INV.LoadStats(pl)
	pl:LoadStats(pl:ID(), function(d)
		if (not IsValid(pl)) then return end
		if (not d or not d[1]) then
			// Create New Player & Convert Inventory
			return
		end

		for i = 1, #d do
			pl["SetStat" .. d[i].var](d[i].val)
		end
	end)
end
hook.Add("PlayerAuthed", "MOAT_INV.LoadStats", MOAT_INV.LoadStats)