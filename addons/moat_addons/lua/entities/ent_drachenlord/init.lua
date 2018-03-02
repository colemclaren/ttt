AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


local meddl = Sound("drachenbomb/meddl4.ogg")
local song = Sound("drachenbomb/meddl2.ogg")
local spawnSounds = {}
for i=1, 15 do
	spawnSounds[i] = Sound("drachenbomb/rnd_1/meddl_"..i..".ogg")
end

function ENT:Initialize()
    self:PhysicsInitBox(Vector(-25,-25,0), Vector(25,25,60)) 
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:EnableCustomCollisions(true)
	self:PhysWake()
	self:DrawShadow(false)
	self.Entity:EmitSound(song, 100, 100, 1);
	self.Entity:EmitSound(spawnSounds[math.random(1,15)],100,100,1)
	timer.Simple(6.5,function()
			if(!IsValid(self.Entity)) then return end
 			local explode = ents.Create("env_explosion")
			explode:SetPos(self:GetPos())
			explode:Spawn()
			explode:SetKeyValue("iMagnitude", "130")
			explode:Fire("Explode", 0, 0)
			self.Entity:EmitSound(meddl, 100, 100, 1)
		end)
	timer.Simple(7.5, function()
			if(!IsValid(self.Entity)) then return end
			self.Entity:Remove()
		end)
	
	timer.Simple(2.5, 
		function()
			for i=0, 20, 1 do
				timer.Simple(math.Rand(0.1,1.0),
					function()
						if(!IsValid(self.Entity)) then return end
						local egg = ents.Create("ent_drachenei")
						egg:SetPos(self:GetPos()+Vector(0,0,5))
						egg:Spawn()

						local phys = egg:GetPhysicsObject()
						local velocity = Vector(0,0,1)
						velocity = velocity * 600
						velocity = velocity + (VectorRand() * 300)
						phys:ApplyForceCenter(velocity)
					end)
			end
		end)
end