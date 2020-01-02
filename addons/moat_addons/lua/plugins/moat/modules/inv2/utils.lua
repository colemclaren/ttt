function mi.Log(str, err)
	if (not str) then MsgC(Color(0, 255, 0), "[MOAT] " .. "----------------------------------\n") return end
	if (SERVER and err) then ServerLog("[MOAT" .. ((err and " Failure!") or "") .. "] " .. str .. "\n") end
	MsgC(((err and Color(255, 0, 0)) or Color(0, 255, 0)), "[MOAT" .. ((err and " Failure!") or "") .. "] " .. str .. "\n")
end

function mi:BigLog(str)
	self.Log()
	self.Log(str)
	self.Log()
end

function mi.Print(str, b)
    MsgC(b and Color(255, 0, 0) or Color(255, 255, 0), "MOAT | " .. str .. "\n")
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
	if (self:IsBot()) then return "76561198050165746" end

	return self:SteamID64()
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