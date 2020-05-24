-- Modified from https://github.com/SuperiorServers/dash/blob/master/lua/dash/extensions/color.lua (t o o l a z y)

local tonumber 		= tonumber
local string_format = string.format
local string_match 	= string.match
local bit_band		= bit.band
local bit_rshift 	= bit.rshift
local Lerp 			= Lerp

local COLOR = FindMetaTable 'Color'

function Color(r, g, b, a)
	return setmetatable({
		r = tonumber(r) or 255,
		g = tonumber(g) or 255,
		b = tonumber(b) or 255,
		a = tonumber(a) or 255
	}, COLOR)
end

function COLOR:Copy()
	return Color(self.r, self.g, self.b, self.a)
end

function COLOR:Unpack()
	return self.r, self.g, self.b, self.a
end

function COLOR:SetHex(hex)
	local r, g, b = string_match(hex, '#(..)(..)(..)')
	self.r, self.g, self.b = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)

	return self
end

function COLOR:ToHex()
	return string_format('#%02X%02X%02X', self.r, self.g, self.b)
end

function COLOR:SetEncodedRGB(num)
	self.r, self.g, self.b = bit_band(bit_rshift(num, 16), 0xFF), bit_band(bit_rshift(num, 8), 0xFF), bit_band(num, 0xFF)

	return self
end

function COLOR:ToEncodedRGB()
	return (self.r * 0x100 + self.g) * 0x100 + self.b
end

function COLOR:SetEncodedRGBA(num)
	self.r, self.g, self.b, self.a = bit_band(rshift(num, 16), 0xFF), bit_band(rshift(num, 8), 0xFF), bit_band(num, 0xFF), bit_band(rshift(num, 24), 0xFF)

	return self
end

function COLOR:ToEncodedRGBA()
	return ((self.a * 0x100 + self.r) * 0x100 + self.g) * 0x100 + self.b
end

function COLOR:Lerp(frac, from, to)
	self.r, self.g, self.b, self.a = Lerp(frac, from.r, to.r), Lerp(frac, from.g, to.g), Lerp(frac, from.b, to.b), Lerp(frac, from.a, to.a)

	return self
end

function COLOR:Alpha(n)
	self.a = n

	return self
end

moat_black = Color(0, 0, 0, 255)
moat_white = Color(255, 255, 255, 255)
moat_dark = Color(21, 30, 47, 255)
moat_light = Color(240, 245, 253, 255)
moat_lyanblue = Color(103, 152, 235, 255)
moat_blue = Color(94, 114, 228, 255)
moat_lime = Color(0, 255, 0, 255)
moat_green = Color(1, 255, 31, 255) -- Color(45, 206, 137, 255)
moat_red = Color(253, 11, 48, 255) -- Color(245, 54, 92, 255)
moat_orange = Color(251, 99, 64, 255)
moat_indigo = Color(155, 61, 255, 255) -- Color(86, 3, 173, 255)
moat_purple = Color(203, 61, 255, 255) -- Color(137, 101, 224, 255)
moat_pink = Color(255, 47, 152, 255) -- Color(243, 164, 181, 255)
moat_yellow = Color(255, 214, 0, 255)
moat_teal = Color(43, 255, 198, 255) -- Color(17, 205, 239, 255)
moat_cyan = Color(0, 182, 255, 255) -- Color(43, 255, 198, 255)

neon_white = Color(255, 255, 255, 255)
neon_green = Color(0, 255, 0, 255)
neon_blue = Color(51, 153, 255, 255)
neon_cyan = Color(0, 200, 255, 255)
neon_pink = Color(255, 0, 255, 255)
neon_red = Color(255, 0, 0, 255)
neon_yellow = Color(255, 255, 0)

-- todo
-- rarity_extinct = Color(255, 255, 255, 255)
-- rarity_cosmic = Color(0, 255, 0, 255)
-- rarity_ascended = Color(51, 153, 255, 255)
-- rarity_highend = Color(0, 200, 255, 255)
-- rarity_superior = Color(255, 0, 255, 255)
-- rarity_specialized = Color(255, 0, 0, 255)
-- rarity_standard = Color(255, 255, 0)
-- rarity_worn = Color(255, 255, 0)
-- rarity_stock = Color(255, 255, 0)
