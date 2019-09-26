function D3A.Print(Text)
	print(D3A.Alias .. " | " .. Text)
end

function D3A.IsEmpty(vector, ignore)
    ignore = ignore or {}

    local point = util.PointContents(vector)
    local a = point ~= CONTENTS_SOLID
        and point ~= CONTENTS_MOVEABLE
        and point ~= CONTENTS_LADDER
        and point ~= CONTENTS_PLAYERCLIP
        and point ~= CONTENTS_MONSTERCLIP
    if not a then return false end

    local b = true

    for k,v in pairs(ents.FindInSphere(vector, 35)) do
        if (v:IsNPC() or v:IsPlayer() or v:GetClass() == "prop_physics" or v.NotEmptyPos) and not table.HasValue(ignore, v) then
            b = false
            break
        end
    end

    return a and b
end

function D3A.FindEmptyPos(pos, ignore, distance, step, area)
    if D3A.IsEmpty(pos, ignore) and D3A.IsEmpty(pos + area, ignore) then
        return pos
    end

    for j = step, distance, step do
        for i = -1, 1, 2 do -- alternate in direction
            local k = j * i

            -- Look North/South
            if D3A.IsEmpty(pos + Vector(k, 0, 0), ignore) and D3A.IsEmpty(pos + Vector(k, 0, 0) + area, ignore) then
                return pos + Vector(k, 0, 0)
            end

            -- Look East/West
            if D3A.IsEmpty(pos + Vector(0, k, 0), ignore) and D3A.IsEmpty(pos + Vector(0, k, 0) + area, ignore) then
                return pos + Vector(0, k, 0)
            end

            -- Look Up/Down
            if D3A.IsEmpty(pos + Vector(0, 0, k), ignore) and D3A.IsEmpty(pos + Vector(0, 0, k) + area, ignore) then
                return pos + Vector(0, 0, k)
            end
        end
    end

    return pos
end


function D3A.FindPlayer(info, begin)
	if not info or info == "" then return nil end
	local pls = player.GetAll()

	for k = 1, #pls do -- Proven to be faster than pairs loop.
		local v = pls[k]
		if tonumber(info) == v:UserID() then
			return v
		end

		if info == v:SteamID64() then
			return v
		end

		if info == v:SteamID() then
			return v
		end
	
		local findname = string.find(string.lower(v:SteamName()), string.lower(tostring(info)), 1, true) 
		if (begin and findname and findname == 1) or (!begin and findname) then
			return v
		end

		findname = string.find(string.lower(v:Name()), string.lower(tostring(info)), 1, true)
		if (begin and findname and findname == 1) or (!begin and findname) then
			return v
		end
	end
	return nil
end

function D3A.WordWrap(font, text, width)
	if (!CLIENT) then return {} end
	surface.SetFont(font)
	
	local sw, sh = surface.GetTextSize(" ")
	local ret = {}
	
	local w = 0
	local s = ""
	for i, l in pairs(string.Explode("\n", text, false)) do
		for k, v in pairs(string.Explode(" ", l)) do
			local neww = surface.GetTextSize(v)
			
			if (w + neww >= width) then
				table.insert(ret, s)
				w = neww + sw
				s = v .. " "
			else
				s = s .. v .. " "
				w = w + neww + sw
			end
		end
		table.insert(ret, s)
		w = 0
		s = ""
	end
	
	table.insert(ret, s)
	
	return ret
end

function D3A.FormatTime(x, y)
	x = x or os.time()
	y = y or os.time()

	local diff = math.max(0, x - y)
	local str = " second"
	if (diff == 0) then return " a moment" end

	if (diff < 60) then
		return diff .. ((str and diff == 1) or (str .. "s"))
	elseif (diff < 3600) then
		local mins = math.Round(diff/60)
		str = " minute"

		return mins .. ((mins == 1 and str) or (str .. "s"))
	elseif (diff < 86400) then
		local hrs = math.Round(diff/3600)
		str = " hour"

		return hrs .. ((hrs == 1 and str) or (str .. "s"))
	else
		local days = math.Round(diff/86400)
		str = " day"

		return days .. ((days == 1 and str) or (str .. "s"))
	end

	return " a moment"
end

function D3A.FormatTimeSingle(x)
	return D3A.FormatTime(x, 0)
end

function D3A.FormatTimeNow(y)
	return D3A.FormatTime(os.time(), y)
end

function D3A.ParseSteamID(str)
	if (str:StartWith("7656")) then
		return str
	end

	str = str:upper()
	if (not str:StartWith("STEAM_")) then
		return false
	end

	str:Replace("STEAM_1", "STEAM_0")
	str = util.SteamIDTo64(str)
	return str
end