
AddCSLuaFile()

SWEP.HoldType = "ar2"
SWEP.PrintName = "MAC11"

if CLIENT then
   SWEP.Slot = 2

   SWEP.Icon = "vgui/ttt/mac11_icon"
end
SWEP.Gun = ("weapon_ttt_mac11")

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_ops_mac10.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_ops_mac10.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= false
SWEP.Base				= "weapon_tttbase" --the Base this weapon will work on. PLEASE RENAME THE BASE! 
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_MAC10
SWEP.AutoSpawnable = true
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.Primary.Sound			= Sound("gunshot_ops_mac10")		-- Script that calls the primary fire sound
SWEP.Primary.SilencedSound 	= Sound("")		-- Sound if the weapon is silenced
SWEP.Primary.Damage      = 14
SWEP.Primary.Delay       = 0.060
SWEP.Primary.Cone        = 0.025
SWEP.Primary.ClipSize    = 25
SWEP.Primary.ClipMax     = 75
SWEP.Primary.DefaultClip = 25
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "smg1"
SWEP.Primary.Recoil      = 1.18
SWEP.Primary.Ammo			= "smg1"

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.9,
	},
}

SWEP.IronSightsPos = Vector(3.168,0,2.398)	--Iron Sight positions and angles. Use the Iron sights utility in 
SWEP.IronSightsAng = Vector(0.699,0,0)	            --Clavus's Swep Construction Kit to get these vectors
SWEP.SightsPos = Vector (3.168,0,2.398)
SWEP.SightsAng = Vector (0.699,0,0)
SWEP.RunSightsPos = Vector(-6.389,-6.422,1.44)	--These are for the angles your viewmodel will be when running
SWEP.RunSightsAng = Vector(-9.483,-58.931,6.499)	--Again, use the Swep Construction Kit

SWEP.WElements = {
	["ops_mac10"] = { type = "Model", model = "models/weapons/w_ops_mac10.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.466, 0.393, 0.437), angle = Angle(-12.131, -3.388, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 2 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 150)

   -- decay from 3.2 to 1.7
   return 1.7 + math.max(0, (1.5 - 0.002 * (d ^ 1.25)))
end

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