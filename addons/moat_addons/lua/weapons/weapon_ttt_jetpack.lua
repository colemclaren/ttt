-- Put your Lua here
CreateConVar("ttt_jetpack_force", 12, {FCVAR_ARCHIVE}, "Change the upward force of the jetpack (default 12, can't fly below 11)")

if SERVER then
    -- AddCSLuaFile("shared.lua")
    --   resource.AddFile("materials/VGUI/ttt/lykrast/icon_jetpack.vmt")
end

if (CLIENT) then
    SWEP.Slot = 7
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
    SWEP.Icon = "VGUI/ttt/lykrast/icon_jetpack"

    SWEP.EquipMenuData = {
        type = "item_weapon",
        desc = "Select it and press Jump to propel upward.\n\nBeware the landing."
    }
end
SWEP.PrintName = "Jet Pack"
SWEP.Author = "Lykrast"
SWEP.Base = "weapon_tttbase"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.HoldType = "normal"
SWEP.Kind = WEAPON_EQUIP2
SWEP.CanBuy = {ROLE_TRAITOR, ROLE_DETECTIVE}
SWEP.ViewModelFOV = 0
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/maxofs2d/thruster_propeller.mdl"
--- PRIMARY FIRE ---
SWEP.Primary.Delay = 1
SWEP.Primary.Recoil = 0
SWEP.Primary.Damage = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.NoSights = true

function SWEP:Initialize()
  self:SetBattery(1)
end

function SWEP:SetupDataTables()
  self:NetworkVar("Float", 0, "Battery")
end

if (CLIENT) then
  local grad_d = Material("vgui/gradient-d")

  function SWEP:DrawHUD()
    local scrx = ScrW()/2
    local scry = ScrH()/2
    surface.SetDrawColor(255, 255, 255, 100)
    --surface.DrawRect(scrx - 75, scry + 200, 150, 16)
    surface.DrawOutlinedRect(scrx - 75, scry + 200, 150, 16)

    local ratio = self:GetBattery()

      surface.SetDrawColor(255, 0, 0, 180)
      surface.DrawRect(scrx - 75, scry + 200, 150 * ratio, 16)

      surface.SetDrawColor(0, 0, 0, 200)
      surface.SetMaterial(grad_d)
      surface.DrawTexturedRect(scrx - 75, scry + 200, 150 * ratio, 16)

    draw.SimpleText("Jetpack Battery", "ChatFont", scrx, scry + 207, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
  end
end

function SWEP:PrimaryAttack()
    return false
end

function SWEP:Think()
  local bat = self:GetBattery()

    if (self.Owner:KeyDown(IN_JUMP) and bat and bat > 0) then
        self:SetBattery(math.Clamp(bat - 0.0019, 0, 1))
        self.Owner:SetVelocity(self.Owner:GetUp() * 8)
    else
      self:SetBattery(math.Clamp(bat + 0.0004, 0, 1))
    end
end

function SWEP:Deploy()
    if SERVER and IsValid(self.Owner) then
        self.Owner:DrawViewModel(false)
    end

    return true
end

function SWEP:DrawWorldModel()
    if not IsValid(self.Owner) then
        self:DrawModel()
    end
end

function SWEP:DrawWorldModelTranslucent()
end