AddCSLuaFile()

if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/msbs_icon"
end

SWEP.PrintName = "MSBS"
SWEP.Gun = ("weapon_ttt_msbs")
SWEP.HoldType 				= "ar2"	

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_rifl_msbs.mdl"
SWEP.WorldModel				= "models/weapons/w_rifl_msbs.mdl"
SWEP.ShowWorldModel			= false
SWEP.Base = "weapon_tttbase"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("gunshot_msbs_radon")
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Delay = 0.25
SWEP.Primary.Recoil = 2.3
SWEP.Primary.Cone = 0.01
SWEP.Primary.Damage = 40
SWEP.HeadshotMultiplier = 3
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 20

SWEP.SelectiveFire		= true
SWEP.CanBeSilenced		= true

SWEP.AmmoEnt = "item_ammo_smg1_ttt"
SWEP.AutoSpawnable = true
SWEP.Kind = WEAPON_HEAVY

SWEP.IronSightsPos = Vector(-1.785,1.597,0.18)
SWEP.IronSightsAng = Vector(-0.083,0.019,0)
SWEP.SightsPos = Vector(-1.785,1.597,0.18)
SWEP.SightsAng = Vector(-0.083,0.019,0)
SWEP.RunSightsPos = Vector(5.26,-5.994,-0.514)
SWEP.RunSightsAng = Vector(-19.5,63.31,-19.584)

// SWEP.PrimaryAnim = {"Shoot1", "Shoot2"}
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1.5
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "Reload",
		Time = 3.875,
	},
}

SWEP.WElements = {
	["msbs"] = { type = "Model", model = "models/weapons/w_rifl_msbs.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.232, 1.36, -0.545), angle = Angle(-0.181, 1.45, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
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