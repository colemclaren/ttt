local surface_DrawTexturedRectRotated = surface.DrawTexturedRectRotated
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
local white = Color(255, 255, 255)

function cdn.DrawImage(key, x, y, w, h, color, params)
	key = cdn.Image(key, nil, params)
	if (not key) then return end

	color = color or white

	surface_SetDrawColor(color.r, color.g, color.b, color.a)
	surface_SetMaterial(key)
	surface_DrawTexturedRect(x, y, w, h)
end

function cdn.SmoothImage(key, x, y, w, h, color)
	return cdn.DrawImage(key, x, y, w, h, color, "noclamp smooth")
end

function cdn.DrawImageRotated(key, x, y, w, h, color, ang, origin, params)
	key = cdn.Image(key, nil, params)
	if (not key) then return end

	color = color or white

	surface_SetDrawColor(color.r, color.g, color.b, color.a)
	surface_SetMaterial(key)
	
	if (origin) then
		surface_DrawTexturedRectRotated(x + w/2, y + h/2, w, h, ang)
	else
		surface_DrawTexturedRectRotated(x, y, w, h, ang)
	end
end

function cdn.SmoothImageRotated(key, x, y, w, h, color, ang, origin)
	return cdn.DrawImageRotated(key, x, y, w, h, color, ang, origin, "noclamp smooth")
end