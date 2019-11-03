-- Variables that are used on both client and server
SWEP.Category				= ""
SWEP.Gun					= ""
SWEP.Author				= "Generic Default, Worshipper, Clavus, and Bob"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.DrawCrosshair			= true		-- Hell no, crosshairs r 4 nubz!
SWEP.ViewModelFOV			= 65		-- How big the gun will look
SWEP.ViewModelFlip			= true		-- True for CSS models, False for HL2 models

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= false

SWEP.Primary.Sound 			= Sound("")				-- Sound of the gun
SWEP.Primary.Round 			= ("")					-- What kind of bullet?
SWEP.Primary.Cone			= 0.2					-- Accuracy of NPCs
SWEP.Primary.Recoil		= 10
SWEP.Primary.Damage		= 10
SWEP.Primary.Spread		= .01					--define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.NumShots	= 1
SWEP.Primary.RPM				= 0					-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 0					-- Size of a clip
SWEP.Primary.DefaultClip			= 0					-- Default number of bullets in a clip
SWEP.Primary.KickUp			= 0					-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0					-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal			= 0					-- Maximum side recoil (koolaid)
SWEP.Primary.Automatic			= true					-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"					-- What kind of ammo

SWEP.Secondary.ClipSize			= 0					-- Size of a clip
SWEP.Secondary.DefaultClip			= 0					-- Default number of bullets in a clip
SWEP.Secondary.Automatic			= false					-- Automatic/Semi Auto
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.IronFOV			= 0					-- How much you 'zoom' in. Less is more! 

SWEP.Penetration		= true
SWEP.Ricochet			= true
SWEP.MaxRicochet			= 1
SWEP.RicochetCoin		= 1
SWEP.BoltAction			= false
SWEP.Scoped				= false
SWEP.ShellTime			= .35
SWEP.Tracer				= 0	
SWEP.CanBeSilenced		= false
SWEP.Silenced			= false
SWEP.NextSilence 		= 0
SWEP.SelectiveFire		= false
SWEP.NextFireSelect		= 0

SWEP.IronSightsPos = Vector(0,0,0)
SWEP.IronSightsAng = Vector(0,0,0)
SWEP.SightsPos = Vector(0,0,0)
SWEP.SightsAng = Vector(0,0,0)
SWEP.RunSightsPos = Vector(0,0,0)
SWEP.RunSightsAng = Vector(0,0,0)

SWEP.VElements = {}
SWEP.WElements = {}

function SWEP:Initialize()
	self.Reloadaftershoot = 0 				-- Can't reload when firing
	self:SetWeaponHoldType(self.HoldType)
	self.Weapon:SetNetworkedBool("Reloading", false)
	if SERVER and self.Owner:IsNPC() then
		self:SetNPCMinBurst(3)			
		self:SetNPCMaxBurst(10)			-- None of this really matters but you need it here anyway
		self:SetNPCFireRate(1/(self.Primary.RPM/60))	
		self:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_VERY_GOOD )
	end
	
	if CLIENT then
	
		-- // Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) -- create viewmodels
		self:CreateModels(self.WElements) -- create worldmodels
		
		-- // init view model bone build function
		if IsValid(self.Owner) and self.Owner:IsPlayer() then
		if self.Owner:Alive() then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				-- // Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					-- // however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end
			end
			
		end
		end
		
	end
	
	if CLIENT then
		local oldpath = "vgui/hud/name" -- the path goes here
		local newpath = string.gsub(oldpath, "name", self.Gun)
		self.WepSelectIcon = surface.GetTextureID(newpath)
	end
	
	self.SightsPos = self.IronSightsPos
	self.SightsAng = self.IronSightsAng
	
end

function SWEP:Deploy()
	self:SetIronsights(false, self.Owner)					-- Set the ironsight false
	
	if self.Silenced then
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW_SILENCED )
	else
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	end

	self.Weapon:SetNetworkedBool("Reloading", false)
	
	if !self.Owner:IsNPC() and self.Owner != nil then 
		if self.ResetSights and self.Owner:GetViewModel() != nil then
			self.ResetSights = CurTime() + self.Owner:GetViewModel():SequenceDuration() 
		end
	end
	return true
end

function SWEP:Holster()
	
	if CLIENT and IsValid(self.Owner) and not self.Owner:IsNPC() then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
	return true
end

function SWEP:OnRemove()

	if CLIENT and IsValid(self.Owner) and not self.Owner:IsNPC() then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end

