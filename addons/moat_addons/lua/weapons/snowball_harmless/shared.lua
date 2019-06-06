if (SERVER) then
	AddCSLuaFile( "shared.lua" )
end
SWEP.Harmless = true
SWEP.Base = "weapon_tttbase"
SWEP.PrintName			= "Snowball"	
SWEP.Slot				= 3
SWEP.Author				= "BlackJackit, Edited from IceAxe Realistic Weapon, Bugs Fixing by Wood, all credits to the creators"
SWEP.DrawAmmo 			= false
SWEP.DrawCrosshair 		= false
SWEP.ViewModelFOV		= 62
SWEP.ViewModelFlip		= false
SWEP.CSMuzzleFlashes	= false
SWEP.IconLetter			= "S"
SWEP.Weight				= 0 --was 5, to remove all the damage
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.HoldType			= "grenade"
SWEP.Instructions 		= "Left click to launch a snowball \nReload to take another one\nUSE key to change trails color\n"
SWEP.Category			= "Snowballs!"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ViewModel 			= "models/weapons/v_snowball.mdl"
SWEP.WorldModel 		= "models/weapons/w_snowball.mdl"
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Primary.ClipSize		= 1
SWEP.Primary.Damage			= 60000 -- real damage
SWEP.Primary.Delay 			= 0
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Secondary.ClipSize		= 1
SWEP.Secondary.DefaultClip	= 1
SWEP.Secondary.Damage		= 0
SWEP.Secondary.Delay 		= 2
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.ReloadSound 			= "none.wav"
SWEP.DrawSound              = "pinpull.wav"

SWEP.IronSightsPos 			= Vector(-15, 0, 15) -- Comment out this line of you don't want ironsights.  This variable must be present if your SWEP is to use a scope.
SWEP.IronSightsAng 			= Vector(0, 0, 0)
SWEP.IronSightZoom			= 1.0 -- How much the player's FOV should zoom in ironsight mode. 

function SWEP:Think()
end

	
function SWEP:GetViewModelPosition( pos, ang ) end
function SWEP:Initialize()
	if self.Harmless then
		self.Slot = 8
	else
		self.slot = 1
	end
	self.WannaIron = false
	self:SetWeaponHoldType( self.HoldType )

 	util.PrecacheSound("weapons/iceaxe/iceaxe_swing1.wav")
	util.PrecacheSound("hit.wav")
	self.Weapon:SetClip1(1)
end

function SWEP:Holster()	
	return true
end


/*---------------------------------------------------------
SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
end

function SWEP:DryFire() end


local function NoGrenadeCollisions(self, e1, e2)
	if ((e1 == self or e2 == self) and (e1 == self:GetOwner() or e2 == self:GetOwner())) then
	   return false
	end
 end

/*---------------------------------------------------------
PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	if self:Clip1() < 1 then return end
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_1)
	self.Weapon:EmitSound("weapons/iceaxe/iceaxe_swing1.wav")
	
	local trace = {}
	trace.start = self.Owner:GetShootPos()
	trace.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 10^14
	trace.filter = self.Owner
	local tr = util.TraceLine(trace)

	local vAng = (tr.HitPos-self.Owner:GetShootPos()):GetNormal():Angle()
	--tr.Entity:SetKeyValue("targetname", "disTarg")
	
	if SERVER then
		local Front = self.Owner:GetAimVector();
		local Up = self.Owner:EyeAngles():Up();
		
		if ( SERVER ) then -- only spawn things on server to prevent issues
			local ball = ents.Create("ent_snowball");

			if IsValid(ball) then

				ball:SetPos(self.Owner:GetShootPos() + Front * 10 + Up * 10 * -1);
				ball:SetAngles(Front:Angle());
				ball.Harmless = self.Harmless
				ball:Spawn();
				ball:Activate();
				ball:SetOwner(self.Owner)
				hook.Add("ShouldCollide", ball, NoGrenadeCollisions)
				local Physics = ball:GetPhysicsObject();

				if IsValid(Physics) then
		
				local Random = Front:Angle();
						
					Random = Random:Forward();
					Physics:ApplyForceCenter(Random * 4000); -- Fixes masive throw (wood)
				end
			end
		end
	end
	self:SetClip1(0)
	self.WannaIron = true
	--timer.Simple(0.6, function() self:Reload() end)
	self.Weapon:SetNextPrimaryFire(CurTime() + 1.5)
end

function SWEP:Reload()
	self:SetClip1(1)
	self.WannaIron = false
	self:SendWeaponAnim( ACT_VM_DRAW )
	return true
end

function SWEP:OnRemove()
	return true
end

function SWEP:Holster()
	return true
end

function SWEP:ShootEffects()
end

-- mostly garry's code
function SWEP:GetViewModelPosition(pos, ang)

	return pos, ang
	
end

-- This function handles player FOV clientside.  It is used for scope and ironsight zooming.
function SWEP:TranslateFOV(current_fov)

	return current_fov

end


IRONSIGHT_TIME = 0.1
-- mostly garry's code
function SWEP:GetViewModelPosition(pos, ang)

	if not self.IronSightsPos then return pos, ang end

	local bIron = self.WannaIron
	if bIron ~= self.bLastIron then -- Are we toggling ironsights?
	
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
		
		if bIron then 
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else 
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
		end
	
	end
	
	local fIronTime = self.fIronTime or 0

	if not bIron and (fIronTime < CurTime() - IRONSIGHT_TIME) then 
		return pos, ang 
	end
	
	local Mul = 1.0 -- we scale the model pos by this value so we can interpolate between ironsight/normal view
	
	if fIronTime > CurTime() - IRONSIGHT_TIME then
	
		Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)
		if not bIron then Mul = 1 - Mul end
	
	end

	local Offset	= self.IronSightsPos
	
	if self.IronSightsAng then
	
		ang = ang*1
		ang:RotateAroundAxis(ang:Right(), 		self.IronSightsAng.x * Mul)
		ang:RotateAroundAxis(ang:Up(), 			self.IronSightsAng.y * Mul)
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
