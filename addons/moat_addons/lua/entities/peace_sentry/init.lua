local sentryWeight = 100
local timeToSelfDestruct = 0

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

local rangecvar = CreateConVar("peace_range", "750", {FCVAR_ARCHIVE})
local hpcvar = CreateConVar("peace_hp", "100", {FCVAR_ARCHIVE})
local rofcvar = CreateConVar("peace_rate_of_fire", "0.1", {FCVAR_ARCHIVE})
local dmgcvar = CreateConVar("peace_damage", "10", {FCVAR_ARCHIVE})
local shotcvar = CreateConVar("peace_shots_total", "100", {FCVAR_ARCHIVE})
local spreadcvar = CreateConVar("peace_spread", "0", {FCVAR_ARCHIVE})
local spawn = CreateConVar("peace_spawnfrozen", "1", {FCVAR_ARCHIVE})
local innocent = CreateConVar("peace_shootinnocents", "1", {FCVAR_ARCHIVE})


local sentryRange = rangecvar:GetInt()
function ENT:Initialize()
	self:SetModel("models/Combine_turrets/Floor_turret.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:GetPhysicsObject():Wake()
	if spawn:GetInt() == 1 then
		self:GetPhysicsObject():EnableMotion(false)
	end
	self:GetPhysicsObject():SetMass(sentryWeight)
	self:SetColor(Color(101, 101, 255, 255))
	self.TurretOwner = self.TurretOwner or NULL
	self.Targets = {}
	
	self.SpawnTime = CurTime()
	
	self.NextShot = 0
	self.HealthPoints = hpcvar:GetInt()
	self.TotalShots = 0

	PEACE_SENTRIES = PEACE_SENTRIES and (PEACE_SENTRIES + 1) or 1
end

function ENT:OnTakeDamage(dmg)
	local dmg = dmg:GetDamage()
	if self.HealthPoints-dmg <= 0 then
		local effectdata = EffectData()
		effectdata:SetStart(self:GetPos())
		effectdata:SetOrigin(effectdata:GetStart())
		util.Effect("HelicopterMegaBomb", effectdata)
		sound.Play("weapons/explode3.wav", self:GetPos(), 85, 115)
		self:Remove()
		return
	end
	self.HealthPoints = self.HealthPoints-dmg
end

hook("EntityTakeDamage", function(pl, dmg)
	if (not PEACE_SENTRIES or PEACE_SENTRIES < 1) then return end
	if (not IsValid(pl) or not pl:IsPlayer()) then return end
	local attacker = dmg:GetAttacker()
	if (attacker:Role() ~= ROLE_DETECTIVE) then
		local bone = attacker:LookupBone "ValveBiped.Bip01_Spine2"
		if !bone then return end
		local bonePos, boneAng = attacker:GetBonePosition(bone)
		local tbl = ents.FindByClass "peace_sentry"
		for i=1, #tbl do
			if (table.HasValue(tbl[i].Targets, attacker)) then continue end
			if attacker != tbl[i].TurretOwner and bonePos:Distance(tbl[i]:GetPos()) < sentryRange and attacker:Visible(tbl[i]) then
				local VNormDot = ((bonePos - tbl[i]:GetPos()):GetNormalized()):Dot(tbl[i]:GetForward())
				if VNormDot > 0.775 then
					table.insert(tbl[i].Targets, attacker)
				end
			end
		end
	end
end)

function ENT:Think()
	if timeToSelfDestruct != 0 and self.SpawnTime + timeToSelfDestruct < CurTime() then
		self:GoBoom()
		self:Remove()
		return
	end

	local tbl, pos = self.Targets, self:GetPos()
	for i=1, #tbl do
		if (IsValid(tbl[i]) and tbl[i]:Alive() and tbl[i]:GetPos():Distance(pos) < sentryRange and tbl[i]:Visible(self)) then
			local target = tbl[i]
			local bone = target:LookupBone("ValveBiped.Bip01_Spine2")
			if !bone then return end
			local bonePos, boneAng = target:GetBonePosition(bone)
			local selfPos, selfAng = self:GetBonePosition(3)
			
			local off = bonePos - (pos)
			local sAng = self:GetAngles()
			local sFw = sAng:Forward()
			local sRt = sAng:Right()
			local sUp = sAng:Up()

			local rOff = off:Dot(sRt)
			local fOff = off:Dot(sFw)
			local yaw = -(math.atan2(rOff,fOff) * 180 / math.pi)
			
			if yaw < -45 or yaw > 45 then return end
			local uOff = off:Dot(sUp)
			
			self:SetPoseParameter("aim_yaw", yaw)
			self:SetPoseParameter("aim_pitch", (math.atan2(uOff,(off - uOff * sUp):Length()) * 180 / math.pi))
			selfPos, selfAng = self:GetBonePosition(3)
			local shootPos = selfPos+selfAng:Up()*3+selfAng:Right()*-1.5+selfAng:Forward()*1.5

			if self.NextShot > CurTime() then return end
			self.NextShot = CurTime()+rofcvar:GetFloat()
			local bullets = {}
			bullets.Attacker = self
			bullets.Damage = dmgcvar:GetInt()
			bullets.Force = bullets.Damage
			bullets.Num = 1
			bullets.Tracer = 1
			bullets.Spread = Vector(spreadcvar:GetFloat(), spreadcvar:GetFloat(), 0)
			bullets.Src = shootPos
			local dirAng = (bonePos-shootPos)
			dirAng:Normalize()
			bullets.Dir = dirAng
			self:FireBullets(bullets)
			sound.Play("weapons/ar1/ar1_dist"..math.random(1,2)..".wav", self:GetPos(), 80)
			self.TotalShots = self.TotalShots+1
			if shotcvar:GetInt() != 0 and self.TotalShots == shotcvar:GetInt() then
				self:GoBoom()
				self:Remove()
			end

		end
	end
	
	self:NextThink(CurTime() + .1)
	return true
end

function ENT:GoBoom()
	local effectdata = EffectData()
	effectdata:SetStart(self:GetPos())
	effectdata:SetOrigin(effectdata:GetStart())
	util.Effect("HelicopterMegaBomb", effectdata)
	sound.Play("weapons/explode3.wav", self:GetPos(), 85, 115)
end

function ENT:OnRemove()
	PEACE_SENTRIES = PEACE_SENTRIES and math.min(PEACE_SENTRIES - 1, 0) or 0
end
