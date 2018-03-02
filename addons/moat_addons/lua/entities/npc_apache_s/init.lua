AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

//make snpc hurt you
//have bounding box move w/ model
//have it make nicenice w/ npc_soldier

ENT.Alerted     = false
ENT.bleeds      = 0
ENT.StartHealth = 650
ENT.PlayerFriendly = 0
ENT.AttackingMelee = false
ENT.State = 0 //1 is moving to enemy, 2 is staying put
ENT.BreathTime = 0
ENT.Enemy = NULL
ENT.BreathTime = 0
ENT.dead = false
ENT.DestAlt = 0
ENT.rocket_toggle = false;
   
function ENT:Initialize()

   self:SetModel( "models/usmcapachelicopter.mdl" )		
   self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
   self.Entity:SetMoveType( MOVETYPE_VPHYSICS )   --after all, gmod is a physics  	
   self.Entity:SetSolid( SOLID_VPHYSICS )        -- Toolbox  
   self:CapabilitiesAdd( CAP_MOVE_FLY )

   self:SetHealth(self.StartHealth)
   self.Enemy = NULL
   //self:EmitSound("npc/attack_helicopter/aheli_rotor_loop1.wav",500,95);
   self.LoopSound = CreateSound(self,Sound("npc/attack_helicopter/aheli_rotor_loop1.wav"))
   self.LoopSound:PlayEx(500,100)
   self.DestAlt = self:GetPos().z + 500
	local phys = self.Entity:GetPhysicsObject()  	
	if (phys:IsValid()) then 		
		phys:Wake()  
		phys:EnableGravity(false) 
	end 
end
   
function ENT:OnTakeDamage(dmg)
  if dmg:IsBulletDamage() then return end;

   self:SetHealth(self:Health() - dmg:GetDamage())

   if dmg:GetAttacker():GetClass() != self:GetClass() && math.random(1,7) == 1 then
   	self:ResetEnemy()
   	self:AddEntityRelationship( dmg:GetAttacker(), 1, 10 )
   	self.Enemy = dmg:GetAttacker()
	//if math.random(1,8) == 1 then
   	//self.myturrent.Enemy = dmg:GetAttacker()
	//end
   end
   self.Alerted = true
   if self:Health() <= 0 && !self.dead then //run on death	
	print("CHOPPERDOWN!!!")
	self.dead = true;
	self:KilledDan()
   end
end

