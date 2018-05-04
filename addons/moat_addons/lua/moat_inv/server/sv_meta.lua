--[[
{
    "t": [
        {
            "m": [1.0],
            "l": 8.0,
            "e": 85.0
        },
        {
            "m": [1.0,1.0],
            "l": 14.0,
            "e": 154.0
        },
        {
            "m": [1.0,1.0],
            "l": 27.0,
            "e": 3.0
        }
    ],
    "u": 1147.0,
    "c": "2197761330",
    "s": {
        "x":170.0,
        "k":0.197,
        "f":0.803
        "m":0.429,
        "w":0.682,
        "r":0.458,
        "l":13.0,
        "a":0.521,
        "d":0.183
    },
    "w": "weapon_ttt_te_sr25",
    "tr": 1.0,
    "n": "Hitregs...",
    "l": 1.0,
    "p": 6035.0
}
]]

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
    local str = MOAT_INV:QueryFromItem(item, self)

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
        if (cb) then cb(d[1].cid) end
    end)
end

function PLAYER:RemoveItem(id, cb)
    if (istable(id)) then id = id["c"] end
    if (not self.Inventory[id]) then return end

    MOAT_INV:SQLQuery("call removeItem(?)", id, function(d, q)
        if (cb) then cb() end
    end)
end

function PLAYER:TransferItem(id, new, cb)
    if (istable(id)) then id = id["c"] end
    if (not self.Inventory[id]) then return end

    MOAT_INV:SQLQuery("call transferItem(?, ?)", id, new, function(d, q)
        if (cb) then cb() end
    end)
end

function PLAYER:NetworkItem()

end


function PLAYER:LoadStats(cb)
	MOAT_INV:SQLQuery("call selectStats(?);", self, function(d, q)
		if (cb) then cb(d, q) end
	end)
end

function PLAYER:NewPlayer()
	self:GetOldStats(function(t)
		local s, str = MOAT_INV.Stats, ""
		for i = 1, s.n do
			local c = s[i].char
			str = str .. MOAT_INV:CreateQuery("call saveStat(?!, ?, ?);", self, c, t[c] and math.max(0, math.floor(t[c])) or s[i].default)
		end
	end)
end