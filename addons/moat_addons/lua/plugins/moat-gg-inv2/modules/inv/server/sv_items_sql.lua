/*
	Stats
*/

function mi:ItemStatsAdd(id, stat, new, cb)
	self:SQLQuery("call moat_inv.item_stats_add(?, ?, ?);", id, stat, new, function(d, q)
		if (cb) then cb() end
	end)
end

function mi:ItemStatsSet(id, stat, new, cb)
	self:SQLQuery("call moat_inv.item_stats_set(?, ?, ?);", id, stat, new, function(d, q)
		if (cb) then cb() end
	end)
end

function mi:ItemStatsDelete(id, stat, cb)
	self:SQLQuery("call moat_inv.item_stats_delete(?, ?);", id, stat, function(d, q)
		if (cb) then cb() end
	end)
end

function mi:ItemStatsDrop(id, cb)
	self:SQLQuery("call moat_inv.item_stats_drop(?);", id, function(d, q)
		if (cb) then cb() end
	end)
end

/*
	Paints
*/

function mi:ItemPaintsAdd(id, paint, type, cb)
	self:SQLQuery("call moat_inv.item_paints_add(?, ?, ?);", id, paint, type, function(d, q)
		if (cb) then cb() end
	end)
end

function mi:ItemPaintsSet(id, paint, type, cb)
	self:SQLQuery("call moat_inv.item_paints_set(?, ?, ?);", id, paint, type, function(d, q)
		if (cb) then cb() end
	end)
end

function mi:ItemPaintsDelete(id, paint, cb)
	self:SQLQuery("call moat_inv.item_paints_delete(?, ?);", id, paint, function(d, q)
		if (cb) then cb() end
	end)
end

function mi:ItemStatsDrop(id, cb)
	self:SQLQuery("call moat_inv.item_paints_drop(?);", id, function(d, q)
		if (cb) then cb() end
	end)
end

/*
	Names
*/

function mi:ItemNamesAdd(id, name, cb)
	self:SQLQuery("call moat_inv.item_names_add(?, ?, ?);", id, name, function(d, q)
		if (cb) then cb() end
	end)
end

function mi:ItemNamesDrop(id, cb)
	self:SQLQuery("call moat_inv.item_names_drop(?);", id, function(d, q)
		if (cb) then cb() end
	end)
end

/*
	Talents
*/

function mi:ItemTalentsAdd(id, talent, required, level, mod, cb)
	self:SQLQuery("call moat_inv.item_talents_add(?, ?, ?, ?, ?);", id, talent, required, level, mod, function(d, q)
		if (cb) then cb() end
	end)
end

function mi:ItemTalentsSet(id, talent, new, cb)
	self:SQLQuery("call moat_inv.item_talents_set(?, ?, ?);", id, talent, new, function(d, q)
		if (cb) then cb() end
	end)
end

function mi:ItemTalentsDelete(id, talent, cb)
	self:SQLQuery("call moat_inv.item_talents_delete(?, ?);", id, talent, function(d, q)
		if (cb) then cb() end
	end)
end

function mi:ItemTalentsDrop(id, cb)
	self:SQLQuery("call moat_inv.item_talents_drop(?);", id, function(d, q)
		if (cb) then cb() end
	end)
end

function mi:ItemTalentsReplace(id, tbl, cb)
	local str = ""
	for k, v in ipairs(tbl) do
		for i = 1, #v["m"] do
			str = str .. self:CreateQuery("call moat_inv.item_talents_add(?, ?, ?, ?, ?);", id, v.e, v.l, i, v.m)
		end
	end

	self:SQLQuery("call moat_inv.item_names_drop(?);" .. str, id, function(d, q)
		if (cb) then cb() end
	end)
end