function ENT:Think()
	if self.Enemy:IsValid() == false then
	self.Enemy = NULL
	elseif self.Enemy:Health(health) <= 0 then
	self.Enemy = NULL
	elseif self.Enemy == self then
	self.Enemy = NULL
	end

	if CurTime() > self.BreathTime then
		//self.EmitSound(self,"vehicles/Crane/crane_turn_loop2.wav",420,100)
		self.BreathTime = CurTime() + 2
	end
	
	//self.myturrent:SetPos(self:GetPos())	

	//print(self.TakingCover)
	if self:Health() > 0 && GetConVarNumber("ai_disabled") == 0 then

		//print( "Think start" );
		//Get all the npc's and other entities.
		local enttable = ents.FindByClass("npc_*")
		local monstertable = ents.FindByClass("monster_*")
		table.Add(monstertable,enttable)//merge

		//sort through each ent.
		for _, x in pairs(monstertable) do
			if (!ents) then print( "No Entities!" ); return end
			if (x:GetClass() != self:GetClass() && x:GetClass() != "npc_grenade_frag" && x:IsNPC()) then
				print(x)
				print("..is chassis enemy")
				if x:GetClass() != "npc_soldier" then
				x:AddEntityRelationship( self, 1, 10 )
				else
				x:AddEntityRelationship( self, 3, 10 )
				end
			end
		end

		local friends = ents.FindByClass("npc_soldier")
		for _, x in pairs(friends) do
		x:AddEntityRelationship( self, 3, 10 )
		end

		local friends = ents.FindByClass("npc_tank")
		for _, x in pairs(friends) do
		x:AddEntityRelationship( self, 3, 10 )
		end

		local friends = ents.FindByClass("npc_tank_turrent")
		for _, x in pairs(friends) do
		x:AddEntityRelationship( self, 3, 10 )
		end

		//set fixed angles
		local phy = self:GetPhysicsObject()
		if phy:IsValid() then
			local velocity = phy:GetVelocity()
			phy:SetAngles( Angle(20,self:GetAngles().y,0) )
			phy:SetVelocity(velocity)
		end

		self:FindEnemyDan()
		
		//set the turrents location to our own
		//self.myturrent:SetAngles(Angle(-(self:GetAngles().p),self.myturrent:GetAngles().y,0))

		if self.Enemy != NULL then 
				//apply movement
				//print("works")
				
				local wantedvector = (self.Enemy:GetPos() - self:GetPos() + Vector(0,0,80))
				local wantedangle = (self.Enemy:GetPos() - self:GetPos() + Vector(0,0,80)):Angle()
				local currentangle = Angle(20,self:GetAngles().y,0)
				local anglediff = self:GetAngleDiff(wantedangle.y,currentangle.y)
				local pitchdiff = self:GetAngleDiff(wantedangle.p,currentangle.p)
				local heightratio = (self.Enemy:GetPos().z - self:GetPos().z ) / self:GetPos():Distance(self.Enemy:GetPos())
				
				if self:GetPos():Distance(self.Enemy:GetPos()) > 2300 then
					//print("moving")
					local phy = self:GetPhysicsObject()
					if phy:IsValid() then
                    phy:ApplyForceCenter((wantedvector * 0))
					end
				end
				if math.abs(anglediff) < 30 && self:GetPos():Distance(self.Enemy:GetPos()) < 2300 then
					local shoot_vector = wantedvector
					shoot_vector:Normalize()

					local bullet = {}
					bullet.Num = 4
					bullet.Src = self:GetPos() + self:GetForward()*150
					bullet.Damage = 3
					bullet.Force		= 200
					bullet.Tracer		= 1
					bullet.Spread		= Vector( 12 / 90, 12 / 90, 0 )
					bullet.Dir =  shoot_vector
					self:FireBullets( bullet )
					self:EmitSound("apache/fire.wav",500,100)
					
					if math.random(0,200) <= 1 then
						local shoot_vector = wantedvector
						shoot_vector:Normalize()
						local rocket = ents.Create("proj_dan_heli_shot")
						if self.rocket_toggle == true then
							rocket:SetPos(self:LocalToWorld(Vector(150,40,-20)))
							self.rocket_toggle = false
						else
							rocket:SetPos(self:LocalToWorld(Vector(150,-40,-20)))
							self.rocket_toggle = true
						end
						rocket:SetAngles(shoot_vector:Angle())
						rocket:Activate()
						rocket:Spawn()
						local phy = rocket:GetPhysicsObject()
						if phy:IsValid() then
							phy:ApplyForceCenter((shoot_vector * 7500))
						end
					end
					//FINISH ME
				elseif math.random(0,200) <= 40 then
					local shoot_vector = wantedvector
					shoot_vector:Normalize()
					local rocket = ents.Create("proj_dan_heli_shot")
					if self.rocket_toggle == true then
						rocket:SetPos(self:LocalToWorld(Vector(150,40,-20)))
						self.rocket_toggle = false
					else
						rocket:SetPos(self:LocalToWorld(Vector(150,-40,-20)))
						self.rocket_toggle = true
					end
					rocket:SetAngles(shoot_vector:Angle())
					rocket:Activate()
					rocket:Spawn()
					local phy = rocket:GetPhysicsObject()
					if phy:IsValid() then
						phy:ApplyForceCenter((shoot_vector * 7500))
					end
				end
				
				if anglediff > 5 then
					print("turning positive")
					local phy = self:GetPhysicsObject()
					if phy:IsValid() then
						local velocity = phy:GetVelocity()
						phy:SetAngles( currentangle + Angle(0,5,0) )
						phy:SetVelocity(velocity)
					end
				elseif anglediff < -5 then
					print("turning negative")
					local phy = self:GetPhysicsObject()
					if phy:IsValid() then
						local velocity = phy:GetVelocity()
						phy:SetAngles( currentangle + Angle(0,-5,0) )
						phy:SetVelocity(velocity)
					end
				end
		end

		if self.DestAlt + 100 > self:GetPos().z then
			local phy = self:GetPhysicsObject()
			if phy:IsValid() then
				phy:ApplyForceCenter((Vector(0.15,0,1) * 5000))
			end
		elseif self.DestAlt + 100 < self:GetPos().z then
			local phy = self:GetPhysicsObject()
			if phy:IsValid() then
				phy:ApplyForceCenter((Vector(0.15,0,-1) * 5000))
			end
		end	
	end
	
