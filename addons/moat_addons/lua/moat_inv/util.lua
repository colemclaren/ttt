function MOAT_INV.Print(str, b)
    MsgC(b and Color(255, 0, 0) or Color(255, 255, 0), "INV | " .. str .. "\n")
end

function string:add(str)
    return str and self .. ", " .. str or self .. ", null"
end

function string:finish(...)
    local n, t = 0, {...}
    return self:gsub("#", function() n = n + 1 return t[n] end) .. ");"
end

local PLAYER = FindMetaTable "Player"
function PLAYER:ID()
    return self.SteamID64 and self:SteamID64() or "BOT"
end

local interval = engine.TickInterval()
local max_per_interval = 30000 * interval
function BreakableMessage(data, i)
    i = i or 1

    local startfn = data.startfn
    local endfn = data.endfn
    local writefn = data.writefn
	local checkfn = data.checkfn
    local datas = data.datas

	if (not datas[i]) then return data.callback() end
	if (not checkfn(datas[i])) then i = i + 1 return BreakableMessage(data, i) end

    startfn(i)
        while (datas[i]) do
			if (not checkfn(datas[i])) then i = i + 1 continue end
            net.WriteBool(true)
            writefn(i, datas[i])
            i = i + 1
            if (net.BytesWritten() >= max_per_interval) then
                break
            end
        end
        net.WriteBool(false)
    endfn()

    if (datas[i]) then
        timer.Simple(0, function()
            return BreakableMessage(data, i)
        end)
    else
        return data.callback()
    end
end