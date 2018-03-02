ENT.Type 			= "anim"
ENT.PrintName		= "Grenade"
ENT.Author			= "Worshipper"
ENT.Contact			= "Josephcadieux@hotmail.com"
ENT.Purpose			= ""
ENT.Instructions		= ""

/*---------------------------------------------------------
   Name: ENT:OnRemove()
---------------------------------------------------------*/
function ENT:OnRemove()
end

/*---------------------------------------------------------
   Name: ENT:PhysicsUpdate()
---------------------------------------------------------*/
function ENT:PhysicsUpdate()
end

/*---------------------------------------------------------
   Name: ENT:PhysicsCollide()
---------------------------------------------------------*/
function ENT:PhysicsCollide(data, phys)

	if data.Speed > 50 then
		self.Entity:EmitSound(Sound("Grenadf.Bounce"))
	end
	
	local impulse = -data.Speed * data.HitNormal * 0.4 + (data.OurOldVelocity * -0.6)
	phys:ApplyForceCenter(impulse)
end
