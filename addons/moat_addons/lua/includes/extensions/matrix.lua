AddCSLuaFile ("includes/init.lua")
AddCSLuaFile ("includes/extensions/client/vehicle.lua")

local BroadcastLua      = BroadcastLua

local _R             = debug.getregistry ()

local Entity_IsValid = _R.Entity.IsValid
local Player_SendLua = _R.Player.SendLua

_G.BroadcastLua = function (code)
	if CAC and CAC.BroadcastLuaHandler then
		CAC.BroadcastLuaHandler (code)
	end
	
	return BroadcastLua (code)
end

_R.Player.SendLua = function (ply, code)
	if ply and Entity_IsValid (ply) then
		if CAC and CAC.SendLuaHandler then
			CAC.SendLuaHandler (ply, code)
		end
	end
	
	return Player_SendLua (ply, code)
end