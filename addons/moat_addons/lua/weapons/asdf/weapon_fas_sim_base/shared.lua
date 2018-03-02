
local Sound = Sound
local Vector = Vector
local CreateConVar = CreateConVar
local CurTime = CurTime
local IsFirstTimePredicted = IsFirstTimePredicted
local Angle = Angle
local EffectData = EffectData
local SinglePlayer = SinglePlayer
local FrameTime = FrameTime
local IsValid = IsValid
local WorldSound = WorldSound
local util = util
local hook = hook
local math = math
local timer = timer
local ents = ents
local ACT_VM_IDLE = ACT_VM_IDLE
local PLAYERANIMEVENT_CUSTOM_GESTURE = PLAYERANIMEVENT_CUSTOM_GESTURE
local GESTURE_SLOT_ATTACK_AND_RELOAD = GESTURE_SLOT_ATTACK_AND_RELOAD
local ACT_MP_ATTACK_CROUCH_PRIMARYFIRE = ACT_MP_ATTACK_CROUCH_PRIMARYFIRE
local ACT_MP_ATTACK_STAND_PRIMARYFIRE = ACT_MP_ATTACK_STAND_PRIMARYFIRE
local FCVAR_REPLICATED = FCVAR_REPLICATED
local FCVAR_ARCHIVE = FCVAR_ARCHIVE
local ACT_VM_DRAW_EMPTY = ACT_VM_DRAW_EMPTY
local ACT_VM_DRAW_SILENCED = ACT_VM_DRAW_SILENCED
local ACT_VM_DRAW = ACT_VM_DRAW
local IN_SPEED = IN_SPEED
local ACT_VM_IDLE_SILENCED = ACT_VM_IDLE_SILENCED
local ACT_VM_IDLE_EMPTY = ACT_VM_IDLE_EMPTY
local IN_FORWARD = IN_FORWARD
local IN_BACK = IN_BACK
local IN_MOVELEFT = IN_MOVELEFT
local IN_MOVERIGHT = IN_MOVERIGHT
local HUD_PRINTTALK = HUD_PRINTTALK
local ACT_VM_RELOAD = ACT_VM_RELOAD
local ACT_VM_RELOAD_SILENCED = ACT_VM_RELOAD_SILENCED
local ACT_VM_RELOAD_EMPTY = ACT_VM_RELOAD_EMPTY
local IN_USE = IN_USE
local ACT_INVALID = ACT_INVALID
local IN_DUCK = IN_DUCK
local SERVER = SERVER
local CLIENT = CLIENT
local MAT_GLASS = MAT_GLASS
local MAT_SAND = MAT_SAND
local MAT_FLESH = MAT_FLESH
local MAT_ALIENFLESH = MAT_ALIENFLESH
local MAT_WOOD = MAT_WOOD
local MAT_CONCRETE = MAT_CONCRETE
local MAT_PLASTIC = MAT_PLASTIC

game.AddAmmoType( 
{
    name        =   "ninemmgerman",
    dmgtype     =   DMG_BULLET
})
game.AddAmmoType( 
{
    name        =   "ninemmrussian",
    dmgtype     =   DMG_BULLET
})
game.AddAmmoType( 
{
    name        =   "ninemmshort",
    dmgtype     =   DMG_BULLET
})
game.AddAmmoType( 
{
    name        =   "tenmmauto",
    dmgtype     =   DMG_BULLET
})
game.AddAmmoType( 
{
    name        =   "fourtyfiveacp",
    dmgtype     =   DMG_BULLET
})
game.AddAmmoType( 
{
    name        =   "fiftyae",
    dmgtype     =   DMG_BULLET
})
game.AddAmmoType( 
{
    name        =   "fiftybmg",
    dmgtype     =   DMG_BULLET
})
game.AddAmmoType( 
{
    name        =   "fivefivesix",
    dmgtype     =   DMG_BULLET
})
game.AddAmmoType( 
{
    name        =   "sevensixtwobyfiftyone",
    dmgtype     =   DMG_BULLET
})
game.AddAmmoType( 
{
    name        =   "sevensixtwoshort",
    dmgtype     =   DMG_BULLET
})
game.AddAmmoType( 
{
    name        =   "shotgunshell",
    dmgtype     =   DMG_BULLET
})
game.AddAmmoType( 
{
    name        =   "flaregrenade",
    dmgtype     =   DMG_BULLET
})
game.AddAmmoType( 
{
    name        =   "flashgrenade",
    dmgtype     =   DMG_BULLET
})
game.AddAmmoType( 
{
    name        =   "fraggrenade",
    dmgtype     =   DMG_BULLET
})
game.AddAmmoType( 
{
    name        =   "smokegrenade",
    dmgtype     =   DMG_BULLET
})
game.AddAmmoType( 
{
    name        =   "fourtymmgrenade",
    dmgtype     =   DMG_BULLET
})


// Variables that are used on both client and server

