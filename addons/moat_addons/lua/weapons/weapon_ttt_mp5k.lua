AddCSLuaFile()

if CLIENT then			
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/mp5k_icon"
end
SWEP.PrintName = "MP5K"
SWEP.Gun = ("weapon_ttt_mp5k") -- must be the name of your swep but NO CAPITALS!

SWEP.HoldType 				= "ar2"	

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_tak_mp5.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_tak_mp5.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base				= "weapon_tttbase" --the Base this weapon will work on. PLEASE RENAME THE BASE! 
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("gunshot_tact_mp5k")		-- Script that calls the primary fire sound
SWEP.Primary.SilencedSound 	= Sound("")		-- Sound if the weapon is silenced
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Delay = 0.09
SWEP.Primary.Recoil = 1
SWEP.Primary.Cone = 0.03
SWEP.Primary.Damage = 20
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 90
SWEP.Primary.DefaultClip = 30
SWEP.HeadshotMultiplier = 2

SWEP.AutoSpawnable = true
SWEP.Kind = WEAPON_HEAVY
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.86667,
	},
}

SWEP.IronSightsPos = Vector(3.716,0,0.644)	--Iron Sight positions and angles. Use the Iron sights utility in 
SWEP.IronSightsAng = Vector(0,0,0)	            --Clavus's Swep Construction Kit to get these vectors
SWEP.SightsPos = Vector (3.716,0,0.644)
SWEP.SightsAng = Vector (0,0,0)
SWEP.RunSightsPos = Vector(-3.343,-6.707,0.882)	--These are for the angles your viewmodel will be when running
SWEP.RunSightsAng = Vector(-9.615,-62.199,4.236)	--Again, use the Swep Construction Kit

SWEP.WElements = {
	["mp5k"] = { type = "Model", model = "models/weapons/w_tak_mp5.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-3.296, 0.308, 0.174), angle = Angle(-1.39, -3.467, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
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