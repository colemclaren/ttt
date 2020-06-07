AddCSLuaFile()

if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/king_ump45_icon"
end

SWEP.PrintName = "UMP-45"
SWEP.Gun = ("ttt_king_ump45")

SWEP.HoldType               = "ar2" 

SWEP.ShowWorldModel         = false
SWEP.Base               = "weapon_tttbase"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.AutoSpawnable          = true

SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Delay = 0.07
SWEP.Primary.Recoil = 1.48
SWEP.Primary.Cone = 0.02
SWEP.Primary.Damage = 19
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 90
SWEP.Primary.DefaultClip = 30
SWEP.HeadshotMultiplier = 1.5

SWEP.Kind                   = WEAPON_HEAVY
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_notmic_hkump.mdl"   -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_notmic_hkump.mdl"   -- Weapon world model

SWEP.Primary.Sound          = Sound("Weapon_UMP45.Single")        -- Script that calls the primary fire sound
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "Reload_full",
		Time = 3.12,
		Sounds = {
			{Delay = 2, Sound = Sound("ump45.magrelease")},
		}
	},
	ReloadEmpty = {
		Anim = "Reload_empty",
		Time = 3.52,
	},
}

SWEP.IronSightsPos = Vector(-2.28, 0, 0.639)
SWEP.IronSightsAng = Vector(0.699, 0.519, 0)
SWEP.SightsPos = Vector(-2.28, 0, 0.639)
SWEP.SightsAng = Vector(0.699, 0.519, 0)
SWEP.RunSightsPos = Vector(2.92, 0, 0.6)
SWEP.RunSightsAng = Vector(-1.4, 43.5, 0)

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