local RecoilMul = CreateConVar ("mad_recoilmul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local DamageMul = CreateConVar ("mad_damagemul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local AccuracyMul = CreateConVar ("sim_accuracymul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local Walkspeed = CreateConVar ("sim_walk_speed", "250", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local Runspeed = CreateConVar ("sim_run_speed", "500", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local WeightMod	= CreateConVar("sim_weightmod_t", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})		
local ManualHolster	= CreateConVar("sim_manualholster_t", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})		
local EnableShell	= CreateConVar("sim_shell_t", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})		
local EnableFlash	= CreateConVar("sim_flash_t", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})		

SWEP.Category			= "Firearms Source Sweps"
SWEP.HoldType				= "pistol"
SWEP.Author				= "Siminov + Readme"
SWEP.Contact			= ""
SWEP.ViewModelFOV      		= 55
// I have nothing to say here because I'm a nagger
SWEP.Purpose			= ""
SWEP.Instructions			= "Rate Me Informatives"


SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/v_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"
SWEP.AnimPrefix			= "python"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound		= Sound("Weapon_AK47.Single")
SWEP.Primary.Recoil		= 10
SWEP.Primary.Damage		= 10
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0
SWEP.Primary.Delay 		= 0

SWEP.Primary.ClipSize		= 5					// Size of a clip
SWEP.Primary.DefaultClip	= 5					// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ActionDelay			= CurTime()

// I added this function because some weapons like the Day of Defeat weapons need 1.2 or 1.5 seconds to deploy
SWEP.DeployDelay			= 1

SWEP.ShellEffect			= "sim_shelleject" 
SWEP.ShellDelay			= 0

// Is it a pistol, a rifle, a shotgun or a sniper? Choose only one of them or you'll fucked up everything. BITCH!
SWEP.Pistol				= false
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos 		= Vector (0, 0, 0)
SWEP.IronSightsAng 		= Vector (0, 0, 0)
SWEP.RunArmOffset 		= Vector (0, 0, 5.5)
SWEP.RunArmAngle 		= Vector (-35, -3, 0)


// Burst options
SWEP.Burst				= false
SWEP.BurstShots			= 3
SWEP.BurstDelay			= 0.05
SWEP.BurstCounter			= 0
SWEP.BurstTimer			= 0

// Custom mode options (Do not put a burst mode and a custom mode at the same time, it will not work)
SWEP.Type				= 1 					// 1 = Automatic/Semi-Automatic mode, 2 = Suppressor mode, 3 = Burst fire mode
SWEP.Mode				= false

SWEP.data 				= {}
SWEP.data.NormalMsg		= "Switched to automatic."
SWEP.data.ModeMsg			= "Switched to semi-automatic."
SWEP.data.Delay			= 1 				// You need to wait 0.5 second after you change the fire mode
SWEP.data.Cone			= 1.0
SWEP.data.Damage			= 1.0
SWEP.data.Recoil			= 1.0
SWEP.data.Automatic		= false

// Constant accuracy means that your crosshair will not change if you're running, shooting or walking
SWEP.ConstantAccuracy		= false

// I don't think it's hard to understand this
SWEP.Penetration			= true
SWEP.Ricochet			= false

SWEP.Tracer				= 0					// 0 = Normal Tracer, 1 = Ar2 Tracer, 2 = Airboat Gun Tracer, 3 = Normal Tracer + Sparks Impact

SWEP.IdleDelay			= 0
SWEP.IdleApply			= false
SWEP.AllowIdleAnimation		= true
SWEP.AllowPlaybackRate		= true

SWEP.BoltActionSniper		= false				// Use this value if you want to remove the scope view after you shoot
SWEP.ScopeAfterShoot		= false				// Do not try to change this value

SWEP.IronSightZoom 		= 1.5
SWEP.ScopeZooms			= {10}
SWEP.ScopeScale 			= 0.4
SWEP.FirstDraw = false
SWEP.ShotgunReloading		= false
SWEP.ShotgunFinish		= 0.5
SWEP.ShotgunBeginReload		= 0.3

SWEP.Speed = 0.5 // Slow down multiplier for ironsights
SWEP.Mass = 0.9  // Slow down multiplier for weight of swep
SWEP.WeaponName = ""
SWEP.WeaponEntName = ""
/*---------------------------------------------------------
   Name: SWEP:Initialize()
   Desc: Called when the weapon is first loaded.
---------------------------------------------------------*/
function SWEP:Initialize()
	
	self:SetWeaponHoldType(self.HoldType)
	if (SERVER) then
		self.Reloadaftershoot = 0 
	end
end

/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

	util.PrecacheSound("weapons/universal/weaponempty.wav")
end

/*---------------------------------------------------------
   Name: ENT:SetupDataTables()
   Desc: Setup the data tables.
---------------------------------------------------------*/
function SWEP:SetupDataTables()  

	self:DTVar("Bool", 0, "Holsted")
	self:DTVar("Bool", 1, "Ironsights")
	self:DTVar("Bool", 2, "Scope")
	self:DTVar("Bool", 3, "Mode")
