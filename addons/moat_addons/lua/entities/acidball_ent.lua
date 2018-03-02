AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

function ENT:Draw()
	self:DrawModel()	
end

if CLIENT then return end

function ENT:Initialize()
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	
	timer.Create("effedfs"..self:EntIndex(),0.01,0, function()
		if not IsValid(self) then return end
		local ef = EffectData()
		ef:SetOrigin(self:GetPos())
		ef:SetAttachment(1)
		util.Effect("effect_acidb_fly", ef, true, true)	
	end)
	
	self:SetMaterial("acid/acid1")
	self:SetColor(Color(0,255,0,255))
end

function ENT:Think()
	local phys = self:GetPhysicsObject()
	if (IsValid(phys)) then phys:ApplyForceCenter(self.dir) end
	
	if self:WaterLevel() == 3 then
		self:Remove()
	end
end

function ENT:PhysicsCollide(data, physobj)
	timer.Simple(0, function()

	local ef = EffectData()
	ef:SetOrigin(self:GetPos())
	ef:SetAttachment(1)
	util.Effect("effect_acidball_impact", ef, true, true)
	
	self:EmitSound("ambient/water/water_splash"..math.random(1,3)..".wav", 400)

	for k, v in pairs(ents.FindInSphere(data.HitPos, 80)) do
		if (v:IsValid() and v:IsPlayer() and v:Team() ~= TEAM_SPEC) then
			local tesla_reps = self.InventoryModifications[3]
			local tesla_dmg = self.InventoryModifications[1]
			local tesla_delay = self.InventoryModifications[2]

			v:ApplyDOT( "poison", tesla_dmg, self.Owner, tesla_delay, tesla_reps, function(vic, att)
				local screams = {
					"vo/npc/male01/pain07.wav",
      				"vo/npc/male01/pain08.wav",
      				"vo/npc/male01/pain09.wav",
      				"vo/npc/male01/no02.wav"
				}

				vic:EmitSound(screams[math.random(1, #screams)])
			end, function(vic, att)
				vic:SendLua([[chat.AddText(Material("icon16/bug.png"),Color(0,150,0),"You have been infected! Prepare for pain!")]])

				net.Start("moat.dot.init")
				net.WriteString("Infected")
				net.WriteUInt(tesla_delay * tesla_reps, 16)
				net.WriteString("icon16/bug.png")
				net.WriteColor(Color(0, 150, 0))
				net.WriteString(tostring("poison" .. vic:EntIndex() .. att:EntIndex()))
				net.Send(vic)
			end, function(vic, att)
				vic:SendLua([[chat.AddText(Material("icon16/bug.png"),Color(255,255,0),"You feel better now.")]])
			end)

		end
	end
	
	util.Decal("Scorch", self:GetPos() + self:GetPos():GetNormalized(), self:GetPos() - self:GetPos():GetNormalized())
	
	self:Remove()

	end)
end