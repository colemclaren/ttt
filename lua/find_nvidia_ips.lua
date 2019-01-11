local function found_banned(data)
    print("found banned")

    local to_unban = {}

    for _, ply in ipairs(data) do
        if (ply.reason:find("Automated")) then
            table.insert(to_unban, ply.steam_id)
        end
    end

    local z = moat.sql.db:query("UPDATE player_bans SET unban_reason = '[Automated] Unbanned (GeForce NOW)' WHERE unban_reason IS NULL AND staff_name = 'Console' AND steam_id IN (" .. table.concat(to_unban, "\n, ")..");")
    z.onError = print
    function z:onSuccess()
        print("unbanned " .. tostring(#to_unban) .. " nvidia users")
    end
    z:start()
end


local function found_steamids(data)
    print("found steamids")
    if (NVIDIA_BANNED) then
        found_banned(NVIDIA_BANNED)
        return
    end
    local steamids = {}
    for _, ply in ipairs(data) do
        local s64 = util.SteamIDTo64(ply.SteamID)
        if (s64 == "0") then
            s64 = ply.SteamID
        end
        if (steamids[s64]) then
            continue
        end
        steamids[s64] = true
        table.insert(steamids, s64)
    end

    print(#steamids .. " players connected from nvidia")

    local a = moat.sql.db:query("SELECT distinct(CAST(steam_id AS CHAR)) as steam_id, reason FROM `player_bans` WHERE unban_reason IS NULL AND staff_name = 'Console' AND steam_id IN (" .. table.concat(steamids, "\n, ") .. ");")

    a.onError = print
    function a:onSuccess(data)
        NVIDIA_BANNED = data
        found_banned(data)
    end
    a:start()
end

local function found_ranges(data)
    print("found ranges")
    if (NVIDIA_STEAMIDS) then
        found_steamids(NVIDIA_STEAMIDS)
        return
    end

    local betweens = {}
    --SELECT SteamID, Address from `player_iplog` WHERE 
    for i, asn in ipairs(data) do
        table.insert(betweens, "(INET_ATON(Address) BETWEEN " .. asn.range_start .. " AND " .. asn.range_end .. ")")
    end

    local d = moat.sql.db:query("SELECT distinct(SteamID), Address from `player_iplog` WHERE " .. table.concat(betweens, "\n OR ") .. ";")

    d.onError = print

    function d:onSuccess(data)
        NVIDIA_STEAMIDS = data
        found_steamids(data)
    end

    d:start()
end



if (NVIDIA_RANGES) then
    found_ranges(NVIDIA_RANGES)
else
    local q = SERVER_SITE_DATA:query("SELECT range_start, range_end from server_site_data.chat_log where AS_number IN (11414, 60977, 38834, 38564, 50889);")
    q.onError = print
    function q:onSuccess(data)
        NVIDIA_RANGES = data
        found_ranges(data)
    end
    q:start()
end