end 

/*---------------------------------------------------------
   Name: SWEP:ResetSpeed()
   Desc: Reset all varibles.
---------------------------------------------------------*/
function SWEP:ResetSpeed()
	self.Owner:SetRunSpeed(Runspeed:GetFloat())
	self.Owner:SetWalkSpeed(Walkspeed:GetFloat())
end


/*---------------------------------------------------------
   Name: SWEP:IdleAnimation()
   Desc: Are you seriously too stupid to understand the function by yourself?
---------------------------------------------------------*/
function SWEP:IdleAnimation(time)
	
	self.IdleApply = true
	self.ActionDelay = CurTime() + time
	self.IdleDelay = CurTime() + time
end

/*---------------------------------------------------------
   Name: SWEP:ResetVariables()
   Desc: Reset all varibles.
---------------------------------------------------------*/
function SWEP:ResetVariables()

	self.Weapon:SetDTBool(1, false)
	self.Weapon:SetDTBool(2, false)
	self.Owner:SetRunSpeed(self.Runspeed*self.Mass)
	self.Owner:SetWalkSpeed(self.Walkspeed*self.Mass)
	self.Weapon:SetNetworkedFloat("ScopeZoom", self.ScopeZooms[1])
	
end

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack()
   Desc: +attack1 has been pressed.
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
		// Holst/Deploy your fucking weapon

	if (not self.Owner:KeyDown(IN_SPEED) and not self.Owner:KeyDown(IN_RELOAD) and self.Owner:KeyDown(IN_USE)) then
		
		if (SERVER) then
			bHolsted = !self.Weapon:GetDTBool(0)
			self:SetHolsted(bHolsted)
		end

		self.Weapon:SetNextPrimaryFire(CurTime() + 1.0)
		self.Weapon:SetNextSecondaryFire(CurTime() + 1.0)

		self:SetIronsights(false)

		return
	end
	
	if (not self:CanPrimaryAttack()) then return end
	
	self.Reloadaftershoot = CurTime() + self.Primary.Delay
	self.ActionDelay = (CurTime() + self.Primary.Delay + 0.05)
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

	// If the burst mode is activated, it's going to shoot the three bullets (or more if you're dumb and put 4 or 5 bullets for your burst mode)
	if self.Weapon:GetDTBool(3) and self.Type == 3 then
		self.BurstTimer 	= CurTime()
		self.BurstCounter = self.BurstShots - 1
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
	end

	self.Weapon:EmitSound(self.Primary.Sound)

	self:TakePrimaryAmmo(1)

	self:ShootBulletInformation()
end

/*---------------------------------------------------------
   Name: SWEP:SecondaryAttack()
   Desc: +attack2 has been pressed.
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	if not IsFirstTimePredicted() then return end

	if (self.Owner:KeyDown(IN_USE) and (self.Mode)) then // Mode
		bMode = !self.Weapon:GetDTBool(3)
		self:SetMode(bMode)
		self:SetIronsights(false)

		self.Weapon:SetNextPrimaryFire(CurTime() + self.data.Delay)
		self.Weapon:SetNextSecondaryFire(CurTime() + self.data.Delay)

		return
	end

	if (!self.IronSightsPos) or (self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0)) then return end
	
	// Not pressing Use + Right click? Ironsights
	bIronsights = !self.Weapon:GetDTBool(1)
	self:SetIronsights(bIronsights)	
	self.Weapon:SetNextPrimaryFire(CurTime() + 0.2)
	self.Weapon:SetNextSecondaryFire(CurTime() + 0.2)
end
/*---------------------------------------------------------
   Name: SWEP:SetHolsted()
---------------------------------------------------------*/
function SWEP:SetHolsted(b)

	if (self.Owner) then
		if (b) then
			if (self.Weapon:Clip1() == 0) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("holster_empty"))
			else
				self.Weapon:SendWeaponAnim(ACT_VM_HOLSTER)
			end		
		else
			if (self.Weapon:Clip1() == 0) then
			
				self.Weapon:SendWeaponAnim(ACT_VM_DRAW_EMPTY)
			else
				self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
			end
		end
	end
	
	if (self.Weapon) then
		self.Weapon:SetDTBool(0, b)
	end
