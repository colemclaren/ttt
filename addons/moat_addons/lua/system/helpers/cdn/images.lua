function cdn.Image(key, cb, params)
	if (cdn.Cache[key] == nil) then
		return cdn.Fetch(key, "materials", key:match"(%.[^%.]+)$", function(object)
			return (not key:match "vtf$") and RealMaterial("../data/" .. object, (type(cb) == "string") and cb or params) or "../data/" .. object
		end, function(object, data)
			return file.Write(object, data)
		end, cb)
	end

	return cdn.Cache[key]
end

local white = Color(255, 255, 255)
function cdn.DrawImage(key, x, y, w, h, color, params)
	key = cdn.Image(key, nil, params)
	if (not key) then return end

	color = color or white

	surface.SetDrawColor(color.r, color.g, color.b, color.a)
	surface.SetMaterial(key)
	surface.DrawTexturedRect(x, y, w, h)
end

function cdn.DrawImageRotated(key, x, y, w, h, color, ang, origin, params)
	key = cdn.Image(key, nil, params)
	if (not key) then return end

	color = color or white

	surface.SetDrawColor(color.r, color.g, color.b, color.a)
	surface.SetMaterial(key)
	
	if (origin) then
		surface.DrawTexturedRectRotated(x + w/2, y + h/2, w, h, ang)
	else
		surface.DrawTexturedRectRotated(x, y, w, h, ang)
	end
end

function cdn.SmoothImage(key, x, y, w, h, color)
	return cdn.DrawImage(key, x, y, w, h, color, "noclamp smooth")
end

function cdn.SmoothImageRotated(key, x, y, w, h, color, ang, origin)
	return cdn.DrawImageRotated(key, x, y, w, h, color, ang, origin, "noclamp smooth")
end