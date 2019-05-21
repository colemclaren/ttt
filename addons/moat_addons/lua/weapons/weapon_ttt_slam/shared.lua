--[[Author informations]]--
SWEP.Author = "Zaratusa"
SWEP.Contact = "http://steamcommunity.com/profiles/76561198032479768"

CreateConVar("ttt_slam_max", 5, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Maximum amount of SLAM's everyone can carry.")
CreateConVar("ttt_slam_bought", 2, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Amount of SLAM's you receive, when you buy a SLAM.")

-- always derive from weapon_tttbase
SWEP.Base = "weapon_tttbase"
SWEP.PrintName = "M4 SLAM"
--[[Default GMod values]]--
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 1.25
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = GetConVar("ttt_slam_max"):GetInt()
SWEP.Primary.DefaultClip = GetConVar("ttt_slam_bought"):GetInt()
SWEP.Secondary.Delay = 0.5
SWEP.FiresUnderwater = false

--[[Model settings]]--
SWEP.HoldType = "slam"
SWEP.ViewModel = Model("models/weapons/v_slam.mdl")
SWEP.WorldModel	= Model("models/weapons/w_slam.mdl")

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

-- If NoSights is true, the weapon won't have ironsights
SWEP.NoSights = true

-- Sounds
local SatchelSound = Sound("weapons/slam/throw.wav")
local TripmineSound = Sound("weapons/slam/mine_mode.wav")
local DetonatorSound = Sound("weapons/c4/c4_beep1.wav")

local NONE, SATCHEL, TRIPMINE = 0, 1, 2 -- the three possible animation states of the SLAM

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 1, "ActiveSatchel")
end

function SWEP:Initialize()
	self.State = NONE
	self:SetActiveSatchel(0)
end

function SWEP:PrimaryAttack()
	if (self:CanPrimaryAttack() and self:GetNextPrimaryFire() <= CurTime()) then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

		if (self.State == SATCHEL) then
			self:ThrowSatchel()
		else
			self:StickTripmine()
		end
	end
end

function SWEP:ThrowSatchel()
	local owner = self.Owner
	if (SERVER and IsValid(owner)) then
		local slam = ents.Create("ttt_slam_satchel")
		if (IsValid(slam)) then
			if (self:GetActiveSatchel() > 0) then
				self:AnimateAttack(ACT_SLAM_THROW_THROW, ACT_SLAM_THROW_THROW2, SatchelSound, 1)
			else
				self:AnimateAttack(ACT_SLAM_THROW_THROW_ND, ACT_SLAM_THROW_THROW_ND2, SatchelSound, 1)
			end

			local src = owner:GetShootPos()
			local ang = owner:GetAimVector()
			local vel = owner:GetVelocity()
			local throw = vel + ang * 200

			slam:SetPos(src + ang * 10)
			slam:SetPlacer(owner)
			slam:SetPlacedBy(self)
			slam:Spawn()

			slam.fingerprints = self.fingerprints

			local phys = slam:GetPhysicsObject()
			if (IsValid(phys)) then
				phys:Wake()
				phys:SetVelocity(throw)
			end
		end
		owner:SetAnimation(PLAYER_ATTACK1)
	end
end

function SWEP:StickTripmine()
	local owner = self.Owner
	if (SERVER and IsValid(owner)) then
		local ignore = {owner, self.Weapon}
		local spos = owner:GetShootPos()
		local epos = spos + owner:GetAimVector() * 42

		local tr = util.TraceLine({start=spos, endpos=epos, filter=ignore, mask=MASK_SOLID})
		if (tr.HitWorld) then
			local slam = ents.Create("ttt_slam_tripmine")
			if (IsValid(slam)) then
				local tr_ent = util.TraceEntity({start=spos, endpos=epos, filter=ignore, mask=MASK_SOLID}, slam)
				if (tr_ent.HitWorld) then
					if (self:GetActiveSatchel() > 0) then
						self:AnimateAttack(ACT_SLAM_STICKWALL_ATTACH, ACT_SLAM_STICKWALL_ATTACH2, TripmineSound, 0)
					else
						self:AnimateAttack(ACT_SLAM_TRIPMINE_ATTACH, ACT_SLAM_TRIPMINE_ATTACH2, TripmineSound, 0)
					end

					local ang = tr_ent.HitNormal:Angle()
					ang.p = ang.p + 90

					slam:SetPos(tr_ent.HitPos + (tr_ent.HitNormal * 3))
					slam:SetAngles(ang)
					slam:SetPlacer(owner)
					slam:Spawn()

					slam.fingerprints = self.fingerprints
				end
			end
		end
		owner:SetAnimation(PLAYER_ATTACK1)
	end
end

function SWEP:AnimateAttack(animation1, animation2, sound, newSatchel)
	self.Weapon:SendWeaponAnim(animation1)
	local holdup = self.Owner:GetViewModel():SequenceDuration()

	timer.Simple(holdup * 0.6, function()
		if (IsValid(self)) then
			self:EmitSound(sound)
		end
	end)
	timer.Simple(holdup, function()
		if (IsValid(self)) then
			self.Weapon:SendWeaponAnim(animation2)
		end
	end)
	timer.Simple(holdup + 0.1, function()
		if (IsValid(self)) then
			self:TakePrimaryAmmo(1)
			self:ChangeActiveSatchel(newSatchel)
		end
	end)
end

function SWEP:ChangeActiveSatchel(amount)
	if (IsValid(self)) then
		self:SetActiveSatchel(self:GetActiveSatchel() + amount)
		self:Deploy()
	end
end

function SWEP:SecondaryAttack()
	local owner = self.Owner
	if (SERVER and self:GetActiveSatchel() > 0 and self:GetNextSecondaryFire() <= CurTime() and IsValid(owner)) then
		self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)
		self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
		if (self.State == SATCHEL) then
			self.Weapon:SendWeaponAnim(ACT_SLAM_THROW_DETONATE)
		elseif (self.State == TRIPMINE) then
			self.Weapon:SendWeaponAnim(ACT_SLAM_STICKWALL_DETONATE)
		else
			self.Weapon:SendWeaponAnim(ACT_SLAM_DETONATOR_DETONATE)
		end
		self:EmitSound(DetonatorSound)

		for _, slam in pairs(ents.FindByClass("ttt_slam_satchel")) do
			if (slam:IsActive() and slam:GetPlacedBy() == self) then
				slam:SetPlacer(owner)
				slam:StartExplode(true)
			end
		end

		self:Deploy()
	end
