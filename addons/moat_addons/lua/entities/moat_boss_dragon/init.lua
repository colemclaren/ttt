AddCSLuaFile "cl_init.lua"
AddCSLuaFile "shared.lua" 
include "shared.lua"

ENT.Boss = NULL
ENT.BossExists = false
ENT.Alerted = false
ENT.bleeds = 1
ENT.StartHealth = 5200
ENT.PlayerFriendly = 0
ENT.AttackingMelee = false
ENT.State = 0
ENT.BreathTime = 0
ENT.RoarTime = 0
ENT.FlameDelay = 0
ENT.Enemy = NULL
ENT.BreathTime = 0
ENT.Dead = false
ENT.DestAlt = 750
ENT.fireball_toggle = false
ENT.MinChaseDistance = 1500
ENT.MinMeleeDistance = 650
ENT.MinRangeDistance = 2000
ENT.MinFloatDistance = 1000
ENT.MeleeAttacking = false
ENT.MeleeDamage = 150
ENT.MeleeTime = 0
ENT.MELEE_SEQ = 14
ENT.dodgeleft = true
ENT.STATE = "idle"
ENT.FlameDelay = 0
ENT.AnimTime = 0
ENT.RoarDelay = 0
ENT.CONTROL = nil
ENT.Ultimate = false
ENT.UltDelay = -1
ENT.UltReady = false
ENT.CanShoot = true
ENT.MoveForward = false
ENT.MoveBack = false 
ENT.MoveLeft = false
ENT.MoveRight = false
ENT.MoveUp = false
ENT.MoveDown = false 
ENT.BossAttack = false 
ENT.BossAttack2 = false 
ENT.SpeedUp = false 
ENT.MaxAng = 0
ENT.MaxAngS = 25
ENT.MaxAngB = 5
ENT.MaxSpeed = 30
ENT.MaxSpeedB = 30
ENT.MaxAccel = 4
ENT.MaxHealth = 100
ENT.Accel = 1
ENT.Speed = 0
ENT.Gravity = 1.8
ENT.fa = 0
ENT.ra = 0

function ENT:Initialize()
	self:SetHullSizeNormal()
	self:SetModel "models/moat/dragon.mdl"
	self:SetHullType(HULL_LARGE)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetPos(self:GetPos() + Vector(0, 0, 500))
	self.Entity:PhysicsInitBox(Vector(-200, -180, -120), Vector(200, 180, 120))
	self:SetHealth(self.StartHealth)

	self.Enemy = NULL
	self.FlameDelay = CurTime() + 10

	local phys = self.Entity:GetPhysicsObject()
	if (IsValid(phys)) then
		phys:Wake()
		phys:EnableGravity(false)
		phys:SetMass(phys:GetMass() / 3)
	end

	self:SetElasticity(0)
end

function ENT:SetBoss(pl, hp)
	self.Boss = pl
	self.MaxHealth = hp or pl:GetMaxHealth()
	self.BossExists = IsValid(pl)
	self.STATE = "idle"
	self:UpdateSequence()
end

function ENT:UpdateSequence()
	if (self.STATE == "idle") then
		self:SetSequence(2)
	elseif (self.STATE == "shoot") then
		self:SetSequence(12)
	elseif (self.STATE == "melee") then
		self:SetSequence(17)
	elseif (self.STATE == "move") then
		self:SetSequence(7)
	elseif (self.STATE == "move_slow") then
		self:SetSequence(2)
	end
end

function ENT:ChangeState(state, time)
	if (self.STATE == state or self.STATE == "shoot" or self.STATE == "melee") then
		return false
	end

	self.STATE = state
	self:UpdateSequence()

	self.AnimTime = CurTime() + (time or self:SequenceDuration())

	return true
end

function ENT:HandleAnimations()
	self:UpdateSequence()

	if (self.AnimTime > CurTime()) then
		return
	end

	if (self.STATE == "shoot" or self.STATE == "melee") then
		self.STATE = "idle"
		self.AnimTime = CurTime() + 10
	end
end

