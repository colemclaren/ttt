local PLAYER = FindMetaTable "Player"
local ENTITY = FindMetaTable "Entity"
local ent_table = ENTITY.GetTable

function PLAYER:__index(k)
	if (PLAYER[k]) then
		return PLAYER[k]
	end

	if (ENTITY[k]) then
		return ENTITY[k]
	end

	return ent_table(self)[k]
end

local function SteamID(pl)
	return IsValid(pl) and pl:SteamID() or "???"
end

local function SteamID64(pl)
	return IsValid(pl) and pl:SteamID64() or "???"
end

local function IPAddress(pl)
	return IsValid(pl) and pl:IPAddress() or "0.0.0.0"
end

function Name(ply)
	return IsValid(ply) and ply:Nick() or "Player"
end

function PLAYER:NameInfo(str, split)
	str = str and " (" .. str .. ")" or ""

	if (split) then
		return Name(self), str
	end

	return Name(self) .. str
end

local NameInfo = PLAYER.NameInfo

function PLAYER:NameID(split)
	return NameInfo(self, SteamID(self), split)
end

function PLAYER:NameID64(split)
	return NameInfo(self, SteamID64(self), split)
end

function PLAYER:SteamURL()
	return "https://steamcommunity.com/profiles/" .. SteamID64(self)
end

function PLAYER:GetIP()
	return string(":"):Explode(self:IPAddress() or "0.0.0.0")[1]
end
