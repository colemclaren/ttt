
AddCSLuaFile()

SWEP.HoldType = "ar2"
SWEP.PrintName = "Scorpion EVO"

if CLIENT then
   SWEP.Slot = 2

   SWEP.Icon = "vgui/entities/cw_scorpin_evo3"
   SWEP.IconLetter = "l"
end

SWEP.Base = "weapon_tttbase"
DEFINE_BASECLASS "weapon_tttbase"

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_MAC10
SWEP.ENUM = 7

SWEP.Primary.Damage      = 14
SWEP.Primary.Delay       = 0.065
SWEP.Primary.Cone        = 0.015
SWEP.Primary.ClipSize    = 30
SWEP.Primary.ClipMax     = 90
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "smg1"
SWEP.Primary.Recoil      = 1.15
SWEP.Primary.Sound       = Sound( "CW_EVO3_FIRE" )

SWEP.AutoSpawnable = true

SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.UseHands		= true
SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/scorpion/v_ev03.mdl"
SWEP.WorldModel		= "models/weapons/scorpion/w_ev03.mdl"

SWEP.IronSightsPos = Vector(-1.675, 0, 1.049)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.DeploySpeed = 1
SWEP.ReloadSpeed = 1.4
SWEP.ReloadAnim = {
	DefaultReload = {
		Animation = "base_reload",
		ReloadTime = 2.5,
		Sounds = {
			{Delay = 0.5, Sound = Sound("CW_EVO3_CLIPOUT")},
			{Delay = 1.9, Sound = Sound("CW_EVO3_CLIPIN")}
		}
	},
	ReloadEmpty = {
		Animation = "base_reloadempty",
		ReloadTime = 4.5,
		Sounds = {
			{Delay = 0.5, Sound = Sound("CW_EVO3_CLIPOUT")},
			{Delay = 1.9, Sound = Sound("CW_EVO3_CLIPIN")},
			{Delay = 3.2, Sound = Sound("CW_EVO3_BOLTPULL")},
			{Delay = 3.4, Sound = Sound("CW_EVO3_BOLTRELEASE")}
		}
	}
}

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 2 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 150)

   -- decay from 3.2 to 1.7
   return 1.2 + math.max(0, (1.5 - 0.002 * (d ^ 1.25)))
end

SWEP.Offset = {
	Pos = {
		Up = -	.6,
		Right = 1,
		Forward = 3.5,
	},
	Ang = {
		Up = 0,
		Right = 350,
		Forward = 180,
	}
}

function SWEP:DrawWorldModel()
    local pl = self:GetOwner()

    if (IsValid(pl) and pl.SetupBones) then
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