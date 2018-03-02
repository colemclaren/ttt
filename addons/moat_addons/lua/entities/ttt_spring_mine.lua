if SERVER then

	AddCSLuaFile()

/*	resource.AddFile("sound/weapons/boing.wav")

	resource.AddFile("materials/vgui/ttt/icon_springmine.png")
*/
end



ENT.Icon = "vgui/ttt/icon_springmine.png"

ENT.Type = "anim"

ENT.Projectile = true

ENT.CanHavePrints = true



ENT.WarningSound = Sound("weapons/boing.wav")



ENT.Height = 800 



ENT.Model = Model("models/props_phx/smallwheel.mdl")

ENT.Material = Material("models/debug/debugwhite")

ENT.Color = Color(0,0,0,255)



function ENT:Initialize()	

   self:SetModel(self.Model)

   self:SetMaterial(self.Material)

   self:SetColor(self.Color)

   

   self:PhysicsInit(SOLID_VPHYSICS)

   

   self:SetHealth(25)

   

   return self.BaseClass.Initialize(self)

end



function ENT:Boing(ply)

	if SERVER then

		local pos = self.Entity:GetPos()

				

		self:EmitSound(self.WarningSound, 500)

		if !self:IsValid() then return end

			

		if ply:IsValid() then

			ply:SetVelocity(Vector(ply:GetVelocity().x, ply:GetVelocity().y, self.Height))

			 ply.was_pushed = {att=self.Owner, t=CurTime(), infl=self}

		end

				

		self:Remove()

	end

end



ENT.touched = false

function ENT:StartTouch(ent)

	if self.touched then return end

	

	if (ent:IsValid() and ent:IsPlayer() and ent:Team() ~= TEAM_SPEC) then

		self.touched = true

		self:Boing(ent)

	end

end



if SERVER then



	local zapsound = Sound("npc/assassin/ball_zap1.wav")

	function ENT:OnTakeDamage( dmginfo )

	   if dmginfo:GetAttacker() == self:GetOwner() then return end



	   self:TakePhysicsDamage(dmginfo)



	   self:SetHealth(self:Health() - dmginfo:GetDamage())

	   if self:Health() < 0 then

		  self:Remove()



		  local effect = EffectData()

		  effect:SetOrigin(self:GetPos())

		  util.Effect("cball_explode", effect)

		  sound.Play(zapsound, self:GetPos())



		  if IsValid(self:GetOwner()) then

			 TraitorMsg(self:GetOwner(), "YOUR SPRINGMINE HAS BEEN DESTROYED!")

		  end

	   end

	end

	

end