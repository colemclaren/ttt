/*
    Stats
*/

function MOAT_INV:UpdateItemStat(id, stat, new, cb)
    self:SQLQuery("call updateItemStat(?, ?, ?);", id, stat, new, function(d, q)
        if (cb) then cb() end
    end)
end

function MOAT_INV:RemoveItemStat(id, stat, val, cb)
    self:SQLQuery("delete from mg_itemstats where weaponid = ? and stat = ?;", id, stat, function(d, q)
        if (cb) then cb() end
    end)
end

function MOAT_INV:AddItemStat(id, stat, val, cb)
    self:SQLQuery("replace into mg_itemstats (weaponid, statid, value) values (?, ?, ?);", id, stat, val, function(d, q)
        if (cb) then cb() end
    end)
end

/*
    Paints
*/

function MOAT_INV:RemoveItemPaint(id, type, cb)
    self:SQLQuery("delete from mg_itempaints where weaponid = ? and type = ?;", id, type, function()
        if (cb) then cb() end
    end)
end

function MOAT_INV:AddItemPaint(id, type, uid, cb)
    self:SQLQuery("replace into mg_itempaints (weaponid, type, paintid) values (?, ?, ?);", id, type, uid, function(d, q)
        if (cb) then cb() end
    end)
end

function MOAT_INV:UpdateItemPaint(id, type, uid, cb)
    self:SQLQuery("update mg_itempaints set paintid = ? where weaponid = ? and type = ?;", uid, id, type, function(d, q)
        if (cb) then cb() end
    end)
end

/*
    Names
*/

function MOAT_INV:RemoveItemName(id, cb)
    self:SQLQuery("delete from mg_itemnames where weaponid = ?;", id, function()
        if (cb) then cb() end
    end)
end

function MOAT_INV:AddItemName(id, name, cb)
    self:SQLQuery("replace into mg_itemnames (weaponid, nickname) values (?, ?)", id, type, function(d, q)
        if (cb) then cb() end
    end)
end

/*
    Talents
*/

function MOAT_INV:ReplaceItemTalents(id, tbl, cb)
    local str = ""
    for k, v in ipairs(tbl) do
        for i = 1, #v["m"] do
            str = str .. self:CreateQuery("insert into mg_itemtalents (weaponid, talentid, required, modification, value) values (?, ?, ?, ?, ?);",
                id,
                v.e,
                v.l,
                i,
                v.m
            )
        end
    end

    self:SQLQuery("delete from mg_itemtalents where weaponid = ?; " .. str, id, function(d, q)
        if (cb) then cb() end
    end)
end



function MOAT_INV:DropItemPaints(id, cb)
    self:SQLQuery("delete from mg_itempaints where weaponid = ?;", id, function()
        if (cb) then cb() end
    end)
end

function MOAT_INV:DropItemName(id, cb)
    self:SQLQuery("delete from mg_itemnames where weaponid = ?;", id, function()
        if (cb) then cb() end
    end)
end

function MOAT_INV:DropItem(id, cb)
    self:SQLQuery("delete from mg_items where id = ?;", id, function()
        if (cb) then cb() end
    end)
end

function MOAT_INV:DropItemStats(id, cb)
    self:SQLQuery("delete from mg_itemstats where weaponid = ?;", id, function()
        if (cb) then cb() end
    end)
end

function MOAT_INV:DropItemTalents(id, cb)
    self:SQLQuery("delete from mg_itemtalents where weaponid = ?;", id, function()
        if (cb) then cb() end
    end)
end