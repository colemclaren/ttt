AddCSLuaFile()

DEFINE_BASECLASS "weapon_tttbase"
SWEP.HoldType                   = "shotgun"
SWEP.PrintName = "SPAS-12"
if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/hud/weapon_supershotty"
end

SWEP.Base                               = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_SHOTGUN
SWEP.ENUM = 13

SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.Range = 330
SWEP.Primary.FalloffRange = 800
SWEP.Primary.Recoil = 7
SWEP.Primary.Damage = 11
SWEP.Primary.Cone = 0.03
SWEP.Primary.Delay = 0.8 + 0.2
SWEP.Primary.ClipSize = 8
SWEP.Primary.ClipMax = 24
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic = true
SWEP.Primary.NumShots = 11
SWEP.Primary.Range = 272
SWEP.Primary.FalloffRange = 304
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_box_buckshot_ttt"
SWEP.ShowWorldModel                     = false
SWEP.Primary.LayerMults = {0.2, 0.4, 0.6}

SWEP.ViewModelFlip              = false
SWEP.ViewModelFOV               = 70
SWEP.ViewModel                          = "models/weapons/v_pvp_s12.mdl"        -- Weapon view model
SWEP.WorldModel                         = "models/weapons/w_pvp_s12.mdl"        -- Weapon world model
SWEP.Primary.Sound                      = Sound( "Weapon_Spas.Fire" )

SWEP.IronSightsPos = Vector( -8.8, 0, 1 )
SWEP.IronSightsAng = Vector( 0, 0, 0 )

SWEP.ShotgunReload = ACT_VM_RELOAD
SWEP.Primary.EmptySound = Sound("Weapon_Shotgun.Empty")
SWEP.ReloadBullets = 1
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {Anim = "reload1", Time = 0.53333},
	StartReload = {Anim = "reload2", Time = 0.43333},
	AfterReload = {Anim = "reload3", Time = 0.46667},
}

function SWEP:Initialize()
	if (CLIENT) then
		self:SetLOD(0)
	end

	return BaseClass.Initialize(self)
end

SWEP.Offset = {
        Pos = {
        Up = -1.3,
        Right = 1.103,
        Forward = 5.892,
        },
        Ang = {
        Up = -1.034,
        Right =  -10.749,
        Forward = 174.756,
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
