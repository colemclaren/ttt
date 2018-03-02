-- Generated from: glib/lua/glib/colors/color.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/colors/color.lua
-- Timestamp:      2016-02-22 19:22:23
CAC.Color = {}

local isnumber          = isnumber

local math_floor        = math.floor
local string_format     = string.format
local string_lower      = string.lower
local string_sub        = string.sub

local Color             = Color
local Vector            = Vector

local Vector___index    = debug.getregistry ().Vector.__index
local Vector___newindex = debug.getregistry ().Vector.__newindex

local colorsByName = {}
local colorNames   = {}

local CAC_Color_Clone    = nil
local CAC_Color_Copy     = nil
local CAC_Color_FromName = nil
local CAC_Color_GetName  = nil
local CAC_Color_ToArgb   = nil

function CAC.Color.Clone (color, clone)
	clone = clone or Color (255, 255, 255, 255)
	
	CAC_Color_Copy (clone, color)
	
	return clone
end

function CAC.Color.Copy (color, source)
	color.r = source.r
	color.g = source.g
	color.b = source.b
	color.a = source.a
	
	return color
end

function CAC.Color.FromColor (color, aOrOut, out)
	local a = nil
	
	if isnumber (aOrOut) then
		a = aOrOut
	else
		out = aOrOut
	end
	
	out = CAC_Color_Clone (color, out)
	out.a = a or 255
	
	return out
end

function CAC.Color.FromName (colorName)
	return colorsByName [string_lower (colorName)]
end

function CAC.Color.FromArgb (argb, out)
	out = out or Color (255, 255, 255, 255)
	out.a = math_floor (argb / 0x01000000)
	out.r = math_floor (argb / 0x00010000) % 256
	out.g = math_floor (argb / 0x00000100) % 256
	out.b =             argb               % 256
	
	return out
end

function CAC.Color.FromHtmlColor (htmlColor, aOrOut, out)
	local a = nil
	
	if isnumber (aOrOut) then
		a = aOrOut
	else
		out = aOrOut
	end
	
	local namedColor = CAC_Color_FromName (htmlColor)
	if namedColor then
		if out or a then
			out = out or Color (255, 255, 255, 255)
			CAC_Colors_Clone (namedColor, out)
			out.a = a or 255
		else
			out = namedColor
		end
	else
		-- #RRGGBB
		if string_sub (htmlColor, 1, 1) == "#" then
			htmlColor = string_sub (htmlColor, 2)
		end
		out = CAC.Color.FromRgb (tonumber (htmlColor, 16), a, out)
	end
	return out
end

function CAC.Color.FromRgb (rgb, aOrOut, out)
	local a = nil
	
	if isnumber (aOrOut) then
		a = aOrOut
	else
		out = aOrOut
	end
	
	out = out or Color (255, 255, 255, 255)
	out.a = a or 255
	out.r = math_floor (rgb / 0x00010000) % 256
	out.g = math_floor (rgb / 0x00000100) % 256
	out.b =             rgb               % 256
	
	return out
end

function CAC.Color.FromVector (v, aOrOut, out)
	local a = nil
	
	if isnumber (aOrOut) then
		a = aOrOut
	else
		out = aOrOut
	end
	
	out = out or Color (255, 255, 255, 255)
	out.r = Vector___index (v, "x") * 255
	out.g = Vector___index (v, "y") * 255
	out.b = Vector___index (v, "z") * 255
	out.a = a and (a * 255) or 255
	
	return out
end

function CAC.Color.GetName (color)
	return colorNames [CAC.Color.ToArgb (color)]
end

function CAC.Color.Lerp (t, color0, color1, out)
	out = out or Color (255, 255, 255, 255)
	
	out.r = t * color1.r + (1 - t) * color0.r
	out.g = t * color1.g + (1 - t) * color0.g
	out.b = t * color1.b + (1 - t) * color0.b
	out.a = t * color1.a + (1 - t) * color0.a
	
	return out
end

function CAC.Color.ToArgb (color)
	return color.a * 0x01000000 + color.r * 0x00010000 + color.g * 0x00000100 + color.b
end

function CAC.Color.ToHtmlColor (color)
	local colorName = CAC_Color_GetName (color)
	if colorName then return string_lower (colorName) end
	
	return string_format ("#%06X", CAC_Color_ToRgb (color))
end

function CAC.Color.ToRgb (color)
	return color.r * 0x00010000 + color.g * 0x00000100 + color.b
end

function CAC.Color.ToVector (color, out)
	out = out or Vector ()
	
	Vector___newindex (out, "x", color.r / 255)
	Vector___newindex (out, "y", color.g / 255)
	Vector___newindex (out, "z", color.b / 255)
	
	return out, color.a / 255
end

CAC_Color_Clone    = CAC.Color.Clone
CAC_Color_Copy     = CAC.Color.Copy
CAC_Color_FromName = CAC.Color.FromName
CAC_Color_GetName  = CAC.Color.GetName
CAC_Color_ToArgb   = CAC.Color.ToArgb
CAC_Color_ToRgb    = CAC.Color.ToRgb

-- Build indices
for colorName, color in pairs (CAC.Colors) do
	colorsByName [string_lower (colorName)] = color
	colorNames [CAC_Color_ToArgb (color)] = colorName
end