end

function SWEP:GetCapabilities()
	return CAP_WEAPON_RANGE_ATTACK1, CAP_INNATE_RANGE_ATTACK1
end

function SWEP:Precache()
	util.PrecacheSound(self.Primary.Sound)
	util.PrecacheModel(self.ViewModel)
	util.PrecacheModel(self.WorldModel)
end

function SWEP:PrimaryAttack()
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
	if !self.Owner:KeyDown(IN_SPEED) and !self.Owner:KeyDown(IN_RELOAD) then
		self:ShootBulletInformation()
		self.Weapon:TakePrimaryAmmo(1)
		
		if self.Silenced then
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_SILENCED )
			self.Weapon:EmitSound(self.Primary.SilencedSound)
		else
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			self.Weapon:EmitSound(self.Primary.Sound)
		end	
	
		local fx 		= EffectData()
		fx:SetEntity(self.Weapon)
		fx:SetOrigin(self.Owner:GetShootPos())
		fx:SetNormal(self.Owner:GetAimVector())
		fx:SetAttachment(self.MuzzleAttachment)
		if GetConVar("M9KGasEffect") != nil then
			if GetConVar("M9KGasEffect"):GetBool() then 
				util.Effect("m9k_rg_muzzle_rifle",fx)
			end
		end
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Owner:MuzzleFlash()
		self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))
		self:CheckWeaponsAndAmmo()
		self.RicochetCoin = (math.random(1,4))
		if self.BoltAction then self:BoltBack() end
	end
	elseif self:CanPrimaryAttack() and self.Owner:IsNPC() then
		self:ShootBulletInformation()
		self.Weapon:TakePrimaryAmmo(1)
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Weapon:EmitSound(self.Primary.Sound)
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Owner:MuzzleFlash()
		self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))
		self.RicochetCoin = (math.random(1,4))
	end
end

function SWEP:CheckWeaponsAndAmmo()
	if SERVER and self.Weapon != nil and (GetConVar("M9KWeaponStrip"):GetBool()) then 
		if self.Weapon:Clip1() == 0 && self.Owner:GetAmmoCount( self.Weapon:GetPrimaryAmmoType() ) == 0 then
			timer.Simple(.1, function() if SERVER then if not IsValid(self) then return end
				if self.Owner == nil then return end
				self.Owner:StripWeapon(self.Gun)
			end end)
		end
	end
end


/*---------------------------------------------------------
   Name: SWEP:ShootBulletInformation()
   Desc: This func add the damage, the recoil, the number of shots and the cone on the bullet.
---------------------------------------------------------*/
function SWEP:ShootBulletInformation()

	local CurrentDamage
	local CurrentRecoil
	local CurrentCone
	
	if (self:GetIronsights() == true) and self.Owner:KeyDown(IN_ATTACK2) then
	CurrentCone = self.Primary.IronAccuracy
	else 
	CurrentCone = self.Primary.Spread
	end
	local damagedice = math.Rand(.85,1.3)
	
	CurrentDamage = self.Primary.Damage * damagedice
	CurrentRecoil = self.Primary.Recoil
	
	-- Player is aiming
	if (self:GetIronsights() == true) and self.Owner:KeyDown(IN_ATTACK2) then
		self:ShootBullet(CurrentDamage, CurrentRecoil / 6, self.Primary.NumShots, CurrentCone)
	-- Player is not aiming
	else
		self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, CurrentCone)
	end
	
end

/*---------------------------------------------------------
   Name: SWEP:ShootBullet()
   Desc: A convenience func to shoot bullets.
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
		bullet.Src 		= self.Owner:GetShootPos()			-- Source
		bullet.Dir 		= self.Owner:GetAimVector()			-- Dir of bullet
		bullet.Spread 	= Vector(aimcone, aimcone, 0)			-- Aim Cone
		bullet.Tracer	= 3							-- Show a tracer on every x bullets
		bullet.TracerName = TracerName
		bullet.Force	= damage * 0.5					-- Amount of force to give to phys objects
		bullet.Damage	= damage
		bullet.Callback	= function(attacker, tracedata, dmginfo) 
		
						return self:RicochetCallback(0, attacker, tracedata, dmginfo) 
					  end

	self.Owner:FireBullets(bullet)
	if SERVER and !self.Owner:IsNPC() then
		local anglo = Angle(math.Rand(-self.Primary.KickDown,-self.Primary.KickUp), math.Rand(-self.Primary.KickHorizontal,self.Primary.KickHorizontal), 0)
		self.Owner:ViewPunch(anglo)
		
		local eyes = self.Owner:EyeAngles()
		eyes.pitch = eyes.pitch + anglo.pitch
		eyes.yaw = eyes.yaw + anglo.yaw
		if game.SinglePlayer() then self.Owner:SetEyeAngles(eyes) end
	end

end

/*---------------------------------------------------------
   Name: SWEP:RicochetCallback()
---------------------------------------------------------*/

