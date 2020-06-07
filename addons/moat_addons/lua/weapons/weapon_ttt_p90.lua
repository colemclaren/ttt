AddCSLuaFile()

if CLIENT then
   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/icon_p90"
   SWEP.IconLetter = "m"
end
SWEP.PrintName      = "FN P90"
SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "smg"

SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Delay = 0.05
SWEP.Primary.Recoil = 1
SWEP.Primary.Cone = 0.05
SWEP.Primary.Damage = 12
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 50
SWEP.Primary.ClipMax = 150
SWEP.Primary.DefaultClip = 50
SWEP.Primary.Sound = Sound( "Weapon_P90.Single" )
SWEP.Secondary.Sound = Sound( "Default.Zoom" )

SWEP.Primary.Range = 400
SWEP.Primary.FalloffRange = 800

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 55
SWEP.ViewModel = Model( "models/weapons/cstrike/c_smg_p90.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_smg_p90.mdl" )

SWEP.IronSightsPos = Vector( 5, -15, -2 )
SWEP.IronSightsAng = Vector( 2.6, 1.37, 3.5 )

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = true
SWEP.AmmoEnt = "item_ammo_smg1_ttt"
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = false
SWEP.Scope = true

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 3.4,
	},
}

function SWEP:SetZoom(state)
   	if (not (IsValid(self.Owner) and self.Owner:IsPlayer())) then return end
   	if (state) then
      	self.Owner:SetFOV(20, 0.3)
   	else
      	self.Owner:SetFOV(0, 0.2)
   	end
end

if CLIENT then
   local scope = surface.GetTextureID( "sprites/scope" )
   function SWEP:DrawHUD()
      if self:GetIronsights() then
         surface.SetDrawColor( 0, 0, 0, 255 )

         local scrW = ScrW()
         local scrH = ScrH()

         local x = scrW / 2.0
         local y = scrH / 2.0
         local scope_size = scrH

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

         local sh = scope_size / 2
         local w = ( x - sh ) + 2
         surface.DrawRect( 0, 0, w, scope_size )
         surface.DrawRect( x + sh - 2, 0, w, scope_size )

         surface.DrawLine( 0, 0, scrW, 0 )
         surface.DrawLine( 0, scrH - 1, scrW, scrH - 1 )

         surface.SetDrawColor( 255, 0, 0, 255 )
         surface.DrawLine( x, y, x + 1, y + 1 )

         surface.SetTexture( scope )
         surface.SetDrawColor( 255, 255, 255, 255 )

         surface.DrawTexturedRectRotated( x, y, scope_size, scope_size, 0 )
      else
         return self.BaseClass.DrawHUD( self )
      end
   end

   function SWEP:AdjustMouseSensitivity()
      return ( self:GetIronsights() and 0.2 ) or nil
   end
end


function SWEP:HandleRecoil()
   local eyeang = self:GetOwner():EyeAngles()
   eyeang.p = eyeang.p - (self:GetIronsights() and 0.3 or 1) * self.Primary.Recoil

   self:GetOwner():SetEyeAngles(eyeang)
end

function SWEP:GetCurrentDelay()
	return self.Primary.Delay * (self:GetIronsights() and 2 or 1)
end

function SWEP:GetPrimaryCone()
   return self.Primary.Cone * (self:GetIronsights() and 0.2 or 1)
end

function SWEP:GetCurrentRange()
	return self.Primary.Range * (self:GetIronsights() and 3 or 1)
end

function SWEP:GetCurrentMaxRange()
	return self.Primary.FalloffRange * (self:GetIronsights() and 3 or 1)
end