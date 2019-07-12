AddCSLuaFile "cl_init.lua"
AddCSLuaFile "shared.lua"
include "shared.lua"

function ENT:Initialize()
	math.randomseed(CurTime())

   	self.exploded = false

	self.Entity:SetModel "models/dav0r/hoverball.mdl"
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetMaterial "models/props_combine/portalball001_sheet"
	self.dietime = CurTime() + 12

	if (not self.ModelScale) then
		self.ModelScale = 1
	end

	if (self.Entity:GetModelScale() ~= 10 * self.ModelScale) then
		self.Entity:Ignite(120, 40)
	end

	local phys = self.Entity:GetPhysicsObject()
	if (IsValid(phys)) then
		phys:Wake()
		phys:EnableGravity(false)
		phys:SetMass(phys:GetMass() / 3)
	end
end

function ENT:OnTakeDamage(dmginfo)
	self.Entity:TakePhysicsDamage(dmginfo)
end

function ENT:PhysicsCollide()
	if (not self.exploded) then
		self.exploded = true
	
		if (self:GetModelScale() > 1 * self.ModelScale) then
			if (self:GetModelScale() > 4 * self.ModelScale) then
				util.BlastDamage(self.Entity, self.Owner, self.Entity:GetPos(), 600, 70)

				for _, pp in pairs(ents.FindInSphere(self:GetPos(), 1600)) do
					if (pp:IsPlayer() and math.abs(pp:GetPos().z - self:GetPos().z) < 48 and pp ~= self.Owner and pp:Team() ~= TEAM_SPEC) then
						pp:Ignite(10, 40)
						local dist = self:GetPos():Distance(pp:GetPos())
						local dif = 800 - dist

						if (dif > 0) then
							dif = dif / 10
						end

						pp:TakeDamage((20 * self.ModelScale) + dif)
						pp:SetGroundEntity(nil)
						local target = pp
						local pos = self:GetPos()
						local push_force = 600
						local tpos = target:LocalToWorld(target:OBBCenter())
						local dir = (tpos - pos):GetNormal()
						local phys = target:GetPhysicsObject()
						-- always need an upwards push to prevent the ground's friction from
						-- stopping nearly all movement
						dir.z = math.abs(dir.z) + 1
						local push = dir * push_force
						-- try to prevent excessive upwards force
						local vel = target:GetVelocity() + push
						vel.z = math.min(vel.z, push_force)

						if pusher == target then
							vel = VectorRand() * vel:Length()
							vel.z = math.abs(vel.z)
						end

						target:SetVelocity(vel)
					end
				end

				local phexp = ents.Create("env_physexplosion")
				if (IsValid(phexp)) then
					phexp:SetOwner(self.Owner)
					phexp:SetPos(self:GetPos())
					phexp:SetKeyValue("magnitude", 100 * self.ModelScale) --max
					phexp:SetKeyValue("radius", 1200)
					-- 1 = no dmg, 2 = push ply, 4 = push radial, 8 = los, 16 = viewpunch
					phexp:SetKeyValue("spawnflags", 1 + 2)
					phexp:Spawn()
					phexp:Fire("Explode", "", 0.2)
					phexp:EmitSound("ambient/explosions/explode_6.wav", 500, 100)
					local bar = ents.Create("env_shake")
					bar:SetPos(self:GetPos())
					bar:SetKeyValue("amplitude", "8")
					bar:SetKeyValue("radius", "4000")
					bar:SetKeyValue("duration", "2")
					bar:SetKeyValue("frequency", "200")
					bar:Fire("StartShake", 0, 0)
					local effect = EffectData()
					effect:SetStart(self:GetPos() + Vector(0, 0, 32))
					effect:SetOrigin(self:GetPos() + Vector(0, 0, 32))
					effect:SetScale(1200)
					effect:SetRadius(1200)
					effect:SetMagnitude(20 * self.ModelScale)
					effect:SetNormal(Vector(0, 0, 1))
					util.Effect("AR2Explosion", effect)
				end
			else
				local MULT = 1

				if (self.Owner:Health() < self.Owner.MaxHealth / 2) then
					MULT = 1.8
				end

				if (self.Owner:Health() < self.Owner.MaxHealth / 4) then
					MULT = 2
				end

				util.BlastDamage(self.Entity, self.Owner, self.Entity:GetPos(), 225 + MULT * 100, 60)
				local explode = ents.Create("env_explosion") -- creates the explosion

				if (IsValid(explode)) then
					explode:SetPos(self:GetPos())
					-- this creates the explosion through your self.Owner:GetEyeTrace, which is why I put eyetrace in front
					explode:SetOwner(self.Owner) -- this sets you as the person who made the explosion
					explode:Spawn() --this actually spawns the explosion
					explode:SetKeyValue("iMagnitude", tostring(10 + 20 * MULT)) -- the magnitude
					explode:Fire("Explode", 0, 0)
				end
			end
		else
			local MULT = 1

			if (self.Owner:Health() < self.Owner.MaxHealth / 2) then
				MULT = 1.8
			end

			util.BlastDamage(self.Entity, self.Owner, self.Entity:GetPos(), 65 + (25 * MULT - 1), 45 * self.ModelScale)

			local spos = self.Entity:GetPos()
			local tr = util.TraceLine({
				start = spos,
				endpos = spos + Vector(0, 0, -32),
				mask = MASK_SHOT_HULL,
				filter = self
			})

			StartFires(self:GetPos(), tr, 1, 6, false, self:GetOwner())
		end

		self.exploded = true
	end
end

function ENT:Think()
	if (not IsValid(self.Owner)) then
		self:Remove()

		return
	end

	if (self.dietime < CurTime()) then
		self.exploded = true

		if (self:GetModelScale() > 1) then
			util.BlastDamage(self.Entity, self.Owner, self.Entity:GetPos(), 250, 50 * self.ModelScale)
			local explode = ents.Create("env_explosion") -- creates the explosion

			if (IsValid(explode)) then
				explode:SetPos(self:GetPos())
				-- this creates the explosion through your self.Owner:GetEyeTrace, which is why I put eyetrace in front
				explode:SetOwner(self.Owner) -- this sets you as the person who made the explosion
				explode:Spawn() --this actually spawns the explosion
				--explode:SetDamage(0);
				explode:SetKeyValue("iMagnitude", "10") -- the magnitude
				explode:Fire("Explode", 0, 0)
			else
				self:Remove()
			end
		else
			util.BlastDamage(self.Entity, self.Owner, self.Entity:GetPos(), 40, 30 * self.ModelScale)
		end

		local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
		--util.Effect( "ImpactGunship", effectdata )
	end

	if (self.exploded) then
		self:Remove()
	end

	self:NextThink(CurTime())

	return true
end