end

function SWEP:CanAttachSLAM()
	local result = false

	if (IsValid(self)) then
		local owner = self.Owner

		if (IsValid(owner)) then
			local ignore = {owner, self.Weapon}
			local spos = owner:GetShootPos()
			local epos = spos + owner:GetAimVector() * 42
			local tr = util.TraceLine({start = spos, endpos = epos, filter = ignore, mask = MASK_SOLID})

			result = tr.HitWorld
		end
	end

	return result
end

function SWEP:ChangeAnimation()
	-- just change the animation, when the weapon is currently active
	if (IsValid(self.Owner) and self.Owner:GetActiveWeapon() == self.Weapon) then
		if (self:CanAttachSLAM()) then
			if (self.State == SATCHEL) then
				if (self:GetActiveSatchel() > 0) then
					self.Weapon:SendWeaponAnim(ACT_SLAM_THROW_TO_STICKWALL)
				else
					self.Weapon:SendWeaponAnim(ACT_SLAM_THROW_TO_TRIPMINE_ND)
				end
				self.State = TRIPMINE
			elseif (self.State == NONE) then
				if (self:GetActiveSatchel() > 0) then
					self.Weapon:SendWeaponAnim(ACT_SLAM_DETONATOR_THROW_DRAW)
					self.State = SATCHEL
				else
					self.Weapon:SendWeaponAnim(ACT_SLAM_TRIPMINE_DRAW)
					self.State = TRIPMINE
				end
			end
		elseif (self.Weapon:Clip1() > 0) then
			if (self.State == TRIPMINE) then
				if (self:GetActiveSatchel() > 0) then
					self.Weapon:SendWeaponAnim(ACT_SLAM_STICKWALL_TO_THROW)
				else
					self.Weapon:SendWeaponAnim(ACT_SLAM_STICKWALL_TO_THROW_ND)
				end
			elseif (self.State == NONE) then
				if (self:GetActiveSatchel() > 0) then
					self.Weapon:SendWeaponAnim(ACT_SLAM_DETONATOR_THROW_DRAW)
				else
					self.Weapon:SendWeaponAnim(ACT_SLAM_THROW_ND_DRAW)
				end
			end
			self.State = SATCHEL
		else
			self.Weapon:SendWeaponAnim(ACT_SLAM_DETONATOR_DRAW)
		end
	end
end

function SWEP:Deploy()
	if (SERVER and (self:GetActiveSatchel() <= 0) and self.Weapon:Clip1() == 0) then
		self:Remove()
	else
		self.State = NONE
		self:ChangeAnimation()
	end
	return true
end

-- Reload does nothing
function SWEP:Reload()
end