function ENT:BossThink(pl)
	if (not IsValid(pl)) then
		return
	end

	if (self:Health() > self.Boss:Health()) then
		self:SetHealth(self.Boss:Health())
	end

	if (self:Health() < self.MaxHealth / 2) then
		self.UltReady = true
	end

	if (self.UltReady and self.UltDelay <= CurTime() and not self.Ultimate) then
		self:SetNetworkedBool("ULTIMATE_ATTACK", true)
		self.Ultimate = true
	end
end

function ENT:BossControls(pl)
	if (IsValid(pl)) then
		pl:SetNoDraw(true)
		pl:SetPos(self:GetPos())
		pl.radar_charge = 0
		pl:StripWeapons()
	else
		if (self.BossExists) then
			self:SetHealth(0)
			self:Die()
		end

		return
	end

	if (pl:KeyDown(IN_SPEED)) then
		self.SpeedUp = true
	elseif (self.SpeedUp) then
		self.SpeedUp = false
	end

	if (pl:KeyDown(IN_FORWARD)) then
		self.MoveForward = true
	elseif (self.MoveForward) then
		self.MoveForward = false
	end

	if (pl:KeyDown(IN_BACK)) then
		self.MoveBack = true
	elseif (self.MoveBack) then
		self.MoveBack = false
	end

	if (pl:KeyDown(IN_MOVELEFT)) then
		self.MoveLeft = true
	elseif (self.MoveLeft) then
		self.MoveLeft = false
	end

	if (pl:KeyDown(IN_MOVERIGHT)) then
		self.MoveRight = true
	elseif (self.MoveRight) then
		self.MoveRight = false
	end

	if (pl:KeyDown(IN_JUMP)) then
		self.MoveUp = true
	elseif (self.MoveUp) then
		self.MoveUp = false
	end

	if (pl:KeyDown(IN_DUCK)) then
		self.MoveDown = true
	elseif (self.MoveDown) then
		self.MoveDown = false
	end

	if (pl:KeyDown(IN_ATTACK)) then
		self.BossAttack = true

		if (self.BossAttack2 and self.UltReady and self.Ultimate) then
			self:EmitSound("moat/dragon/flameroar1.wav", 500, 100)
			self:ShootUltimate(pl:EyeAngles():Forward())
			self:ChangeState("shoot", 1.8)
			
			self.CanShoot = false
			timer.Simple(2, function() if (IsValid(self)) then self.CanShoot = true end end)
		end
	elseif (self.BossAttack) then
		self.BossAttack = false

		if (self.CanShoot) then
			self:ShootFire(pl)
		end
	end

	if (pl:KeyDown(IN_ATTACK2)) then
		self.BossAttack2 = true

		if (self.BossAttack and self.UltReady and self.Ultimate) then
			self:EmitSound("moat/dragon/flameroar1.wav", 500, 100)
			self:ShootUltimate(pl:EyeAngles():Forward())
			self:ChangeState("shoot", 1.8)
			
			self.CanShoot = false
			timer.Simple(2, function() if (IsValid(self)) then self.CanShoot = true end end)
		end
	elseif (self.BossAttack2) then
		self.BossAttack2 = false

		if (self.CanShoot) then
			self:EmitSound("moat/dragon/flameroar1.wav", 500, 100)
			self:ShootFireball2(pl:EyeAngles():Forward())
			self:ChangeState("shoot", 1.8)
			
			if (self.RoarDelay < CurTime()) then
				self:EmitSound("moat/dragon/roar" .. math.random(2) .. ".wav", 500, 100)

				local shake = ents.Create "env_shake"
				shake:SetPos(self:GetPos())
				shake:SetKeyValue("amplitude", "12")
				shake:SetKeyValue("radius", "4000")
				shake:SetKeyValue("duration", "3")
				shake:SetKeyValue("frequency", "128")
				shake:Fire("StartShake", 0, 0)

				self.RoarDelay = CurTime() + 10
			end
		end
	end

	if (pl:KeyDown(IN_USE) and self.STATE ~= "melee" and self.CanShoot) then
		self:ClawAttack()
	end

	local phys = self:GetPhysicsObject()
	if (not IsValid(phys)) then
		return
	end

	local a = pl:EyeAngles()
	local v = phys:GetVelocity()

	if (self.MoveForward) then
		if (self.fa > self.MaxAng) then
			self.fa = self.MaxAng
		end

		if (self.Speed < self.MaxSpeed) then
			self.Speed = self.Speed + self.Accel
		end

		if (self.Accel < self.MaxAccel) then
			self.Accel = self.Accel + (self.MaxAccel / 20)
		else
			self.Accel = self.MaxAccel
		end

		a.p = a.p + self.fa
	elseif (self.MoveBack) then
		self:ChangeState "idle"

		if (self.fa > 0) then
			self.fa = self.fa - (self.MaxAng / 25)
			a.p = a.p + self.fa

			if (self.fa <= 0) then
				self.fa = 0
			end
		end

		if (self.Speed > 0) then
			self.Speed = self.Speed - (self.MaxSpeed / 100)
		else
			self.Speed = 0
		end

		if (self.Accel > 1) then
			self.Accel = self.Accel - (self.MaxAccel / 20)
		else
			self.Accel = 1
		end
	end

	if (self.MoveBack) then
		self:ChangeState "idle"

		if (self.fa > -self.MaxAngB) then
			self.fa = self.fa - (self.MaxAngB / 25)
		else
			self.fa = -self.MaxAngB
		end

		if (self.Speed > -self.MaxSpeedB) then
			self.Speed = self.Speed - self.Accel
		end

		if (self.Accel < self.MaxAccel) then
			self.Accel = self.Accel + (self.MaxAccel / 20)
		else
			self.Accel = self.MaxAccel
		end

		a.p = a.p + self.fa
	elseif (not self.MoveForward) then
		self:ChangeState "idle"

		if (self.fa < 0) then
			self.fa = self.fa + self.MaxAngB / 35
			a.p = a.p + self.fa

			if (self.fa >= 0) then
				self.fa = 0
			end
		end

		if (self.Speed < 0) then
			self.Speed = self.Speed + (self.MaxSpeed / 100)
		else
			self.Speed = 0
		end

		if (self.Accel > 1) then
			self.Accel = self.Accel - (self.MaxAccel / 20)
		else
			self.Accel = 1
		end
	end

	if (self.MoveLeft) then
		if (self.ra > -self.MaxAngS) then
			self.ra = self.ra - self.MaxAngS / 25
		else
			self.ra = -self.MaxAngS
		end

		a.r = a.r + self.ra
	elseif (self.MoveRight) then
		if (self.ra < self.MaxAngS) then
			self.ra = self.ra + self.MaxAngS / 25
		else
			self.ra = self.MaxAngS
		end

		a.r = a.r + self.ra
	else
		if (self.ra < 0) then
			self.ra = self.ra + self.MaxAngS / 25

			if (self.ra > 0) then
				self.ra = 0
			end

			a.r = a.r + self.ra
		elseif (self.ra > 0) then
			self.ra = self.ra - self.MaxAngS / 25

			if (self.ra <= 0) then
				self.ra = 0
			end

			a.r = a.r + self.ra
		end
	end

	local sc = math.Clamp(self:GetModelScale() * 2, .95, 1)
	self:SetAngles(Angle(math.Clamp(a.p, -30, 80), a.y, a.r))
	phys:SetVelocity(v * sc)

	if (self.MoveForward) then
		phys:SetVelocity(phys:GetVelocity() + pl:EyeAngles():Forward() * self.Speed * sc)
	end

	if (self.MoveBack) then
		phys:SetVelocity(phys:GetVelocity() + pl:EyeAngles():Forward() * self.Speed * sc)
	end	

	if (self.MoveLeft) then
		phys:AddVelocity(self:GetRight() * -15 * sc)
	end

	if (self.MoveRight) then
		phys:AddVelocity(self:GetRight() * 15 * sc)
	end

	if (not self.MoveUp and not self.MoveDown and not self:IsOnGround()) then
		phys:AddVelocity(Angle(0, 90, 0):Up() * -self.Gravity * sc)
	elseif (self.MoveUp) then
		phys:AddVelocity(Angle(0, 90, 0):Up() * (self.Gravity + 10) * sc)
	end

	local vel = phys:GetVelocity()
	phys:SetVelocity(Vector(math.Clamp(vel.x, -760, 760), math.Clamp(vel.y, -760, 760), math.Clamp(vel.z, -760, 760)))

	if (self.SpeedUp) then
		local vec = phys:GetVelocity()
		phys:AddVelocity(Vector((vec.x * -1) * .01, (vec.y * -1) * .01, (vec.z * -1) * .01))
	end

	local vec = phys:GetVelocity()
	if (math.abs(math.Round(vec.x)) >= 760 or math.abs(math.Round(vec.y)) >= 760 or math.abs(math.Round(vec.z)) >= 760) then
		if (a.p <= -40) then
			self:ChangeState "move_slow"
		elseif (not self.MoveUp) then
			self:ChangeState "move"
		elseif (self.MoveForward) then
			self:ChangeState "move_slow"
		end
	elseif (self.MoveForward) then
		self:ChangeState "move_slow"
	end
