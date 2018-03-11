require("mysqloo")

local DBD = {
    host = "gamedb.moat.gg",
    port = 3306,
    name = "old_moat_stats",
    user = "footsies",
    pass = "clkmTQF6bF@3V0NYjtUMoC6sF&17B$",
    connected = false
}
MOATSTATS = MOATSTATS or {}
local mdb

function MOATSTATS.Escape(str)

    return mdb:escape(tostring(str))
end

function MOATSTATS.Query(str, suc, err)

    local dbq = mdb:query(str)

    if (suc) then
        function dbq:onSuccess(data)
            suc(data)
        end
    end

    function dbq:onError(er)
        ServerLog(er)
    end

    dbq:start()
end
/*
function MOATSTATS.InitializeMySQL()
    mdb = mysqloo.connect(DBD.host, DBD.user, DBD.pass, DBD.name, DBD.port)

    mdb.onConnected = function()
        DBD.connected = true
        print("Stats connected to database.")
        MOATSTATS.Query("CREATE TABLE IF NOT EXISTS stats (id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, steamid VARCHAR(30) NOT NULL, credits INTEGER NOT NULL, time INTEGER NOT NULL, rank TEXT NOT NULL, name TEXT NOT NULL)")
        MOATSTATS.Query("CREATE TABLE IF NOT EXISTS bans (id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, steamid VARCHAR(30) NOT NULL, length TEXT NOT NULL, reason TEXT NOT NULL, admin TEXT NOT NULL, adminid VARCHAR(30) NOT NULL)")
    end

    mdb.onConnectionFailed = function()
        print("Stats failed to connect to the database.")
        DBD.connected = false
    end

    mdb:connect()
end
*/
hook.Add("SQLConnected", "StatsTrackSQL", function(db)
    mdb = db
    DBD.connected = true
    print("Stats connected to database.")
    MOATSTATS.Query("CREATE TABLE IF NOT EXISTS stats (id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, steamid VARCHAR(30) NOT NULL, credits INTEGER NOT NULL, time INTEGER NOT NULL, rank TEXT NOT NULL, name TEXT NOT NULL)")
    MOATSTATS.Query("CREATE TABLE IF NOT EXISTS bans (id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, steamid VARCHAR(30) NOT NULL, length TEXT NOT NULL, reason TEXT NOT NULL, admin TEXT NOT NULL, adminid VARCHAR(30) NOT NULL)")
end)

hook.Add("SQLConnectionFailed", "StatsTrackSQL", function(db, err)
    print("Stats failed to connect to the database.")
    DBD.connected = false
end)

/*
util.AddNetworkString("MOAT_EASTER_GIVEAWAY")

function MOATSTATS.InitializePlayer(ply)
    local plid = ply:SteamID64()

    if (not plid) then
        plid = "STEAM_0:0:"
    end
    -- EASTER STUFF
    MOATSTATS.Query(string.format("SELECT * FROM users WHERE steamid = %s", plid), function(data)
        if (data and type(data) == "table" and #data > 0) then
            local row = data[1]
            local amt = tonumber(row["points"])
            local ref = row["ref"]

            if (ref ~= "24hour") then
                timer.Simple(12, function()
                    if (not ply:IsValid()) then return end

                    for i = 1, amt do
                        ply:m_DropInventoryItem([[Easter Egg]])
                    end

                    net.Start("MOAT_EASTER_GIVEAWAY")
                    net.WriteString(ply:Nick())
                    net.WriteUInt(amt, 8)
                    net.Broadcast()

                    MOATSTATS.Query(string.format("DELETE FROM users WHERE steamid = %s", ply:SteamID64()))
                end)
            end
        end

        if (data and type(data) == "table" and #data > 0) then
            local row = data[1]
            local amt = tonumber(row["points"])
            local ref = row["ref"]

            if (ref == "24hour") then
                timer.Simple(12, function()
                    if (not ply:IsValid()) then return end

                    for i = 1, amt do
                        ply:m_DropInventoryItem([[Insomnious]])
                    end

                    MOATSTATS.Query(string.format("DELETE FROM users WHERE steamid = %s", ply:SteamID64()))
                end)
            end
        end
    end)
end
hook.Add("PlayerInitialSpawn", "MoatStats Initialize Player", MOATSTATS.InitializePlayer)*/