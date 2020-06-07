AddCSLuaFile()

DEFINE_BASECLASS "weapon_tttbase"

if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/m590_icon"
end
SWEP.PrintName = "Mossberg"

SWEP.Kind = WEAPON_HEAVY

SWEP.Gun = ("weapon_ttt_m590")
SWEP.HoldType 				= "ar2"

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_mossberg_590a1.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_mossberg_590a1.mdl"	-- Weapon world model
SWEP.Base 				= "weapon_tttbase"
SWEP.ShowWorldModel			= false
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.AutoSpawnable = true
SWEP.AmmoEnt = "item_box_buckshot_ttt"
SWEP.reloadtimer = 0

SWEP.Primary.Sound			= Sound("gunshot_moss_590")		-- script that calls the primary fire sound
SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.Range = 100
SWEP.Primary.FalloffRange = 400
SWEP.Primary.Delay = 1.1 + 0.5
SWEP.Primary.Recoil = 10
-- Cone controls distance for damage falloff
SWEP.Primary.Cone = 0.5
-- If these exist: 
SWEP.Primary.ConeY = 0.06
SWEP.Primary.ConeX = 0.04
SWEP.Primary.Damage = 20
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 6
SWEP.Primary.ClipMax = 18
SWEP.Primary.DefaultClip = 6
SWEP.Primary.NumShots = 9
SWEP.Primary.LayerMults = {0.4, 0.6}


SWEP.ShellTime			= .45
SWEP.ShotgunReload = ACT_VM_RELOAD
SWEP.Primary.EmptySound = Sound("Weapon_Shotgun.Empty")
SWEP.ReloadBullets = 1
SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "insert",
		Time = 0.43333,
	},
	AfterReload = {
		Anim = "after_reload",
		Time = 0.86667,
	},
	StartReload = {
		Anim = "start_reload",
		Time = 0.4,
	},
}

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(2.849,-1.836,2.309)
SWEP.IronSightsAng = Vector(0.911,0.717,-4.219)
SWEP.SightsPos = Vector(2.849,-1.836,2.309)
SWEP.SightsAng = Vector(0.911,0.717,-4.219)
SWEP.RunSightsPos = Vector(-5.45,-8.476,1.213)	--These are for the angles your viewmodel will be when running
SWEP.RunSightsAng = Vector(-13.49,-62.8,5.441)

SWEP.WElements = {
	["moss_590"] = { type = "Model", model = "models/weapons/w_mossberg_590a1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.546, 0.797, 0), angle = Angle(0.36, -0.997, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
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