end

function ENT:Think()
	self:HandleAnimations()

	if (IsValid(self.Boss)) then
		self:BossThink(self.Boss)
		self:BossControls(self.Boss)
	end

	if (self.RoarTime < CurTime() and self:Health() > 0) then
		self:EmitSound("moat/dragon/roar" .. math.random(2) .. ".wav", 500, 100)

		local shake = ents.Create "env_shake"
		shake:SetPos(self:GetPos())
		shake:SetKeyValue("amplitude", "12")
		shake:SetKeyValue("radius", "4000")
		shake:SetKeyValue("duration", "3")
		shake:SetKeyValue("frequency", "128")
		shake:Fire("StartShake", 0, 0)

		self.RoarTime = CurTime() + math.random(30, 45)
	end

	self:NextThink(CurTime())

	return true
end

function ENT:ShootFireball(dir)
	dir:Normalize()

	local fireball = ents.Create "moat_proj_fireball"
	if (not IsValid(fireball)) then
		return
	end
	local sc = math.Clamp(self:GetModelScale(), .25, 1)
	fireball.shotByDragon = true
	fireball.ModelScale = sc
	
	fireball:SetPos(self:LocalToWorld(Vector(240 * sc, 0, 50 * sc)))
	fireball:SetModelScale(sc ~= 1 and sc * .5 or sc, 0)
	fireball:SetAngles(dir:Angle())
	fireball:SetOwner(self)
	fireball:Spawn()
	fireball:Activate()

	local phys = fireball:GetPhysicsObject()
	if (IsValid(phys)) then
		phys:ApplyForceCenter(dir * 8500 * math.Clamp(sc, .5, 1))
	end

	self:EmitSound("moat/dragon/flame1.wav", 500, 100)
