AddCSLuaFile( 'cl_init.lua' )

AddCSLuaFile( 'shared.lua' )

include( 'shared.lua' )









local MAX_HEALTH = 60

local EXPLODE_DAMAGE = 120 

local EXPLODE_RADIUS = 140 

local EXPLODE_DAMAGE2 = 90 

local EXPLODE_RADIUS2 = 360

local JUMP_VERT_SPEED = 220 

local JUMP_HORIZ_SPEED = 400 

local WADDLE_SPEED = 300 

local TARGET_RADIUS = 600 

local ATTACK_DIST = 150 

local ANGER_STARTATTACK = 15

local ANGER_MAX = 255 

local ANGER_RATE = 3



local sndTabAttack = 

{

	"chicken/attack1.wav",

	"chicken/attack2.wav"

}



local sndTabIdle = 

{

	"chicken/idle1.wav",

	"chicken/idle2.wav",

	"chicken/idle3.wav"

}



local sndTabPain = 

{

	"chicken/pain1.wav",

	"chicken/pain2.wav",

	"chicken/pain3.wav" 

}



local sndAngry = "chicken/alert.wav"

local sndDeath = "chicken/death.wav"

local sndCharge = "chicken/charge.wav"



function ENT:Initialize()	





	self:SetModel( "models/lduke/chicken/chicken3.mdl" )

	



	local mins = Vector( -7, -6, 0 )

	local maxs = Vector( 7, 6, 25 )

	

	self:PhysicsInit( SOLID_VPHYSICS )



	self:SetCollisionBounds( mins, maxs )

	

	self:SetSolid( SOLID_VPHYSICS )

	self:SetMoveType( MOVETYPE_VPHYSICS )

	

	self.Phys = self:GetPhysicsObject()

	if self.Phys:IsValid() then 

		self.Phys:SetMass( 8 )

		self.Phys:Wake()

	end

	



	self.CurHealth = MAX_HEALTH

	

	self.reprotime = CurTime() + math.random(30,75)

	



	self.Attacking = self.Attacking or false

	



	self.Attacker = self.Attacker or NULL

	



	self.Dieing = self.Dieing or false

	



	self.IsChicken = true

	



	self.Anger = self.Anger or 0

	



	self.Target = self.Target or NULL

	self.TargetHasPhysics = self.TargetHasPhysics or false

	self.TargetPhys = self.TargetPhys or NULL

	



	self.Waddling = self.Waddling or false

	self.InitialWaddlePhase = math.Rand( 0, 2 * math.pi )

	self.LastAngleChange = self.LastAngleChange or 0

	self.NextEmitIdle = self.NextEmitIdle or CurTime()

	



	self.NextJump = self.NextJump or CurTime()

	



	self.CurrentMoveFunction = self.CurrentMoveFunction or self.Waddle 

	



	self:StartMotionController()

	



	self:EmitSound( sndTabAttack[ math.random( 1, #sndTabAttack ) ], 100, 100 )



end





function ENT:SpawnFunction( ply, tr )



	if not tr.Hit then return end

	

	local ent = ents.Create( self.Classname )

	ent:SetPos( tr.HitPos + tr.HitNormal * 8 )

	ent:Spawn()

	ent:Activate()

	

	return ent



end



function ENT:Reproduce()

	local foundclucker = 0

	

	for k, v in pairs(ents.GetAll()) do 

		if v:GetClass() == "weapon_ttt_chickennade" then

			foundclucker = foundclucker + 1

		end

	end

	

	if foundclucker > 30 then return end

	

	if self.reprotime < CurTime() then

		self.reprotime = CurTime() + math.random(30,75)

		

		local ent = ents.Create( "weapon_ttt_chickennade" )

		ent:SetPos( self:GetPos() )

		ent:Spawn()

		ent:Activate()

	end

end







function ENT:Think()



	self:NextThink( CurTime() + 0.2 )





	if not self.Attacker:IsValid() then

		self:SetAttacker( self )

	end

	

	local coloring = ANGER_MAX - self.Anger

	self:SetColor(Color(255, coloring, coloring, 255))





	if self.Waddling then

	



		local target = self:FindTarget()

		if target:IsPlayer() then

			if target:IsValid() and not target:IsSpec() and not target:GetNW2Bool("stealthed", false) then 

			

				self.Anger = self.Anger + ANGER_RATE

					

				if self.Anger >= ANGER_STARTATTACK then 

					

					if math.random() < 0.05 then

						self:EmitSound( sndCharge )

					end

				

					self:StopWaddling()

					self:SetTarget( target )

					

					return true

						

				end

			end

		else

	

			if self.Anger > 0 then 

				self.Anger = self.Anger - ANGER_RATE

				if self.Anger < 0 then self.Anger = 0 end				

			end

				

			if self.Anger < 50 then

				--self:Reproduce()

			end

		end

		

	

		if self:GetAngles():Up():Dot( Vector( 0, 0, -1) ) >= 0 and self:OnSomething() then

	

			self.Phys:AddVelocity( Vector( 0, 0, 200 ) )

		

	

		end

	



		if CurTime() > self.NextEmitIdle then

		

			self.NextEmitIdle = CurTime() + 3

		

		

			if math.random() < 0.33 then

				self:EmitSound( sndTabIdle[ math.random( 1, #sndTabIdle ) ] )

			end



		end

		

		return true

		

	end

	



	if not self:CanSeeTarget() then

	

		

		self:StartWaddling()

		return true



	end

	



	self.Anger = self.Anger + ANGER_RATE

	if self.Anger > 200 and not self.Dieing then

	

		self.Dieing = true

		

		self:DoDeath2()

		return true

		

	end

	

	

	if CurTime() > self.NextJump then

		

		self.Attacking = false

		

		if not self:OnSomething() then

			self.NextJump = CurTime() + 0.6

			return true

		end

		

		self:JumpAtTarget()

		self.NextJump = CurTime() + 1.5

		

	end

		

	return true



end







function ENT:PhysicsCollide( data, phys )



	if data.Speed < 30 then return end

	

	

	if data.Speed > 900 then

	

		self:TakeDamage( 0.2 * ( data.Speed - 900 ), data.HitEntity, data.HitEntity )

	

	end



	

	if self.Attacking and not ( data.HitEntity:IsWorld() or data.HitEntity.IsChicken ) then

	

		local dmg = 50

		if data.HitEntity:IsPlayer() then

			if data.HitEntity:GetActiveWeapon():GetClass() == "weapon_ttt_riot" then

				dmg = 5

			end

		end

		

		local dmginfo = DamageInfo()

        dmginfo:SetDamage(dmg)

        dmginfo:SetAttacker(self.Attacker)

        dmginfo:SetInflictor(self)

        dmginfo:SetDamageType(DMG_CLUB)

        dmginfo:SetDamageForce(self:GetPos() - data.HitEntity:GetPos())

        dmginfo:SetDamagePosition(data.HitEntity:GetPos())

		

		if self.IsPoisoned then

			if data.HitEntity:IsPlayer() then

				TakePoisonDamage(data.HitEntity, self.Attacker, self)

			end

		end



        data.HitEntity:TakeDamageInfo(dmginfo)

		self.Attacking = false

	end



end







function ENT:OnTakeDamage( dmginfo )

	self.Anger = self.Anger + 25

	

	if dmginfo:GetAttacker():IsPlayer() and IsValid(dmginfo:GetAttacker():GetActiveWeapon()) and dmginfo:GetAttacker():GetActiveWeapon():GetClass() == "weapon_ttt_poisondart" then

		self.IsPoisoned = true

	else

		self.IsPoisoned = false

	end

	

	self:TakePhysicsDamage( dmginfo )

	

	if self.Dieing then return end

	

	self.CurHealth = self.CurHealth - dmginfo:GetDamage()

	if self.CurHealth <= 0 then



		self.Dieing = true

		if dmginfo:GetAttacker():IsWorld() then

			self:DoDeath()

		else

			timer.Simple( math.Rand( 0.05, 0.1 ), function() self:DoDeath() end )

		end

		

		return

		

	end

	



	self:EmitSound( sndTabPain[ math.random( 1, #sndTabPain ) ] )

	



	local dmgpos = dmginfo:GetDamagePosition()

	if dmgpos == Vector( 0, 0, 0 ) then 

		dmgpos = self:GetPos()

		dmgpos.z = dmgpos.z + 10

	end

	

	local fx = EffectData()

	fx:SetOrigin( dmgpos )

	util.Effect( "chicken_pain", fx )



end





function ENT:FindTarget()



	local target = NULL

	local shortest = TARGET_RADIUS

	local mypos = self:GetPos()





	for _,ent in pairs(player.GetAll()) do
		if (ent:IsPlayer() and ent:Alive() and !ent:IsActiveTraitor() and mypos:DistToSqr(ent:GetPos()) <= (TARGET_RADIUS * TARGET_RADIUS)) then 
			local dist = ent:GetPos():Distance( mypos )

		

			if dist < shortest then

			

				shortest = dist

				target = ent

			

			end

	

		end

	

	end



	return target



end







function ENT:SetTarget( ent )



	self.Target = ent

	self.TargetIsPlayer = self.Target:IsPlayer()

	

	local phys = self.Target:GetPhysicsObject()

	if phys:IsValid() then

		self.TargetHasPhysics = true

		self.TargetPhys = phys

	end

	

	self.CurrentMoveFunction = self.TrackTarget

	



	if ent:IsNPC() then

		ent:AddEntityRelationship( self, D_HT, 99 ) 

	end



end







function ENT:CanSeeTarget()



	if not self.Target:IsValid() then return false end

	if self.TargetIsPlayer and not self.Target:Alive() then return false end

	if self.Target:Health() <= 0 then return false end

	

	if self:GetPos():Distance( self.Target:GetPos() ) > TARGET_RADIUS then return false end

	if not self:Visible( self.Target ) then return false end

	

	return true

	

end







function ENT:OnSomething()



	local start = self:GetPos() + Vector( 0, 0, 20 )

	local endpos = Vector( start.x, start.y, start.z - 30 )



	local tr = util.TraceLine( 

	{

		start = start,

		endpos = endpos,

		filter = self,

		mask = bit.bor(MASK_SOLID, MASK_WATER)

	})

	

	return tr.Hit



end





function ENT:StartWaddling()



	self.Waddling = true

	self.CurrentMoveFunction = self.Waddle



end





function ENT:StopWaddling()



	self.Waddling = false



end





function ENT:SetAttacker( plr )



	self.Attacker = plr



end







function ENT:DoDeath()



	local mypos = self:GetPos()

	



	local fx = EffectData()

	fx:SetOrigin( mypos )

	util.Effect( "chicken_death", fx )

	util.Effect( "Explosion", fx, true, true )

	

	self:Explode()

	



	self:EmitSound( sndDeath )

	

	local kfc = ents.Create("ttt_kfc")

	kfc:SetPos(self:GetPos())

	kfc:SetAngles(self:GetAngles())

	kfc:Spawn()

	kfc:PhysWake()

	



	self:Remove()



end



function ENT:DoDeath2()



	if not self:IsValid() then return end 

	local mypos = self:GetPos()

	



	local fx = EffectData()

	fx:SetOrigin( mypos )

	util.Effect( "chicken_death", fx )

	util.Effect( "Explosion", fx, true, true )

	

	self:Explode2()

	



	self:EmitSound( sndDeath )

	



	self:Remove()



end



function ENT:Explode()



	local mypos = self:GetPos()

	local dmgmul = -EXPLODE_DAMAGE / EXPLODE_RADIUS

	for _,ent in pairs( ents.FindInSphere( self:GetPos(), EXPLODE_RADIUS ) ) do



		local dmg = dmgmul * mypos:Distance( ent:GetPos() ) + EXPLODE_DAMAGE

		if ent.Chicken then dmg = 0.5 * dmg end

		if ent:IsPlayer() then

			

			local dmginfo = DamageInfo()

			dmginfo:SetDamage(dmg)

			dmginfo:SetAttacker(self.Attacker)

			dmginfo:SetInflictor(self)

			dmginfo:SetDamageType(DMG_BLAST)

			dmginfo:SetDamageForce(self:GetPos() - ent:GetPos())

			dmginfo:SetDamagePosition(ent:GetPos())



			ent:TakeDamageInfo(dmginfo)

			

		end

	end

end



function ENT:Explode2()



	local mypos = self:GetPos()

	local dmgmul = -EXPLODE_DAMAGE2 / EXPLODE_RADIUS2

	for _,ent in pairs( ents.FindInSphere( self:GetPos(), EXPLODE_RADIUS2 ) ) do



		local dmg = dmgmul * mypos:Distance( ent:GetPos() ) + EXPLODE_DAMAGE2

		if ent.Chicken then dmg = 0.5 * dmg end

		if ent:IsPlayer() then

			local dmginfo = DamageInfo()

			dmginfo:SetDamage(dmg)

			dmginfo:SetAttacker(self.Attacker)

			dmginfo:SetInflictor(self)

			dmginfo:SetDamageType(DMG_BLAST)

			dmginfo:SetDamageForce(self:GetPos() - ent:GetPos())

			dmginfo:SetDamagePosition(ent:GetPos())



			ent:TakeDamageInfo(dmginfo)

		end

	end

end







function ENT:PhysicsSimulate( phys, dt )



	phys:Wake()



	return self:CurrentMoveFunction( phys, dt )



end







function ENT:JumpAtTarget()





	local vel

	if self.TargetHasPhysics then

		vel = self.TargetPhys:GetVelocity()

	else

		vel = self.Target:GetVelocity()

	end

	

	local mypos = self:GetPos()

	local targpos = self.Target:EyePos()

	local disp = targpos - mypos

	



	local proj = vel - ( disp:Dot( vel ) / disp:Dot( disp ) ) * disp

	



	local dest = targpos + proj * 0.6

	local dist = mypos:Distance( dest )

	



	vel = ( dest - mypos ) * ( JUMP_HORIZ_SPEED / dist )

	vel.z = vel.z + JUMP_VERT_SPEED

	if vel.z < 20 then vel.z = 20 end

	

	if type(vel) != "userdata" then

	    self.Phys:AddVelocity( vel )

    end

	

	local ang = Vector( ( math.random( 0, 1 ) * 2 - 1 ) * math.Rand( 300, 600 ), math.Rand( -600, 200 ), ( math.random( 0, 1 ) * 2 - 1 ) * math.Rand( 300, 600 ) )

	if type(ang) == "Vector" then

	    self.Phys:AddAngleVelocity(ang)

	end

	



	local angerratio = ( self.Anger - ANGER_STARTATTACK ) / ( ANGER_MAX - ANGER_STARTATTACK )

	local vol = 100 + 50 * angerratio

	local pitch = 100 + 20 * angerratio



	if dist < ATTACK_DIST then -- Attack!

	

		self.Attacking = true

		self:EmitSound( sndTabAttack[ math.random( 1, #sndTabAttack ) ], vol, pitch )

	

	else

	

		self:EmitSound( sndAngry, vol, pitch )

		

	end

	

end





function ENT:Waddle( phys, dt )



	if not self:OnSomething() then return SIM_NOTHING end



	local TargetAng = self:GetAngles()

	local DeltaAng = math.Rand( -50, 50 ) * dt + self.LastAngleChange

	self.LastAngleChange = DeltaAng

	

	TargetAng.p = 0

	TargetAng.y = TargetAng.y + 30 * math.sin( 0.6 * CurTime() ) + DeltaAng 

	TargetAng.r = 60 * math.sin( 10 * CurTime() + self.InitialWaddlePhase ) 





	phys:ComputeShadowControl(

	{

		secondstoarrive		= 1,

		angle				= TargetAng,

		maxangular			= 400,

		maxangulardamp		= 60,

		dampfactor			= 0.8,

		deltatime			= dt

	})

	

	local linear = self:GetAngles():Forward() * WADDLE_SPEED - phys:GetVelocity()

	linear.z = linear.z + 250 

	

	return Vector( 0, 0, 0 ), linear, SIM_GLOBAL_ACCELERATION



end





function ENT:TrackTarget( phys, dt )



	local TargetAng



	if self.Target:IsValid() then

	

		local targpos = self.Target:GetPos()

		local mypos = phys:GetPos()

	

		TargetAng = ( targpos - mypos ):Angle()

		

	else

		

		TargetAng = phys:GetAngles()

		TargetAng.p = 0

		TargetAng.r = 0

		

	end

	



	phys:ComputeShadowControl(

	{

		secondstoarrive		= 1,

		angle				= TargetAng,

		maxangular			= 150,

		maxangulardamp		= 80,

		dampfactor			= 0.8,

		deltatime			= dt

	})



	return SIM_NOTHING



end



