--[[

// Variables that are used on both client and server

local Walkspeed = CreateConVar ("sim_walk_speed", "250", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local Runspeed = CreateConVar ("sim_run_speed", "500", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local WeightMod	= CreateClientConVar("sim_weightmod_t", 1, true, false)		// Enable/Disable

SWEP.Instructions			= "Uses 7.62mm Short ammo, Alternate Mode: E + Right Click, Switch Weapons: E + Left Click, Melee: E + Left and Right Click"
SWEP.Base 				= "weapon_fas_sim_base_reg"
SWEP.HoldType				= "ar2"
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/a_ak47.mdl"
SWEP.WorldModel			= "models/weapons/b_ak47.mdl"
SWEP.ViewModelFOV			= 55
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapof_AK47.Shoot")
SWEP.Primary.Recoil		= 2.2
SWEP.Primary.Damage		= 33
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.008
SWEP.Primary.Delay 		= 0.1

SWEP.Primary.ClipSize		= 30					// Size of a clip
SWEP.Primary.DefaultClip	= 0					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "AR2"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "sim_shelleject_fas_762x39"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.ShellDelay			= 0.02
SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos = Vector (-2.7995, -5.0013, 1.9694)
SWEP.IronSightsAng = Vector (0.2422, -0.0422, 0)
SWEP.RunArmOffset  = Vector (4.0928, 0.4246, 2.3712)
SWEP.RunArmAngle   = Vector (-18.4406, 33.1846, 0)

SWEP.Type				= 1 					// 1 = Automatic/Semi-Automatic mode, 2 = Suppressor mode, 3 = Burst fire mode
SWEP.Mode				= true

SWEP.data 				= {}
SWEP.data.NormalMsg		= "Switched to automatic."
SWEP.data.ModeMsg			= "Switched to semi-automatic."

SWEP.Speed = 0.6
SWEP.Mass = 0.8
SWEP.WeaponName = "weapon_fas_ak47"
SWEP.WeaponEntName = "sim_fas_ak47"
/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/ar_ak47/ak47_fire1.wav")
	util.PrecacheSound("weapons/ar_ak47/ak47_fire2.wav")
	util.PrecacheSound("weapons/ar_ak47/ak47_fire3.wav")
	util.PrecacheSound("weapons/ar_ak47/ak47_fire4.wav")
	util.PrecacheSound("weapons/ar_ak47/ak47_fire5.wav")
	util.PrecacheSound("weapons/ar_ak47/ak47_magin.wav")
	util.PrecacheSound("weapons/ar_ak47/ak47_magout.wav")	
	util.PrecacheSound("weapons/ar_ak47/ak47_cock.wav")
end

/*---------------------------------------------------------
   Name: SWEP:EntityFaceBack
   Desc: Is the entity face back to the player?
---------------------------------------------------------*/
function SWEP:EntsInSphereBack(pos, range)

	local ents = ents.FindInSphere(pos, range)

	for k, v in pairs(ents) do
		if v ~= self and v ~= self.Owner and (v:IsNPC() or v:IsPlayer()) and IsValid(v) and self:EntityFaceBack(v) then
			return true
		end
	end

	return false
end

/*---------------------------------------------------------
   Name: SWEP:EntityFaceBack
   Desc: Is the entity face back to the player?
---------------------------------------------------------*/
function SWEP:EntityFaceBack(ent)

	local angle = self.Owner:GetAngles().y - ent:GetAngles().y

	if angle < -180 then angle = 360 + angle end
	if angle <= 90 and angle >= -90 then return true end

	return false
end

/*---------------------------------------------------------
   Name: SWEP:SecondaryAttack()
   Desc: +attack2 has been pressed.
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

	if (!self.IronSightsPos) or (self.Owner:KeyDown(IN_SPEED)) or self.Owner:IsNPC() then return end

	if (self.Owner:KeyDown(IN_ATTACK) and self.Owner:KeyDown(IN_ATTACK2) and self.Owner:KeyDown(IN_USE)) then
		
		self:SetIronsights(false)
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local Animation = self.Owner:GetViewModel()
		Animation:SetSequence(Animation:LookupSequence("stab"))
		self.Weapon:SetNextPrimaryFire(CurTime() + 1.5)
		self.Weapon:SetNextSecondaryFire(CurTime() + 1.5)

		if not IsValid(self.Owner) then return end
		
		timer.Create( "reloading1", 0.25, 1, function()
			
		local tr = {}
		tr.start = self.Owner:GetShootPos()
		tr.endpos = self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 100)
		tr.filter = self.Owner
		tr.mask = MASK_SHOT
		local trace = util.TraceLine(tr)
			if (trace.Hit) then
				if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(),"npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
					if self:EntsInSphereBack(tr.endpos, 12) then

						self.Weapon:SetNextPrimaryFire(CurTime() + 1.5)
						self.Weapon:SetNextSecondaryFire(CurTime() + 1.5)

						bullet = {}
						bullet.Num    = 1
						bullet.Src    = self.Owner:GetShootPos()
						bullet.Dir    = self.Owner:GetAimVector()
						bullet.Spread = Vector(0, 0, 0)
						bullet.Tracer = 0
						bullet.Force  = 1
						bullet.Damage = 60
						self.Owner:FireBullets(bullet)

						self.Weapon:EmitSound("Weapof_Knife.Hit")
						return
					end 
			

					bullet = {}
					bullet.Num    = 1
					bullet.Src    = self.Owner:GetShootPos()
					bullet.Dir    = self.Owner:GetAimVector()
					bullet.Spread = Vector(0, 0, 0)
					bullet.Tracer = 0
					bullet.Force  = 1
					bullet.Damage = 35
					self.Owner:FireBullets(bullet) 

					self.Weapon:EmitSound("Weapof_Knife.Hit")
				
				else
			
					bullet = {}
					bullet.Num    = 1
					bullet.Src    = self.Owner:GetShootPos()
					bullet.Dir    = self.Owner:GetAimVector()
					bullet.Spread = Vector(0, 0, 0)
					bullet.Tracer = 0
					bullet.Force  = 1
					bullet.Damage = 25
					self.Owner:FireBullets(bullet) 

					self.Weapon:EmitSound("Weapof_Knife.HitWall")
	
					util.Decal("ManhackCut", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal)
				end
			else
				self.Weapon:EmitSound("Weapof_Machete.Stab")
			end 
		end )
		
		if ((game.SinglePlayer() and SERVER) or CLIENT) then
		self.Weapon:SetNetworkedFloat("LastShootTime", CurTime())
		end
		
		return
	end

	if (not self.Owner:IsNPC() and not self.Owner:KeyDown(IN_SPEED) and not self.Owner:KeyDown(IN_RELOAD) and self.Owner:KeyDown(IN_USE)) then
		
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
--]]

AddCSLuaFile()

SWEP.HoldType     = "ar2"
SWEP.PrintName     = "AK47 TE"

if CLIENT then
   SWEP.Slot        = 2

   SWEP.Icon = "vgui/ttt/icon_ak47"
   SWEP.IconLetter = "w"
end

SWEP.Base       = "weapon_tttbase"
SWEP.Spawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_AK47

SWEP.Primary.Delay      = 0.095
SWEP.Primary.Recoil     = 1.5
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Cone = 0.015
SWEP.Primary.Damage = 19
SWEP.HeadshotMultiplier = 2.5
SWEP.Primary.ClipSize = 35
SWEP.Primary.ClipMax = 105
SWEP.Primary.DefaultClip = 35
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.ViewModelFlip    = false
SWEP.ViewModelFOV   = 55
SWEP.ViewModel			= "models/weapons/a_ak47.mdl"
SWEP.WorldModel			= "models/weapons/b_ak47.mdl"

SWEP.Primary.Sound = Sound("Weapof_AK47.Shoot")

SWEP.IronSightsPos = Vector (-2.7995, -5.0013, 1.9694)
SWEP.IronSightsAng = Vector (0.2422, -0.0422, 0)

SWEP.DeploySpeed = 1.4
SWEP.ReloadSpeed = 1
SWEP.ReloadAnim = {
	DefaultReload = {
		Anim = "reload",
		Time = 2.4,
	},
	ReloadEmpty = {
		Anim = "reload_empty",
		Time = 3.23333,
	}
}

function SWEP:SetZoom(state)
   	if (not (IsValid(self.Owner) and self.Owner:IsPlayer())) then return end
   	if (state) then
      	self.Owner:SetFOV(55, 0.5)
   	else
      	self.Owner:SetFOV(0, 0.2)
   	end
end