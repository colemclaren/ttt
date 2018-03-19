--[[
// Variables that are used on both client and server
SWEP.Instructions			= "Uses 12 Gauge Buckshot, Switch Weapons: E + Left Click"
SWEP.Base 				= "weapon_fas_sim_base"

SWEP.HoldType				= "ar2"
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/a_m3.mdl"
SWEP.WorldModel			= "models/weapons/b_m3s90.mdl"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapof_M3S90.Shoot")
SWEP.Primary.Recoil		= 6
SWEP.Primary.Damage		= 4.3
SWEP.Primary.NumShots		= 20
SWEP.Primary.Cone			= 0.065
SWEP.Primary.Delay 		= 0.35

SWEP.Primary.ClipSize		= 8					// Size of a clip
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "Buckshot"

SWEP.ShellDelay			= 0.04
SWEP.ShellEffect			= "sim_shelleject_fas_12gabuck"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.IronSightsPos = Vector (-2.2631, -4.0007, 1.6813)
SWEP.IronSightsAng = Vector (0.2298, 0.0043, 0)
SWEP.RunArmOffset  = Vector (4.0928, 0.4246, 2.3712)
SWEP.RunArmAngle   = Vector (-18.4406, 33.1846, 0)

SWEP.Speed = 0.6
SWEP.Mass = 0.8
SWEP.WeaponName = "weapon_fas_m3s90"
SWEP.WeaponEntName = "sim_fas_m3s90"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_Boltcatch.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_distance_fire1.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_distance_fire2.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_distance_fire3.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_distance_fire4.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_distance_fire5.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_fire1.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_fire2.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_fire3.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_fire4.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_fire5.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_getammo1.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_getammo2.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_getammo3.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_load1.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_load2.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_load3.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_load4.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_load5.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_load6.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_load7.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_load8.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_pumpback.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_pumpforward.wav")
    	util.PrecacheSound("weapons/shotgun_m3s90p/m3s90_restock.wav")
end

/*---------------------------------------------------------
   Name: SWEP:ShootAnimation()
---------------------------------------------------------*/
function SWEP:ShootAnimation()

	if (self.Weapon:Clip1() == 0) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("fire_last"))
	else
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	end

end

/*---------------------------------------------------------
   Name: SWEP:ReloadAnimation()
---------------------------------------------------------*/
function SWEP:ReloadAnimation()
	
	if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) > 7) then
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload8"))
	end
	if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) == 1) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload1_empty"))	
	end
	if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) == 2) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload2_empty"))		
	end
	if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) == 3) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload3_empty"))	
	end
	if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) == 4) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload4_empty"))
	end
	if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) == 5) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload5_empty"))
	end
	if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) == 6) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload6_empty"))
	end
	if (self.Weapon:Clip1() == 0) and (self.Owner:GetAmmoCount(self.Primary.Ammo) == 7) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload7_empty"))
	end
	if (self.Weapon:Clip1() == 1) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload1"))	
	end
	if (self.Weapon:Clip1() == 1) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 2) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload2"))	
	end
	if (self.Weapon:Clip1() == 1) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 3) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload3"))
	end
	if (self.Weapon:Clip1() == 1) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 4) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload4"))
	end
	if (self.Weapon:Clip1() == 1) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 5) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload5"))
	end
	if (self.Weapon:Clip1() == 1) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 6) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload6"))
	end
	if (self.Weapon:Clip1() == 1) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 7) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload7"))
	end
	if (self.Weapon:Clip1() == 2) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload1"))	
	end
	if (self.Weapon:Clip1() == 2) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 2) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload2"))	
	end
	if (self.Weapon:Clip1() == 2) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 3) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload3"))
	end
	if (self.Weapon:Clip1() == 2) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 4) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload4"))
	end
	if (self.Weapon:Clip1() == 2) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 5) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload5"))
	end
	if (self.Weapon:Clip1() == 2) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 6) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload6"))
	end
	if (self.Weapon:Clip1() == 3) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload1"))
	end
	if (self.Weapon:Clip1() == 3) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 2) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload2"))
	end
	if (self.Weapon:Clip1() == 3) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 3) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload3"))
	end
	if (self.Weapon:Clip1() == 3) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 4) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload4"))
	end
	if (self.Weapon:Clip1() == 3) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 5) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload5"))
	end
	if (self.Weapon:Clip1() == 4) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload1"))
	end
	if (self.Weapon:Clip1() == 4) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 2) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload2"))	
	end
	if (self.Weapon:Clip1() == 4) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 3) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload3"))
	end
	if (self.Weapon:Clip1() == 4) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 4) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload4"))
	end
	if (self.Weapon:Clip1() == 5) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload1"))		
	end
	if (self.Weapon:Clip1() == 5) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 2) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload2"))	
	end
	if (self.Weapon:Clip1() == 5) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 3) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload3"))
	end
	if (self.Weapon:Clip1() == 6) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload1"))	
	end
	if (self.Weapon:Clip1() == 6) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 2) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload2"))	
	end
	if (self.Weapon:Clip1() == 7) and (self.Owner:GetAmmoCount(self.Primary.Ammo) >= 1) then 
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("reload1"))
	end
	if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
 
	if ( self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
       	    	     local AnimationTime = self.Owner:GetViewModel():SequenceDuration()
       	    	     self.ReloadingTime = CurTime() + AnimationTime
       	    	     self:SetNextPrimaryFire(CurTime() + AnimationTime)
       	    	     self:SetNextSecondaryFire(CurTime() + AnimationTime)
	end

end
-]]