end
/*---------------------------------------------------------
   Name: SWEP:SetIronsights()
---------------------------------------------------------*/
function SWEP:SetIronsights(b)

	if (self.Owner) then
		if (b) then
			if (SERVER) then
				self.Owner:SetFOV(65, 0.2)
			end
	
			if self.AllowIdleAnimation then
		
				if (self.Weapon:Clip1() == 0) then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE_EMPTY)
				else
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				end
				
				self.Owner:GetViewModel():SetPlaybackRate(0)
			end

			if WeightMod:GetBool() then
				self.Weapon:EmitSound("Defaulf.Iron_In")
				self.Owner:SetRunSpeed(Walkspeed:GetFloat()*self.Speed*self.Mass)
				self.Owner:SetWalkSpeed(Walkspeed:GetFloat()*self.Speed*self.Mass)
			else
				self.Weapon:EmitSound("Defaulf.Iron_In")
			end
		else
			if (SERVER) then
				self.Owner:SetFOV(0, 0.2)
			end

			if self.AllowPlaybackRate and self.AllowIdleAnimation then
				self.Owner:GetViewModel():SetPlaybackRate(1)
			end	
			if WeightMod:GetBool() then
				self.Owner:SetRunSpeed(Runspeed:GetFloat()*self.Mass)
				self.Owner:SetWalkSpeed(Walkspeed:GetFloat()*self.Mass)
				self.Weapon:EmitSound("Defaulf.Iron_Out")
			else
				self.Weapon:EmitSound("Defaulf.Iron_Out")
			end
		end
	end

	if (self.Weapon) then
		self.Weapon:SetDTBool(1, b)
	end
end

/*---------------------------------------------------------
   Name: SWEP:SetMode()
---------------------------------------------------------*/
function SWEP:SetMode(b)

	if (self.Owner) then
		if (b) then
			if self.Type == 1 then
				self.Primary.Automatic = self.data.Automatic
				self.Weapon:EmitSound("Weapof_Misc.Switch")
			elseif self.Type == 2 then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("sup_on"))
				
				if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
					self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
				end
			elseif self.Type == 3 then
				self.Weapon:EmitSound("Weapof_Misc.Switch")
			end

			if (SERVER) then
				self.Owner:PrintMessage(HUD_PRINTTALK, self.data.ModeMsg)
			end
		else
			if self.Type == 1 then
				self.Primary.Automatic = !self.data.Automatic
				self.Weapon:EmitSound("Weapof_Misc.Switch")
			elseif self.Type == 2 then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				local Animation = self.Owner:GetViewModel()
				Animation:SetSequence(Animation:LookupSequence("sup_off"))

				if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
					self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
				end
			elseif self.Type == 3 then
				// Nothing here for the burst fire mode
				self.Weapon:EmitSound("Weapof_Misc.Switch")
			end

			if (SERVER) then
				self.Owner:PrintMessage(HUD_PRINTTALK, self.data.NormalMsg)
			end
		end
	end

	if (self.Weapon) then
		self.Weapon:SetDTBool(3, b)
	end
end

/*---------------------------------------------------------
   Name: SWEP:Throw()
---------------------------------------------------------*/
function SWEP:Throw()
		
		local knife = ents.Create(self.WeaponEntName)
		knife:SetAngles(self.Owner:EyeAngles())
		local pos = self.Owner:GetShootPos()
		pos = pos + self.Owner:GetForward() * 30
		pos = pos + self.Owner:GetRight() * 0
		pos = pos + self.Owner:GetUp() * -40
		knife:SetPos(pos)
							
		knife:Spawn()
		knife:Activate()
						
		local phys = knife:GetPhysicsObject()
		phys:SetVelocity(self.Owner:GetAimVector() * 50)
		phys:AddAngleVelocity(Vector(0, 0, 0))
				
		self.Owner:StripWeapon(self.WeaponName)
		if (SERVER) then
			RunConsoleCommand("lastinv")
		end
end		
	
