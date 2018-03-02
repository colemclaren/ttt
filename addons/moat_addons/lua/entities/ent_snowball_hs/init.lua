AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	self.Entity:SetModel("models/weapons/w_snowball_thrown.mdl");
	self.Entity:PhysicsInit(SOLID_VPHYSICS);
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS);
	self.Entity:SetSolid(SOLID_VPHYSICS);
	self.Entity:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:EnableGravity(true);
	end
	local color = Color(255,255,255)
	if not self.Harmless then
		color = Color(255,0,0)
	end
	self.Trail = util.SpriteTrail(self.Entity, 0, color, false, 15, 1, 0.2, 1/(15+1)*0.5, "trails/laser.vmt") 
end

function ENT:Think()
end

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16;
	local ent = ents.Create("ent_snowball");
	ent:SetPos(SpawnPos);
	ent:Spawn();
	ent:Activate();
	ent:SetOwner(ply)
	return ent;
end

function ENT:PhysicsCollide(data)
    if self.Collided then return end
    local pos = self.Entity:GetPos() --Get the position of the snowball
    local effectdata = EffectData()
    data.HitObject:ApplyForceCenter(self:GetPhysicsObject():GetVelocity() * 40)
    if(not self.Harmless) then 
        if not IsValid(data.HitObject) then return end
        data.HitObject:GetEntity():TakeDamage(self.Damage);    
    end
    if IsValid(data.HitObject) then
        local p = data.HitObject:GetEntity()
        self.Weap.CanRR = true
		self.Weap:Reload()
		print("Hit")
		if (p:IsWorld()) then 
            hpos = data.HitPos + data.HitNormal * 2
        --  util.Decal("PaintSplatBlue",pos,hpos,self)
        elseif p:IsPlayer() then
			MG_HS.Current = p
			p:Give("snowball_hs")
			self.Owner:StripWeapons()
		end
    end
    effectdata:SetStart( pos )
    effectdata:SetOrigin( pos )
    effectdata:SetScale( 1.5 )
    self:EmitSound("hit.wav")
    //util.Effect( "watersplash", effectdata ) -- effect
    util.Effect( "inflator_magic", effectdata ) -- effect
    util.Effect( "WheelDust", effectdata ) -- effect
    util.Effect( "GlassImpact", effectdata ) -- effect
    timer.Simple(0,function() self:Remove() end)
    self.Collided = true
end 