end

function ENT:ShootFireball2(dir)
	dir:Normalize()

	local fireball = ents.Create "moat_proj_fireball"
	if (not IsValid(fireball)) then
		return
	end

	local sc = math.Clamp(self:GetModelScale(), .25, 1)
	fireball.shotByDragon = true
	fireball.ModelScale = sc
	
	fireball:SetPos(self:LocalToWorld(Vector(240 * sc, 0, 50 * sc)))
	fireball:SetModelScale(2 * sc, 0)
	fireball:SetAngles(dir:Angle())
	fireball:SetOwner(self)
	fireball:Spawn()

	local phys = fireball:GetPhysicsObject()
	if (IsValid(phys)) then
		phys:ApplyForceCenter(dir * 8500 * 1)
	end

	self:EmitSound("moat/dragon/flame1.wav", 500, 100)
end

function ENT:ShootUltimate(dir)
	if (not self.Ultimate) then
		return
	end
	
	self.UltDelay = CurTime() + 20
	self:SetNetworkedInt("ULTIMATE_RECHARGE", self.UltDelay)
	self:SetNetworkedInt("ServTime", CurTime())
	self:SetNetworkedBool("ULTIMATE_ATTACK", false)
	self.Ultimate = false

	dir:Normalize()

	local fireball = ents.Create "moat_proj_fireball"
	if (not IsValid(fireball)) then
		return
	end

	fireball.shotByDragon = true
	fireball.ModelScale = 1
	
	fireball:SetPos(self:LocalToWorld(Vector(240, 0, 50)))
	fireball:SetModelScale(10, 0)
	fireball:SetAngles(dir:Angle())
	fireball:SetOwner(self)
	fireball:Activate()
	fireball:Spawn()

	local phys = fireball:GetPhysicsObject()
	if (IsValid(phys)) then
		phys:ApplyForceCenter(dir * 5000)
	end

	self:EmitSound("moat/dragon/flame1.wav", 500, 100)
