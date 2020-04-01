AddCSLuaFile()
DEFINE_BASECLASS("base_anim")
ENT.PrintName = "Eggs"
ENT.Author = "Gonzalolog"
ENT.Information = "Book"
ENT.Category = "Fun + Games"
ENT.Editable = false
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.AutomaticFrameAdvance = true
ENT.Spell = 0

if SERVER then
	util.AddNetworkString("Easter.SendEggEffect")
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
		self:SetModel("models/gonzo/easter/egg.mdl")
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetModelScale(0.5, 0)
		self:SetSkin(math.random(1, 6))

		timer.Simple(0, function()
			self:SetPos(self:GetPos() - Vector(0, 0, 8 + (1 / 2) * 16))
		end)
	end

	self:ResetSequence("idle")
	self:SetSequence("idle")
	self:DoSpawning()
end

function ENT:DoSpawning()
	local effect = EffectData()
	effect:SetEntity(self)
	effect:SetMagnitude(1)
	util.Effect("eff_easter_alive", effect)
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
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 24)) do
				if (v:IsPlayer() and v:Alive() and v:Team() ~= TEAM_SPEC and (not MOAT_BOSS_CUR or (MOAT_BOSS_CUR and v ~= MOAT_BOSS_CUR))) then
					-- give item
					-- v:m_DropInventoryItem("50/50 Crate")
					v:m_DropInventoryItem("Easter Egg")
					
					net.Start("moat_easter_egg_found")
					net.WriteString(v:Nick())
					net.Broadcast()

					self.Grabbed = true
					self:SetModelScale(0.01, 0.3)
					net.Start("Easter.SendEggEffect")
					net.WriteVector(self:GetPos())
					net.SendPVS(self:GetPos())
					local effect = EffectData()
					effect:SetOrigin(self:GetPos())
					effect:SetMagnitude(1)
					util.Effect("eff_easter_grab", effect)
					self:EmitSound("garrysmod/balloon_pop_cute.wav")

					timer.Simple(0.3, function()
						self:Remove()
					end)
				end
			end

			self.NextSearchCheck = CurTime() + 0.4
		end

		self:NextThink(CurTime())

		return true
	end
end

if (CLIENT) then
	net.Receive("SendEggEffect", function()
		local pos = net.ReadVector()
		local effect = EffectData()
		effect:SetOrigin(pos)
		effect:SetMagnitude(1)
		util.Effect("eff_easter_grab", effect)
	end)
end