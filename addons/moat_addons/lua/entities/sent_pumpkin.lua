AddCSLuaFile()
DEFINE_BASECLASS("base_anim")
ENT.PrintName = "Pumpkin"
ENT.Editable = false
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.AutomaticFrameAdvance = true
ENT.Spell = 0

if SERVER then
	util.AddNetworkString("SendPumpkinEffect")
end

function ENT:SpawnFunction(ply, tr, ClassName)
	if (not tr.Hit) then return end
	local SpawnPos = tr.HitPos
	local ent = ents.Create(ClassName)
	ent:SetPos(SpawnPos + tr.HitNormal * 4)
	ent:Spawn()
	ent:Activate()
	ent:SetPersistent()

	return ent
end

ENT.baseHorSize = 0
ENT.vertFontSize = 0

--[[---------------------------------------------------------
Name: Initialize
-----------------------------------------------------------]]
function ENT:Initialize()
	if (SERVER) then
		self:SetModel("models/props/pumpkin_z.mdl")
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetModelScale(1, 0)
		self:SetPos(self:GetPos() + Vector(0, 0, 1))
		self:SetAngles(Angle(0, (CurTime() * 20) % 360, 0))
	end

	self:ResetSequence("idle")
	self:SetSequence("idle")
	self:DoSpawning()
end

function ENT:DoSpawning()
	local effect = EffectData()
	effect:SetEntity(self)
	effect:SetMagnitude(1)
	util.Effect("eff_pumpkin_alive", effect)
end

function ENT:Draw()
	if (LocalPlayer() and LocalPlayer():Team() ~= TEAM_SPEC) then
		self:DrawModel()
		self:DrawShadow(true)
	else
		self:DrawShadow(false)
	end
end

function ENT:Think()
	if SERVER then
		if (not self.Grabbed and not self:GetNoDraw() and not self.NextSearchCheck or (self.NextSearchCheck and self.NextSearchCheck <= CurTime())) then
			local pls = player.GetAll()

			for k, v in pairs(pls) do
				if (IsValid(v) and (v:GetPos():Distance(self:GetPos()) <= 58) and v:Alive() and v:Team() ~= TEAM_SPEC and (not MOAT_BOSS_CUR or (MOAT_BOSS_CUR and v ~= MOAT_BOSS_CUR))) then
					-- give item
					if self.Grabbed then return end
					self.Grabbed = true
					v:m_DropInventoryItem("Pumpkin Crate")
					
					net.Start("moat_halloween_pumpkin_found")
					net.WriteString(v:Nick())
					net.Broadcast()

					self:SetModelScale(0.01, 0.3)
					net.Start("SendPumpkinEffect")
					net.WriteVector(self:GetPos())
					net.SendPVS(self:GetPos())
					local effect = EffectData()
					effect:SetOrigin(self:GetPos())
					effect:SetMagnitude(1)
					util.Effect("eff_pumpkin_grab", effect)
					self:EmitSound("garrysmod/balloon_pop_cute.wav")

					timer.Simple(0.3, function()
						self:Remove()
					end)
				end
			end

			self.NextSearchCheck = CurTime() + 0.3
		end

		self:SetAngles(Angle(0, (CurTime() * 20) % 360, 0))
		self:SetPos(self:GetPos() + Vector(0, 0, math.sin(RealTime() * 2) * 0.1))
		self:NextThink(CurTime())

		return true
	end
end

if (CLIENT) then
	net.Receive("SendPumpkinEffect", function()
		local pos = net.ReadVector()
		local effect = EffectData()
		effect:SetOrigin(pos)
		effect:SetMagnitude(1)
		util.Effect("eff_pumpkin_grab", effect)
	end)
end