end

function ENT:ShootFire(pl)
	if (self.FlameDelay > CurTime()) then
		return
	end

	self.FlameDelay = CurTime() + .8
	self:ChangeState("shoot", 1.8)

	for i = 1, 13 do
		timer.Simple(1.05 + (i * .05), function()
			if (IsValid(self) and IsValid(pl)) then self:ShootFireball(pl:EyeAngles():Forward()) end
		end)
	end

	self:EmitSound("moat/dragon/flameroar1.wav", 500, 100)
end

function ENT:ClawAttack()
	if (not self:ChangeState("melee", 1.6)) then
		return
	end

	timer.Simple(1, function()
		for _, pl in pairs(ents.FindInCone(self:GetPos(), self:GetOwner():GetAimVector(), 310, 40)) do
			if (IsValid(pl) and pl:IsPlayer() and pl:Team() ~= TEAM_SPEC and pl ~= self.Boss) then
				local push = Angle(0, self:GetAngles().y, 0):Forward() * 600
				push.z = math.max(push.z, 100)
				pl:SetGroundEntity(nil)
				pl:SetLocalVelocity(pl:GetVelocity() + push)

				local dmg = DamageInfo()
				dmg:SetAttacker(self:GetOwner())
				dmg:SetDamageType(DMG_SLASH)
				dmg:SetDamage(80)
				pl:TakeDamageInfo(dmg)
			end
		end
	end)
end

function ENT:DamageBoss(dmg)
	if (self:Health() < self.Boss:Health()) then
		self:SetHealth(self.Boss:Health())
	end

	self:SetHealth(self:Health() - dmg:GetDamage())
	self.Boss:SetHealth(self:Health())

	if (self:Health() <= 0 and not self.Dead) then
		self.Boss:Kill()

		if (self.DeathCallback) then
			self:DeathCallback(self)
		end

		self.Dead = true
	end
end

function ENT:Die()
	local rag = ents.Create "prop_ragdoll"
	rag:SetModel(self:GetModel())
	rag:SetPos(self:GetPos())
	rag:SetAngles(self:GetAngles())
	rag:SetSkin(self:GetSkin())
	rag:SetColor(self:GetColor())
	rag:SetMaterial(self:GetMaterial())
	rag:Spawn()

	rag:SetCollisionGroup(1)
	rag:Fire("FadeAndRemove", "", 15)

	if (self:IsOnFire()) then
		rag:Ignite(10, 0)
	end

	for i = 1, 128 do
		local b = rag:GetPhysicsObjectNum(i)

		if (IsValid(b)) then
			local pos, ang = self:GetBonePosition(rag:TranslatePhysBoneToBone(i))
			bone:SetPos(pos)
			bone:SetAngles(ang)
		end
	end

	local shake = ents.Create("env_shake")
	shake:SetPos(self:GetPos())
	shake:SetKeyValue("amplitude", "8")
	shake:SetKeyValue("radius", "4000")
	shake:SetKeyValue("duration", "0.75")
	shake:SetKeyValue("frequency", "128")
	shake:Fire("StartShake", 0, 0)

	sound.Play("moat/dragon/death" .. math.random(2) .. ".wav", self:GetPos(), 450, 100)

	self:Remove()
end

function ENT:BloodEffects(dmg)
	local blood = ents.Create "info_particle_system"
	if (not IsValid(blood)) then
		return
	end

	blood:SetKeyValue("effect_name", self.BleedsRed and "blood_impact_red_01" or "blood_impact_yellow_01")
	blood:SetPos(dmg:GetDamagePosition())
	blood:Spawn()
	blood:Activate()
	blood:Fire("Start", "", 0)
	blood:Fire("Kill", "", 0.1)
end

function ENT:OnRemove()
end