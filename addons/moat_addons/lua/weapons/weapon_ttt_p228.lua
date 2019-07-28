if CLIENT then
   SWEP.Slot = 1
   SWEP.Icon = "vgui/ttt/p228_icon"
end

SWEP.PrintName = "P228"
-- Variables that are used on both client and server
SWEP.Gun = ("weapon_ttt_p226") -- must be the name of your swep but NO CAPITALS!
SWEP.HoldType               = "pistol"  

SWEP.ViewModelFOV           = 54
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_sig2_p228.mdl"  -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_sig2_p228.mdl"  -- Weapon world model
SWEP.ShowWorldModel         = false
SWEP.Base               = "weapon_tttbase" --the Base this weapon will work on. PLEASE RENAME THE BASE! 
SWEP.Kind                   = WEAPON_PISTOL
SWEP.AmmoEnt                = "item_ammo_pistol_ttt"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true

SWEP.Primary.Sound          = Sound("gunshot_p228")     -- Script that calls the primary fire sound
SWEP.Primary.SilencedSound  = Sound("")     -- Sound if the weapon is silenced
SWEP.Primary.Delay              = 0.16
SWEP.Primary.ClipSize           = 25        -- Size of a clip
SWEP.Primary.DefaultClip        = 25        -- Bullets you start with
SWEP.Primary.ClipMax            = 75
SWEP.Primary.KickUp             = 0.4       -- Maximum up recoil (rise)
SWEP.Primary.KickDown           = 0.3       -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal     = 0.3       -- Maximum up recoil (stock)
SWEP.Primary.Automatic          = true      -- Automatic = true; Semi Auto = false
SWEP.AutoSpawnable              = true
SWEP.Primary.Ammo           = "pistol"          -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV          = 38        -- How much you 'zoom' in. Less is more!    

SWEP.data               = {}                --The starting firemode
SWEP.data.ironsights            = 1

SWEP.Primary.NumShots   = 1     -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage     = 18    -- Base damage per bullet
SWEP.Primary.Spread     = .030
SWEP.Primary.IronAccuracy = .015 -- Ironsight accuracy, should be the same for shotguns
SWEP.Primary.Cone = 0.008

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1.2
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "Reload",
		Time = 3.83333,
	},
}

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-2.168,0.1,0.94)    --Iron Sight positions and angles. Use the Iron sights utility in 
SWEP.IronSightsAng = Vector(-0.214,0.197,0) --Clavus's Swep Construction Kit to get these vectors
SWEP.SightsPos = Vector (-2.168,0.1,0.94)
SWEP.SightsAng = Vector (-0.214,0.197,0)
SWEP.RunSightsPos = Vector(2.552,-8.948,-5.685) --These are for the angles your viewmodel will be when running
SWEP.RunSightsAng = Vector(61.358,-6.942,-2.892)    --Again, use the Swep Construction Kit
SWEP.HeadshotMultiplier = 2.5

SWEP.WElements = {
    ["sig_p228"] = { type = "Model", model = "models/weapons/w_sig2_p228.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.32, 0.458, 0.321), angle = Angle(-4.157, -6.651, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
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