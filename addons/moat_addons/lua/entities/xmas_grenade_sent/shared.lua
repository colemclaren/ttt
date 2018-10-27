ENT.Type = "anim"
ENT.PrintName			= "explosive Grenade"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions			= ""
ENT.Spawnable			= false
ENT.AdminOnly = true 
ENT.DoNotDuplicate = true 
ENT.DisableDuplicator = true

if SERVER then

AddCSLuaFile( "shared.lua" )

function ENT:Initialize()

	self.Owner = self.Entity.Owner
	self.timeleft = CurTime() + 1.5
	self.Entity:SetModel("models/roblox/holiday_owl.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
	phys:Wake()
	end

	self:Think()
	self.CanTool = false
end

 function ENT:Think()
	
	if not IsValid(self) then return end
	if not IsValid(self.Entity) then return end
	
	if (not self.timeleft or (self.timeleft <= CurTime())) then
		self:Explosion()	
	end

	self.Entity:NextThink( CurTime() )
	return true
end

function ENT:Explosion()

	if not IsValid(self.Owner) then
		self.Entity:Remove()
		return
	end

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
		effectdata:SetEntity(self.Entity)
		effectdata:SetStart(self.Entity:GetPos())
		effectdata:SetNormal(Vector(0,0,1))
		--util.Effect("ManhackSparks", effectdata)
		util.Effect("cball_explode", effectdata)
		util.Effect("Explosion", effectdata)
	
	local thumper = effectdata
		thumper:SetOrigin(self.Entity:GetPos())
		thumper:SetScale(500)
		thumper:SetMagnitude(500)
		util.Effect("ThumperDust", effectdata)
		
	local sparkeffect = effectdata
		sparkeffect:SetMagnitude(3)
		sparkeffect:SetRadius(8)
		sparkeffect:SetScale(5)
		util.Effect("Sparks", sparkeffect)
		
	local scorchstart = self.Entity:GetPos() + ((Vector(0,0,1)) * 5)
	local scorchend = self.Entity:GetPos() + ((Vector(0,0,-1)) * 5)
	
	util.BlastDamage(self.Entity, self.Owner, self.Entity:GetPos(), 350, 100)
	util.ScreenShake(self.Entity:GetPos(), 500, 500, 1.25, 500)
	self.Entity:Remove()
	util.Decal("Scorch", scorchstart, scorchend)
end

function ENT:OtherExplosion()

	if not IsValid(self.Owner) then
		self.Entity:Remove()
		return
	end

	util.BlastDamage(self.Entity, self.Owner, self.Entity:GetPos(), 450, 350)
	util.ScreenShake(self.Entity:GetPos(), 500, 500, 1.25, 500)	
	
	local scorchstart = self.Entity:GetPos() + ((Vector(0,0,1)) * 5)
	local scorchend = self.Entity:GetPos() + ((Vector(0,0,-1)) * 5)

	pos = self.Entity:GetPos() --+Vector(0,0,10)
	
	local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetEntity(self.Entity)
		effectdata:SetStart(pos)
		effectdata:SetNormal(Vector(0,0,1))
	util.Effect("Explosion", effectdata)
	
	local thumper = effectdata
		thumper:SetOrigin(self.Entity:GetPos())
		thumper:SetScale(500)
		thumper:SetMagnitude(500)
	util.Effect("ThumperDust", thumper)
	
	local sparkeffect = effectdata
		sparkeffect:SetMagnitude(3)
		sparkeffect:SetRadius(8)
		sparkeffect:SetScale(5)
	util.Effect("Sparks", sparkeffect)
	
	local fire = EffectData()
		fire:SetOrigin(pos)
		fire:SetEntity(self.Owner) //i dunno, just use it!
		fire:SetScale(1)
	util.Effect("nfrag_xplode", fire)
	
	for i=1, 30 do 
			
		ouchies = {}
		ouchies.start = pos
		ouchies.endpos = pos + (Vector(math.Rand(-1,1), math.Rand(-1,1), math.Rand(0,1)) * 64000)
		ouchies.filter = self.Entity
		ouchies = util.TraceLine(ouchies)
		
		if ouchies.Hit then
			local bullet = {}
			bullet.Num 		= 2
			bullet.Src 		= pos			-- Source
			bullet.Dir 		= ouchies.Normal			-- Dir of bullet
			bullet.Spread 	= Vector(.001,.001, 0)			-- Aim Cone
			bullet.Tracer	= 1							-- Show a tracer on every x bullets
			bullet.TracerName = "m9k_effect_mad_penetration_trace"
			bullet.Force	= 100					-- Amount of force to give to phys objects
			bullet.Damage	= 200

			self.Owner:FireBullets(bullet)
			if ouchies.Entity == self.Owner then 
				ouchies.Entity:TakeDamage(200 * math.Rand(.85,1.15), self.Owner, self.Entity)
			end
		end
	end
	
	self.Entity:Remove()
	util.Decal("Scorch", scorchstart, scorchend)
	
	self.Entity:EmitSound("ambient/explosions/explode_9.wav", pos, 500, 100 )
end

/*---------------------------------------------------------
PhysicsCollide
---------------------------------------------------------*/
function ENT:PhysicsCollide(data,phys)
	if data.Speed > 50 then
		self.Entity:EmitSound(Sound("HEGrenade.Bounce"))
	end
	
	local impulse = -data.Speed * data.HitNormal * .4 + (data.OurOldVelocity * -.6)
	phys:ApplyForceCenter(impulse)
	
end

end

if CLIENT then
function ENT:Draw()
	self.Entity:DrawModel()
end
end
function ENT:SetThrower()
end

function ENT:SetDetonateTimer(length)
   self:SetDetonateExact( CurTime() + length )
end

function ENT:SetDetonateExact()
end