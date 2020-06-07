AddCSLuaFile()
 
SWEP.HoldType = "pistol"
SWEP.PrintName = "HK USP"

if CLIENT then
   SWEP.Slot = 1

   SWEP.Icon = "vgui/ttt/hkusp_icon"
end

SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_PISTOL

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_usp_mtch.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_usp_mtch.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base				= "pyrous_gun_base" --the Base this weapon will work on. PLEASE RENAME THE BASE! 
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("gunshot_hk_usp_mtch")		-- Script that calls the primary fire sound
SWEP.Primary.SilencedSound 	= Sound("gunshot_hk_usp_mtch_silenced")		-- Sound if the weapon is silenced
SWEP.Base = "weapon_tttbase"
SWEP.Primary.Recoil	= 1.4
SWEP.Primary.Damage = 25
SWEP.Primary.Delay = 0.3
SWEP.Primary.Cone = 0.02
SWEP.Primary.ClipSize = 14
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = 14
SWEP.Primary.ClipMax = 42
SWEP.Primary.Ammo = "Pistol"
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_ammo_pistol_ttt"
SWEP.SelectiveFire		= false
SWEP.CanBeSilenced		= true

SWEP.HeadshotMultiplier = 1.5

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	/*DefaultReload = {
		Anim = "reload",
		Time = 2.67516,
	},*/
	DefaultReload = {
		Anim = "reload_unsil",
		Time = 2.67516,
	},
}

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(2.26,0.1,0.840)	--Iron Sight positions and angles. Use the Iron sights utility in 
SWEP.IronSightsAng = Vector(0.105,-0.12,0)	--Clavus's Swep Construction Kit to get these vectors
SWEP.SightsPos = Vector(2.26,0.1,0.840)
SWEP.SightsAng = Vector(0.105,-0.12,0)
SWEP.RunSightsPos = Vector(-1.824,-6.892,-5.882)  --These are for the angles your viewmodel will be when running
SWEP.RunSightsAng = Vector(53.816,10.904,5.323)	 --Again, use the Swep Construction Kit

SWEP.WElements = {
	["hk_usp_match"] = { type = "Model", model = "models/weapons/w_usp_mtch.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.511, 0.827, 0.24), angle = Angle(-3.201, 0, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
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