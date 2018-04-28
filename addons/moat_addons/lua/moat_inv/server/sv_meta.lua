--[[
{"t":[{"m":[1.0],"l":8.0,"e":85.0},
    {"m":[1.0,1.0],"l":14.0,"e":154.0},
    {"m":[1.0,1.0],"l":27.0,"e":3.0}],
 "u":1147.0,
 "c":"2197761330",
 "s":{"x":170.0,"k":0.197,"f":0.803
    "m":0.429,"w":0.682,"r":0.458,
    "l":13.0,"a":0.521,"d":0.183},
 "w":"weapon_ttt_te_sr25",
    "tr":1.0,
    "n":"Hitregs...",
    "l":1.0,
    "p":6035.0}
]]

local PLAYER = FindMetaTable "Player"

function PLAYER:LoadInventory(cb)
    self.LoadingInventory = true

    MOAT_INV:Query("call selectInventory(#)", self:ID(), function(d, q)
        if (not IsValid(self)) then return end
        if (not d or not d[1]) then
            -- new player?
            return
        end

        self.Inventory = MOAT_INV:ParseInventoryQuery(d, q)
        self.InventoryLoaded = true

        cb(self)
    end)
end

function PLAYER:AddItem(item, cb)
    if (not item["u"]) then return end
    if (item["tr"] and item["s"]) then item["s"]["j"] = "1" end
    local str = MOAT_INV:QueryFromItem(item, self:ID())

    if (item["n"]) then
        str = str .. MOAT_INV:QueryForName(item.n, "LAST_INSERT_ID()")
    end

    if (item["p"] or item["p2"] or item["p3"]) then
        str = str .. MOAT_INV:QueryForPaint(item, "LAST_INSERT_ID()")
    end

    MOAT_INV:Query(str, function(d, q)
        if (not d or not d[1]) then return end
        if (cb) then cb(d[1].cid) end
    end)
end

function PLAYER:RemoveItem(id, cb)
    if (istable(id)) then id = id["c"] end
    if (not self.Inventory[id]) then return end

    MOAT_INV:Query("call removeItem(#)", id, function(d, q)
        if (cb) then cb() end
    end)
end

function PLAYER:TransferItem(id, new, cb)
    if (istable(id)) then id = id["c"] end
    if (not self.Inventory[id]) then return end

    MOAT_INV:Query("call transferItem(#, #)", id, new, function(d, q)
        if (cb) then cb() end
    end)
end

function PLAYER:NetworkItem()

end