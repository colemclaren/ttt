
NET_LIMITS = NET_LIMITS or {}
local LIMITS = NET_LIMITS
local time = SysTime

if (not engine.TickCount) then
    function engine.TickCount()
        return CurTime() / engine.TickInterval()
    end
end

net.ReceiveNoLimit = net.ReceiveNoLimit or net.Receive
function net.Receive( name, _func )
    LIMITS[name] = {}
    local LIMITS = LIMITS[name]

    local function func(len, p)
        local limit = LIMITS[p]
        local now = time()
        local s,e
        if (not limit) then
            limit = {
                starttime = now,
                lasttime = 0,
                cputime = 0,
                errors = 0,
                calls = 0,
                starttick = engine.TickCount()
            }
            LIMITS[p] = limit
        elseif (limit.lasttime + 0.000000001 > now) then
            return
        -- reset at 2
        elseif (limit.lasttime + 2 < now) then
            limit.starttime = now
            limit.cputime = 0
            limit.errors = 0
            limit.starttick = engine.TickCount()
            limit.notified = false
        -- calculate if this person is hogging the cpu with this request
        elseif (limit.calls > 10 and (engine.TickCount() - limit.starttick + 1) * engine.TickInterval() / (now - limit.starttime) < 0.75) then
            if (not limit.notified) then
                local msg = ":warning: "
				.. style.Code(name) .. style.Dot(style.BoldUnderline(limit.calls) .. " Calls") .. style.Dot(style.BoldUnderline(now - limit.starttime) .. " Seconds")
				.. style.NewLine(style.Pipe("Net Limiter for ")) .. style.Code(p:Nick()) .. style.Dot(style.Code(p:SteamID())) .. style.Dot(style.Code(p:IPAddress())) .. style.Dot(p:SteamURL())
				.. style.NewLine(style.Pipe("Playing on ")) .. string.Extra(GetServerName(), GetServerURL())

				ServerLog(msg .. "\n")
                if (not name:match("MOAT_REM_INV_ITEM")) then
                    discord.Send("Skid", msg)
                end

                limit.notified = true
            end
            goto endpoint
        end

        s, e = xpcall(_func, function(err)
            return {p, err, debug.getinfo(3).source, nil, nil, debug.traceback()}
        end, len, p)

        if (not s) then
            limit.errors = limit.errors + 1
            hook.Run("ClientLuaError", e[1], e[2], e[3], e[4], e[5], e[6])
            if (Server.IsDev) then
                print(e[2].."\n"..e[6])
            end
        end


::endpoint::

        local finished = time()

        limit.calls = limit.calls + 1
        limit.cputime = limit.cputime + finished - now
        limit.lasttime = finished
    end

    net.ReceiveNoLimit(name, func)
end

if (CLIENT) then
    error("SHOULD NOT BE ON CLIENT")
end