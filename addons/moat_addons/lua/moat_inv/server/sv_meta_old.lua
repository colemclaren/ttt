local PLAYER = FindMetaTable "Player"

function PLAYER:GetOldStats(cb)
	/*OAT_INV:SQLQuery(""
    local query1 = MINVENTORY_MYSQL:query("SELECT * FROM moat_stats WHERE steamid = '" .. ply:SteamID() .. "'")
    function query1:onSuccess(data)
        if (#data > 0) then
            local row = data[1]
            local stats_table = util.JSONToTable(row["stats_tbl"])
            m_InitStatsToPlayer(ply, stats_table)
        else
            m_InsertNewStatsPlayer(ply)
        end
    end
    query1:start()*/
end