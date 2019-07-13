STAFF_TRACK = STAFF_TRACK or {
    Players = {},
    Handled = {}
}

function STAFF_TRACK.CreateQuery(query, succ, fail)
    local q = STAFF_TRACK.db:query(query)
    function q:onSuccess(d)
        succ(q)
    end
    function q:onError(err)
        fail(err)
    end
    q:start()
end

function STAFF_TRACK.Initialize(ply)
    local steamid = ply:SteamID64()

    STAFF_TRACK.Players[steamid] = {
        join_time = os.time(),
        sql_id = nil,
        Stats = {
            rounds_played = 0,
            rounds_on = 0,
            time_played = 0,
            reports_handled = 0,
        }
    }
    STAFF_TRACK.CreateEntry(ply)
end

function STAFF_TRACK.UpdateEntry(ply)
    local Entry = STAFF_TRACK.Players[ply:SteamID64()]
    if (not Entry.sql_id or Entry.sql_id < 0) then
        return
    end

    local statupd = {}

    local backup = {}

    for stat, addend in pairs(Entry.Stats) do
        if (addend > 0) then
            table.insert(statupd, stat .. " = " .. stat .. " + " .. tonumber(addend))
            Entry.Stats[stat] = 0
            backup[stat] = addend
        end
    end

    if (#statupd == 0) then
        return
    end
        
    STAFF_TRACK.CreateQuery("UPDATE staff_tracker SET " .. table.concat(statupd, ", ") .. " WHERE id = " .. Entry.sql_id .. ";",
        function(q)
        end,
        function(err)
            for k, v in pairs(backup) do
                Entry.Stats[k] = Entry.Stats[k] + v
            end
        end
    )
end

function STAFF_TRACK.Escape(data)
    return STAFF_TRACK.db:escape(data)
end

function STAFF_TRACK.CreateEntry(ply, cb)
    local steamid = ply:SteamID64()
    if (STAFF_TRACK.Players[steamid].sql_id ~= nil) then
        cb(false)
        return
    end

    STAFF_TRACK.Players[steamid].sql_id = -1

    local ipport = string.Explode(":", game.GetIP())
    local ip, port = ipport[1] or "0.0.0.0", tonumber(ipport[2] or 0)
    STAFF_TRACK.CreateQuery("INSERT INTO staff_tracker (steamid, server_ip, server_port) VALUES (" .. steamid .. ", INET_ATON('" .. STAFF_TRACK.db:escape(ip) .. "'), " .. port .. ");",
        function(q)
            STAFF_TRACK.Players[steamid].sql_id = q:lastInsert()
            if (not IsValid(ply)) then
                return
            end
            STAFF_TRACK.UpdateEntry(ply)
        end,
        function(err)
        end
    )
end

function STAFF_TRACK.SQLConnected(db)
    STAFF_TRACK.db = db
    for steamid, data in pairs(STAFF_TRACK.Players) do
        if (not data.sql_id) then
        end
    end
end


function STAFF_TRACK.AddStat(ply, statname, addend)
    local steamid = ply:SteamID64()

    local Stats = STAFF_TRACK.Players[steamid]
    if (not Stats) then
        STAFF_TRACK.Initialize(ply)
        Stats = STAFF_TRACK.Players[steamid]
    end
    Stats = Stats.Stats

    Stats[statname] = Stats[statname] + (addend or 1)
    STAFF_TRACK.UpdateEntry(ply)
end

hook.Add("PlayerDataLoaded", "Staff Tracker", function(ply, data)
    if (ply.IsStaff) then
        STAFF_TRACK.Initialize(ply)
    end
end)

local RoundStart = os.time()

hook.Add("TTTBeginRound", "Staff Tracker", function()
    for _, ply in pairs(player.GetAll()) do
        if (ply.IsStaff) then
            RoundStart = os.time()
            STAFF_TRACK.AddStat(ply, "rounds_on", 1)
            if (not ply:GetForceSpec()) then
                STAFF_TRACK.AddStat(ply, "rounds_played", 1)
            end
        end
    end
end)
hook.Add("TTTEndRound", "Staff Tracker", function()
    for _, ply in pairs(player.GetAll()) do
        if (ply.IsStaff and not ply:GetForceSpec()) then
            STAFF_TRACK.AddStat(ply, "time_played", os.time() - RoundStart)
        end
    end
end)

hook.Add("RDMManagerReportStatusUpdate", "Staff Tracker", function(ply, ind, e)
    if (e == RDM_MANAGER_FINISHED and not STAFF_TRACK.Handled[ind]) then
        STAFF_TRACK.Handled[ind] = true
        STAFF_TRACK.AddStat(ply, "reports_handled", 1)
    end
end)

hook.Add("SQLConnected", "Staff Tracker", STAFF_TRACK.SQLConnected)
