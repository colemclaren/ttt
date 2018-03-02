--- Author informations ---
SWEP.Author = "Zaratusa"
SWEP.Contact = "http://steamcommunity.com/profiles/76561198032479768"

--- Default GMod values ---
SWEP.Base = "weapon_base"
SWEP.Category = "Other"
SWEP.Purpose = "Kill everyone you see, just like a predator."
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = false
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true

SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 0.6
SWEP.Primary.Damage = 25
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 4
SWEP.Primary.DefaultClip = 4

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.MinimumPredatorStacks = 1

--- Model settings ---
SWEP.HoldType = "knife"

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel = Model("models/weapons/zaratusa/predator_blade/v_predator_blade.mdl")
SWEP.WorldModel = Model("models/weapons/zaratusa/predator_blade/w_predator_blade.mdl")

function SWEP:Initialize()
	if (SERVER) then
		self.NextJumpStack = 0
		self.NextSpeedDecrease = 0
	end

	self:SetDeploySpeed(self.DeploySpeed)

	if (self.SetHoldType) then
		self:SetHoldType(self.HoldType or "pistol")
	end
end

function SWEP:PrimaryAttack()
	if (SERVER and self:GetNextPrimaryFire() <= CurTime()) then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

		local owner = self.Owner
		local spos = owner:GetShootPos()
		local epos = spos + (owner:GetAimVector() * 130)

		local tr = util.TraceLine({start = spos, endpos = epos, filter = owner, mask = MASK_SHOT_HULL})
		local ent = tr.Entity

		-- blood effect
		if (IsValid(ent)) then
			local effect = EffectData()
			effect:SetStart(spos)
			effect:SetOrigin(tr.HitPos)
			effect:SetNormal(tr.Normal)
			effect:SetEntity(ent)

			if (ent:IsPlayer() or ent:GetClass() == "prop_ragdoll") then
				util.Effect("BloodImpact", effect)
			end
		end

		if (SERVER) then
			if (tr.Hit) then
				if (IsValid(ent)) then
					local dmg = ent:GetMaxHealth() * 0.5
					if (ent:IsPlayer() or ent:IsNPC()) then
						if ((ent:TranslatePhysBoneToBone(tr.PhysicsBone) == 6) or (math.abs(math.AngleDifference(ent:GetAngles().y, owner:GetAngles().y)) <= 50)) then
							dmg = ent:GetMaxHealth()
							self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
							sound.Play("Predator_Blade.Hit", ent:GetPos())
						else
							self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK_2)
							sound.Play("Predator_Blade.Hit", self.Weapon:GetPos())
						end

						if (ent:Health() - dmg < 0) then
							self:ChangePredatorStacks(1)
						end
					else
						self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK_2)
						sound.Play("Predator_Blade.Hitwall", self.Weapon:GetPos(), 60)
					end

					local dmginfo = DamageInfo()
					dmginfo:SetDamage(dmg)
					dmginfo:SetAttacker(owner)
					dmginfo:SetInflictor(self.Weapon or self)
					dmginfo:SetDamageType(DMG_SLASH)
					dmginfo:SetDamageForce(owner:GetAimVector() * 10)
					dmginfo:SetDamagePosition(ent:GetPos())

					ent:DispatchTraceAttack(dmginfo, spos, epos)
				else
					self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK_1)
					sound.Play("Predator_Blade.Hitwall", self.Weapon:GetPos(), 60)
				end
			else
				self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
				sound.Play("Predator_Blade.Slash", self.Weapon:GetPos(), 50)
			end

			owner:SetAnimation(PLAYER_ATTACK1)
		end

		self:UpdateNextIdle()

		if (IsValid(owner) and !owner:IsNPC() and owner.ViewPunch) then
			owner:ViewPunch(Angle(0, math.Rand(1, 5), 0))
		end
	end
end

function SWEP:SecondaryAttack()
	if (self:Clip1() > 0 and IsValid(self.Owner) and self.Owner:OnGround()) then
		self.Owner:ConCommand("+jump")
		self.Owner:SetVelocity(Vector(self.Owner:GetAimVector().x * 650, self.Owner:GetAimVector().y * 650, 0))
		timer.Simple(0.1,function()
			if (IsValid(self) and IsValid(self.Owner)) then
				self.Owner:ConCommand("-jump")
			end
		end)

		if (SERVER and self:Clip1() == self.Primary.ClipSize) then
			self.NextJumpStack = CurTime() + 5
		end
		self:SetClip1(self:Clip1() - 1)
	end
end

function SWEP:Reload()
	self.Owner:EmitSound("Predator_Blade.Taunt")
end

function SWEP:ChangePredatorStacks(amount)
	self.Owner:SetNWInt("PredatorStacks", self.Owner:GetNWInt("PredatorStacks") + amount)
	self.NextSpeedDecrease = CurTime() + 10
end

function SWEP:Deploy()
	self.Owner:SetNWInt("PredatorStacks", self.MinimumPredatorStacks)
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self:UpdateNextIdle()
end

function SWEP:UpdateNextIdle()
	self:SetNWFloat("NextIdle", CurTime() + (self.Owner:GetViewModel():SequenceDuration() * 0.8))
end

function SWEP:Holster()
	if (IsValid(self) and IsValid(self.Owner)) then
		self.Owner:SetWalkSpeed(200)
		self.Owner:SetRunSpeed(400)
		self.Owner:ConCommand("-jump")
	end

	return true
end

function SWEP:OnDrop()
	self:Holster()
end

function SWEP:OnRemove()
	self:Holster()
end