function SWEP:RicochetCallback(bouncenum, attacker, tr, dmginfo)

	if GetConVar("M9KDisablePenetration") != nil then
		if GetConVar("M9KDisablePenetration"):GetBool() then return end
	end

	bulletmiss = {}
		bulletmiss[1]=Sound("weapons/fx/nearmiss/bulletLtoR03.wav")
		bulletmiss[2]=Sound("weapons/fx/nearmiss/bulletLtoR04.wav")
		bulletmiss[3]=Sound("weapons/fx/nearmiss/bulletLtoR06.wav")
		bulletmiss[4]=Sound("weapons/fx/nearmiss/bulletLtoR07.wav")
		bulletmiss[5]=Sound("weapons/fx/nearmiss/bulletLtoR09.wav")
		bulletmiss[6]=Sound("weapons/fx/nearmiss/bulletLtoR10.wav")
		bulletmiss[7]=Sound("weapons/fx/nearmiss/bulletLtoR13.wav")
		bulletmiss[8]=Sound("weapons/fx/nearmiss/bulletLtoR14.wav")
		
	local DoDefaultEffect = true
	if (tr.HitSky) then return end
	
	// -- Can we go through whatever we hit?
	if (self.Penetration) and (self:BulletPenetrate(bouncenum, attacker, tr, dmginfo)) then
		return {damage = true, effects = DoDefaultEffect}
	end
	
	// -- Your screen will shake and you'll hear the savage hiss of an approaching bullet which passing if someone is shooting at you.
	if (tr.MatType != MAT_METAL) then
		if (SERVER) then
			util.ScreenShake(tr.HitPos, 5, 0.1, 0.5, 64)
			sound.Play(table.Random(bulletmiss), tr.HitPos, 75, math.random(75,150), 1)
		end

		if self.Tracer == 0 or self.Tracer == 1 or self.Tracer == 2 then
			local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetScale(20)
			util.Effect("AR2Impact", effectdata)
		elseif self.Tracer == 3 then
			local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetScale(20)
			util.Effect("StunstickImpact", effectdata)
		end

		return 
	end

	if (self.Ricochet == false) then return {damage = true, effects = DoDefaultEffect} end
	
	if self.Primary.Ammo == "SniperPenetratedRound" then -- .50 Ammo 
		self.MaxRicochet = 20
	elseif self.Primary.Ammo == "pistol" then -- pistols
		self.MaxRicochet = 2
	elseif self.Primary.Ammo == "357" then -- revolvers with big ass bullets
		self.MaxRicochet = 4
	elseif self.Primary.Ammo == "smg1" then -- smgs
		self.MaxRicochet = 5
	elseif self.Primary.Ammo == "ar2" then -- assault rifles
		self.MaxRicochet = 8
	elseif self.Primary.Ammo == "buckshot" then -- shotguns
		self.MaxRicochet = 3
	elseif self.Primary.Ammo == "slam" then -- secondary shotguns
		self.MaxRicochet = 3
	elseif self.Primary.Ammo ==	"AirboatGun" then -- metal piercing shotgun pellet
		self.MaxRicochet = 20
	end
	
	if (bouncenum > self.MaxRicochet) then return end
	
	// -- Bounce vector
	local trace = {}
	trace.start = tr.HitPos
	trace.endpos = trace.start + (tr.HitNormal * 16384)

	local trace = util.TraceLine(trace)

 	local DotProduct = tr.HitNormal:Dot(tr.Normal * -1) 
	
	local ricochetbullet = {}
		ricochetbullet.Num 		= 1
		ricochetbullet.Src 		= tr.HitPos + (tr.HitNormal * 5)
		ricochetbullet.Dir 		= ((2 * tr.HitNormal * DotProduct) + tr.Normal) + (VectorRand() * 0.05)
		ricochetbullet.Spread 	= Vector(0, 0, 0)
		ricochetbullet.Tracer	= 1
		ricochetbullet.TracerName 	= "m9k_effect_mad_ricochet_trace"
		ricochetbullet.Force		= dmginfo:GetDamage() * 0.25
		ricochetbullet.Damage	= dmginfo:GetDamage() * 0.5
		ricochetbullet.Callback  	= function(a, b, c) 
			if (self.Ricochet) then  
			local impactnum
			if tr.MatType == MAT_GLASS then impactnum = 0 else impactnum = 1 end
			return self:RicochetCallback(bouncenum + impactnum, a, b, c) end 
			end

	timer.Simple(0.05, function() attacker:FireBullets(ricochetbullet) end)
	
	return {damage = true, effects = DoDefaultEffect}
