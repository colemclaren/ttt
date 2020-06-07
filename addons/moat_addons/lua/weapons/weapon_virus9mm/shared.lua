/*
SWEP.Category				= "GMod Tower Tribute"
SWEP.Author				= "Babel Industries"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= "This 9mm pistol is surprisingly powerful, and can take out infected with just a couple shots."
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "9mm Pistol"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 1				-- Slot in the weapon selection menu
SWEP.SlotPos				= 2			-- Position in the slot
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

SWEP.DisableChambering = true
SWEP.CanBeSilenced		= false
SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_vir_9mm1.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_vir_9mm1.mdl"	-- Weapon world model
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
SWEP.Akimbo = false




SWEP.Primary.Sound			= Sound("Weapon_9mm.fire")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 725			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 18		-- Size of a clip
SWEP.Primary.DefaultClip		= 120		-- Bullets you start with
SWEP.Primary.KickUp				= 0.35		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.35		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.35		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "Pistol"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 55		-- How much you 'zoom' in. Less is more! 	

SWEP.IronSightsSensitivity = 0.75

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 30	-- Base damage per bullet
SWEP.Primary.Spread		= .02	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .0001 -- Ironsight accuracy, should be the same for shotguns

SWEP.Primary.SpreadMultiplierMax = 1.5 --How far the spread can expand when you shoot.
SWEP.Primary.SpreadIncrement = 1/3.5 --What percentage of the modifier is added on, per shot.
SWEP.Primary.SpreadRecovery = 3 --How much the spread recovers, per second.

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector(2.03, 7, 0.9)
SWEP.SightsAng = Vector(0.307, -0.131, 0)
SWEP.RunSightsPos = Vector()
SWEP.RunSightsAng = Vector()
SWEP.InspectPos = Vector(-5.18, -4.444, 1.542)
SWEP.InspectAng = Vector(1.855, -39.906, 0)
SWEP.Offset = {
        Pos = {
        Up = 0,
        Right = 0.8,
        Forward = 0.09,
        },
        Ang = {
        Up = 0,
        Right = -6,
        Forward = 175,
        },
		Scale = 1.0
}
*/


AddCSLuaFile()

SWEP.HoldType = "pistol"
SWEP.PrintName = "TAC-45"
if CLIENT then
   SWEP.Slot = 1

   SWEP.Icon = "vgui/hud/weapon_virus9mm"
end
SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_GLOCK

SWEP.ViewModelFOV                       = 70
SWEP.ViewModelFlip                      = true
SWEP.ViewModel                          = "models/weapons/v_vir_9mm1.mdl"       -- Weapon view model
SWEP.WorldModel                         = "models/weapons/w_vir_9mm1.mdl"       -- Weapon world model
SWEP.ShowWorldModel                     = false
SWEP.Base = "weapon_tttbase"
SWEP.Spawnable                          = true
SWEP.AdminSpawnable                     = true

SWEP.Primary.Sound = Sound("Weapon_9mm.fire")         -- Script that calls the primary fire sound
SWEP.Primary.Recoil = 0.9
SWEP.Primary.Damage = 16
SWEP.Primary.Delay = 0.12
SWEP.Primary.Cone = 0.024
SWEP.Primary.ClipSize = 18
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = 18
SWEP.Primary.ClipMax = 54
SWEP.Primary.Ammo = "Pistol"
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_ammo_pistol_ttt"
SWEP.IronSightsPos = Vector(2.05, 0, 0)

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	/*
	DefaultReload = {
		Anim = "reload",
		Time = 2.51351,
	},
	*/
	DefaultReload = {
		Anim = "reload_unsil",
		Time = 2.51351,
	},
}

SWEP.Offset = {
        Pos = {
        Up = 0,
        Right = 0.8,
        Forward = 0.09,
        },
        Ang = {
        Up = 0,
        Right = -6,
        Forward = 175,
        },
                Scale = 1.0
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