end

function ENT:Touch( ent )
	if ent:GetClass() == "npc_grenade_rocket" then
		self:TakeDamage(200,ent)
		return
	end
	if self.State == 0 then
		ent:TakeDamage(100,self)
	end
end

function ENT:GetAngleDiff(angle1, angle2)
	local result = angle1 - angle2
	if result < -180 then
	result = result + 360
	end

	if result > 180 then
	result = result - 360
	end
	
	return result
end
   
function ENT:SelectSchedule()

if self.Enemy:IsValid() == false then
	self.Enemy = NULL
elseif self.Enemy:Health(health) <= 0 then
	self.Enemy = NULL
end

if self:Health() > 0 then
	local haslos = self:HasLOS()
	local distance = 0
	local enemy_pos = 0

	if self.Enemy:IsValid() == false then
	self.Enemy = NULL
	elseif self.Enemy:Health(health) <= 0 then
	self.Enemy = NULL
	elseif self.Enemy == self then
	self.Enemy = NULL
	end

	if self.Enemy == NULL then//no enemy
		//print( "No Enemy!" );
		//play idle sounds every now and then
	else
		//print( "Enemy!" );
		//print(self.Enemy)
		print(self.Enemy)
		print("..is chassis enemy")
		enemy_pos = self.Enemy:GetPos()
		distance = self:GetPos():Distance(enemy_pos)
		//distance = 4000
	        if distance > 2300 then// too far away
			self.State = 0//move to him
		elseif distance < 2300 && distance > 380 then//if in reasonable distance
			self.State = 1//stay put
		else//if too close 
			self.State = 1//stay put
		end
	end
end
end

function ENT:FindEnemyDan()
	local MyNearbyTargets = ents.FindInSphere(self:GetPos(),1500)
	//local ClosestDistance = 3000
	if (!MyNearbyTargets) then print( "No Targets!" ); return end
	for k,v in pairs(MyNearbyTargets) do
	    if self:Disposition( v ) == D_HT || v:IsPlayer() then
	    if (v:GetClass() != self:GetClass()) && v != self then
		self:ResetEnemy()
   		self:AddEntityRelationship( v, 1, 10 )
	      	self.Enemy = v
		//alerted
		self.Alerted = true
	      	return
	    end
	    end
	end
	MyNearbyTargets = ents.FindInSphere(self:GetPos(),5000)
	if (!MyNearbyTargets) then print( "No Targets!" ); return end
	for k,v in pairs(MyNearbyTargets) do
	    if self:Disposition( v ) == D_HT || v:IsPlayer() then
	    if (v:GetClass() != self:GetClass()) && v != self then
		self:ResetEnemy()
   		self:AddEntityRelationship( v, 1, 10 )
	      	self.Enemy = v
		//alerted
		self.Alerted = true
	      	return
	    end
	    end
	end
	MyNearbyTargets = ents.FindInSphere(self:GetPos(),10000)
	if (!MyNearbyTargets) then print( "No Targets!" ); return end
	for k,v in pairs(MyNearbyTargets) do
	    if self:Disposition( v ) == D_HT || v:IsPlayer() then
	    if (v:GetClass() != self:GetClass()) && v != self then
		self:ResetEnemy()
   		self:AddEntityRelationship( v, 1, 10 )
	      	self.Enemy = v
		//alerted
		self.Alerted = true
	      	return
	    end
	    end
	end
	//if ClosestDistance == 4000 then
	self.Enemy = NULL
	//end
end

function ENT:StopHurtSounds()
end

