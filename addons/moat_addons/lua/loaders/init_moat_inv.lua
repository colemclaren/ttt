local dev_server = GetHostName():lower():find("dev")
if (not dev_server) then return end
if (true) then return end -- this is master branch anyways

if (SERVER) then
	AddCSLuaFile()
	AddCSLuaFile "moat_inv/init.lua"
end

include "moat_inv/init.lua"