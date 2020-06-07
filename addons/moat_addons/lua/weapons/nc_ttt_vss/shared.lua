AddCSLuaFile()

SWEP.HoldType           = "ar2"

if CLIENT then
   SWEP.PrintName          = "VSS Silenced"
   SWEP.Slot               = 2
   SWEP.Icon = "VGUI/ttt/icon_vss"
end

SWEP.Base               = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_EQUIP2

SWEP.Primary.Delay          = 0.75
SWEP.Primary.Recoil         = 4
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.Damage = 40
SWEP.Primary.Cone = 0.003
SWEP.Primary.ClipSize = 10
SWEP.Primary.ClipMax = 30 -- keep mirrored to ammo
SWEP.Primary.DefaultClip = 10
SWEP.CanBuy = nil
SWEP.IsSilent = true
SWEP.Scope = true

SWEP.EquipMenuData = {
   type = "Weapon",
   desc = "Deadly Silenced Sniper."
};

SWEP.HeadshotMultiplier = 5

SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_ammo_357_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 76
SWEP.ViewModel          = Model("models/weapons/v_vss_sg552.mdl")
SWEP.WorldModel         = Model("models/weapons/w_vss_sg552.mdl")

SWEP.Primary.Sound = Sound("Weapoz_vss.Single")

SWEP.Secondary.Sound = Sound("Default.Zoom")

SWEP.IronSightsPos      = Vector( 5, -15, -2 )
SWEP.IronSightsAng      = Vector( 2.6, 1.37, 3.5 )

/*if SERVER then
   resource.AddFile("materials/VGUI/ttt/icon_vss.vmt")
   resource.AddFile("materials/VGUI/ttt/icon_vss.vtf")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_bakelite.vmt")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_bits.vmt")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_bits.vtf")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_bits_normal.vtf")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_bullets.vmt")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_chrome.vmt")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_glass.vmt")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_lense.vmt")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_lense.vtf")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_lense_normal.vtf")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_pso.vmt")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_pso.vtf")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_pso_normal.vtf")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_reciever.vmt")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_reciever.vtf")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_reciever_normal.vtf")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_rubber.vmt")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_synth.vmt")
   resource.AddFile("materials/models/weapons/v_models/vintorez/v_vintorez_wood.vmt")
   resource.AddFile("materials/models/weapons/w_models/vintorez/w_vintorez_bits.vmt")
   resource.AddFile("materials/models/weapons/w_models/vintorez/w_vintorez_bits.vtf")
   resource.AddFile("materials/models/weapons/w_models/vintorez/w_vintorez_bits_normal.vtf")
   resource.AddFile("materials/models/weapons/w_models/vintorez/w_vintorez_pso.vmt")
   resource.AddFile("materials/models/weapons/w_models/vintorez/w_vintorez_pso.vtf")
   resource.AddFile("materials/models/weapons/w_models/vintorez/w_vintorez_pso_normal.vtf")
   resource.AddFile("materials/models/weapons/w_models/vintorez/w_vintorez_reciever.vmt")
   resource.AddFile("materials/models/weapons/w_models/vintorez/w_vintorez_reciever.vtf")
   resource.AddFile("materials/models/weapons/w_models/vintorez/w_vintorez_reciever_normal.vtf")
   resource.AddFile("models/weapons/v_vss_sg552.dx80.vtx")
   resource.AddFile("models/weapons/v_vss_sg552.dx90.vtx")
   resource.AddFile("models/weapons/v_vss_sg552.mdl")
   resource.AddFile("models/weapons/v_vss_sg552.sw.vtx")
   resource.AddFile("models/weapons/v_vss_sg552.vvd")
   resource.AddFile("models/weapons/w_vss_sg552.dx80.vtx")
   resource.AddFile("models/weapons/w_vss_sg552.dx90.vtx")
   resource.AddFile("models/weapons/w_vss_sg552.mdl")
   resource.AddFile("models/weapons/w_vss_sg552.phy")
   resource.AddFile("models/weapons/w_vss_sg552.sw.vtx")
   resource.AddFile("models/weapons/w_vss_sg552.vvd")
   resource.AddFile("sound/weapons_nc/vss/sg552_boltpull.wav")
   resource.AddFile("sound/weapons_nc/vss/sg552_clipin.wav")
   resource.AddFile("sound/weapons_nc/vss/sg552_clipout.wav")
   resource.AddFile("sound/weapons_nc/vss/sg552_clipout1.wav")
   resource.AddFile("sound/weapons_nc/vss/sg552_cloth.wav")
   resource.AddFile("sound/weapons_nc/vss/sg552-1.wav")
end*/

function SWEP:SetZoom(state)
    if IsValid(self.Owner) and self.Owner:IsPlayer() then
       if state then
          self.Owner:SetFOV(20, 0.3)
       else
          self.Owner:SetFOV(0, 0.2)
       end
    end
end

-- Add some zoom to ironsights for this gun
function SWEP:SecondaryAttack()
    if not self.IronSightsPos then return end
    if self:GetNextSecondaryFire() > CurTime() then return end

    bIronsights = not self:GetIronsights()

    self:SetIronsights( bIronsights )

    self:SetZoom(bIronsights)
    
    if (CLIENT) then
        self:EmitSound(self.Secondary.Sound)
    end

    self:SetNextSecondaryFire( CurTime() + 0.3)
end

function SWEP:PreDrop()
    self:SetZoom(false)
    self:SetIronsights(false)
    return self.BaseClass.PreDrop(self)
end

function SWEP:Reload()
	if ( self:Clip1() == self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then return end
    self:DefaultReload( ACT_VM_RELOAD )
    self:SetIronsights( false )
    self:SetZoom( false )
end


function SWEP:Holster()
    self:SetIronsights(false)
    self:SetZoom(false)
    return true
end

if CLIENT then
   local scope = surface.GetTextureID("sprites/scope")
   function SWEP:DrawHUD()
      if self:GetIronsights() then
         surface.SetDrawColor( 0, 0, 0, 255 )
         
         local x = ScrW() / 2.0
         local y = ScrH() / 2.0
         local scope_size = ScrH()

         -- crosshair
         local gap = 80
         local length = scope_size
         surface.DrawLine( x - length, y, x - gap, y )
         surface.DrawLine( x + length, y, x + gap, y )
         surface.DrawLine( x, y - length, x, y - gap )
         surface.DrawLine( x, y + length, x, y + gap )

         gap = 0
         length = 50
         surface.DrawLine( x - length, y, x - gap, y )
         surface.DrawLine( x + length, y, x + gap, y )
         surface.DrawLine( x, y - length, x, y - gap )
         surface.DrawLine( x, y + length, x, y + gap )


         -- cover edges
         local sh = scope_size / 2
         local w = (x - sh) + 2
         surface.DrawRect(0, 0, w, scope_size)
         surface.DrawRect(x + sh - 2, 0, w, scope_size)

         surface.SetDrawColor(255, 0, 0, 255)
         surface.DrawLine(x, y, x + 1, y + 1)

         -- scope
         surface.SetTexture(scope)
         surface.SetDrawColor(255, 255, 255, 255)

         surface.DrawTexturedRectRotated(x, y, scope_size, scope_size, 0)

      else
         return self.BaseClass.DrawHUD(self)
      end
   end

   function SWEP:AdjustMouseSensitivity()
      return (self:GetIronsights() and 0.2) or nil
   end
end
