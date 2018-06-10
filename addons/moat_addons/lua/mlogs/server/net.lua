mlogs.net:Load("init")

-- credit meepen https://steamcommunity.com/profiles/76561198050165746
local interval = engine.TickInterval()
local max_per_interval = 30000 * interval
function mlogs.BreakableMessage(data, i)
    i = i or 1
    local datas = data.datas

	if (not datas[i]) then return data.callback() end
	if (not data.checkfn(datas[i])) then i = i + 1 return BreakableMessage(data, i) end

    data.startfn(i)
        while (datas[i]) do
			if (not checkfn(datas[i])) then i = i + 1 continue end
            net.WriteBool(true)
            data.writefn(i, datas[i])
            i = i + 1
            if (net.BytesWritten() >= max_per_interval) then
                break
            end
        end
        net.WriteBool(false)
    data.endfn()

    if (datas[i]) then
        timer.Simple(0, function()
            return BreakableMessage(data, i)
        end)
    else
        return data.callback()
    end
end