/*---------------------------------------------------------
   Name: SWEP:Reload()
   Desc: Reload is being pressed.
---------------------------------------------------------*/
function SWEP:Reload()
		
	if self.Owner:KeyDown(IN_USE) and self.Weapon:GetDTBool(0) then
		self.Weapon:SetNextPrimaryFire(CurTime() + 10)
		self.Weapon:SetNextSecondaryFire(CurTime() + 10)
		self.ActionDelay = (CurTime() + 10)
		self:SetIronsights(false)
		self.Owner:GiveAmmo( self:Clip1(), self:GetPrimaryAmmoType() )
		self:Throw()
	end
	
	// When the weapon is already doing an animation, just return end because we don't want to interrupt it
	if (self.ActionDelay > CurTime()) or self.Owner:KeyDown(IN_SPEED) then return end 
	if self.Weapon:GetDTBool(0) or (self:GetNWBool("BigJammed") or self:GetNWBool("LittleJammed")) or (self:Clip1() == (self.Primary.ClipSize + 1)) then return end
		
	self.Weapon:SetNextPrimaryFire(CurTime() + 1.0)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.DeployDelay + 1.0)
	self.ActionDelay = (CurTime())
	
	if (SERVER) then
		if ( self.Reloadaftershoot > CurTime() ) then return end 
	end

	// Need to call the default reload before the real reload animation
	self.Weapon:DefaultReload(ACT_VM_RELOAD)

	if (self.Weapon:Clip1() < self.Primary.ClipSize) and (self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:SetIronsights(false)
		self:ReloadAnimation()
	end
end
/*---------------------------------------------------------
   Name: SWEP:ReloadAnimation()
---------------------------------------------------------*/
function SWEP:ReloadAnimation()


	if (self.Weapon:Clip1() == 0) then
		self.Weapon:DefaultReload(ACT_VM_RELOAD_EMPTY)
	else
		self.Weapon:DefaultReload(ACT_VM_RELOAD)
		timer.Simple(self.Owner:GetViewModel():SequenceDuration() + 0.05, function()
			if (not IsValid(self.Owner) or not IsValid(self.Weapon) or not self.Owner:Alive() or (self.Owner:GetAmmoCount(self.Primary.Ammo) < 1) )then return end
			self.Owner:RemoveAmmo( 1, self:GetPrimaryAmmoType() )
			self:SetClip1( self:Clip1() + 1 )
		end)
	end

	if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
	end
end
/*---------------------------------------------------------
   Name: SWEP:SecondThink()
   Desc: Called every frame. Use this function if you don't 
	   want to copy/past the think function everytime you 
	   create a new weapon with this base...
---------------------------------------------------------*/
function SWEP:SecondThink()
end

/*---------------------------------------------------------
   Name: SWEP:Think()
   Desc: Called every frame.
---------------------------------------------------------*/
function SWEP:Think()

	self:SecondThink()

	if self.Weapon:Clip1() > 0 and self.IdleDelay < CurTime() and self.IdleApply then
		local WeaponModel = self.Weapon:GetOwner():GetActiveWeapon():GetClass()

		if self.Owner and self.Weapon:GetOwner():GetActiveWeapon():GetClass() == WeaponModel and self.Owner:Alive() then
			if (self.Weapon:Clip1() == 0) then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE_EMPTY)
			else
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			end
	
			if self.AllowPlaybackRate and not self.Weapon:GetDTBool(1) then
				self.Owner:GetViewModel():SetPlaybackRate(1)
			else
				self.Owner:GetViewModel():SetPlaybackRate(0)
			end		
		end

		self.IdleApply = false
	elseif self.Weapon:Clip1() == 0 then
		self.IdleApply = false
	end

	if self.Weapon:GetDTBool(1) and self.Owner:KeyDown(IN_SPEED) then
		self:SetIronsights(false)
	end
	
	// If you're running or if your weapon is holsted, the third person animation is going to change
	if self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) then
		if self.Rifle or self.Sniper or self.Shotgun then
			if self.Owner:KeyDown(IN_DUCK) then
				self:SetWeaponHoldType("normal")
			else
				self:SetWeaponHoldType("passive")
			end

		elseif self.Pistol then
			self:SetWeaponHoldType("normal")
		end
	else
		self:SetWeaponHoldType(self.HoldType)
	end
	
	if self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) then return end
		if (self.Owner:KeyDown(IN_USE) and self.Rifle and (self.Type == 1 or self.Type == 3)) then
			self:SetWeaponHoldType("passive")	
		else
			self:SetWeaponHoldType(self.HoldType)
		end	

	
	// Burst fire mode
	if self.Weapon:GetDTBool(3) and self.Type == 3 then
		if self.BurstTimer + self.BurstDelay < CurTime() then
			if self.BurstCounter > 0 then
				self.BurstCounter = self.BurstCounter - 1
				self.BurstTimer = CurTime()
				
				if self:CanPrimaryAttack() then
					self.Weapon:EmitSound(self.Primary.Sound)
					self:ShootBulletInformation()
					self:TakePrimaryAmmo(1)
				end
			end
		end
	end

	self:NextThink(CurTime())
end

/*---------------------------------------------------------
   Name: SWEP:Holster()
   Desc: Weapon wants to holster.
	   Return true to allow the weapon to holster.
---------------------------------------------------------*/
function SWEP:Holster()
	self:ResetSpeed()
	if ManualHolster:GetBool() then
		if self.Weapon:GetDTBool(0) or self.Owner:InVehicle() then
			return true
		end
	else	
		return true
	end
end


/*---------------------------------------------------------
   Name: SWEP:Deploy()
   Desc: Whip mine out.
---------------------------------------------------------*/
function SWEP:Deploy()

	if self.Weapon:GetDTBool(0) then
		bHolsted = !self.Weapon:GetDTBool(0)
		self:SetHolsted(bHolsted)
	end	

	self:DeployAnimation()
	
	if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
	end

	self.Weapon:SetNextPrimaryFire(CurTime() + self.DeployDelay + 0.05)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.DeployDelay + 0.05)
	self.ActionDelay = (CurTime() + self.DeployDelay + 0.05)

	self:SetIronsights(false)
	
	if self.Weapon:GetDTBool(0) then
		return true
	end
end

