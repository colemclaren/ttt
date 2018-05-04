local PLAYER = FindMetaTable "Player"

function PLAYER:GetOldStats(cb)
	MOAT_INV:SQLQuery("select stats_tbl from moat_stats where steamid = ?", self:SteamID(), function(d)
		if (not d or not d[1]) then cb({}) end
		cb(util.JSONToTable(d[1].stats_tbl))
	end)
end

function PLAYER:GetOldInv(cb)
	MOAT_INV:SQLQuery("select * from moat_inventories where steamid = ?", self:SteamID(), function(d)
		if (not d or not d[1]) then cb() end
        local inv_tbl = {}
        local row = d[1]
        inv_tbl["credits"] = util.JSONToTable(row["credits"])

        for i = 1, 10 do
            inv_tbl["l_slot" .. i] = util.JSONToTable(row["l_slot" .. i])
        end

        local inventory_tbl = util.JSONToTable(row["inventory"])
        for i = 1, #inventory_tbl do
            inv_tbl["slot" .. i] = inventory_tbl[i]

            if (i == #inventory_tbl and cb) then
                cb(inv_tbl)
            end
        end
	end)
end

function PLAYER:GetOldData(cb)
	self:GetOldStats(function(stats)
		self:GetOldInv(function(inv)
			cb(stats, inv)
		end)
	end)
end