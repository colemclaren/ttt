AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Think()
end

function ENT:PhysicsCollide(data)
	if (self.Collided) then return end
	local pos = self.Entity:GetPos() --Get the position of the snowball
	local effectdata = EffectData()
	data.HitObject:ApplyForceCenter(self:GetPhysicsObject():GetVelocity() * 40)
	if(not self.Harmless) then 
		if (not IsValid(data.HitObject)) then return end
		if (data.HitEntity:GetClass() == "ent_propshot") then return end
		local dmg = DamageInfo()
		dmg:SetAttacker(self.Owner)
		dmg:SetInflictor(self)
		dmg:SetDamage(self.Damage)
		data.HitObject:GetEntity():TakeDamageInfo(dmg);
	end
	if IsValid(data.HitObject) then
		local p = data.HitObject:GetEntity()
		if (p:IsWorld()) then 
			hpos = data.HitPos + data.HitNormal * 2
			--util.Decal("PaintSplatBlue",pos,hpos,self)
		end
	end
	effectdata:SetStart( pos )
	effectdata:SetOrigin( pos )
	effectdata:SetScale( 1.5 )
	self:EmitSound("hit.wav")
	//util.Effect( "watersplash", effectdata ) -- effect
	util.Effect( "WheelDust", effectdata ) -- effect
	util.Effect( "GlassImpact", effectdata ) -- effect
	timer.Simple(30,function() if (IsValid(self)) then self:Remove() end end)
	self.Collided = true
end 