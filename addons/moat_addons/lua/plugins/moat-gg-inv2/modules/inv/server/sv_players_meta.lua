local PLAYER = FindMetaTable "Player"

--[[-----------------------------------
Player Methods for Inital Loading
------------------------------------]]--

function PLAYER:LoadInventory(cb)
    self.LoadingInventory = true

    return mi:SQLQuery("call moat_inv.items_get(?);", self, function(d, q)
        if (not IsValid(self)) then
			return
		end

        self.InventoryLoaded = true
		self.LoadingInventory = false

        cb(self, d and d[1] and mi:ParseInventoryQuery(d, q) or {})
    end)
end

function PLAYER:SaveData(id, num, str, cb)
    return mi:SQLQuery('call moat_inv.player_data_set(?, ?, ?, ?);', self, id, num, str, function(d, q)
        if (not IsValid(self)) then
			return
		end

		if (cb) then
			cb(d, q)
		end
    end)
end

function PLAYER:LoadData(cb)
    return mi:SQLQuery('call moat_inv.player_data_get(?);', self, function(d, q)
        if (not IsValid(self)) then
			return
		end

        if (not d or not d[1]) then
			self:NewPlayer()
			// Create New Player and onvert Inventory
			return
		end

		MsgC(Color(0, 255, 0), "Loaded Data for " .. self:Nick() .. "\n")

		for i = 1, #d do
			self["SetData" .. d[i].id](self, d[i].num)
		end

		mi:NetworkPlayersData(self)

        if (cb) then
			cb(d, q)
		end
    end)
end

--[[-----------------------------------
Player Methods for New Players
------------------------------------]]--

function PLAYER:CreateNewPlayer(str, inv)
	return mi:SQLQuery(str, function()
		if (not IsValid(self)) then
			return
		end

		self:LoadData(function()
			mi:SendUpdatedSlots(self, function()
				mi.SendInventoryToPlayer(self)
			end)
		end)
	end)
end

function PLAYER:NewPlayer()
	return self:GetOldData(function(st, inv_tbl, loadout, ic)
		if (not IsValid(self)) then
			return
		end

		local s, str = mi.Players, ""
		if (inv_tbl) then
			str = mi:GetOldInvQuery(inv_tbl, loadout, self:ID())
			st["c"] = math.max(0, math.floor(ic))
			st["s"] = #inv_tbl
		end

		for k, v in pairs(s) do
			str = str .. mi:CreateQuery("call moat_inv.player_data_set(?, ?, ?, ?);", self, k, 
				v.Type == 'num' and (st[v.Old] and math.max(0, math.floor(st[v.Old])) or v.Default) or nil, 
				v.Type == 'str' and v.Default or nil
			)
		end

		self:CreateNewPlayer(str, inv_tbl, loadout, ic)
	end)
end

--[[-----------------------------------
Player Methods for Old Inv Data
------------------------------------]]--

function PLAYER:GetOldStats(cb)
	return mi:SQLQuery("SELECT stats_tbl FROM moat_stats WHERE steamid = ?;", mi.Config.Tester.old or self:SteamID(), function(d)
		if (not d or not d[1]) then
			cb({})
		end

		cb(util.JSONToTable(d[1].stats_tbl))
	end)
end

function PLAYER:GetOldInv(cb)
	return mi:SQLQuery("SELECT * FROM " .. mi.Config.OldInvTable .. " WHERE steamid = ?", mi.Config.Tester.old or self:SteamID(), function(d)
		if (not d or not d[1]) then
			return cb()
		end

        local inv_tbl, loadout = {}, {}
		local row = d[1]

        for i = 1, 10 do
			loadout[i] = util.JSONToTable(row["l_slot" .. i])
        end

        local inventory_tbl = util.JSONToTable(row["inventory"])
		local ic = util.JSONToTable(row["credits"])
		ic = ic.c or 0

        for i = 1, #inventory_tbl do
            inv_tbl[i] = inventory_tbl[i]
        end

		if (cb) then
			return cb(inv_tbl, loadout, ic)
		end
	end)
end

function PLAYER:GetOldData(cb)
	return self:GetOldStats(function(stats)
		return self:GetOldInv(function(inv_tbl, loadout, ic)
			cb(stats, inv_tbl, loadout, ic)
		end)
	end)
end

--[[-----------------------------------
Player Methods for Items
------------------------------------]]--

function PLAYER:AddItem(item, cb)
    if (not item.u) then
		return
	end
	
	local LAST_INSERT_ID = mi:LastInsertID()
    local steamid = self:ID()

	item = new_weapon(item)

    local str = mi:QueryFromItem(item, steamid)
    local var = mi:Raw "@cid"
    str = str .. mi:CreateQuery("set ? = ?;", var, LAST_INSERT_ID)

    if (item.n) then
        str = str .. mi:QueryForName(item.n, var, steamid)
    end

	if (v.p or v.p2 or v.p3) then
		str = str .. mi:QueryForPaint(item, var)
	end

    mi:SQLQuery(str, function(d, q)
        if (not d or not d[1]) then
			return
		end

        print(d[1].cid)
        PrintTable(d[1])

        if (cb) then
			cb(d[1].cid)
		end
    end)
end

function PLAYER:OwnsItem(id, cb)
	id = istable(id) and id["c"] or id

    mi:SQLQuery("SELECT 1 FROM moat_inv.items WHERE id = ? AND ownerid = ?;", id, self, function(d)
        return cb(not not d[1])
    end)
end

function PLAYER:RemoveItem(id, cb)
	id = istable(id) and id["c"] or id

	self:OwnsItem(id, function(does_own)
		if (not does_own) then
            error "item is not owned by player"
        end

        mi:SQLQuery("call moat_inv.item_delete(?);", id, function(d, q)
            if (cb) then
				return cb(d, q)
			end
        end)
    end)
end

function PLAYER:TransferItem(id, new, cb)
    id = istable(id) and id["c"] or id
    if (not self.Inventory[id]) then
		return
	end

    mi:SQLQuery("call moat_inv.item_ownerid_set(?, ?);", id, new, function(d, q)
        if (cb) then
			return cb(d, q)
		end
    end)
end