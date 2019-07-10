
AddCSLuaFile()

SWEP.HoldType = "pistol"
SWEP.PrintName = "CZ-75"

if CLIENT then
   SWEP.Slot = 1

   SWEP.Icon = "vgui/ttt/cz75_icon"
end
SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_GLOCK

SWEP.Gun = ("weapon_ttt_cz75")

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_pist_cz75.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_pist_cz75.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base = "weapon_tttbase"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("gunshot_cz75")		-- Script that calls the primary fire sound
SWEP.Primary.SilencedSound 	= Sound("")		-- Sound if the weapon is silenced
SWEP.Primary.Recoil	= 0.9
SWEP.Primary.Damage = 16
SWEP.Primary.Delay = 0.12
SWEP.Primary.Cone = 0.024
SWEP.Primary.ClipSize = 20
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.Ammo = "Pistol"
SWEP.AutoSpawnable = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.Secondary.IronFOV			= 38		-- How much you 'zoom' in. Less is more! 	

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.7,
	},
}

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-2.631,-1.17,0.939)	--Iron Sight positions and angles. Use the Iron sights utility in 
SWEP.IronSightsAng = Vector(0.625,0.05,0)	--Clavus's Swep Construction Kit to get these vectors
SWEP.SightsPos = Vector(-2.631,-1.17,0.939)
SWEP.SightsAng = Vector(0.625,0.05,0)
SWEP.RunSightsPos = Vector(1.059,-9.096,-5.051)	--These are for the angles your viewmodel will be when running
SWEP.RunSightsAng = Vector(61.359,-6.943,-8.021)	--Again, use the Swep Construction Kit

SWEP.WElements = {
	["cz_75"] = { type = "Model", model = "models/weapons/w_pist_cz75.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.567, 1.039, 0.8), angle = Angle(-5.178, 0, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
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