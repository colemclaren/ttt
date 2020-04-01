AddCSLuaFile()
DEFINE_BASECLASS("base_anim")
ENT.PrintName = "Easter Basket"
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
		self:SetModel("models/eastereggbasket/eastereggbasket.mdl")
		self:SetMoveType(MOVETYPE_NONE)
	end

	self:ResetSequence("idle")
	self:SetSequence("idle")
	self:DoSpawning()
	self:AddEFlags(EFL_FORCE_CHECK_TRANSMIT)
	if (CLIENT) then
		self:SetRenderBoundsWS(Vector(-100000, -100000, -100000), Vector(100000, 100000, 100000))
	end

	blink:Disable()
end

function ENT:OnRemove()
	blink:Enable()
end

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "ShinesThrough")
end

function ENT:DoSpawning()
	local effect = EffectData()
	effect:SetEntity(self)
	effect:SetMagnitude(1)
	util.Effect("eff_easter_alive", effect)
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

if (CLIENT) then
	local mat = CreateMaterial("Moat.easter.mat", "VertexLitGeneric", {["$basetexture"] = "models/debug/debugwhite", ["$model"] = 1, ["$ignorez"] = 1})

	function ENT:Draw()
		if (LocalPlayer() and LocalPlayer():Team() ~= TEAM_SPEC) then
			if (self:GetShinesThrough()) then
				render.ClearStencil()
				render.SetStencilEnable(true)
				render.SetStencilPassOperation(STENCIL_REPLACE)
				render.SetStencilZFailOperation(STENCIL_KEEP)
				render.SetStencilFailOperation(STENCIL_KEEP)
				render.SetStencilWriteMask(1)
				render.SetStencilTestMask(1)
				render.SetStencilReferenceValue(1)
				render.SetStencilCompareFunction(STENCIL_ALWAYS)
				self:DrawModel()
				render.SetStencilCompareFunction(STENCIL_NOTEQUAL)
				render.SetStencilZFailOperation(STENCIL_KEEP)
				render.SetColorModulation(1,1,0)
				render.SuppressEngineLighting(true)
				render.MaterialOverride(mat)
				self:DrawModel()
				render.MaterialOverride()
				render.SuppressEngineLighting(false)
				render.SetStencilEnable(false)
			else
				self:DrawModel()
			end

			self:DrawShadow(true)
		else
			self:DrawShadow(false)
		end
	end
end

function ENT:Think()
	self:AddEFlags(EFL_FORCE_CHECK_TRANSMIT)
	if SERVER then
		if (not self.Grabbed and not self:GetNoDraw()) then
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 24)) do
				if (v ~= self.IgnoreEntity and v:IsPlayer() and v:Alive() and v:Team() ~= TEAM_SPEC and (not MOAT_BOSS_CUR or (MOAT_BOSS_CUR and v ~= MOAT_BOSS_CUR)) and not self.Grabbed) then
					-- give item

					-- if (EASTER.CanDoBoss() and math.random() < EASTER.BossChance) then
					-- 	EASTER.ReadyBoss(v)
					-- end

					local basket = false
					if (math.random() < EASTER.GoldenChance) then
						v:m_DropInventoryItem "Easter Basket"
						
						basket = true
					else
						v:m_DropInventoryItem "Easter Egg"
					end

					hook.Run("moat_Easter2019_Taken", v)

					net.Start("moat_easter_basket_found")
					net.WriteString(v:Nick())
					net.WriteBool(basket)
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