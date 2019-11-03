--[[Author informations]]--
SWEP.Author = "Zaratusa"
SWEP.Contact = "http://steamcommunity.com/profiles/76561198032479768"

-- always derive from weapon_tttbase
SWEP.Base = "weapon_tttbase"
SWEP.PrintName = "Predator Blade"
--[[Default GMod values]]--
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 0.6
SWEP.Primary.Damage = 25
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 4
SWEP.Primary.DefaultClip = 4

SWEP.MinimumPredatorStacks = 1

--[[Model settings]]--
SWEP.HoldType = "knife"
SWEP.ViewModel = Model("models/weapons/zaratusa/predator_blade/v_predator_blade.mdl")
SWEP.WorldModel = Model("models/weapons/zaratusa/predator_blade/w_predator_blade.mdl")

--[[TTT config values]]--

-- Kind specifies the category this weapon is in. Players can only carry one of
-- each. Can be: WEAPON_... MELEE, PISTOL, HEAVY, NADE, CARRY, EQUIP1, EQUIP2 or ROLE.
-- Matching SWEP.Slot values: 0      1       2     3      4      6       7        8
SWEP.Kind = WEAPON_EQUIP1

-- If AutoSpawnable is true and SWEP.Kind is not WEAPON_EQUIP1/2,
-- then this gun can be spawned as a random weapon.
SWEP.AutoSpawnable = false

-- The AmmoEnt is the ammo entity that can be picked up when carrying this gun.
SWEP.AmmoEnt = "none"

-- CanBuy is a table of ROLE_* entries like ROLE_TRAITOR and ROLE_DETECTIVE. If
-- a role is in this table, those players can buy this.
SWEP.CanBuy = { ROLE_TRAITOR }

-- If LimitedStock is true, you can only buy one per round.
SWEP.LimitedStock = true

-- If AllowDrop is false, players can't manually drop the gun with Q
SWEP.AllowDrop = true

-- If IsSilent is true, victims will not scream upon death.
SWEP.IsSilent = false

-- If NoSights is true, the weapon won't have ironsights
SWEP.NoSights = true

function SWEP:Initialize()
	if (SERVER) then
		self.fingerprints = {}
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
		local epos = spos + (owner:GetAimVector() * 200)

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
					if (ent:IsPlayer() and !ent:IsSpec()) then
						if ((ent:TranslatePhysBoneToBone(tr.PhysicsBone) == 6) or (math.abs(math.AngleDifference(ent:GetAngles().y, owner:GetAngles().y)) <= 50)) then
							dmg = ent:GetMaxHealth()
							self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
							sound.Play("Predator_Blade.Stab", ent:GetPos())
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
					dmginfo:SetDamageForce(owner:GetAimVector() * 200)
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
		self.Owner:SetVelocity(Vector(self.Owner:GetAimVector().x * 450, self.Owner:GetAimVector().y * 450, 0))
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
	self.Owner:SetNW2Int("PredatorStacks", self.Owner:GetNW2Int("PredatorStacks") + amount)
	self.NextSpeedDecrease = CurTime() + 10
end

function SWEP:Deploy()
	self.Owner:SetNW2Int("PredatorStacks", self.MinimumPredatorStacks)
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self:UpdateNextIdle()

	hook.Add("TTTPlayerSpeed", "TTTPredatorBladeSpeed", function(ply)
		if (IsValid(ply) and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "weapon_ttt_predator_blade") then
			return 1 + ply:GetNW2Int("PredatorStacks") * 0.1 -- 10% speed increase per stack
		end
	end)
end

function SWEP:UpdateNextIdle()
	self:SetNW2Float("NextIdle", CurTime() + (self.Owner:GetViewModel():SequenceDuration() * 0.8))
end

function SWEP:Holster()
	hook.Remove("TTTPlayerSpeed", "TTTPredatorBladeSpeed")
	if (IsValid(self) and IsValid(self.Owner)) then
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
