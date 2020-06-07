SWEP.Category				= "Nikolai's Sweps"
SWEP.Author				= "Nikolai"
SWEP.Contact				= "Nikolai"
SWEP.Purpose				= "Russian Holemaker"
SWEP.Instructions			= " "
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment		= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.DrawCrosshair			= false

SWEP.HoldType     = "ar2"
SWEP.PrintName = "MP-40"
if CLIENT then
   SWEP.Slot        = 2

   SWEP.Icon = "vgui/ttt/icon_m16"
   SWEP.IconLetter = "w"
end
SWEP.Kind = WEAPON_HEAVY
SWEP.AmmoEnt = "item_ammo_smg1_ttt"
SWEP.WeaponID = AMMO_M16

SWEP.ViewModelFOV     = 70
SWEP.ViewModelFlip    = true
SWEP.ViewModel	      = "models/weapons/v_smg_mp40w.mdl"
SWEP.WorldModel	      = "models/weapons/w_smg_mp40w.mdl"
SWEP.Base             = "weapon_tttbase"
SWEP.Spawnable        = false
SWEP.AutoSpawnable = false
SWEP.FiresUnderwater  = false
SWEP.AdminSpawnable   = false
SWEP.HeadshotMultiplier = 1.1

SWEP.Primary.Damage        = 30
SWEP.Primary.Sound         = Sound("weapons/mp40/wpnfire.wav")
SWEP.Primary.Round         = "gdcw_7.62x25_tokarev"
SWEP.Primary.Delay         = 0.12
SWEP.Primary.ClipSize      = 32
SWEP.Primary.DefaultClip   = 32
SWEP.Primary.ClipMax	   = 96
SWEP.Primary.Cone          = 0.025
SWEP.Primary.Recoil        = 0.4
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "SMG1"
SWEP.Primary.Range = 666

SWEP.Secondary.ClipSize			= 1
SWEP.Secondary.DefaultClip		= 1
SWEP.Secondary.Automatic		= false
SWEP.Secondary.IronFOV			= 70

SWEP.IronSightsPos = Vector(3.037, 3.801, 1.38)
SWEP.IronSightsAng = Vector(2, -1.43, 0)

SWEP.Offset = {
    Pos = {
        Up = -1.1,
        Right = 1.0,
        Forward = -3.0,
    },
    Ang = {
        Up = 0,
        Right = 0,
        Forward = 180,
    }
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