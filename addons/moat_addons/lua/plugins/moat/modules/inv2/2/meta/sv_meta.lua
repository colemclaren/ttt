local PLAYER = FindMetaTable "Player"

function PLAYER:LoadInventory(cb)
    self.LoadingInventory = true

    local query = MOAT_INV.SQL:CreateQuery("call selectInventory(?);", self)
    MOAT_INV:SQLQuery(query, function(d, q)
        if (not IsValid(self)) then return end
        self.InventoryLoaded = true
		self.LoadingInventory = false

        cb(self, d and d[1] and MOAT_INV:ParseInventoryQuery(d, q) or {})
    end)
end

function PLAYER:AddItem(item, cb)
    if (not item["u"]) then return end
    if (item["tr"] and item["s"]) then item["s"]["j"] = "1" end
    local str = MOAT_INV:QueryFromItem(item, self:ID())

    local var = MOAT_INV:Raw "@cid"
    str = str..MOAT_INV:CreateQuery("set ? = ?;", var, MOAT_INV:LastInsertID())
    if (item["n"]) then
        str = str .. MOAT_INV:QueryForName(item.n, var)
    end

    if (item["p"] or item["p2"] or item["p3"]) then
        str = str .. MOAT_INV:QueryForPaint(item, var)
    end

    MOAT_INV:SQLQuery(str, function(d, q)
        if (not d or not d[1]) then return end
        print(d[1].cid)
        PrintTable(d[1])
        if (cb) then cb(d[1].cid) end
    end)
end

function PLAYER:OwnsItem(id, cb)
    if (istable(id)) then id = id["c"] end
    local query = MOAT_INV:CreateQuery("SELECT 1 FROM mg_items WHERE id = ? AND ownerid = ?;", id, self)
    MOAT_INV:SQLQuery(query, function(d)
        return cb(not not d[1])
    end)
end

function PLAYER:RemoveItem(id, cb)
    if (istable(id)) then id = id["c"] end
    self:OwnsItem(id, function(does_own)
        if (not does_own) then
            error "item is not owned by player"
        end

        local query = MOAT_INV:CreateQuery("call removeItem(?);", id)

        MOAT_INV:SQLQuery(query, function(d, q)
            if (cb) then cb() end
        end)
    end)
end

function PLAYER:TransferItem(id, new, cb)
    if (istable(id)) then id = id["c"] end
    if (not self.Inventory[id]) then return end

    local query = MOAT_INV:CreateQuery("call transferItem(?, ?);", id, new)

    MOAT_INV:SQLQuery(query, function(d, q)
        if (cb) then cb() end
    end)
end

function PLAYER:NetworkItem()

end


function PLAYER:LoadStats(cb)
    local query = MOAT_INV:CreateQuery("call selectStats(?);", self)
    MOAT_INV:SQLQuery(query, function(d, q)
        if (not IsValid(self)) then return end

        if (cb) then cb(d, q) end
    end)
end

function PLAYER:CreateNewPlayer(str, inv)
	MOAT_INV:SQLQuery(str, function()
		if (not IsValid(self)) then return end

		MOAT_INV:SendUpdatedSlots(self, function()
			MOAT_INV.LoadStats(self)
		end)
	end)
end

function PLAYER:NewPlayer()
	self:GetOldData(function(st, inv, tbl)
		if (not IsValid(self)) then return end

		local s, str = MOAT_INV.Stats, ""
		if (inv) then
			str = MOAT_INV:GetOldInvQuery(inv, self:ID())
			st["c"] = math.max(0, math.floor(inv["credits"].c))
		end

		MOAT_INV:PlayerCreateSlots(self, tbl)

		for i = 1, s.n do
			local chr = s[i].char
			str = str .. MOAT_INV:CreateQuery("call saveStat(?, ?, ?);", self, chr, st[chr] and math.max(0, math.floor(st[chr])) or s[i].default)
		end

		self:CreateNewPlayer(str, inv)
	end)
end