end


/*---------------------------------------------------------
   Name: SWEP:BulletPenetrate()
---------------------------------------------------------*/
function SWEP:BulletPenetrate(bouncenum, attacker, tr, paininfo)
	
	if GetConVar("M9KDisablePenetration") != nil then
		if GetConVar("M9KDisablePenetration"):GetBool() then return end
	end
	
	local MaxPenetration

	if self.Primary.Ammo == "SniperPenetratedRound" then -- .50 Ammo 
		MaxPenetration = 20
	elseif self.Primary.Ammo == "pistol" then -- pistols
		MaxPenetration = 8
	elseif self.Primary.Ammo == "357" then -- revolvers with big ass bullets
		MaxPenetration = 12
	elseif self.Primary.Ammo == "smg1" then -- smgs
		MaxPenetration = 14
	elseif self.Primary.Ammo == "ar2" then -- assault rifles
		MaxPenetration = 16
	elseif self.Primary.Ammo == "buckshot" then -- shotguns
		MaxPenetration = 8
	elseif self.Primary.Ammo == "slam" then -- secondary shotguns
		MaxPenetration = 8
	elseif self.Primary.Ammo ==	"AirboatGun" then -- metal piercing shotgun pellet
		MaxPenetration = 20
	else
		MaxPenetration = 16
	end

	local DoDefaultEffect = true
	// -- Don't go through metal, sand or player
	
	if self.Primary.Ammo == "pistol" or
		self.Primary.Ammo == "buckshot" or
		self.Primary.Ammo == "slam" then self.Ricochet = true
	else
		if self.RicochetCoin == 1 then
		self.Ricochet = true
		elseif self.RicochetCoin >= 2 then
		self.Ricochet = false
		end
	end
	
	if self.Primary.Ammo == "SniperPenetratedRound" then self.Ricochet = false end
	
	if self.Primary.Ammo == "SniperPenetratedRound" then -- .50 Ammo 
		self.MaxRicochet = 20
	elseif self.Primary.Ammo == "pistol" then -- pistols
		self.MaxRicochet = 2
	elseif self.Primary.Ammo == "357" then -- revolvers with big ass bullets
		self.MaxRicochet = 4
	elseif self.Primary.Ammo == "smg1" then -- smgs
		self.MaxRicochet = 5
	elseif self.Primary.Ammo == "ar2" then -- assault rifles
		self.MaxRicochet = 8
	elseif self.Primary.Ammo == "buckshot" then -- shotguns
		self.MaxRicochet = 3
	elseif self.Primary.Ammo == "slam" then -- secondary shotguns
		self.MaxRicochet = 3
	elseif self.Primary.Ammo ==	"AirboatGun" then -- metal piercing shotgun pellet
		self.MaxRicochet = 20
	end
	
	if (tr.MatType == MAT_METAL and self.Ricochet == true ) then return false end
	
	// -- Don't go through more than 3 times
	if (bouncenum > self.MaxRicochet) then return false end
	
	// -- Direction (and length) that we are going to penetrate
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
	
	// -- Bullet didn't penetrate.
	if (trace.StartSolid or trace.Fraction >= 1.0 or tr.Fraction <= 0.0) then return false end
	
	// -- Damage multiplier depending on surface
	local fDamageMulti = 0.5
	
	if self.Primary.Ammo == "SniperPenetratedBullet" then
		fDamageMulti = 1
	elseif(tr.MatType == MAT_CONCRETE or tr.MatType == MAT_METAL) then
		fDamageMulti = 0.3
	elseif (tr.MatType == MAT_WOOD or tr.MatType == MAT_PLASTIC or tr.MatType == MAT_GLASS) then
		fDamageMulti = 0.8
	elseif (tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH) then
		fDamageMulti = 0.9
	end
	
	local damagedice = math.Rand(.85,1.3)
	local newdamage = self.Primary.Damage * damagedice
		
	// -- Fire bullet from the exit point using the original trajectory
	local penetratedbullet = {}
		penetratedbullet.Num 		= 1
		penetratedbullet.Src 		= trace.HitPos
		penetratedbullet.Dir 		= tr.Normal	
		penetratedbullet.Spread 	= Vector(0, 0, 0)
		penetratedbullet.Tracer	= 1
		penetratedbullet.TracerName 	= "m9k_effect_mad_penetration_trace"
		penetratedbullet.Force		= 5
		penetratedbullet.Damage	= paininfo:GetDamage() * fDamageMulti
		penetratedbullet.Callback  	= function(a, b, c) if (self.Ricochet) then 	
		local impactnum
		if tr.MatType == MAT_GLASS then impactnum = 0 else impactnum = 1 end
		return self:RicochetCallback(bouncenum + impactnum, a,b,c) end end	
		
	timer.Simple(0.05, function() if attacker != nil then attacker:FireBullets(penetratedbullet) end end)

	return true
