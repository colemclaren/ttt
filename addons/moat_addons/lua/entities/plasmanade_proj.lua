AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "ttt_basegrenade_proj"
ENT.Model = Model("models/props/de_tides/vending_turtle.mdl")
ENT.HelloSound = Sound("weapons/mine_turtle/hello.wav")

AccessorFunc( ENT, "radius", "Radius", FORCE_NUMBER )

function ENT:Initialize()
	self.Hit = false
	self.HelloPlayed = false
	self.CurrentPitch = 100

	self:SetMaterial( "models/alyx/emptool_glow" )

--	self:SetModelScale(self:GetModelScale()*0.75,0)

	if SERVER then
		util.SpriteTrail(self, 0, Color(0,100,255), false, 32, 1, 0.3, 0.01, "trails/plasma.vmt")
	end

	self.WhirrSound = CreateSound(self, "ambient/energy/force_field_loop1.wav")
	self.WhirrSound:Play()

	if not self:GetRadius() then self:SetRadius(20) end

	return self.BaseClass.Initialize(self)
end

if CLIENT then
   function ENT:CreateSmoke(center)
      local em = ParticleEmitter(center)

      for i=1,24 do
			local smoke = em.Add("particle/particle_smokegrenade", vOrig)
			if (smoke) then
				smoke:SetColor(25, 125, 200)
				smoke:SetVelocity(VectorRand():GetNormal()*math.random(100, 300))
				smoke:SetRoll(math.Rand(0, 360))
				smoke:SetRollDelta(math.Rand(-2, 2))
				smoke:SetDieTime(1)
				smoke:SetLifeTime(0)
				smoke:SetStartSize(50)
				smoke:SetStartAlpha(255)
				smoke:SetEndSize(100)
				smoke:SetEndAlpha(0)
				smoke:SetGravity(Vector(0,0,0))
			end
			local smoke2 = em.Add("particle/particle_smokegrenade", vOrig)
			if (smoke2) then
				smoke2:SetColor(25, 125, 200)
				smoke2:SetVelocity(VectorRand():GetNormal()*math.random(50, 100))
				smoke2:SetRoll(math.Rand(0, 360))
				smoke2:SetRollDelta(math.Rand(-2, 2))
				smoke2:SetDieTime(5)
				smoke2:SetLifeTime(0)
				smoke2:SetStartSize(50)
				smoke2:SetStartAlpha(255)
				smoke2:SetEndSize(100)
				smoke2:SetEndAlpha(0)
				smoke2:SetGravity(Vector(0,0,0))
			end
			local smoke3 = em.Add("particle/particle_smokegrenade", vOrig+Vector(math.random(-150,150),math.random(-150,150),0))
			if (smoke3) then
				smoke3:SetColor(0, 25, 50)
				smoke3:SetVelocity(VectorRand():GetNormal()*math.random(50, 100))
				smoke3:SetRoll(math.Rand(0, 360))
				smoke3:SetRollDelta(math.Rand(-2, 2))
				smoke3:SetDieTime(5)
				smoke3:SetLifeTime(0)
				smoke3:SetStartSize(50)
				smoke3:SetStartAlpha(255)
				smoke3:SetEndSize(100)
				smoke3:SetEndAlpha(0)
				smoke3:SetGravity(Vector(0,0,0))
			end
			local heat = em.Add("sprites/heatwave", vOrig+Vector(math.random(-150,150),math.random(-150,150),0))
			if (heat) then
				heat:SetColor(0, 25, 50)
				heat:SetVelocity(VectorRand():GetNormal()*math.random(50, 100))
				heat:SetRoll(math.Rand(0, 360))
				heat:SetRollDelta(math.Rand(-2, 2))
				heat:SetDieTime(3)
				heat:SetLifeTime(0)
				heat:SetStartSize(100)
				heat:SetStartAlpha(255)
				heat:SetEndSize(0)
				heat:SetEndAlpha(0)
				heat:SetGravity(Vector(0,0,0))
			end
		end
		
		for i=1,72 do
			local sparks = em.Add("effects/spark", vOrig)
			if (sparks) then
				sparks:SetColor(0, 200, 255)
				sparks:SetVelocity(VectorRand():GetNormal()*math.random(300, 500))
				sparks:SetRoll(math.Rand(0, 360))
				sparks:SetRollDelta(math.Rand(-2, 2))
				sparks:SetDieTime(2)
				sparks:SetLifeTime(0)
				sparks:SetStartSize(3)
				sparks:SetStartAlpha(255)
				sparks:SetStartLength(15)
				sparks:SetEndLength(3)
				sparks:SetEndSize(3)
				sparks:SetEndAlpha(255)
				sparks:SetGravity(Vector(0,0,-800))
			end
			local sparks2 = em.Add("effects/spark", vOrig)
			if (sparks2) then
				sparks2:SetColor(0, 200, 255)
				sparks2:SetVelocity(VectorRand():GetNormal()*math.random(400, 800))
				sparks2:SetRoll(math.Rand(0, 360))
				sparks2:SetRollDelta(math.Rand(-2, 2))
				sparks2:SetDieTime(0.4)
				sparks2:SetLifeTime(0)
				sparks2:SetStartSize(5)
				sparks2:SetStartAlpha(255)
				sparks2:SetStartLength(80)
				sparks2:SetEndLength(0)
				sparks2:SetEndSize(5)
				sparks2:SetEndAlpha(0)
				sparks2:SetGravity(Vector(0,0,0))
			end
		end
		for i=1,8 do
			local flash = em.Add("effects/combinemuzzle2_dark", vOrig)
			if (flash) then
				flash:SetColor(255, 255, 255)
				flash:SetVelocity(VectorRand():GetNormal()*math.random(10, 30))
				flash:SetRoll(math.Rand(0, 360))
				flash:SetDieTime(0.10)
				flash:SetLifeTime(0)
				flash:SetStartSize(150)
				flash:SetStartAlpha(255)
				flash:SetEndSize(240)
				flash:SetEndAlpha(0)
				flash:SetGravity(Vector(0,0,0))		
			end
			local quake = em.Add("effects/splashwake3", vOrig)
			if (quake) then
				quake:SetColor(0, 175, 255)
				quake:SetVelocity(VectorRand():GetNormal()*math.random(10, 30))
				quake:SetRoll(math.Rand(0, 360))
				quake:SetDieTime(0.10)
				quake:SetLifeTime(0)
				quake:SetStartSize(160)
				quake:SetStartAlpha(200)
				quake:SetEndSize(270)
				quake:SetEndAlpha(0)
				quake:SetGravity(Vector(0,0,0))		
			end
			local wave = em.Add("sprites/heatwave", vOrig)
			if (wave) then
				wave:SetColor(0, 175, 255)
				wave:SetVelocity(VectorRand():GetNormal()*math.random(10, 30))
				wave:SetRoll(math.Rand(0, 360))
				wave:SetDieTime(0.25)
				wave:SetLifeTime(0)
				wave:SetStartSize(160)
				wave:SetStartAlpha(255)
				wave:SetEndSize(270)
				wave:SetEndAlpha(0)
				wave:SetGravity(Vector(0,0,0))
			end
		end
      em:Finish()
   end
