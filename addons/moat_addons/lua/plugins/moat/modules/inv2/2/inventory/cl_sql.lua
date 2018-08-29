hook.Add("InventoryPrepare", function()
    mi.SQL:Query([[
        CREATE TABLE IF NOT EXISTS ]] .. mi.Config.CacheKey .. [[ (
            c int not null,
            locked boolean not null default 0,
            slotid int unsigned not null,
            steamid bigint unsigned not null,
            primary key(steamid, slotid)
        );
    ]])
end)