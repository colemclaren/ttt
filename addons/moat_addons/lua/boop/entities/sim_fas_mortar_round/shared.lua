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
function ENT:PhysicsCollide(data, physobj)
	
	local Ent = data.HitEntity
	if !(ValidEntity(Ent) or Ent:IsWorld()) then return end
	
	if data.Speed > 50 then
		self.Entity:EmitSound(Sound("Grenadf.Hit"))
	end
	
	if not self.Explode then
		if (Ent:IsPlayer() or Ent:IsNPC() or Ent:GetClass() == "prop_ragdoll") and self.Timer > CurTime() then
			local effectdata = EffectData()
			effectdata:SetStart(data.HitPos)
			effectdata:SetOrigin(data.HitPos)
			effectdata:SetScale(1)
			util.Effect("BloodImpact", effectdata)
			Ent:TakeDamage(50, self:GetOwner())
		end
		self.Entity:Fire("kill", "", 5)
		self.Entity:SetNWBool("Explode", true)
		self.Timer = CurTime() + 100
		self.Explode = false
		self:Disable()
		return 
	end

	self.Explode = false

	util.Decal("Scorch", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal) 

	self:Explosion()
	self.Entity:Remove()
end