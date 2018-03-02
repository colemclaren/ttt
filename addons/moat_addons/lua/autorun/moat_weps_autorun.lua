if (SERVER) then
	include "moat_weps/moat_weps_sv.lua"
	AddCSLuaFile "moat_weps/moat_weps_cl.lua"
else
	include "moat_weps/moat_weps_cl.lua"
end