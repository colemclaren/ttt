/*
SWEP.VElements = {
	["element_name"] = { type = "Model", model = "models/gmod_tower/stealth box/box.mdl", bone = "v_weapon", rel = "", pos = Vector(0, 4.776, 20.913), angle = Angle(137.046, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 169), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


SWEP.ViewModelFOV = 43.5
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/v_knife_t.mdl"
SWEP.WorldModel = "models/gmod_tower/stealth box/box.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["v_weapon.knife_Parent"] = { scale = Vector(0.01, 0.01, 0.01), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.Category				= "GMod Tower Tribute"
SWEP.Author				= "Babel Industries"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= "Hide yourself inside a box and dissapear completely from your enemies' view. Taunt them over towards you, then pop out and end their lives. Snake used it, so can you."
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Stealth Box"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 5				-- Slot in the weapon selection menu
SWEP.SlotPos				= 2			-- Position in the slot
SWEP.DrawAmmo				= false		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= true		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon

-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.DisableChambering = true
SWEP.CanBeSilenced		= false

SWEP.ViewModelFlip			= false

SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
SWEP.Akimbo = false


SWEP.SelectiveFire		= false

SWEP.HoldType = "camera"

SWEP.ProjectileEntity = "stealth_rock" --Entity to shoot
SWEP.ProjectileVelocity = 500 --Entity to shoot's velocity
SWEP.ProjectileModel = nil --Entity to shoot's model

SWEP.Primary.Sound			= Sound("Weapon_Box.Taunt")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			    = 50			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 9999		-- Size of a clip
SWEP.Primary.DefaultClip		= 9999		-- Bullets you start with
SWEP.Primary.KickUp				= 0		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "slam"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 91.5		-- How much you 'zoom' in. Less is more! 	

SWEP.IronSightHoldTypes = { pistol = "revolver",
	smg = "rpg",
	grenade = "melee",
	ar2 = "rpg",
	shotgun = "ar2",
	rpg = "rpg",
	physgun = "physgun",
	crossbow = "ar2",
	melee = "melee2",
	slam = "slam",
	normal = "fist",
	melee2 = "magic",
	knife = "fist",
	duel = "duel",
	camera = "slam",
	magic = "magic",
	revolver = "revolver"
}
SWEP.IronSightsSensitivity = 0.75

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 0	-- Base damage per bullet
SWEP.Primary.Spread		= .03	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .02 -- Ironsight accuracy, should be the same for shotguns

SWEP.Primary.SpreadMultiplierMax = 1.5 --How far the spread can expand when you shoot.
SWEP.Primary.SpreadIncrement = 1/3.5 --What percentage of the modifier is added on, per shot.
SWEP.Primary.SpreadRecovery = 3 --How much the spread recovers, per second.

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector(0, 0, 0.365)
SWEP.SightsAng = Vector(-38.294, 0, 0)
SWEP.RunSightsPos = Vector()
SWEP.RunSightsAng = Vector()
SWEP.InspectPos = Vector()
SWEP.InspectAng = Vector()
SWEP.Offset = {
        Pos = {
        Up = 1,
        Right =7.5,
        Forward = -10.5,
        },
        Ang = {
        Up = 0,
        Right = 40,
        Forward = 187,
        },
		Scale = 1.1
}*/

AddCSLuaFile()

SWEP.HoldType = "camera"
SWEP.PrintName = "Stealth Box"
if CLIENT then
   SWEP.Slot      = 5

   SWEP.Icon = "vgui/hud/weapon_stealthbox"
   SWEP.ViewModelFOV = 0
end

SWEP.Base = "weapon_tttbase"
SWEP.ViewModelFlip = false
SWEP.ShowViewModel = false
SWEP.UseHands = false
SWEP.ViewModel  = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/gmod_tower/stealth box/box.mdl"

SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = false
SWEP.Primary.Ammo           = "none"
SWEP.Secondary.ClipSize     = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo         = "none"
SWEP.AutoSpawnable = false
SWEP.Kind = WEAPON_UNARMED

SWEP.AllowDelete = false
SWEP.AllowDrop = false

SWEP.NoSights = true

function SWEP:GetClass()
   return "weapon_ttt_unarmed"
end

function SWEP:OnDrop()
   self:Remove()
end

function SWEP:ShouldDropOnDie()
   return false
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:Deploy()
   if SERVER and IsValid(self.Owner) then
      self.Owner:DrawViewModel(false)

   end

    self.CurrentCamera = 0
    return true
end

function SWEP:Holster()
   return true
end

SWEP.Offset = {
        Pos = {
        Up = 30,
        Right = 7.5,
        Forward = -10.5,
        },
        Ang = {
        Up = -5,
        Right = 10,
        Forward = 190,
        },
		Scale = 1.1
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

            if (pl:Crouching()) then
            	pos = pl:GetShootPos()
            	ang = pl:GetAimVector():Angle()
            	ang:RotateAroundAxis(ang:Forward(), 170)
            	ang:RotateAroundAxis(ang:Right(), -13)
            	pos = pos + (ang:Forward() * 20) + (ang:Up() * -10)
            end

            pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up
            ang:RotateAroundAxis(ang:Up(), self.Offset.Ang.Up)
            ang:RotateAroundAxis(ang:Right(), self.Offset.Ang.Right)
            ang:RotateAroundAxis(ang:Forward(), self.Offset.Ang.Forward)
            self:SetModelScale(self.Offset.Scale or 1, 0)
            self:SetRenderOrigin(pos)
            self:SetRenderAngles(Angle(0, ang.y, 0))
            self:DrawModel()
        end
    else
        self:SetRenderOrigin(nil)
        self:SetRenderAngles(nil)
        self:DrawModel()
    end
end

SWEP.CurrentCamera = 0

function SWEP:CalcView(ply, pos, ang, fov)
    if (LocalPlayer():Crouching()) then
        local calc = {}

        self.CurrentCamera = Lerp(FrameTime() * 5, self.CurrentCamera, 100)

        local extra_vec = pos - (ang:Forward() * self.CurrentCamera)

        local tr = util.TraceLine({
            start = pos,
            endpos = extra_vec,
            filter = ply
        })

        if (tr.Hit) then
            extra_vec = tr.HitPos + (ang:Forward() * 10)
        end

        calc.origin = extra_vec
        calc.angles = ang
        calc.fov = fov

        return calc.origin, calc.angles, calc.fov, true
    end
end


function SWEP:DrawWorldModelTranslucent()
end
