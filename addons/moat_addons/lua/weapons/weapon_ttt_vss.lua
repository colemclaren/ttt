AddCSLuaFile()

SWEP.HoldType           = "ar2"

SWEP.PrintName          = "VSS"
SWEP.Slot               = 2
SWEP.Icon = "VGUI/ttt/icon_vss"

SWEP.Base               = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Delay          = 0.13
SWEP.Primary.Recoil         = 2.5
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Damage = 40
SWEP.Primary.Cone = 0.003
SWEP.Primary.ClipSize = 12
SWEP.Primary.ClipMax = 36
SWEP.Primary.DefaultClip = 12
SWEP.IsSilent = true
SWEP.Scope = true

SWEP.EquipMenuData = {
   type = "Weapon",
   desc = "Deadly Silenced Sniper."
}

SWEP.AutoSpawnable      = true
SWEP.AmmoEnt 			= "item_ammo_pistol_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 90
SWEP.ViewModel          = Model "models/weapons/v_vss_sg552.mdl"
SWEP.WorldModel         = Model  "models/weapons/w_vss_sg552.mdl"

SWEP.Primary.Sound = Sound("Weapoz_vss.Single")

SWEP.Secondary.Sound = Sound("Default.Zoom")

SWEP.IronSightsPos = Vector( 5, -15, -2 )
SWEP.IronSightsAng = Vector( 2.6, 1.37, 3.5 )

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

	self:SetIronsights(bIronsights)

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
	if (self:Clip1() == self.Primary.ClipSize or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0) then return end
	self:DefaultReload(ACT_VM_RELOAD)
	self:SetIronsights(false)
	self:SetZoom(false)
	self:SetInaccuracyTime(0)
	self:SetInaccuracyPercent(0)
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

DEFINE_BASECLASS "weapon_tttbase"
function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)
	self:NetworkVar("Float", 0, "InaccuracyPercent")
	self:NetworkVar("Float", 1, "InaccuracyTime")
end

function SWEP:GetCurrentInaccacuracy()
	local pct = self:GetInaccuracyPercent()
	local time = self:GetInaccuracyTime()
	local curtime = CurTime()

	return math.max(0, pct - (curtime - time) * 2)
end

function SWEP:Initialize()
	BaseClass.Initialize(self)
	self:SetInaccuracyTime(0)
	self:SetInaccuracyPercent(0)
end

function SWEP:ModifySpreadBasedOnShots(conex, coney)
	local inacc = self:GetCurrentInaccacuracy() ^ 1.2 * 150
	return conex * inacc, coney * inacc
end

function SWEP:GetHeadshotMultiplier(vic, dmginfo)
	local att = dmginfo:GetAttacker()
	if not IsValid(att) then return 5 end


	return 1.2 + 3.8 * (math.min(4000, math.max(0, vic:GetPos():Distance(att:GetPos()))) / 4000)
end


function SWEP:ShootBullet(dmg, recoil, numbul, conex, coney)
	BaseClass.ShootBullet(self, dmg, recoil, numbul, self:ModifySpreadBasedOnShots(conex, coney))
	self:SetInaccuracyPercent(math.min(1, self:GetCurrentInaccacuracy() + 0.4))
	self:SetInaccuracyTime(CurTime())
end