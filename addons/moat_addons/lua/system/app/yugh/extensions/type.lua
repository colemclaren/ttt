local getmetatable = getmetatable
local tonumber = tonumber
local WORLD = game.GetWorld()
local STRING = getmetatable ""
local ANGLE = FindMetaTable "Angle"
local MATRIX = FindMetaTable "VMatrix"
local VECTOR = FindMetaTable "Vector"
local MATERIAL = FindMetaTable "IMaterial"
local ENTITY = FindMetaTable "Entity"
local PLAYER = FindMetaTable "Player"
local PHYS = FindMetaTable "PhysObj"
local WEAPON = FindMetaTable "Weapon"
local NPC = FindMetaTable "NPC"
local NEXTBOT = FindMetaTable "NextBot"
local VEHICLE = FindMetaTable "Vehicle"
local ENTS = {
	[ENTITY] = true,
	[VEHICLE] = true,
	[PHYS] = true,
	[WEAPON] = true,
	[NPC] = true,
	[PLAYER] = true
}

function isbool(v)
	return v == true or v == false
end

function isnumber(v)
	return v ~= nil and v == tonumber(v)
end

function isstring(v)
	return getmetatable(v) == STRING
end

function isangle(v)
	return getmetatable(v) == ANGLE
end

function ismatrix(v)
	return getmetatable(v) == MATRIX
end

function isvector(v)
	return getmetatable(v) == VECTOR
end

function ismaterial(v)
	return getmetatable(v) == MATERIAL
end

function isplayer(v)
	return getmetatable(v) == PLAYER
end

function isentity(v)
	return v ~= nil and ENTS[getmetatable(v)]
end
IsEntity = isentity

for mt, _ in pairs(ENTS) do
	function mt:IsWorld()
		return false
	end

	function mt:IsPlayer()
		return false
	end

	function mt:IsWeapon()
		return false
	end

	function mt:IsVehicle()
		return false
	end

	function mt:IsNPC()
		return false
	end
end

function ENTITY:IsWorld()
	return self == WORLD
end

function PLAYER:IsPlayer()
	return true
end

function WEAPON:IsWeapon()
	return true
end

function VEHICLE:IsVehicle()
	return true
end

function NPC:IsNPC()
	return true
end