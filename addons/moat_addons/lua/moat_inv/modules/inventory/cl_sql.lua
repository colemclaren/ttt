hook.Add("InventoryPrepare", function()
    MOAT_INV.SQL:Query [[
        CREATE TABLE IF NOT EXISTS mg_slots (c int not null, locked boolean not null default false, slotid int unsigned not null, primary key(slotid));
    ]]
end)