local math_huge = math.huge

local Vector___index = debug.getregistry ().Vector.__index
local Angle___index  = debug.getregistry ().Angle.__index

function VA.IsFinite (x)
	if x ~= x then return false end
	
	if x == math_huge then return false end
	if x == -math_huge then return false end
	
	return true
end

VA.Vector = VA.Vector or {}

local VA_IsFinite = VA.IsFinite

function VA.Vector.IsFinite (v)
	return VA_IsFinite (Vector___index (v, 1)) and
	       VA_IsFinite (Vector___index (v, 2)) and
		   VA_IsFinite (Vector___index (v, 3))
end

function VA.Vector.IsSanePosition (v)
	local v1 = Vector___index (v, 1)
	local v2 = Vector___index (v, 2)
	local v3 = Vector___index (v, 3)
	
	return -16384 <= v1 and v1 <= 16483 and
	       -16384 <= v2 and v2 <= 16483 and
	       -16384 <= v3 and v3 <= 16483
end

VA.Angle = VA.Angle or {}

local VA_IsFinite = VA.IsFinite

function VA.Angle.IsFinite (a)
	return VA_IsFinite (Angle___index (a, 1)) and
	       VA_IsFinite (Angle___index (a, 2)) and
		   VA_IsFinite (Angle___index (a, 3))
end

function VA.Angle.IsSane (a)
	local a1 = Angle___index (a, 1)
	local a2 = Angle___index (a, 2)
	local a3 = Angle___index (a, 3)
	
	return -360 <= a1 and a1 <= 360 and
	       -360 <= a2 and a2 <= 360 and
	       -360 <= a3 and a3 <= 360
end
