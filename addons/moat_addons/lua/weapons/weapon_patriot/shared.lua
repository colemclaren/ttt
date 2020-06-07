/*

SWEP.Category				= "GMod Tower Tribute"
SWEP.Author				= "Babel Industries"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= "Want more Snake in your life? This gun is dedicated to anyone who enjoys shooting like crazy. Ammo is unlimited*, but damage is very low. Spread is high as well - making this gun more of a clearing device. You can also use it to hover above the ground - with bullets."
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "The Patriot"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 3				-- Slot in the weapon selection menu
SWEP.SlotPos				= 21			-- Position in the slot
SWEP.DrawAmmo				= false		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= true		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.DisableChambering = true
SWEP.CanBeSilenced		= false
SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_pvp_patriotmg.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pvp_patriotmg.mdl"	-- Weapon world model
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
SWEP.Akimbo = false

function SWEP:AutoDetectKnockback()
	self.Primary.Knockback = self.Primary.Knockback or self.Knockback or math.max(math.pow(self.Primary.Force - 5.97, 2), 0) * math.pow(self.Primary.NumShots, 1 / 3) * 3
end

SWEP.SelectiveFire		= false

SWEP.Primary.Sound			= Sound("Weapon_Pat.Fire")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			    = 425			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 9000		-- Size of a clip
SWEP.Primary.DefaultClip		= 9000		-- Bullets you start with
SWEP.Primary.KickUp				= 0.25		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.25		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.25		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "AirboatGun"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 90		-- How much you 'zoom' in. Less is more! 	

SWEP.IronSightsSensitivity = 0.75

function SWEP:ShootBullet( damage, num_bullets, aimcone )
	local bullet = {}
	bullet.Num 		= 1
	bullet.Src 		= self.Owner:GetShootPos()			
	bullet.Dir 		= self.Owner:GetAimVector()			
	bullet.Spread 	= Vector( 0,0 ,0 )		
	bullet.Tracer	= 1			
    bullet.TracerName = "tracer"	
	bullet.Force	= 5000									
	bullet.Damage	= 2
	bullet.AmmoType = "AirboatGun"
	bullet.Callback = function(attacker,tr,dmginfo)
			
			end
	self.Owner:FireBullets( bullet )
	self:ShootEffects()
	
		if ( SERVER ) then
	
		// Make the player fly backwards..
		self.Owner:SetGroundEntity( NULL )
		self.Owner:SetVelocity( self.Owner:GetVelocity() * -1 + self.Owner:GetAimVector() * -80 )
		
	end

	
end


SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 0

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 2	-- Base damage per bullet
SWEP.Primary.Spread		= .03	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .02 -- Ironsight accuracy, should be the same for shotguns

SWEP.Primary.SpreadMultiplierMax = 1.5 --How far the spread can expand when you shoot.
SWEP.Primary.SpreadIncrement = 1/3.5 --What percentage of the modifier is added on, per shot.
SWEP.Primary.SpreadRecovery = 3 --How much the spread recovers, per second.

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector()
SWEP.SightsAng = Vector()
SWEP.RunSightsPos = Vector()
SWEP.RunSightsAng = Vector()
SWEP.InspectPos = Vector(2.759, -2.328, 0.36)
SWEP.InspectAng = Vector(5.785, 26.798, 0)
SWEP.Offset = {
        Pos = {
        Up = 1,
        Right = .3,
        Forward = 3.5,
        },
        Ang = {
        Up = 0,
        Right = -15,
        Forward = 175,
        },
		Scale = 1.4
}
*/


AddCSLuaFile()

SWEP.HoldType                   = "ar2"
if CLIENT then
   SWEP.Slot                            = 2

   SWEP.Icon = "vgui/hud/weapon_patriot"
end
SWEP.PrintName                  = "The Patriot"
SWEP.Base                               = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_AK47

SWEP.Primary.Delay                      = 0.12
SWEP.Primary.Recoil                     = 0.8
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Cone = 0.025
SWEP.Primary.Damage = 19
SWEP.Primary.ClipSize = 50
SWEP.Primary.ClipMax = 150
SWEP.Primary.DefaultClip = 50
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.UseHands                   = true
SWEP.ViewModelFOV   = 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_pvp_patriotmg.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pvp_patriotmg.mdl"	-- Weapon world model

SWEP.ShowWorldModel                     = false

SWEP.Primary.Sound = Sound( "Weapon_Pat.Fire" )	
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload_unsil",
		Time = 3.86667,
		Sounds = {
			{Delay = .1, Sound = Sound("Weapon_M4A1.Clipout")},
			{Delay = .85, Sound = Sound("Weapon_M4A1.Clipin")},
			{Delay = 2.35, Sound = Sound("Weapon_Pat.Deploy")},
		}
	},
}
/*
Weapon_M4A1.Single	)weapons/m4a1/m4a1_unsil-1.wav
Weapon_M4A1.Silenced	)weapons/m4a1/m4a1-1.wav
Weapon_M4A1.Silencer_Off	weapons/m4a1/m4a1_silencer_off.wav
Weapon_M4A1.Silencer_On	weapons/m4a1/m4a1_silencer_on.wav
Weapon_M4A1.Clipout	weapons/m4a1/m4a1_clipout.wav
Weapon_M4A1.Clipin	weapons/m4a1/m4a1_clipin.wav
Weapon_M4A1.Boltpull	weapons/m4a1/m4a1_boltpull.wav
Weapon_M4A1.Deploy	weapons/m4a1/m4a1_deploy.wav
*/
SWEP.IronSightsPos = Vector( -3.3, 0, 0 )
SWEP.IronSightsAng = Vector( 1, 0, 0 )

SWEP.Offset = {
        Pos = {
        Up = 1,
        Right = .3,
        Forward = 3.5,
        },
        Ang = {
        Up = 0,
        Right = -15,
        Forward = 175,
        },
		Scale = 1.4
}

function SWEP:DrawWorldModel()
    local hand, offset, rotate
    local pl = self:GetOwner()

    if IsValid(pl) and pl.SetupBones then
        pl:SetupBones()
        pl:InvalidateBoneCache()
        self:InvalidateBoneCache()
    end

    if IsValid(pl) then
        local boneIndex = pl:LookupBone("ValveBiped.Bip01_R_Hand")

        if boneIndex then
            local pos, ang

            local mat = pl:GetBoneMatrix(boneIndex)
            if mat then
                pos, ang = mat:GetTranslation(), mat:GetAngles()
            else
                pos, ang = pl:GetBonePosition( handBone )
            end

            pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up
            ang:RotateAroundAxis(ang:Up(), self.Offset.Ang.Up)
            ang:RotateAroundAxis(ang:Right(), self.Offset.Ang.Right)
            ang:RotateAroundAxis(ang:Forward(), self.Offset.Ang.Forward)
            self:SetModelScale(self.Offset.Scale or 1, 0)
            self:SetRenderOrigin(pos)
            self:SetRenderAngles(ang)
            self:DrawModel()
        end
    else
        self:SetRenderOrigin(nil)
        self:SetRenderAngles(nil)
        self:DrawModel()
    end
end
