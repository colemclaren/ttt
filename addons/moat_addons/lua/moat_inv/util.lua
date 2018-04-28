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