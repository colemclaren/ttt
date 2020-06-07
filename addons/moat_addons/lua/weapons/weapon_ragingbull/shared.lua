/*

SWEP.Category               = "GMod Tower Tribute"
SWEP.Author             = "Babel Industries"
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions               = "Add a new meaning to fire power. Let waves of bullets ricochet off walls to both confuse, and destroy your enemies. Don't let the ricochets deceive you, the Raging Bull is powerful on its own."
SWEP.MuzzleAttachment           = "1"   -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment           = "2"   -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "Raging Bull"     -- Weapon name (Shown on HUD)   
SWEP.Slot               = 1             -- Slot in the weapon selection menu
SWEP.SlotPos                = 21            -- Position in the slot
SWEP.DrawAmmo               = true      -- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox          = true      -- Should draw the weapon info box
SWEP.BounceWeaponIcon           =   false   -- Should the weapon icon bounce?
SWEP.DrawCrosshair          = true      -- set false if you want no crosshair
SWEP.Weight             = 30            -- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo           = true      -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true      -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "revolver"        -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles


SWEP.SelectiveFire      = false
SWEP.CanBeSilenced      = false
SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = true
SWEP.ViewModel              = "models/weapons/v_pvp_ragingb.mdl"    -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_pvp_ragingb.mdl"    -- Weapon world model
SWEP.Base               = "tfa_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater = false
SWEP.Akimbo = false

SWEP.DisableChambering = true

SWEP.Primary.Sound          = Sound("Weapon_RagBull.fire")      -- Script that calls the primary fire sound
SWEP.Primary.RPM            = 90            -- This is in Rounds Per Minute
SWEP.Primary.ClipSize           = 6     -- Size of a clip
SWEP.Primary.DefaultClip        = 120       -- Bullets you start with
SWEP.Primary.KickUp         = 1.70                  -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown           = 1.70                          -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal         = 1.70                          -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.45  --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
SWEP.MaxPenetrationCounter= 5
SWEP.Primary.Automatic          = false     -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "Pistol"          -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV          = 55        -- How much you 'zoom' in. Less is more!    

SWEP.IronSightsSensitivity = 0.75

SWEP.data               = {}                --The starting firemode
SWEP.data.ironsights            = 1

SWEP.Primary.NumShots   = 1     -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage     = 70    -- Base damage per bullet
SWEP.Primary.Spread     = .01   -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .005 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector (2.7483, -1.6223, 0.522)
SWEP.SightsAng = Vector (0.0208, 0.002, 0)
SWEP.RunSightsPos = Vector ()
SWEP.RunSightsAng = Vector ()
SWEP.InspectPos = Vector(-5.611, -3.639, -0.12)
SWEP.InspectAng = Vector(7.539, -54.735, 0)

SWEP.Offset = {
        Pos = {
        Up = -0.1,
        Right = 0.7,
        Forward = -0,
        },
        Ang = {
        Up = 0,
        Right = -4,
        Forward = 180,
        },
        Scale = 1
}
*/



AddCSLuaFile()

SWEP.HoldType = "pistol"
SWEP.PrintName = "Raging Bull"
if CLIENT then
   SWEP.Slot = 1

   SWEP.Icon = "vgui/hud/weapon_ragingbull"
end
SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_GLOCK

SWEP.ViewModelFOV                       = 70
SWEP.ViewModelFlip                      = true
SWEP.ViewModel                          = "models/weapons/v_pvp_ragingb.mdl"    -- Weapon view model
SWEP.WorldModel                         = "models/weapons/w_pvp_ragingb.mdl"    -- Weapon world model
SWEP.ShowWorldModel                     = false
SWEP.Base = "weapon_tttbase"
SWEP.Spawnable                          = true
SWEP.AdminSpawnable                     = true

SWEP.Primary.Sound = Sound("Weapon_RagBull.fire")         -- Script that calls the primary fire sound
SWEP.Primary.Recoil = 6
SWEP.Primary.Damage = 50
SWEP.Primary.Delay = 0.6
SWEP.Primary.Cone = 0.02
SWEP.Primary.ClipSize = 8
SWEP.Primary.ClipMax = 24
SWEP.Primary.DefaultClip = 8
SWEP.HeadshotMultiplier = 3
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "AlyxGun"
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_ammo_revolver_ttt"

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.73529,
	},
}

SWEP.IronSightsPos = Vector(2.746, 0, 2.525)

SWEP.Offset = {
        Pos = {
        Up = -0.1,
        Right = 0.7,
        Forward = -0,
        },
        Ang = {
        Up = 0,
        Right = -4,
        Forward = 180,
        },
                Scale = 1
}

function SWEP:SetZoom(state)
    if not (IsValid(self.Owner) and self.Owner:IsPlayer()) then return end
    if state then
        self.Owner:SetFOV(55, 0.5)
    else
        self.Owner:SetFOV(0, 0.2)
    end
end

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
