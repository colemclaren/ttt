// Variables that are used on both client and server
-- Major thanks to rm-rf / for thinking up a solution to the reload glitch. Good man!

SWEP.Category				= ""
SWEP.Author				= "Generic Default, Worshipper, Clavus, and Bob"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.Base 				= "bobs_gun_base"
SWEP.MuzzleAttachment			= "1" 		// Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 		// Should be "2" for CSS models or "1" for hl2 models
SWEP.DrawCrosshair			= true		// Hell no, crosshairs r 4 nubz!
SWEP.ViewModelFOV			= 65		// How big the gun will look
SWEP.ViewModelFlip			= true		// True for CSS models, False for HL2 models

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= false

SWEP.Primary.Sound 			= Sound("")				// Sound of the gun
SWEP.Primary.RPM				= 0					// This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 0					// Size of a clip
SWEP.Primary.DefaultClip			= 0					// Default number of bullets in a clip
SWEP.Primary.KickUp			= 0					// Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0					// Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal			= 0					// Maximum side recoil (koolaid)
SWEP.Primary.Automatic			= true					// Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"					// What kind of ammo
SWEP.Primary.Reloading			= false					// Reloading func

-- SWEP.Secondary.ClipSize			= 0					// Size of a clip
-- SWEP.Secondary.DefaultClip			= 0					// Default number of bullets in a clip
-- SWEP.Secondary.Automatic			= false					// Automatic/Semi Auto
SWEP.Secondary.Ammo			= ""
SWEP.Secondary.IronFOV			= 0					// How much you 'zoom' in. Less is more! 

SWEP.data 				= {}					-- The starting firemode
SWEP.data.ironsights			= 1

SWEP.IronSightsPos = Vector (2.4537, 1.0923, 0.2696)
SWEP.IronSightsAng = Vector (0.0186, -0.0547, 0)

SWEP.ShotgunReloading		= false
SWEP.ShotgunFinish		= 0.5
SWEP.ShellTime		= 0.35
SWEP.InsertingShell	=		false

SWEP.NextReload	=	0

/*---------------------------------------------------------
   Name: SWEP:Think()
   Desc: Called every frame.
---------------------------------------------------------*/
function SWEP:Think()
	if not IsValid(self) then return end
	if not IsValid(self.Owner) then return end
	if not self.Owner:IsPlayer() then return end
	if self.Owner.NextReload == nil then self.Owner.NextReload = CurTime() + 1 end
	local timerName = "ShotgunReload_" ..  self.Owner:UniqueID()
	--if the owner presses shoot while the timer is in effect, then...
	if (self.Owner:KeyPressed(IN_ATTACK)) and (self.Weapon:GetNextPrimaryFire() <= CurTime()) and (timer.Exists(timerName)) and not (self.Owner:KeyDown(IN_SPEED)) then
		if self:CanPrimaryAttack() then --well first, if we actually can attack, then...
		
			timer.Destroy(timerName) -- kill the timer, and
			self:PrimaryAttack()-- ATTAAAAACK!
			
		end
	end
	
	if self.InsertingShell == true and self.Owner:Alive() then
		vm = self.Owner:GetViewModel()-- its a messy way to do it, but holy shit, it works!
		vm:ResetSequence(vm:LookupSequence("after_reload")) -- Fuck you, garry, why the hell can't I reset a sequence in multiplayer?
		vm:SetPlaybackRate(.01) -- or if I can, why does facepunch have to be such a shitty community, and your wiki have to be an unreadable goddamn mess?
		self.InsertingShell = false -- You get paid for this, what's your excuse?
	end
	
	self:IronSight()
	
end

/*---------------------------------------------------------
   Name: SWEP:Deploy()
   Desc: Whip it out.
---------------------------------------------------------*/
function SWEP:Deploy()
	if not IsValid(self) then return end
	if not IsValid(self.Owner) then return end
	if not self.Owner:IsPlayer() then return end
	
	self:SetHoldType(self.HoldType)
	
	local timerName = "ShotgunReload_" ..  self.Owner:UniqueID()
	if (timer.Exists(timerName)) then
		timer.Destroy(timerName)
	end

	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)

	self.Weapon:SetNextPrimaryFire(CurTime() + .25)
	self.Weapon:SetNextSecondaryFire(CurTime() + .25)
	self.ActionDelay = (CurTime() + .25)

	if (SERVER) then
		self:SetIronsights(false)
	end
	
	self.Owner.NextReload = CurTime() + 1

	return true
end

/*---------------------------------------------------------
   Name: SWEP:Reload()
   Desc: Reload is being pressed.
---------------------------------------------------------*/
function SWEP:Reload()

	if not IsValid(self) then return end
	if not IsValid(self.Owner) then return end
	if not self.Owner:IsPlayer() then return end

	local maxcap = self.Primary.ClipSize
	local spaceavail = self.Weapon:Clip1()
	local shellz = (maxcap) - (spaceavail) + 1

	if (timer.Exists("ShotgunReload_" ..  self.Owner:UniqueID())) or self.Owner.NextReload > CurTime() or maxcap == spaceavail then return end
	
	if self.Owner:IsPlayer() then 

		if self.Weapon:GetNextPrimaryFire() <= (CurTime()+2) then
			self.Weapon:SetNextPrimaryFire(CurTime() + 2) -- wait TWO seconds before you can shoot again
		end
		self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START) -- sending start reload anim
		self.Owner:SetAnimation( PLAYER_RELOAD )
		
		self.Owner.NextReload = CurTime() + 1
	
		if (SERVER) then
			self.Owner:SetFOV( 0, 0.15 )
			self:SetIronsights(false)
		end
	
		if SERVER and self.Owner:Alive() then
			local timerName = "ShotgunReload_" ..  self.Owner:UniqueID()
			timer.Create(timerName, 
			(self.ShellTime + .05), 
			shellz,
			function() if not IsValid(self) then return end 
			if IsValid(self.Owner) and IsValid(self.Weapon) then 
				if self.Owner:Alive() then 
					self:InsertShell()
				end 
			end end)
		end
	
	elseif self.Owner:IsNPC() then
		self.Weapon:DefaultReload(ACT_VM_RELOAD) 
	end
	
end

function SWEP:InsertShell()

	if not IsValid(self) then return end
	if not IsValid(self.Owner) then return end
	if not self.Owner:IsPlayer() then return end
	
	local timerName = "ShotgunReload_" ..  self.Owner:UniqueID()
	if self.Owner:Alive() then
		local curwep = self.Owner:GetActiveWeapon()
		if curwep:GetClass() != self.Gun then 
			timer.Destroy(timerName)
		return end
	
		if (self.Weapon:Clip1() >= self.Primary.ClipSize or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0) then
		-- if clip is full or ammo is out, then...
			self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH) -- send the pump anim
			timer.Destroy(timerName) -- kill the timer
		elseif (self.Weapon:Clip1() <= self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) >= 0) then
			self.InsertingShell = true --well, I tried!
			timer.Simple( .05, function() self:ShellAnimCaller() end)
			self.Owner:RemoveAmmo(1, self.Primary.Ammo, false) -- out of the frying pan
			self.Weapon:SetClip1(self.Weapon:Clip1() + 1) --  into the fire
		end
	else
		timer.Destroy(timerName) -- kill the timer
	end
	
end

function SWEP:ShellAnimCaller()
	self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
end
