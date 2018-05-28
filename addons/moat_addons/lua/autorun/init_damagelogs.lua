if (true) then return end

if (SERVER) then
	AddCSLuaFile()
	AddCSLuaFile "dlogs/init.lua"
end

include "dlogs/init.lua"