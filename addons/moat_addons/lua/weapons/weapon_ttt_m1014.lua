
AddCSLuaFile()

DEFINE_BASECLASS "weapon_tttbase"

SWEP.HoldType			= "shotgun"

if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/m1014_icon"
end

SWEP.PrintName = "SL0G3"
SWEP.Gun = ("weapon_ttt_m1014")
SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_SHOTGUN

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_bbenelli_m4.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_bbenelli_m4.mdl"	-- Weapon world model
SWEP.Base				= "weapon_tttbase"
SWEP.ShowWorldModel			= false
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("gunshot_benli_m4")		-- script that calls the primary fire sound
SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.Range = 100000
SWEP.Primary.RealCone = Vector(0.003, 0.003)
SWEP.Primary.Cone = 0.035
SWEP.Primary.Damage = 32
SWEP.Primary.Delay = 0.7 + 0.2
SWEP.Primary.ClipSize = 9
SWEP.Primary.ClipMax = 27
SWEP.Primary.DefaultClip = 9
SWEP.Primary.Automatic = true
SWEP.Primary.NumShots = 3
SWEP.Primary.ReverseShotsDamage = true
SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_box_buckshot_ttt"
SWEP.reloadtimer = 0
SWEP.Primary.Recoil			= 7
SWEP.Primary.LayerMults = {0.25, 0.25, 0.25, 0.25}

SWEP.Secondary.IronFOV			= 38

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.ShellTime			= .45

SWEP.ShotgunReload = ACT_VM_RELOAD
SWEP.Primary.EmptySound = Sound("Weapon_Shotgun.Empty")
SWEP.ReloadBullets = 1
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "insert",
		Time = 0.42029,
	},
	AfterReload = {
		Anim = "after_reload",
		Time = 1.03279,
	},
	StartReload = {
		Anim = "start_reload",
		Time = 0.63333,
	},
}

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(2.017,0,1.75)
SWEP.IronSightsAng = Vector(-0.04,-0.03,0)
SWEP.SightsPos = Vector(2.017,0,1.75)
SWEP.SightsAng = Vector(-0.04,-0.03,0)
SWEP.RunSightsPos = Vector(-5.44,-5.676,0.68)	--These are for the angles your viewmodel will be when running
SWEP.RunSightsAng = Vector(-13.971,-62.3,8.305)

SWEP.WElements = {
	["benli_m4"] = { type = "Model", model = "models/weapons/w_bbenelli_m4.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.146, 0.8, -0.461), angle = Angle(-5.244, -1.275, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
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