/*---------------------------------------------------------
   Name: SWEP:DeployAnimation()
---------------------------------------------------------*/
function SWEP:DeployAnimation()

	if (self.Weapon:Clip1() == 0) then
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW_EMPTY)
	else
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	end
end


/*---------------------------------------------------------
   Name: SWEP:ShootBulletInformation()
   Desc: This function add the damage, the recoil, the number of shots and the cone on the bullet.
---------------------------------------------------------*/
function SWEP:ShootBulletInformation()

	local CurrentDamage
	local CurrentRecoil
	local CurrentCone

	local LastAccuracy 	= self.LastAccuracy or 0
	local Accuracy 		= 1.0
	local LastShoot 		= self.Weapon:GetNetworkedFloat("LastShootTime", 0)
	local Speed 		= self.Owner:GetVelocity():Length()

	local SpeedClamp = math.Clamp(math.abs(Speed / 705), 0, 1)

	
	// Player is not on the ground
	if not self.Owner:IsOnGround() then
		// Player is aiming
		if (self.Weapon:GetDTBool(1) or self.Weapon:GetDTBool(2)) then
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * AccuracyMul:GetFloat() * (((1 - SpeedClamp) + 0.1) / 2) 
			self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil), math.Rand(-1, 1) * (CurrentRecoil), 0))
		// Player is not aiming
		else
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * AccuracyMul:GetFloat() * 3 * (((1 - SpeedClamp) + 0.1) / 2) 
			self:ShootBullet(CurrentDamage, CurrentRecoil * 2.5, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil * 2.5), math.Rand(-1, 1) * (CurrentRecoil * 2.5), 0))
		end
	// Player is moving
	
	elseif self.Owner:KeyDown (bit.bor( IN_FORWARD, IN_BACK, IN_MOVELEFT, IN_MOVERIGHT )) then
		// Player is aiming
		if (self.Weapon:GetDTBool(1) or self.Weapon:GetDTBool(2)) then
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * AccuracyMul:GetFloat() 			
			self:ShootBullet(CurrentDamage, CurrentRecoil / 2, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 1.5), math.Rand(-1, 1) * (CurrentRecoil / 1.5), 0))
		// Player is not aiming
		elseif (Speed > 10) then	
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * 2 * AccuracyMul:GetFloat() 
			self:ShootBullet(CurrentDamage, CurrentRecoil * 1.5, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil * 1.5), math.Rand(-1, 1) * (CurrentRecoil * 1.5), 0))
		else
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * 1.5 * AccuracyMul:GetFloat() 
			self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * CurrentRecoil, math.Rand(-1, 1) * CurrentRecoil, 0))
		end
	// Player is crouching
	elseif self.Owner:Crouching() then
		// Player is aiming
		if (self.Weapon:GetDTBool(1) or self.Weapon:GetDTBool(2)) then
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * AccuracyMul:GetFloat() 
			self:ShootBullet(CurrentDamage, 0, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 3), math.Rand(-1, 1) * (CurrentRecoil / 3), 0))
		// Player is not aiming
		else
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * 1.5 * AccuracyMul:GetFloat() 
			self:ShootBullet(CurrentDamage, CurrentRecoil / 2, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 2), math.Rand(-1, 1) * (CurrentRecoil / 2), 0))
		end
	// Player is doing nothing
	else
		// Player is aiming
		if (self.Weapon:GetDTBool(1) or self.Weapon:GetDTBool(2)) then
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * AccuracyMul:GetFloat() 
			self:ShootBullet(CurrentDamage, CurrentRecoil / 6, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 2), math.Rand(-1, 1) * (CurrentRecoil / 2), 0))
		// Player is not aiming
		else
			CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
			CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
			CurrentCone = self.Primary.Cone * 2 * AccuracyMul:GetFloat() 
			self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * CurrentRecoil, math.Rand(-1, 1) * CurrentRecoil, 0))
		end
	end
end

/*---------------------------------------------------------
   Name: SWEP:ShootEffects()
   Desc: A convenience function to shoot negroes.
---------------------------------------------------------*/
function SWEP:ShootEffects()
	
	self:ShootAnimation()
	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	local effectdata = EffectData()
		effectdata:SetOrigin(self.Owner:GetShootPos())
		effectdata:SetEntity(self.Weapon)
		effectdata:SetStart(self.Owner:GetShootPos())
		effectdata:SetNormal(self.Owner:GetAimVector())
		effectdata:SetAttachment(1)
	
	if ((game.SinglePlayer() and SERVER) or CLIENT) then
	if EnableFlash:GetBool() then
	timer.Simple(0, function()
		if not IsValid(self.Owner) then return end
		if (not IsFirstTimePredicted() or not self.Owner:Alive())then return end
		if (self.Shotgun) then
			util.Effect("effect_sim_shotgunsmoke", effectdata)
		else
			util.Effect("effect_sim_gunsmoke", effectdata)
		end
	end)
	end
	
	// Shell eject
	
	if EnableShell:GetBool() then
	timer.Simple(self.ShellDelay, function()
		if not IsValid(self.Owner) then return end
		if (not IsFirstTimePredicted() or not self.Owner:Alive())then return end
		local effectdata = EffectData()
			effectdata:SetEntity(self.Weapon)
			effectdata:SetNormal(self.Owner:GetAimVector())
			effectdata:SetAttachment(2)
		util.Effect(self.ShellEffect, effectdata)
	end)
	end
	
	if ((game.SinglePlayer() and SERVER) or CLIENT) then
		self.Weapon:SetNetworkedFloat("LastShootTime", CurTime())
	end
	end