end


function SWEP:SecondaryAttack()
	return false
end

function SWEP:Reload()
	if not IsValid(self) then return end if not IsValid(self.Owner) then return end
	
	if self.Owner:IsNPC() then
		self.Weapon:DefaultReload(ACT_VM_RELOAD)
	return end
	
	if self.Owner:KeyDown(IN_USE) then return end
	
	if self.Silenced then
		self.Weapon:DefaultReload(ACT_VM_RELOAD_SILENCED) 
	else
		self.Weapon:DefaultReload(ACT_VM_RELOAD) 
	end
	
	if !self.Owner:IsNPC() then
		if self.Owner:GetViewModel() == nil then self.ResetSights = CurTime() + 3 else
		self.ResetSights = CurTime() + self.Owner:GetViewModel():SequenceDuration() 
		end
	end
	
	if SERVER and self.Weapon != nil then
	if ( self.Weapon:Clip1() < self.Primary.ClipSize ) and !self.Owner:IsNPC() then
	-- When the current clip < full clip and the rest of your ammo > 0, then
		self.Owner:SetFOV( 0, 0.3 )
		-- Zoom = 0
		self:SetIronsights(false)
		-- Set the ironsight to false
		self.Weapon:SetNetworkedBool("Reloading", true)
	end
	local waitdammit = (self.Owner:GetViewModel():SequenceDuration())
	timer.Simple(waitdammit + .1, 
		function() 
		if self.Weapon == nil then return end
		self.Weapon:SetNetworkedBool("Reloading", false)
		if self.Owner:KeyDown(IN_ATTACK2) and self.Weapon:GetClass() == self.Gun then 
			if CLIENT then return end
			if self.Scoped == false then
				self.Owner:SetFOV( self.Secondary.IronFOV, 0.3 )
				self.IronSightsPos = self.SightsPos					-- Bring it up
				self.IronSightsAng = self.SightsAng					-- Bring it up
				self:SetIronsights(true, self.Owner)
				self.DrawCrosshair = false
			else return end
		elseif self.Owner:KeyDown(IN_SPEED) and self.Weapon:GetClass() == self.Gun then 
			self.Weapon:SetNextPrimaryFire(CurTime()+0.3)			-- Make it so you can't shoot for another quarter second
			self.IronSightsPos = self.RunSightsPos					-- Hold it down
			self.IronSightsAng = self.RunSightsAng					-- Hold it down
			self:SetIronsights(true, self.Owner)					-- Set the ironsight true
			self.Owner:SetFOV( 0, 0.3 )
		else return end
		end)
	end
end