AddCSLuaFile()

SWEP.HoldType			= "shotgun"

if CLIENT then
   SWEP.PrintName = "Benelli TE"

   SWEP.Slot = 2
   SWEP.Icon = "vgui/ttt/icon_shotgun"
   SWEP.IconLetter = "B"
end
SWEP.PrintName = "Benelli TE"

SWEP.Base				= "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_SHOTGUN

SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.Damage = 7
SWEP.Primary.Cone = 0.2
SWEP.Primary.Delay = 0.55 + 0.2
SWEP.Primary.ClipSize = 8
SWEP.Primary.ClipMax = 24
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic = true
SWEP.Primary.NumShots = 10
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_box_buckshot_ttt"

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel			= "models/weapons/a_m3.mdl"
SWEP.WorldModel			= "models/weapons/b_m3s90.mdl"
SWEP.Primary.Sound			= Sound("Weapof_M3S90.Shoot")
SWEP.Primary.Recoil			= 7

SWEP.IronSightsPos = Vector (-2.2631, -4.0007, 1.6813)
SWEP.IronSightsAng = Vector (0.2298, 0.0043, 0)

SWEP.reloadtimer = 0

function SWEP:SetupDataTables()
   --self:DTVar("Bool", 0, "reloading")

   return self.BaseClass.SetupDataTables(self)
end

function SWEP:Reload()
	if ( self:Clip1() == self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then return end
	self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
	local Animation = self.Owner:GetViewModel()
	local seq = Animation:LookupSequence("reload4")
	Animation:SetSequence(seq)

   self:DefaultReload(Animation:GetSequenceActivity(seq))
   --self:ReloadAnimation()
   self:SetIronsights( false )
end

/*
function SWEP:Reload()

   --if self:GetNetworkedBool( "reloading", false ) then return end
   if self.dt.reloading then return end

   if not IsFirstTimePredicted() then return end

   if self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then

      if self:StartReload() then
         return
      end
   end

end

function SWEP:StartReload()
   --if self:GetNWBool( "reloading", false ) then
   if self.dt.reloading then
      return false
   end

   self:SetIronsights( false )

   if not IsFirstTimePredicted() then return false end

   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   local ply = self.Owner

   if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then
      return false
   end

   local wep = self

   if wep:Clip1() >= self.Primary.ClipSize then
      return false
   end

   wep:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)

   self.reloadtimer =  CurTime() + wep:SequenceDuration()

   --wep:SetNWBool("reloading", true)
   self.dt.reloading = true

   return true
end

function SWEP:PerformReload()
   local ply = self.Owner

   -- prevent normal shooting in between reloads
   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then return end

   if self:Clip1() >= self.Primary.ClipSize then return end

   self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
   self:SetClip1( self:Clip1() + 1 )

   self:SendWeaponAnim(ACT_VM_RELOAD)

   self.reloadtimer = CurTime() + self:SequenceDuration()
end

function SWEP:FinishReload()
   self.dt.reloading = false
   self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)

   self.reloadtimer = CurTime() + self:SequenceDuration()
end*/

function SWEP:CanPrimaryAttack()
   if self:Clip1() <= 0 then
      self:EmitSound( "Weapon_Shotgun.Empty" )
      self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
      return false
   end
   return true
end

function SWEP:Think()
   if self.dt.reloading and IsFirstTimePredicted() then
      if self.Owner:KeyDown(IN_ATTACK) then
         self:FinishReload()
         return
      end

      if self.reloadtimer <= CurTime() then

         if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
            self:FinishReload()
         elseif self:Clip1() < self.Primary.ClipSize then
            self:PerformReload()
         else
            self:FinishReload()
         end
         return
      end
   end
end

function SWEP:Deploy()
   self.dt.reloading = false
   self.reloadtimer = 0
   return self.BaseClass.Deploy(self)
end

-- The shotgun's headshot damage multiplier is based on distance. The closer it
-- is, the more damage it does. This reinforces the shotgun's role as short
-- range weapon by reducing effectiveness at mid-range, where one could score
-- lucky headshots relatively easily due to the spread.

function SWEP:SecondaryAttack()
   if self.NoSights or (not self.IronSightsPos) or self.dt.reloading then return end
   --if self:GetNextSecondaryFire() > CurTime() then return end

   self:SetIronsights(not self:GetIronsights())

   self:SetNextSecondaryFire(CurTime() + 0.3)
end
