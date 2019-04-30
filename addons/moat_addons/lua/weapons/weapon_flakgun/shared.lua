/*	

SWEP.Category				= "GMod Tower Tribute"
SWEP.Author				= "Babel Industries"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= "Fires an impossibly powerful burst of flak. Watch out for the spread, and the low ammo count."
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Flak Handgun"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 1				-- Slot in the weapon selection menu
SWEP.SlotPos				= 21			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= true		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "pistol"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles


SWEP.SelectiveFire		= false
SWEP.CanBeSilenced		= false
SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_vir_flakhg.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_vir_flakhg.mdl"	-- Weapon world model
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
SWEP.Akimbo = false

SWEP.DisableChambering = true

SWEP.Primary.Sound			= Sound("Weapon_Flak.Fire")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 90			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 1	-- Size of a clip
SWEP.Primary.DefaultClip		= 120		-- Bullets you start with
SWEP.Primary.KickUp			= 1.70					-- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown			= 1.70							-- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal			= 1.70							-- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.45 	--Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
SWEP.MaxPenetrationCounter= 5
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "357"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 55		-- How much you 'zoom' in. Less is more! 	

SWEP.IronSightsSensitivity = 0.75

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.SpreadMultiplierMax = 1.5 --How far the spread can expand when you shoot.
SWEP.Primary.SpreadIncrement = 1/3.5 --What percentage of the modifier is added on, per shot.
SWEP.Primary.SpreadRecovery = 3 --How much the spread recovers, per second.

SWEP.Primary.NumShots	= 8		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 50	-- Base damage per bullet
SWEP.Primary.Spread		= .07	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .07 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector(5.639, 0, 2.16)
SWEP.SightsAng = Vector(-0.142, -0.139, 0)
SWEP.RunSightsPos = Vector ()
SWEP.RunSightsAng = Vector ()
SWEP.InspectPos = Vector(-5.611, -14.639, 4.12)
SWEP.InspectAng = Vector(15.539, -57.735, -10)

SWEP.Offset = {
        Pos = {
        Up = -2,
        Right = 1.6,
        Forward = 6.1,
        },
        Ang = {
        Up = -3.6,
        Right = -4,
        Forward = 180,
        },
		Scale = 1
}
*/

/*
AddCSLuaFile()

SWEP.HoldType = "pistol"

if CLIENT then
   SWEP.PrintName = "Flak-28"
   SWEP.Slot = 1

   SWEP.Icon = "vgui/hud/weapon_flakgun"
end
SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_GLOCK

SWEP.ViewModelFOV                       = 70
SWEP.ViewModelFlip                      = true
SWEP.ViewModel                          = "models/weapons/v_vir_flakhg.mdl"     -- Weapon view model
SWEP.WorldModel                         = "models/weapons/w_vir_flakhg.mdl"     -- Weapon world model
SWEP.ShowWorldModel                     = false
SWEP.Base = "weapon_tttbase"
SWEP.Spawnable                          = true
SWEP.AdminSpawnable                     = true

SWEP.Primary.Sound = Sound("Weapon_Flak.Fire")         -- Script that calls the primary fire sound
SWEP.Primary.Recoil = 0.9
SWEP.Primary.Damage = 16
SWEP.Primary.Delay = 0.12
SWEP.Primary.Cone = 0.024
SWEP.Primary.ClipSize = 18
SWEP.Primary.Automatic = false
SWEP.Primary.DefaultClip = 18
SWEP.Primary.ClipMax = 60
SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.Range = 10000
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_box_buckshot_ttt"
SWEP.IronSightsPos = Vector(4.73, 0, 2.4)

SWEP.Offset = {
        Pos = {
        Up = -2,
        Right = 1.6,
        Forward = 6.1,
        },
        Ang = {
        Up = -3.6,
        Right = -4,
        Forward = 180,
        },
                Scale = 1
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
*/
AddCSLuaFile()

SWEP.HoldType                   = "pistol"
SWEP.PrintName = "Flak-28"
if CLIENT then
   SWEP.Slot = 1
   SWEP.Icon = "vgui/hud/weapon_flakgun"
end

SWEP.Base                               = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_GLOCK

SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.Delay = 1.2
SWEP.Primary.Recoil = 7
SWEP.Primary.Cone = 0.11
SWEP.Primary.Damage = 11
SWEP.Primary.ClipSize = 2
SWEP.Primary.ClipMax = 6
SWEP.Primary.DefaultClip = 2
SWEP.Primary.Automatic = true
SWEP.Primary.NumShots = 10
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_box_buckshot_ttt"
SWEP.ShowWorldModel                     = false

SWEP.ViewModelFOV                       = 70
SWEP.ViewModelFlip                      = true
SWEP.ViewModel                          = "models/weapons/v_vir_flakhg.mdl"     -- Weapon view model
SWEP.WorldModel                         = "models/weapons/w_vir_flakhg.mdl"     -- Weapon world model
SWEP.Primary.Sound                      = Sound( "Weapon_Flak.Fire" )

SWEP.IronSightsPos = Vector( 5.65, 0, 0 )
SWEP.IronSightsAng = Vector( 0, 0, 0 )
SWEP.ReloadLength = 2.23


-- The shotgun's headshot damage multiplier is based on distance. The closer it
-- is, the more damage it does. This reinforces the shotgun's role as short
-- range weapon by reducing effectiveness at mid-range, where one could score
-- lucky headshots relatively easily due to the spread.


function SWEP:SecondaryAttack()
   if self.NoSights or (not self.IronSightsPos) or self.dt.reloading then return end
   --if self:GetNextSecondaryFire() > CurTime() then return end

   self:SetIronsights(not self:GetIronsights())

   self:SetNextSecondaryFire(CurTime() + 0.3)
end

SWEP.Offset = {
        Pos = {
        Up = -2,
        Right = 1.6,
        Forward = 6.1,
        },
        Ang = {
        Up = -3.6,
        Right = -4,
        Forward = 180,
        },
                Scale = 1
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
