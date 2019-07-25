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
SWEP.Primary.Cone = 0.06
SWEP.Primary.ConeY = 0.11
SWEP.Primary.Damage = 13
SWEP.Primary.ClipSize = 6
SWEP.Primary.ClipMax = 18
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic = true
SWEP.Primary.NumShots = 10
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_box_buckshot_ttt"
SWEP.ShowWorldModel                     = false
SWEP.Primary.LayerMults = {0.6, 0.4}

SWEP.ViewModelFOV                       = 70
SWEP.ViewModelFlip                      = true
SWEP.ViewModel                          = "models/weapons/v_vir_flakhg.mdl"     -- Weapon view model
SWEP.WorldModel                         = "models/weapons/w_vir_flakhg.mdl"     -- Weapon world model
SWEP.Primary.Sound                      = Sound( "Weapon_Flak.Fire" )

SWEP.IronSightsPos = Vector( 5.65, 0, 0 )
SWEP.IronSightsAng = Vector( 0, 0, 0 )
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.23,
	},
}

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
