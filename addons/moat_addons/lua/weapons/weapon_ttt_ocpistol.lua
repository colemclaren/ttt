if CLIENT then
   SWEP.Author				= "TTT"

   SWEP.Slot				= 1

   SWEP.Icon = "vgui/ttt/mr96_icon"
end
SWEP.PrintName			= "One Shot Revolver"
SWEP.Gun = ("weapon_ttt_mr96") -- must be the name of your swep but NO CAPITALS!
SWEP.Spawnable = true
SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_DEAGLE

SWEP.HoldType 				= "revolver"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg makes for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_manur_mr_96.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_manur_mr_96.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base				= "weapon_tttbase" --the Base this weapon will work on. PLEASE RENAME THE BASE! 
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("gunshot_mr96")		-- Script that calls the primary fire sound
SWEP.Primary.SilencedSound 	= Sound("")		-- Sound if the weapon is silenced
SWEP.Primary.ClipSize			= 6
SWEP.Primary.ClipMax 			= 36	
SWEP.Primary.DefaultClip		= 1	
SWEP.Primary.Recoil				= 5
SWEP.AmmoEnt 					= "item_ammo_revolver_ttt"
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "AlyxGun"
SWEP.HeadshotMultiplier 	= 4
SWEP.AutoSpawnable 		= false

SWEP.Secondary.IronFOV			= 38		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.Damage = 2000
SWEP.Primary.Delay = 0.45
SWEP.Primary.Cone = 0.02

SWEP.AllowDrop = false

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.16667,
	},
}

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-2.336,0,0.74)	--Iron Sight positions and angles. Use the Iron sights utility in 
SWEP.IronSightsAng = Vector(0.004,0.059,0)	--Clavus's Swep Construction Kit to get these vectors
SWEP.SightsPos = Vector(-2.336,0,0.74)
SWEP.SightsAng = Vector(0.004,0.059,0)
SWEP.RunSightsPos = Vector(1.315,-7.731,-6.395)	--These are for the angles your viewmodel will be when running
SWEP.RunSightsAng = Vector(61.359,-6.943,-8.021)	--Again, use the Swep Construction Kit

SWEP.WElements = {
	["mr96"] = { type = "Model", model = "models/weapons/w_manur_mr_96.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.138, 0.625, 1.125), angle = Angle(-16.882, 0, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.Offset = {
Pos = {
Up = 0,
Right = 1,
Forward = -2,
},
Ang = {
Up = 0,
Right = 355,
Forward = 180,
}
}

function SWEP:CanPrimaryAttack()
   if not IsValid(self.Owner) then return end
    
    local plyspn = self.Owner:GetNW2Int("MG_OC_SPAWNPROTECTION")

    if (plyspn and plyspn > CurTime()) then
        return false
    end

   if self:Clip1() <= 0 then
      self:DryFire(self.SetNextPrimaryFire)
      return false
   end
   return true
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