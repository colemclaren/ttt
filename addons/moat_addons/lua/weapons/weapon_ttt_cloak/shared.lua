if SERVER then
    AddCSLuaFile("shared.lua")
    --resource.AddFile("materials/VGUI/ttt/lykrast/icon_cloak.vmt")

    util.AddNetworkString("MOAT_PLAYER_CLOAKED")
end
SWEP.PrintName = "Cloaking Device"
if (CLIENT) then
    SWEP.Slot = 7
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
    SWEP.Icon = "VGUI/ttt/lykrast/icon_cloak"

    SWEP.EquipMenuData = {
        type = "item_weapon",
        desc = "Hold it to become nearly invisible.\n\nDoesn't hide your name, shadow or\nbloodstains on your body."
    }
end

SWEP.Author = "Lykrast"
SWEP.Base = "weapon_tttbase"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.HoldType = "slam"
SWEP.Kind = WEAPON_EQUIP2
SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.UseHands = true
--- PRIMARY FIRE ---
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 0
SWEP.Primary.Damage = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.NoSights = true
SWEP.AllowDrop = false

if (CLIENT) then
  local grad_d = Material("vgui/gradient-d")

  function SWEP:DrawHUD()
    local scrx = ScrW()/2
    local scry = ScrH()/2
    surface.SetDrawColor(255, 255, 255, 100)
    --surface.DrawRect(scrx - 75, scry + 200, 150, 16)
    surface.DrawOutlinedRect(scrx - 75, scry + 200, 150, 16)

    local ratio = self:GetCooldown()

      surface.SetDrawColor(255, 0, 0, 180)
      surface.DrawRect(scrx - 75, scry + 200, 150 * ratio, 16)

      surface.SetDrawColor(0, 0, 0, 200)
      surface.SetMaterial(grad_d)
      surface.DrawTexturedRect(scrx - 75, scry + 200, 150 * ratio, 16)

      if (ratio <= 0) then
        draw.SimpleText("Cloak is Dead", "ChatFont", scrx, scry + 207, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
      else
        draw.SimpleText("Cloak Lifetime", "ChatFont", scrx, scry + 207, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
      end
  end
end

function SWEP:PrimaryAttack()
    return false
end

function SWEP:DrawWorldModel()
    -- if not IsValid(self.Owner) then -- Well let's test this way then
    --  self:DrawWorldModel()
    -- end
end -- Thanks v_hana :)

function SWEP:DrawWorldModelTranslucent()
end

function SWEP:Cloak()
    local cooldown = self:GetCooldown()

    if (cooldown <= 0) then
      return
    end

    if (SERVER) then
        self.Owner:SetRenderMode(RENDERMODE_TRANSALPHA)
        self.Owner:SetColor(Color(255, 255, 255, 0))

        net.Start("MOAT_PLAYER_CLOAKED")
        net.WriteEntity(self.Owner)
        net.WriteBool(true)
        net.Broadcast()
    end

    --self.Owner:SetMaterial( "sprites/heatwave" )
    -- self.Weapon:SetMaterial("sprites/heatwave")
    self:EmitSound("AlyxEMP.Charge")
    -- self.Owner:DrawWorldModel( false ) -- Thanks v_hana :)
    self.conceal = true
end

function SWEP:Initialize()
  self:SetCooldown(1)
end

function SWEP:SetupDataTables()
  self:NetworkVar("Float", 0, "Cooldown")
end

function SWEP:Think()
  if (self.conceal) then
    local cooldown = self:GetCooldown()

    if (cooldown <= 0) then
      self:UnCloak()
    end

    self:SetCooldown(math.Clamp(cooldown - 0.001, 0, 1))
  end
end

function SWEP:UnCloak()
    --self.Owner:SetMaterial("models/glass")
    -- self.Weapon:SetMaterial("models/glass")
    if (SERVER) then
        self.Owner:SetColor(Color(255, 255, 255, 255))

        net.Start("MOAT_PLAYER_CLOAKED")
        net.WriteEntity(self.Owner)
        net.WriteBool(false)
        net.Broadcast()
    end

    self:EmitSound("AlyxEMP.Discharge")
    -- self.Owner:DrawWorldModel( true ) -- Thanks v_hana :)
    self.conceal = false
end

function SWEP:Deploy()
    self:Cloak()
end

function SWEP:Holster()
    if (self.conceal) then
        self:UnCloak()
    end

    return true
end

function SWEP:PreDrop()
    if (self.conceal) then
        self:UnCloak()
    end
end

function SWEP:OnDrop()
    self:Remove()
end --Hopefully this'll work

hook.Add("TTTPrepareRound", "UnCloakAll", function()
    for k, v in pairs(player.GetAll()) do
        v:SetRenderMode(RENDERMODE_NORMAL)
        v:SetColor(Color(255, 255, 255, 0))
    end
end)