function SWEP:PostReloadScopeCheck()
	if self.Weapon == nil then return end
	self.Weapon:SetNetworkedBool("Reloading", false)
	if self.Owner:KeyDown(IN_ATTACK2) and self.Weapon:GetClass() == self.Gun then 
		if CLIENT then return end
		if self.Scoped == false then
			self.Owner:SetFOV( self.Secondary.IronFOV, 0.3 )
			self.IronSightsPos = self.SightsPos					-- Bring it up
			self.IronSightsAng = self.SightsAng					-- Bring it up
			self:SetIronsights(true, self.Owner)
			self.DrawCrosshair = false
		else return end
 	elseif self.Owner:KeyDown(IN_SPEED) and self.Weapon:GetClass() == self.Gun then 
		self.Weapon:SetNextPrimaryFire(CurTime()+0.3)				-- Make it so you can't shoot for another quarter second
		self.IronSightsPos = self.RunSightsPos					-- Hold it down
		self.IronSightsAng = self.RunSightsAng					-- Hold it down
		self:SetIronsights(true, self.Owner)					-- Set the ironsight true
		self.Owner:SetFOV( 0, 0.3 )
	else return end
end

function SWEP:Silencer()
	
	if self.NextSilence > CurTime() then return end
	
	if self.Weapon != nil then
		self.Owner:SetFOV( 0, 0.3 )
		self:SetIronsights(false)
		self.Weapon:SetNetworkedBool("Reloading", true) -- i know we're not reloading but it works
	end
	
	if self.Silenced then
		self:SendWeaponAnim(ACT_VM_DETACH_SILENCER)
		self.Silenced = false
	elseif not self.Silenced then
		self:SendWeaponAnim(ACT_VM_ATTACH_SILENCER)
		self.Silenced = true
	end
	
	siltimer = CurTime() + (self.Owner:GetViewModel():SequenceDuration()) + 0.1
	self.Weapon:SetNextPrimaryFire(siltimer)
	self.NextSilence = siltimer
	
	timer.Simple( ((self.Owner:GetViewModel():SequenceDuration()) + 0.1), 
		function() 
		if self.Weapon != nil then
			self.Weapon:SetNetworkedBool("Reloading", false)
		if self.Owner:KeyDown(IN_ATTACK2) and self.Weapon:GetClass() == self.Gun then 
			if CLIENT then return end
			if self.Scoped == false then
				self.Owner:SetFOV( self.Secondary.IronFOV, 0.3 )
				self.IronSightsPos = self.SightsPos					-- Bring it up
				self.IronSightsAng = self.SightsAng					-- Bring it up
				self:SetIronsights(true, self.Owner)
				self.DrawCrosshair = false
			else return end
		elseif self.Owner:KeyDown(IN_SPEED) and self.Weapon:GetClass() == self.Gun then 
			self.Weapon:SetNextPrimaryFire(CurTime()+0.3)			-- Make it so you can't shoot for another quarter second
			self.IronSightsPos = self.RunSightsPos					-- Hold it down
			self.IronSightsAng = self.RunSightsAng					-- Hold it down
			self:SetIronsights(true, self.Owner)					-- Set the ironsight true
			self.Owner:SetFOV( 0, 0.3 )
		else return end
		end
	end)

end

function SWEP:SelectFireMode()

		if self.Primary.Automatic then
			self.Primary.Automatic = false
			self.NextFireSelect = CurTime() + .5
			if CLIENT then
				self.Owner:PrintMessage(HUD_PRINTTALK, "Semi-automatic selected.")
			end
			self.Weapon:EmitSound("Weapon_AR2.Empty")
		else
			self.Primary.Automatic = true
			self.NextFireSelect = CurTime() + .5
			if CLIENT then
				self.Owner:PrintMessage(HUD_PRINTTALK, "Automatic selected.")
			end
			self.Weapon:EmitSound("Weapon_AR2.Empty")
		end
end

/*---------------------------------------------------------
IronSight
---------------------------------------------------------*/
function SWEP:IronSight()

	if !self.Owner:IsNPC() then
	if self.ResetSights and CurTime() >= self.ResetSights then
	self.ResetSights = nil
	
	if self.Silenced then
		self:SendWeaponAnim(ACT_VM_IDLE_SILENCED)
	else
		self:SendWeaponAnim(ACT_VM_IDLE)
	end
	end end
	
	if self.CanBeSilenced and self.NextSilence < CurTime() then
		if self.Owner:KeyDown(IN_USE) and self.Owner:KeyPressed(IN_ATTACK2) then
			self:Silencer()
		end
	end
	
	if self.SelectiveFire and self.NextFireSelect < CurTime() and not (self.Weapon:GetNW2Bool("Reloading")) then
		if self.Owner:KeyDown(IN_USE) and self.Owner:KeyPressed(IN_RELOAD) then
			self:SelectFireMode()
		end
	end
	
