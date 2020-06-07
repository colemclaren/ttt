AddCSLuaFile()

SWEP.HoldType			= "pistol"
SWEP.PrintName			= "M1911"
if CLIENT then
   SWEP.Author				= "TTT"

   SWEP.Slot				= 1
   SWEP.SlotPos			= 1

   SWEP.Icon = "vgui/ttt/m1911_icon"
end

SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_DEAGLE

SWEP.ViewModelFOV			= 75
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_pist_cm1911.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_cm1911.mdl"
SWEP.Base 				= "weapon_tttbase"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("weapons/colt/m1911.wav")
SWEP.Primary.Ammo       = "AlyxGun"
SWEP.Primary.Recoil			= 3
SWEP.Primary.Damage = 32
SWEP.Primary.Delay = 0.3
SWEP.Primary.Cone = 0.01
SWEP.Primary.ClipSize = 8
SWEP.Primary.ClipMax = 24
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic = true
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_ammo_revolver_ttt"

SWEP.HeadshotMultiplier = 2

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.45714,
	},
}

SWEP.IronSightsPos = Vector(2.799, -2.401, 0.839)
SWEP.IronSightsAng = Vector(0, 0.1, 0)
SWEP.SightsPos = Vector(2.784, -2.401, 0.839)
SWEP.SightsAng = Vector(0, 0.1, 0)
SWEP.RunSightsPos = Vector(0.319, 1.18, -0.16)
SWEP.RunSightsAng = Vector(-21.3, -31.5, 26.18)

SWEP.Offset = {
Pos = {
Up = 0,
Right = 1,
Forward = -2,
},
Ang = {
Up = 90,
Right = 355,
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