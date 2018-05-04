local PLAYER = FindMetaTable "Player"

function PLAYER:GetOldStats(cb)
	MOAT_INV:SQLQuery("select stats_tbl from moat_stats where steamid = ?", "STEAM_0:0:93667545", function(d)
		if (not d or not d[1]) then cb({}) end
		cb(util.JSONToTable(d[1].stats_tbl))
	end)
end

function PLAYER:GetOldInv(cb)
	MOAT_INV:SQLQuery("select * from moat_inventories where steamid = ?", "STEAM_0:0:93667545", function(d)
		if (not d or not d[1]) then cb() end
        local inv_tbl = {}
        local row = d[1]
		local tbl = {n = 0, ln = 0, l = {}}

        inv_tbl["credits"] = util.JSONToTable(row["credits"])

        for i = 1, 10 do
            inv_tbl["l_slot" .. i] = util.JSONToTable(row["l_slot" .. i])
        end

        local inventory_tbl = util.JSONToTable(row["inventory"])
		tbl.n = #inventory_tbl
	
        for i = 1, #inventory_tbl do
			local t = inventory_tbl[i]
            inv_tbl["slot" .. i] = t

			if (t.l) then
				table.insert(tbl.l, i)
				tbl.ln = tbl.ln + 1
			end
        end

		if (cb) then cb(inv_tbl, tbl) end
	end)
end

function PLAYER:GetOldData(cb)
	self:GetOldStats(function(stats)
		self:GetOldInv(function(inv, tbl)
			cb(stats, inv, tbl)
		end)
	end)
end