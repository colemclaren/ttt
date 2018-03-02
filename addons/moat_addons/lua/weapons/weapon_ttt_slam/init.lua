AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

//resource.AddWorkshop("254177306")

function SWEP:Think()
	self:ChangeAnimation()

	self:NextThink(CurTime() + 0.25)
	return true
end