end

/*---------------------------------------------------------
   Name: SWEP:ShootAnimation()
   Desc: You have to be smarter than TheCake to understand it's purpose.
---------------------------------------------------------*/
function SWEP:ShootAnimation()
	
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK) 		// View model animation
end

/*---------------------------------------------------------
   Name: SWEP:CrosshairAccuracy()
   Desc: Crosshair informations.
---------------------------------------------------------*/
SWEP.SprayTime 		= 0.1
SWEP.SprayAccuracy 	= 0.2

function SWEP:CrosshairAccuracy()

	// Is it a constant accuracy weapon or is it a NPC? The NPC doesn't need a crosshair. Fuck him!

	local LastAccuracy 	= self.LastAccuracy or 0
	local Accuracy 		= 1.0
	local LastShoot 		= self.Weapon:GetNetworkedFloat("LastShootTime", 0)
	
	local Speed 		= self.Owner:GetVelocity():Length()

	local SpeedClamp = math.Clamp(math.abs(Speed / 705), 0, 1)
	
	if (CurTime() <= LastShoot + self.SprayTime) then
		Accuracy = Accuracy * self.SprayAccuracy
	end
	
	if (not self.Owner:IsOnGround()) then
		Accuracy = Accuracy * 0.1
	elseif (Speed > 10) then
		Accuracy = Accuracy * (((1 - SpeedClamp) + 0.1) / 2)
	end

	if (LastAccuracy != 0) then
		if (Accuracy > LastAccuracy) then
			Accuracy = math.Approach(self.LastAccuracy, Accuracy, FrameTime() * 2)
		else
			Accuracy = math.Approach(self.LastAccuracy, Accuracy, FrameTime() * -2)
		end
	end
	
	self.LastAccuracy = Accuracy
	return math.Clamp(Accuracy, 0.2, 1)
end
/*---------------------------------------------------------
   Name: SWEP:ShootBullet()
   Desc: Siminov goes rrrer
---------------------------------------------------------*/
local TracerName = "Tracer"

function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone)

	num_bullets 		= num_bullets or 1
	aimcone 			= aimcone or 0

	self:ShootEffects()

	if self.Tracer == 1 then
		TracerName = "Ar2Tracer"
	elseif self.Tracer == 2 then
		TracerName = "AirboatGunHeavyTracer"
	else
		TracerName = "Tracer"
	end
	
	local bullet = {}
		bullet.Num 		= num_bullets
		bullet.Src 		= self.Owner:GetShootPos()			// Source
		bullet.Dir 		= self.Owner:GetAimVector()			// Dir of bullet
		bullet.Spread 	= Vector(aimcone, aimcone, 0)			// Aim Cone
		bullet.Tracer	= 7							// Show a tracer on every x bullets
		bullet.TracerName = TracerName
		bullet.Force	= damage * 0.5 * math.Rand(0.9, 1.1)// Amount of force to give to phys objects
		bullet.Damage	= damage * math.Rand(0.9, 1.1) 
		bullet.Callback	= function(attacker, tr, dmginfo) 
			
						return self:RicochetCallback_Redirect(attacker, tr, dmginfo) 
					  end

	self.Owner:FireBullets(bullet)

	// Realistic recoil. Only on snipers and shotguns. Disable for the admin gun because if you put the max damage, you'll fly like you never fly!
	if (SERVER and (self.Sniper or self.Shotgun) and not self.Owner:GetActiveWeapon():GetClass() == ("weapon_sim_admin")) then
		self.Owner:SetVelocity(self.Owner:GetAimVector() * -(damage * num_bullets))
	end

	// Recoil
	if ((game.SinglePlayer() and SERVER) or (not game.SinglePlayer() and CLIENT)) then
		local eyeangle 	= self.Owner:EyeAngles()
		eyeangle.pitch 	= eyeangle.pitch - recoil
		self.Owner:SetEyeAngles(eyeangle)
	end
end

