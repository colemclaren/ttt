AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

SWEP.Weight				= 30		// Decides whether we should switch from/to this
SWEP.AutoSwitchTo			= true		// Auto switch to 
SWEP.AutoSwitchFrom			= true		// Auto switch from

function SWEP:Initialize()
end

function SWEP:OnRemove()
end