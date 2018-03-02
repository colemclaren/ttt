// Flashbang entity originally made by Cheesylard but modified by me.

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local FLASH_INTENSITY = 4000

/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()

	self.Owner = self.Entity:GetOwner()
	self.Entity:SetNWBool("Explode", false)

	self.Entity:SetModel("models/weapons/b_flashbang.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	// Don't collide with the player
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end
end

/*---------------------------------------------------------
   Name: ENT:Explode()
---------------------------------------------------------*/
function ENT:Explode()

	self.Entity:EmitSound(Sound("Weapof_Flashbang.Explode"))

	for _, pl in pairs(player.GetAll()) do

		//local ang = (self.Entity:GetPos() - pl:GetShootPos()):GetNormal():Angle()
		local ANG_1 = (self:GetPos() - pl:EyePos())
		local ANG_2 = ANG_1:GetNormal()
		local ANG_3 = ANG_2:Angle()

		local tracedata = {}

		tracedata.start = pl:GetShootPos()
		tracedata.endpos = self.Entity:GetPos()
		tracedata.filter = pl
		local tr = util.TraceLine(tracedata)

		if (!tr.HitWorld) then
			local dist = pl:GetShootPos():Distance(self.Entity:GetPos())  
			local endtime = FLASH_INTENSITY / (dist * 2)

			if (endtime > 6) then
				endtime = 6
			elseif (endtime < 1) then
				endtime = 0
			end

			simpendtime = math.floor(endtime)
			tenthendtime = math.floor((endtime - simpendtime) * 10)

			pl:SetNetworkedFloat("FLASHED_END", endtime + CurTime())

			pl:SetNetworkedFloat("FLASHED_END_START", CurTime())
		end
	end

	self.Entity:Remove()
end

/*---------------------------------------------------------
   Name: ENT:OnTakeDamage()
---------------------------------------------------------*/
function ENT:OnTakeDamage()
end

/*---------------------------------------------------------
   Name: ENT:Use()
---------------------------------------------------------*/
function ENT:Use()
end

/*---------------------------------------------------------
   Name: ENT:StartTouch()
---------------------------------------------------------*/
function ENT:StartTouch()
end

/*---------------------------------------------------------
   Name: ENT:EndTouch()
---------------------------------------------------------*/
function ENT:EndTouch()
end

/*---------------------------------------------------------
   Name: ENT:Touch()
---------------------------------------------------------*/
function ENT:Touch()
end