AddCSLuaFile()

DEFINE_BASECLASS "weapon_tttbase"

SWEP.HoldType			= "shotgun"
SWEP.PrintName = "S12"
if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/hud/weapon_supershotty"
end

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_SHOTGUN
SWEP.ENUM = 13

SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.Range = 200
SWEP.Primary.Delay = 1.4
SWEP.Primary.Recoil = 7
SWEP.Primary.Cone = 0.05
SWEP.Primary.ConeY = 0.05
SWEP.Primary.Damage = 15
SWEP.Primary.ClipSize = 8
SWEP.Primary.ClipMax = 24
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic = true
SWEP.Primary.NumShots = 12
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_box_buckshot_ttt"
SWEP.ShowWorldModel                     = false

SWEP.ViewModelFlip		= true
SWEP.ViewModelFOV		= 70
SWEP.ViewModel				= "models/weapons/v_pvp_supershoty.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pvp_supershoty.mdl"	-- Weapon world model
SWEP.Primary.Sound			= Sound( "Weapon_Super.Fire" )

SWEP.IronSightsPos = Vector( 2.2, 0, 1 )
SWEP.IronSightsAng = Vector( 0, 0, 0 )

SWEP.ShotgunReload = ACT_VM_RELOAD
SWEP.Primary.EmptySound = Sound("Weapon_Shotgun.Empty")
SWEP.ReloadBullets = 1
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "insert",
		Time = 0.66667,
	},
	AfterReload = {
		Anim = "after_reload",
		Time = 0.90909,
	},
	StartReload = {
		Anim = "start_reload",
		Time = 0.5,
	},
}

SWEP.Offset = {
        Pos = {
        Up = 1.3,
        Right = 0.53,
        Forward = 2.092,
        },
        Ang = {
        Up = -1.034,
        Right =  -10.749,
        Forward = 174.756,
        },
		Scale = 1.16
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
