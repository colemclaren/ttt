AddCSLuaFile()

SWEP.HoldType = "pistol"
SWEP.PrintName = "Glock-17"
if CLIENT then
   SWEP.Slot = 1

   SWEP.Icon = "vgui/hud/weapon_semiauto"
end
SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_GLOCK

SWEP.ViewModelFOV                       = 70
SWEP.ViewModelFlip                      = true
SWEP.ViewModel                          = "models/weapons/v_pvp_semiauto.mdl"      -- Weapon view model
SWEP.WorldModel                         = "models/weapons/w_pvp_semiauto.mdl"      -- Weapon world model
SWEP.ShowWorldModel                     = false
SWEP.Base = "weapon_tttbase"
SWEP.Spawnable                          = true
SWEP.AdminSpawnable                     = true

SWEP.Primary.Sound = Sound("Weapon_Semi.fire")         -- Script that calls the primary fire sound
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
SWEP.IronSightsPos = Vector( 3.2, 1, 2 )

SWEP.Offset = {
        Pos = {
        Up = 0,
        Right = 1.3,
        Forward = 0.2,
        },
        Ang = {
        Up = 0,
        Right = -3,
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