end

function ENT:Explode(tr)
   if SERVER then
      self:SetNoDraw(true)
      self:SetSolid(SOLID_NONE)

      -- pull out of the surface
      if tr.Fraction != 1.0 then
         self:SetPos(tr.HitPos + tr.HitNormal * 0.6)
      end

      local pos = self:GetPos()

      self:Remove()
   else
      local spos = self:GetPos()
      local trs = util.TraceLine({start=spos + Vector(0,0,64), endpos=spos + Vector(0,0,-128), filter=self})
      util.Decal("SmallScorch", trs.HitPos + trs.HitNormal, trs.HitPos - trs.HitNormal)      

      self:SetDetonateExact(0)

      if tr.Fraction != 1.0 then
         spos = tr.HitPos + tr.HitNormal * 0.6
      end

      -- Smoke particles can't get cleaned up when a round restarts, so prevent
      -- them from existing post-round.
      if GetRoundState() == ROUND_POST then return end

      self:CreateSmoke(spos)
   end
end



function ENT:Think()
	if self.Hit then
		self.CurrentPitch = self.CurrentPitch + 5
		if self.WhirrSound then self.WhirrSound:ChangePitch(math.Clamp(self.CurrentPitch,100,255),0) end
		if self.Hit and not self.HelloPlayed then
			timer.Simple(0, function() if (IsValid(self)) then self:EmitSound(self.HelloSound,90,100) end end)
			self.HelloPlayed = true
		end
	end
	
	if self.Hit && self.Splodetimer && self.Splodetimer < CurTime() then
		util.ScreenShake( self:GetPos(), 50, 50, 1, 250 )
		if SERVER and IsValid(self.Owner) then
			if IsValid(self.Inflictor) then
				util.BlastDamage(self.Inflictor, self.Owner, self:GetPos(), 150, 88) 
			else
				util.BlastDamage(self, self.Owner, self:GetPos(), 150, 88) 
			end
		end
			
		local fx = EffectData()
		fx:SetOrigin(self:GetPos())
		util.Effect("plasmasplode", fx)
			
		self:EmitSound("ambient/energy/zap"..math.random(1,9)..".wav",90,100)
		self:EmitSound("ambient/explosions/explode_"..math.random(7,9)..".wav",90,100)
		self:EmitSound("weapons/explode"..math.random(3,5)..".wav",90,85)

		if (SERVER) then self:Remove() end
	end		
end

function ENT:Touch(ent)
	if IsValid(ent) && !self.Stuck then
		if ent:IsNPC() || (ent:IsPlayer() && ent != self:GetOwner()) || (ent == self:GetOwner() && self.SpawnDelay < CurTime() ) || ent:IsVehicle() then
			self:SetSolid(SOLID_NONE)
			self:SetMoveType(MOVETYPE_NONE)
			self:SetParent(ent)
			if !self.Splodetimer then
				self.Splodetimer = CurTime() + 2
			end
			self.Stuck = true
			self.Hit = true
		end
	end
end

function ENT:PhysicsCollide(data,phys)	
	if self:IsValid() && !self.Hit then
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		if !self.Splodetimer then
			self.Splodetimer = CurTime() + 2
		end
		self.Hit = true
	end	
end

function ENT:OnRemove()
	if self.WhirrSound then self.WhirrSound:Stop() end
	if IsValid(self.Fear) then self.Fear:Fire("kill") end

	return self.BaseClass.OnRemove(self)
end
