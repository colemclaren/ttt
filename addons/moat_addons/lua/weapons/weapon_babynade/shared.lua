/*-- Variables that are used on both client and server

SWEP.Category				= "GMod Tower Tribute"
SWEP.Author				= "Babel Industries"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= "Use care when planting, as the explosion is quite deadly."
SWEP.PrintName				= "Babynade"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 4				-- Slot in the weapon selection SWEP.DrawWeaponInfoBox			= true
SWEP.SlotPos				= 40			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= true	-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 2			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "grenade"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and ar2 make for good sniper rifles

SWEP.ViewModelFOV			= 65
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_pvp_babynade.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/props_c17/doll01.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true
SWEP.Base				= "tfa_nade_base"
SWEP.Spawnable				= true
SWEP.UseHands = false
SWEP.AdminSpawnable			= true

SWEP.Primary.RPM				= 30		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 1		-- Size of a clip
SWEP.Primary.DefaultClip		= 11		-- Bullets you start with
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "Grenade"				
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal peircing shotgun slug

SWEP.Primary.Round 			= ("pvp_babynade")	--NAME OF ENTITY GOES HERE
SWEP.Velocity = 1000 -- Entity Velocity
SWEP.Delay = 0.1 -- Delay to fire entity
-- enter bone mod and other custom stuff below. Irons aren't used for grenades


if GetConVar("tfaUniqueSlots") != nil then
	if not (GetConVar("tfaUniqueSlots"):GetBool()) then 
		SWEP.SlotPos = 2
	end
end


SWEP.Offset = {
        Pos = {
        Up = 0,
        Right = 2.3,
        Forward = 2,
        },
        Ang = {
        Up = -90,
        Right = 10,
        Forward = 180,
        },
		Scale = 1
}*/


AddCSLuaFile()

SWEP.HoldType                   = "grenade"
SWEP.PrintName = "Babynade"

if CLIENT then
   SWEP.Slot = 3

   SWEP.Icon = "vgui/hud/weapon_babynade"
end

SWEP.Base = "weapon_tttbasegrenade"

SWEP.PrintName = "Babynade"
SWEP.Spawnable = true
SWEP.AutoSpawnable = false

SWEP.WeaponID = AMMO_SMOKE
SWEP.Kind = WEAPON_NADE

SWEP.UseHands                   = true
SWEP.ViewModelFlip              = false
SWEP.ViewModelFOV               = 65
SWEP.ViewModel                          = "models/weapons/v_pvp_babynade.mdl"   -- Weapon view model
SWEP.WorldModel                         = "models/props_c17/doll01.mdl" -- Weapon world model
SWEP.Weight                     = 5
SWEP.ShowWorldModel                     = false
SWEP.AutoSpawnable      = false
-- really the only difference between grenade weapons: the model and the thrown
-- ent.

function SWEP:GetGrenadeName()
   return "pvp_babynade"
end

SWEP.Offset = {
        Pos = {
        Up = 0,
        Right = 2.3,
        Forward = 2,
        },
        Ang = {
        Up = -90,
        Right = 10,
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