function ENT:KilledDan()

	//create ragdoll
	local ragdoll = ents.Create( "prop_physics" )
	ragdoll:SetModel( "models/apgb/helicopter_brokenpiece_06_body.mdl" )
	ragdoll:SetPos( self:GetPos() )
	ragdoll:SetAngles( self:GetAngles() )
	ragdoll:Spawn()
	ragdoll:SetSkin( self:GetSkin() )
	ragdoll:SetColor( self:GetColor() )
	ragdoll:SetMaterial( self:GetMaterial() )
	undo.AddEntity(ragdoll)

	local ragdoll = ents.Create( "prop_physics" )
	ragdoll:SetModel( "models/apgb/helicopter_brokenpiece_04_cockpit.mdl" )
	ragdoll:SetPos( self:LocalToWorld(Vector(100,0,0)))
	ragdoll:SetAngles( self:GetAngles() )
	ragdoll:Spawn()
	ragdoll:SetSkin( self:GetSkin() )
	ragdoll:SetColor( self:GetColor() )
	ragdoll:SetMaterial( self:GetMaterial() )
	undo.AddEntity(ragdoll)

	local ragdoll = ents.Create( "prop_physics" )
	ragdoll:SetModel( "models/apgb/helicopter_brokenpiece_05_tailfan.mdl" )
	ragdoll:SetPos( self:LocalToWorld(Vector(-100,0,0)))
	ragdoll:SetAngles( self:GetAngles() )
	ragdoll:Spawn()
	ragdoll:SetSkin( self:GetSkin() )
	ragdoll:SetColor( self:GetColor() )
	ragdoll:SetMaterial( self:GetMaterial() )
	
	//my code
	undo.AddEntity(ragdoll)
	cleanup.ReplaceEntity(self,ragdoll)

	//ignight ragdoll if on fire.
	if self:IsOnFire() then ragdoll:Ignite( math.Rand( 8, 10 ), 0 ) end

	//position bones the same way.
        for i=1,128 do
		local bone = ragdoll:GetPhysicsObjectNum( i )
		
	end
	
	//kill our turrent
	local bar = ents.Create("env_shake")
	bar:SetPos(self:GetPos())
	bar:SetKeyValue("amplitude","8")
	bar:SetKeyValue("radius","4000")
	bar:SetKeyValue("duration","0.75")
	bar:SetKeyValue("frequency","128")
	bar:Fire( "StartShake", 0, 0 )
	
	//kill our turrent
	//self.myturrent:KilledDan()
	local blargity = EffectData()
	blargity:SetStart(self:GetPos())
	blargity:SetOrigin(self:GetPos())
	blargity:SetScale(500)
   	self.LoopSound:Stop()
	
	util.Effect("HelicopterMegaBomb",blargity)
	util.Effect("ThumperDust",blargity)
	self:StopSound("npc/attack_helicopter/aheli_rotor_loop1.wav")
	self:Remove()
end

function ENT:ResetEnemy()
	local enttable = ents.FindByClass("npc_*")
	local monstertable = ents.FindByClass("monster_*")
	table.Add(monstertable,enttable)//merge

	//sort through each ent.
	for _, x in pairs(monstertable) do
		//print(x)
		if (!ents) then print( "No Entities!" ); return end
		if (x:GetClass() != self:GetClass()) then
			self:AddEntityRelationship( x, 2, 10 )
		end
		//print("Relationship Complete")
	end
	self:AddRelationship("player D_NU 10")
end

function ENT:OnRemove()
self:StopSound("npc/attack_helicopter/aheli_rotor_loop1.wav")
self.LoopSound:Stop()
end

function ENT:HasLOS()
	if self.Enemy != NULL then
	//local shootpos = self:GetAimVector()*(self:GetPos():Distance(self.Enemy:GetPos())) + self:GetPos()
	//local shootpos = self.Enemy:GetPos()
	local tracedata = {}

	tracedata.start = self:GetPos()
	tracedata.endpos = self.Enemy:GetPos()
	tracedata.filter = self

	local trace = util.TraceLine(tracedata)
	if trace.HitWorld == false then
		return true
	else 
		return false
	end
	end
	print ("no enemy!")
	return false
end