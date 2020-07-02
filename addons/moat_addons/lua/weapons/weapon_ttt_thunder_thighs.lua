AddCSLuaFile()
SWEP.HoldType = "normal"
SWEP.PrintName = "Thunder Thighs"
if CLIENT then
    SWEP.Slot = 7
    id = speed
    SWEP.DrawAmmo = true
    SWEP.DrawCrosshair = false
    SWEP.ViewModelFOV = 0

    SWEP.EquipMenuData = {
        type = "Active Use Item",
        material = "vgui/ttt/ttt_tt.vtf",
        desc = "This will probably kill you.\nSome form of fall damage reduction is advised.\nLeft Click launches you towards where you are aiming.\nRight Click will launch you upwards only."
    }
end

-----------------------------------------------------------
-- SWEP Information
-----------------------------------------------------------
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/props/cs_office/paper_towels.mdl"
SWEP.UseHands = true
SWEP.Primary.ClipSize = 3
SWEP.Primary.DefaultClip = 3
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Base = "weapon_tttbase"
SWEP.AutoSpawnable = false
SWEP.Kind = WEAPON_EQUIP2
SWEP.AmmoEnt = "none"
SWEP.CanBuy = {ROLE_TRAITOR, ROLE_DETECTIVE}
SWEP.InLoadoutFor = {nil}
SWEP.LimitedStock = true
SWEP.AllowDrop = true
SWEP.NoSights = true

-----------------------------------------------------------
--SWEP Functions
-----------------------------------------------------------
function SWEP:PrimaryAttack()
    if (not self:CanPrimaryAttack()) then return end
    local aimvector = self.Owner:GetAimVector()
    self:TakePrimaryAmmo(1)
    self:SetNextPrimaryFire(CurTime() + 1.5)
    self:EmitSound("weapons/mortar/mortar_shell_incomming1.wav", 100, 100, 1, CHAN_AUTO)
	if (IsValid(self.Owner)) then
		self.Owner.BlockFallDamage = CurTime() + 10
	end

    timer.Simple(.5, function()
		if (not IsValid(self.Owner)) then return end

        self:EmitSound("ambient/explosions/explode_9.wav", 100, 100, 1, CHAN_AUTO)
        self.Owner:SetVelocity(aimvector * 4000) --[[0]]
        local effectdata = EffectData()
        effectdata:SetOrigin(self.Owner:GetPos())
        effectdata:SetScale(.5)
        util.Effect("HelicopterMegaBomb", effectdata)
        util.ScreenShake(Vector(self.Owner:GetPos()), 4, 10, 2, 4000)
        self.Owner:ViewPunch(Angle(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5)))
    end)
end

function SWEP:SecondaryAttack()
    if (not self:CanPrimaryAttack()) then return end
    self:SetNextSecondaryFire(CurTime() + 0.5)
    self:EmitSound("weapons/mortar/mortar_shell_incomming1.wav", 100, 100, 1, CHAN_AUTO)
	if (IsValid(self.Owner)) then
		self.Owner.BlockFallDamage = CurTime() + 10
	end

    timer.Simple(.5, function()
		if (not IsValid(self.Owner)) then return end

        self:EmitSound("ambient/explosions/explode_8.wav", 100, 100, 1, CHAN_AUTO)
        self.Owner:SetVelocity(Vector(0, 0, 1400))
        self:TakePrimaryAmmo(1)
        local effectdata = EffectData()
        effectdata:SetOrigin(self.Owner:GetPos())
        effectdata:SetScale(.5)
        util.Effect("HelicopterMegaBomb", effectdata)
        util.ScreenShake(Vector(self.Owner:GetPos()), 4, 10, 2, 4000)
        self.Owner:ViewPunch(Angle(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5)))
    end)
end

function SWEP:Deploy()
    if SERVER and IsValid(self.Owner) then
        self.Owner:DrawViewModel(false)
    end

    self:DrawShadow(false)

    return true
end

function SWEP:Holster()
    return true
end

function SWEP:DrawWorldModelTranslucent()
end

function SWEP:DrawWorldModel()
    if not IsValid(self.Owner) then
        self:DrawModel()
    end
end