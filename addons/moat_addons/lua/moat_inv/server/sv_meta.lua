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

local load_str = [[CALL selectInventoryDev4(#)]]
function PLAYER:LoadInventory()
    self.LoadingInventory = true

    MOAT_INV:Query(load_str:gsub("#", self.SteamID64 and self:SteamID64() or "BOT"), function(data, q)
        if (not IsValid(self)) then return end
        if (not d or not d[1]) then
            -- new player?
            return
        end

        pl.Inventory = MOAT_INV:ParseInventoryQuery(d, q)
        self.InventoryLoaded = true
    end)
end

function PLAYER:DropItem()

end

function PLAYER:AddItem()

end

function PLAYER:SaveItem()

end

function PLAYER:TransferItem()

end

function PLAYER:NetworkItem()

end