--copy this...
	if self.Owner:KeyDown(IN_SPEED) and not (self.Weapon:GetNW2Bool("Reloading")) then		-- If you are running
	self.Weapon:SetNextPrimaryFire(CurTime()+0.3)				-- Make it so you can't shoot for another quarter second
	self.IronSightsPos = self.RunSightsPos					-- Hold it down
	self.IronSightsAng = self.RunSightsAng					-- Hold it down
	self:SetIronsights(true, self.Owner)					-- Set the ironsight true
	self.Owner:SetFOV( 0, 0.3 )
	end								

	if self.Owner:KeyReleased (IN_SPEED) then	-- If you release run then
	self:SetIronsights(false, self.Owner)					-- Set the ironsight true
	self.Owner:SetFOV( 0, 0.3 )
	end								-- Shoulder the gun

--down to this
	if !self.Owner:KeyDown(IN_USE) and !self.Owner:KeyDown(IN_SPEED) then
	-- If the key E (Use Key) is not pressed, then

		if self.Owner:KeyPressed(IN_ATTACK2) and not (self.Weapon:GetNW2Bool("Reloading")) then 
			self.Owner:SetFOV( self.Secondary.IronFOV, 0.3 )
			self.IronSightsPos = self.SightsPos					-- Bring it up
			self.IronSightsAng = self.SightsAng					-- Bring it up
			self:SetIronsights(true, self.Owner)
			self.DrawCrosshair = false
			-- Set the ironsight true

			if CLIENT then return end
 		end
	end

	if self.Owner:KeyReleased(IN_ATTACK2) and !self.Owner:KeyDown(IN_USE) and !self.Owner:KeyDown(IN_SPEED) then
	-- If the right click is released, then
		self.Owner:SetFOV( 0, 0.3 )
		self.DrawCrosshair = true
		self:SetIronsights(false, self.Owner)
		-- Set the ironsight false

		if CLIENT then return end
	end

		if self.Owner:KeyDown(IN_ATTACK2) and !self.Owner:KeyDown(IN_USE) and !self.Owner:KeyDown(IN_SPEED) then
		self.SwayScale 	= 0.05
		self.BobScale 	= 0.05
		else
		self.SwayScale 	= 1.0
		self.BobScale 	= 1.0
		end
end

/*---------------------------------------------------------
Think
---------------------------------------------------------*/
function SWEP:Think()

self:IronSight()

end

/*---------------------------------------------------------
GetViewModelPosition
---------------------------------------------------------*/
local IRONSIGHT_TIME = 0.3
-- Time to enter in the ironsight mod

function SWEP:GetViewModelPosition(pos, ang)

	if (not self.IronSightsPos) then return pos, ang end

	local bIron = self.Weapon:GetNW2Bool("Ironsights")

	if (bIron != self.bLastIron) then
		self.bLastIron = bIron
		self.fIronTime = CurTime()

	end

	local fIronTime = self.fIronTime or 0

	if (not bIron and fIronTime < CurTime() - IRONSIGHT_TIME) then
		return pos, ang
	end

	local Mul = 1.0

	if (fIronTime > CurTime() - IRONSIGHT_TIME) then
		Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)

		if not bIron then Mul = 1 - Mul end
	end

	local Offset	= self.IronSightsPos

	if (self.IronSightsAng) then
		ang = ang * 1
		ang:RotateAroundAxis(ang:Right(), 		self.IronSightsAng.x * Mul)
		ang:RotateAroundAxis(ang:Up(), 		self.IronSightsAng.y * Mul)
		ang:RotateAroundAxis(ang:Forward(), 	self.IronSightsAng.z * Mul)
	end

	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
end

/*---------------------------------------------------------
SetIronsights
---------------------------------------------------------*/
function SWEP:SetIronsights(b)
	self.Weapon:SetNetworkedBool("Ironsights", b)
end

function SWEP:GetIronsights()
	return self.Weapon:GetNW2Bool("Ironsights")
end


if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			-- // we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				-- //model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			-- // when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				-- //model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			-- // Technically, if there exists an element with the same name as a bone
			-- // you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r --// Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		-- // Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				-- // make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			-- // !! WORKAROUND !! --//
			-- // We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			//!! ----------- !! --
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				-- // !! WORKAROUND !! --//
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				//!! ----------- !! --
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	-- // Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	-- // Does not copy entities of course, only copies their reference.
	-- // WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) --// recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end