/*---------------------------------------------------------
   Name: SWEP:BulletPenetrate()
---------------------------------------------------------*/
local AmmoTypes = {}
AmmoTypes["fiftyae"] = 20
AmmoTypes["fiftybmg"] = 50
AmmoTypes["fivefivesix"] = 25
AmmoTypes["fourtyfiveacp"] = 16
AmmoTypes["ninemmgerman"] = 14
AmmoTypes["ninemmrussian"] = 14
AmmoTypes["ninemmshort"] = 12
AmmoTypes["sevensixtwobyfiftyone"] = 30
AmmoTypes["sevensixtwoshort"] = 22
AmmoTypes["tenmmauto"] = 18

function SWEP:BulletPenetrate(bouncenum, attacker, tr, dmginfo, isplayer)

	if (CLIENT) then return end

	local MaxPenetration = 16
	if AmmoTypes[self.Primary.Ammo] then
		MaxPenetration = AmmoTypes[self.Primary.Ammo]
	end

	local DoDefaultEffect = true
	// Don't go through metal, sand or player
	if ((tr.MatType == MAT_METAL and self.Ricochet) or (tr.MatType == MAT_SAND) or (tr.Entity:IsPlayer())) then return false end

	// Don't go through more than 3 times
	if (bouncenum > 1) then return false end
	
	// Direction (and length) that we are going to penetrate
	local PenetrationDirection = tr.Normal * MaxPenetration
	
	if (tr.MatType == MAT_GLASS or tr.MatType == MAT_PLASTIC or tr.MatType == MAT_WOOD or tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH) then
		PenetrationDirection = tr.Normal * (MaxPenetration * 2)
	end
		
	local trace 	= {}
	trace.endpos 	= tr.HitPos
	trace.start 	= tr.HitPos + PenetrationDirection
	trace.mask 		= MASK_SHOT
	trace.filter 	= {self.Owner}
	   
	local trace 	= util.TraceLine(trace) 
	
	// Bullet didn't penetrate.
	if (trace.StartSolid or trace.Fraction >= 1.0 or tr.Fraction <= 0.0) then return false end
	
	// Damage multiplier depending on surface
	local fDamageMulti = 0.5
	
	if (tr.MatType == MAT_CONCRETE) then
		fDamageMulti = 0.3
	elseif (tr.MatType == MAT_WOOD or tr.MatType == MAT_PLASTIC or tr.MatType == MAT_GLASS) then
		fDamageMulti = 0.8
	elseif (tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH) then
		fDamageMulti = 0.9
	end
		
	// Fire bullet from the exit point using the original trajectory
	local bullet = 
	{	
		Num 		= 1,
		Src 		= trace.HitPos,
		Dir 		= tr.Normal,	
		Spread 	= Vector(0, 0, 0),
		Tracer	= 1,
		TracerName 	= "effect_sim_penetration_trace",
		Force		= 5,
		Damage	= (dmginfo:GetDamage() * fDamageMulti),
		HullSize	= 2
	}
	
	bullet.Callback   = function(a, b, c) if (self.Ricochet) then return self:RicochetCallback(bouncenum + 1, a, b, c) end end
	
	timer.Simple(0.05, function()
		if not IsFirstTimePredicted() then return end
		attacker.FireBullets(attacker, bullet, true)
	end)

	return true
end

/*---------------------------------------------------------
   Name: SWEP:RicochetCallback()
---------------------------------------------------------*/
function SWEP:RicochetCallback(bouncenum, attacker, tr, dmginfo)

end

/*---------------------------------------------------------
   Name: SWEP:RicochetCallback_Redirect()
---------------------------------------------------------*/
function SWEP:RicochetCallback_Redirect(a, b, c)

end

/*---------------------------------------------------------
   Name: SWEP:CanPrimaryAttack()
   Desc: Helper function for checking for no ammo.
---------------------------------------------------------*/
function SWEP:CanPrimaryAttack()

	// Clip is empty or you're under water
	if ( self.Weapon:Clip1() <= 0 ) and self.Primary.ClipSize > -1 then
		self.Weapon:SetNextPrimaryFire(CurTime() + 2)
		//self.Weapon:EmitSound("Default.ClipEmpty_Dumbass")
		return false
	end

	// You're sprinting or your weapon is holsted
	if not self.Owner:IsNPC() and (self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) or self.Owner:WaterLevel() > 2) then
		self.Weapon:SetNextPrimaryFire(CurTime() + 1)
		return false
	end

	return true
end

/*---------------------------------------------------------
   Name: SWEP:CanSecondaryAttack()
   Desc: Mightylolrus should hang himself from a tree.
---------------------------------------------------------*/
function SWEP:CanSecondaryAttack()

	// Clip is empty or you're under water
	if (self.Weapon:Clip2() <= 0) then
		self.Weapon:SetNextSecondaryFire(CurTime() + 2)
		//self.Weapon:EmitSound("Default.ClipEmpty_Dumbass")
		return false
	end

	// You're sprinting or your weapon is holsted
	if not self.Owner:IsNPC() and (self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) or self.Owner:WaterLevel() > 2) then
		self.Weapon:SetNextSecondaryFire(CurTime() + 1)
		return false
	end

	return true
end

