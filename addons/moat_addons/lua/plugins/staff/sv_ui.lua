util.AddNetworkString "ST_UI"

net.Receive("ST_UI", function(_, cl)
    if (not cl:HasAccess(D3A.Config.Commands.SetGroup)) then
        print "no access!"
        return
    end
    local steamid = net.ReadString()

    if (steamid:StartWith "STEAM_") then
        steamid = util.SteamIDTo64(steamid)
    end

    if (steamid == "0" or not steamid) then
        print "error"
        return
    end

    local from, to = net.ReadUInt(32), net.ReadUInt(32)
    local query = "SELECT CAST(steamid AS CHAR) as steamid, SUM(rounds_played) as rounds_played, SUM(rounds_on) as rounds_on, " ..
    "SUM(time_played) as time_played, SUM(reports_handled) as handled FROM staff_tracker WHERE steamid = '" .. STAFF_TRACK.Escape(steamid) .. "'" ..
    " AND leave_time > FROM_UNIXTIME(" .. from .. ") AND join_time < FROM_UNIXTIME(" .. to .. ");"

    STAFF_TRACK.CreateQuery(query, function(q)
        net.Start "ST_UI"
            net.WriteBool(true)
            local data = q:getData()[1]
            if (not data) then
                data = {}
            else
                data.to = to
                data.from = from
            end
            net.WriteTable(data)
        net.Send(cl)
    end,
    function(e)
        net.Start "ST_UI"
            net.WriteBool(false)
            net.WriteString(e)
        net.Send(cl)
    end)
end)

--[[
net.Receive("ST_UI", function(len, cl)
    STAFF_TRACK.CreateQuery("SELECT UNIX_TIMESTAMP(MIN(join_time)) as earliest, UNIX_TIMESTAMP(MAX(join_time)) as latest FROM staff_tracker;", function(d)
        net.Start "ST_UI"
            net.WriteString "times"
            net.WriteUInt(d.earliest, 32)
            net.WriteUInt(d.latest, 32)
        net.Send(cl)
    end,
    function(e)
        net.Start "ST_UI"
            net.WriteString "error"
            net.WriteString(e)
        net.Send(cl)
    end)
end)]]