AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

function ENT:Draw()
	self:DrawModel()	
	
    local dlight = DynamicLight(self:EntIndex())	
	if dlight then
		local r, g, b, a = self:GetColor()
		dlight.Pos = self:GetPos() + self:GetForward() * 30
		dlight.r = 255
		dlight.g = 178
		dlight.b = 46
		dlight.Brightness = 0
		dlight.Size = 500
		dlight.Decay = 0
		dlight.DieTime = CurTime() + 0.1
	end   
end

if CLIENT then return end

function ENT:Initialize()
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	
	/*timer.Create("effedfs"..self:EntIndex(),0.01,0, function()
		if not IsValid(self) then return end
		local ef = EffectData()
		ef:SetOrigin(self:GetPos())
		ef:SetAttachment(1)
		util.Effect("effect_fireb_fly", ef, true, true)	
	end)*/
	
	self:SetMaterial("models/effects/splode_sheet")
end

function ENT:Think()
	local phys = self:GetPhysicsObject()
	if (IsValid(phys)) then phys:ApplyForceCenter(self.dir) end

	if self:WaterLevel() == 3 then self:Remove() end
end

function ENT:PhysicsCollide(data, physobj)
	timer.Simple(0, function()

	local ef = EffectData()
	ef:SetOrigin(self:GetPos())
	ef:SetAttachment(1)
	util.Effect("effect_fireball_impact", ef, true, true)
	
	self:EmitSound("ambient/explosions/explode_8.wav", 400)

	for k, v in pairs(ents.FindInSphere(data.HitPos, 80)) do
		if (IsValid(v) and v:IsPlayer() and v:Team() ~= TEAM_SPEC) then
			status.Inflict("Inferno", {
				Victim = v,
				Attacker = self.Owner,
				Inflictor = self,
				Time = self.InventoryModifications[1]
			})
		end
	end

	/*
	for k, v in pairs(ents.FindInSphere(data.HitPos, 60)) do
	
		if v:GetClass() == "prop_physics" then if IsValid(v) then v:GetPhysicsObject():EnableMotion(true) end end
	
		v:Ignite(5,50)
		
		if v:IsPlayer() or v:IsNPC() then
			v:SetMaterial("models/charple/charple3_sheet")
			
			timer.Create("shitfuc342202214"..self:EntIndex(), 5, 1, function()
				if not v or not IsValid(v) then return end
				v:SetMaterial("sasdsddsd")			
			end)
			
		else
			v:SetColor(Color(67,46,46,255))
			v:SetMaterial("models/props_c17/metalladder002")
			
			constraint.RemoveAll( v )
		end
		
		local dmg = DamageInfo()	
	
		dmg:SetAttacker(self.Owner)
		dmg:SetInflictor(self)
		dmg:SetDamage(100)
		dmg:SetDamageType(DMG_BURN)
		v:TakeDamageInfo(dmg)
		
	end
	
	data.HitEntity:Ignite(5,10)
	
	if data.HitEntity:IsPlayer() or data.HitEntity:IsNPC() then
	
		data.HitEntity:SetMaterial("models/charple/charple3_sheet")
		
		timer.Create("shitfuc34ff12222214"..self:EntIndex(), 5, 1, function()
			if not data.HitEntity or not IsValid(data.HitEntity) then return end
			data.HitEntity:SetMaterial("sasdsddsd")			
		end)
		
	else
		data.HitEntity:SetColor(Color(67,46,46,255))
		data.HitEntity:SetMaterial("models/props_c17/metalladder002")
		
		if IsValid(data.HitEntity) then data.HitEntity:GetPhysicsObject():EnableMotion(true) end
		
		constraint.RemoveAll( data.HitEntity )
	end*/
	
	util.Decal("Scorch", self:GetPos() + self:GetPos():GetNormalized(), self:GetPos() - self:GetPos():GetNormalized())
	
	self:Remove()

	end)
end