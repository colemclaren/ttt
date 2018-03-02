-- Variables that are used on both client and server
-- this is almost all code from Generic Default, I just decided to streamline it for new sweps.
-- so thanks GD! your stuff rocks! :D
SWEP.Gun = ("") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= ""
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= ""		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 4				-- Slot in the weapon selection menu
SWEP.SlotPos				= 3			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 2			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "grenade"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and ar2 make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_eq_FragGrenade.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_eq_FragGrenade.mdl"	-- Weapon world model
SWEP.Base				= "bobs_gun_base"
SWEP.Spawnable				= false
SWEP.AdminSpawnable			= false
SWEP.FiresUnderwater 		= false

SWEP.Primary.Sound			= Sound("")		-- Script that calls the primary fire sound
SWEP.Primary.RPM				= 60		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 1		-- Size of a clip
SWEP.Primary.DefaultClip		= 1		-- Bullets you start with
SWEP.Primary.KickUp				= 0		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "Grenade"				
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal peircing shotgun slug

SWEP.Primary.Round 			= ("")	--NAME OF ENTITY GOES HERE

SWEP.Secondary.IronFOV			= 0		-- How much you 'zoom' in. Less is more! 	

SWEP.Primary.NumShots	= 0		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 0	-- Base damage per bullet
SWEP.Primary.Spread		= 0	-- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0 -- Ironsight accuracy, should be the same for shotguns
--none of this matters for IEDs and other ent-tossing sweps

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector(0, 0, 0)	-- These are the same as IronSightPos and IronSightAng
SWEP.SightsAng = Vector(0, 0, 0)	-- No, I don't know why
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

--and now to the nasty parts of this swep...

function SWEP:PrimaryAttack()
	if self.Owner:IsNPC() then return end
	if self:CanPrimaryAttack() then
		self.Weapon:SendWeaponAnim(ACT_VM_PULLPIN)
		
		self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))	
		timer.Simple( 0.6, function() if SERVER then if not IsValid(self) then return end 
			if IsValid(self.Owner) then 
				if (self:AllIsWell()) then 
					self:Throw() 
				end 
			end
		end end )
	end
end

function SWEP:Throw()

	if SERVER then
	
	if self.Owner != nil and self.Weapon != nil then 
	if self.Owner:GetActiveWeapon():GetClass() == self.Gun then

	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	timer.Simple( 0.35, function() if not IsValid(self) then return end 
	if self.Owner != nil
	and self.Weapon != nil
	then if(self:AllIsWell()) then 
	self.Owner:SetAnimation(PLAYER_ATTACK1)
			aim = self.Owner:GetAimVector()
			side = aim:Cross(Vector(0,0,1))
			up = side:Cross(aim)
			pos = self.Owner:GetShootPos() + side * 5 + up * -1
			if SERVER then
				local rocket = ents.Create(self.Primary.Round)
				if !rocket:IsValid() then return false end
				rocket:SetNWEntity("Owner", self.Owner)
				rocket:SetAngles(aim:Angle()+Angle(90,0,0))
				rocket:SetPos(pos)
				rocket:SetOwner(self.Owner)
				rocket.Owner = self.Owner	-- redundancy department of redundancy checking in
				rocket:SetNWEntity("Owner", self.Owner)
				rocket:Spawn()
				local phys = rocket:GetPhysicsObject()
				if self.Owner:KeyDown(IN_ATTACK2) and (phys:IsValid()) then
					if phys != nil then phys:ApplyForceCenter(self.Owner:GetAimVector() * 2000) end
				else 
					if phys != nil then phys:ApplyForceCenter(self.Owner:GetAimVector() * 5500) end
				end
				self.Weapon:TakePrimaryAmmo(1)
		end
		self:checkitycheckyoself()
		end end
	end )
		
	end
	end
	end
end

function SWEP:SecondaryAttack()
end	

function SWEP:checkitycheckyoself()
	timer.Simple(.15, function() if not IsValid(self) then return end 
	if IsValid(self.Owner) then 
	if SERVER and (self:AllIsWell()) then	
		if self.Weapon:Clip1() == 0 
			and self.Owner:GetAmmoCount( self.Weapon:GetPrimaryAmmoType() ) == 0 then
				self.Owner:StripWeapon(self.Gun)
			else
				self.Weapon:DefaultReload( ACT_VM_DRAW )
			end
		end
	end end)
end

function SWEP:AllIsWell()

	if self.Owner != nil and self.Weapon != nil then
		if self.Weapon:GetClass() == self.Gun and self.Owner:Alive() then
			return true
			else return false
		end
		else return false
	end

end

function SWEP:Think()
end