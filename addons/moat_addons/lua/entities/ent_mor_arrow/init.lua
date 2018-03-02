AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()
	self:SetModel("models/morrowind/steel/arrow/steelarrow.mdl")
	--self.Weapon = self.Weapon:GetClass()	//MORE MAJICKZ
	self:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	self.SpawnTime = CurTime()
	self.HitEnemy = false
	self.Disabled = false

	self.Entity:DrawShadow(false)
	self:SetGravity(.01)

	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(2)
	end

	util.PrecacheSound("weapons/bow/skyrim_bow_hitflesh.mp3")
	util.PrecacheSound("weapons/bow/skyrim_bow_hitwall.mp3")

	self.Hit = "weapons/bow/skyrim_bow_hitflesh.mp3"

	self.HitWall = "weapons/bow/skyrim_bow_hitwall.mp3"

	self.Entity:SetUseType(SIMPLE_USE)
end

/*---------------------------------------------------------
   Name: ENT:Think()
---------------------------------------------------------*/
function ENT:Think()
	local velocity = self:GetPhysicsObject():GetVelocity()
	if velocity:Length() > 400 then
		self:SetAngles(self:GetVelocity():Angle() + Angle(180, 0, 0))	// MAJICKZ, DON'T FAIL ME NOW!
	end
	self:GetPhysicsObject():SetVelocity(velocity)
	if CurTime() > (self.SpawnTime + 30) then
		self:Remove()
	end
	if (self:GetParent():IsValid()) and !(self:GetParent():Health() > 0) then
		self:Remove()
	end

	local lifetime = CurTime() - self.SpawnTime
	local velx = velocity.x
	local vely = velocity.y
	local horizvel = (velx^2 + vely^2) ^ .5		// PYTHAGORAS WAS HERE.
	
	if velocity.z < 0 then
		local upvel = horizvel / 50
		self:GetPhysicsObject():SetVelocity(velocity + Vector(0, 0, upvel))
	end

	self:NextThink(CurTime() + .1)
	return true
end

/*---------------------------------------------------------
   Name: ENT:PhysicsCollide()
---------------------------------------------------------*/
function ENT:PhysicsCollide(data, phys)
	if self.Disabled == true then return end
	timer.Simple(0, function()
	local Ent = data.HitEntity
	if !(IsValid(Ent) or Ent:IsWorld()) then return end
	if self.Trail then
		self.Trail:SetParent(nil)
		local trail = self.Trail
		self.Trail = nil
		timer.Simple(100000, trail.Remove, trail)
	end
	if Ent:IsWorld() then
		util.Decal("ManhackCut", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
		self:EmitSound(self.HitWall)
		if data.OurOldVelocity:Length() > 400 then
			self:SetPos(data.HitPos + self:GetForward() * -2)
			self.Entity:SetMoveType(MOVETYPE_NONE)
			self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		end
		self.Disabled = true
		self.SpawnTime = CurTime()
	elseif self.HitEnemy == false then	// Only deal damage once.
		if not(Ent:IsPlayer() or Ent:IsNPC() or Ent:GetClass() == "prop_ragdoll") then 
			util.Decal("ManhackCut", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
			self:EmitSound(self.Hit)
			self.HitEnemy = true
		end
		
		local damage = self.Damage
		local tr = {}
		tr.start = data.HitPos
		tr.endpos = data.HitPos + (data.OurOldVelocity * 25)
		tr.filter = self
		local trace = util.TraceLine(tr)
		if trace.Entity == Ent and trace.HitGroup == HITGROUP_HEAD then
			damage = damage * 2
		end

		if (not IsValid(self:GetOwner())) then
			self:Remove()
			return
		end

		local dmginfo = DamageInfo()
		dmginfo:SetAttacker(self:GetOwner())
		dmginfo:SetInflictor(self.Weapon)
		dmginfo:SetDamageType(DMG_BULLET)
		dmginfo:SetDamage(damage)

		hook.Call("ScalePlayerDamage", nil, Ent, trace.HitGroup, dmginfo)

		Ent:TakeDamageInfo(dmginfo)

		if (Ent:IsPlayer() or Ent:IsNPC() or Ent:GetClass() == "prop_ragdoll") then 
			local effectdata = EffectData()
			effectdata:SetStart(data.HitPos)
			effectdata:SetOrigin(data.HitPos)
			effectdata:SetScale(1)
			util.Effect("BloodImpact", effectdata)

			self:EmitSound(self.Hit)
		end
		if (Ent:IsPlayer() or Ent:IsNPC()) and (Ent:Health() > 0) or Ent:GetMoveType() == MOVETYPE_VPHYSICS then //and (!Ent == self:GetOwner()) then
			self.Entity:SetMoveType(MOVETYPE_NONE)
			self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			self:SetPos(self:GetPos() + self:GetForward() * -25)
			self:SetParent(Ent)
			self:SetOwner(Ent)
			self.SpawnTime = CurTime()
			self.Disabled = true
		end

		self:Remove()
	end

	if (self.Weapon and self.Weapon.Talents) then
    	local weapon_lvl = self.Weapon.level

    	for k, v in ipairs(self.Weapon.Talents) do
        	if (weapon_lvl >= v.l) then

            	local talent_enum = v.e
            	local talent_mods = v.m or {}
            	local talent_servertbl = m_GetTalentFromEnumWithFunctions(talent_enum)

            	if (talent_servertbl.OnWeaponFired) then
                	if (talent_servertbl:OnWeaponFired(self:GetOwner(), {}, talent_mods, true, data.HitPos)) then
                	    return true
                	end
            	end
        	end
        end
    end

	if !self:GetParent():IsValid() then
		self.Entity:SetOwner(nil)
	end
	end)
end

/*---------------------------------------------------------
   Name: ENT:Use()
---------------------------------------------------------*/
function ENT:Use(activator, caller)
	if (activator:IsPlayer()) then
		activator:GiveAmmo(1, "357", true)
	end
	self.Entity:Remove()
end