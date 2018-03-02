AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

SWEP.Weight					= 5		// Decides whether we should switch from/to this
SWEP.AutoSwitchTo				= false	// Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= false	// Auto switch from if you pick up a better weapon

function SIM_EnterVehicleHolster(ply,vehicle)
	if(vehicle) then
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) && string.find(wep:GetClass(),"weapon_fas") then
			wep:SetDTBool(0,true)
		end
end
end
hook.Add( "PlayerEnteredVehicle", "SIM_EnterVehicleHolster_Swedishfishisgood", SIM_EnterVehicleHolster )
