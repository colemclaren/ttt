AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_SPIDER","npc_frostbitespider_small")
ENT.iClass = CLASS_SPIDER_FROSTBITE
util.AddNPCClassAlly(CLASS_SPIDER_FROSTBITE,"npc_frostbitespider_small")
ENT.sModel = "models/skyrim/frostbitespider_small.mdl"
ENT.CollisionBounds = Vector(4,4,4)
ENT.fMeleeDistanceJump = 180
ENT.fMeleeDistance = 20
ENT.CanSpit = false
ENT.skName = "frostbitespider_small"

function ENT:OnInit()
	self.BaseClass.OnInit(self)
	self:SetSoundVolume(58)
	self:NoCollide(self:GetClass())
	self.m_tmDeath = CurTime() +math.Rand(28,42)
end

function ENT:AttackJump()
	if(self.m_bInJump) then return end
	local entTgt = self.entEnemy
	if(!IsValid(entTgt)) then return end
	self.m_bInJump = true
	local posSelf = self:GetPos()
	local posEnemy = entTgt:GetPos()
	posEnemy.z = posEnemy.z +math.Rand(40,math.max(50,entTgt:OBBMaxs().z -10)) +20
	local dir = (posEnemy -posSelf):GetNormal()
	self:SetGroundEntity(NULL)
	self:SetPos(self:GetPos() +Vector(0,0,18))
	self:SetVelocity(dir *500)
end

function ENT:AttachToTarget(ent)
	local pos = self:GetCenter()
	local posTgt = ent:NearestPoint(pos)
	local tr
	if(tracex) then
		tr = tracex.TraceLine({
			start = pos,
			endpos = posTgt,
			filter = self
		},function(entTgt) return entTgt == ent end,true)
	else
		tr = util.TraceLine({
			start = pos,
			endpos = posTgt,
			filter = self
		})
	end
	self:SetPos(tr.HitPos +(posTgt -pos):GetNormal() *20)
	
	local i = 0
	local bonepos, boneang = ent:GetBonePosition(i)
	local boneClosest
	local distClosest = math.huge
	while(bonepos) do
		local dist = tr.HitPos:Distance(bonepos)
		if(dist < distClosest) then
			distClosest = dist
			boneClosest = i
		end
		i = i +1
		bonepos, boneang = ent:GetBonePosition(i)
	end
	local bonepos,boneang = ent:GetBonePosition(boneClosest)
	if(bonepos) then
		local ang = (bonepos -self:GetPos()):Angle()
		self:SetAngles(Angle(90,ang.y,math.Rand(0,360)))
	end
	self:FollowBone(ent,boneClosest)
	self.m_entAttacking = ent
	self:SetMoveType(MOVETYPE_NONE)
	self:SetNotSolid(true)
	self.m_bInJump = false
end

function ENT:ClearAttachment()
	self.m_entAttacking = nil
	self:FollowBone()
	self:SetNotSolid(false)
	self:SetAngles(Angle(0,self:GetAngles().y,0))
	self:SetParent()
	self:SetMoveType(MOVETYPE_STEP)
end

function ENT:OnThink()
	if(CurTime() >= self.m_tmDeath) then
		self:TakeDamage(self:Health())
	end
	self:UpdateLastEnemyPositions()
	if(self.m_bInJump) then
		local entGround = self:GetGroundEntity()
		local pos = self:GetCenter()
		if(entGround:IsValid() || entGround:IsWorld()) then self.m_bInJump = false
		elseif(IsValid(self.entEnemy) && self.entEnemy:NearestPoint(pos):Distance(pos) <= 6) then self:AttachToTarget(self.entEnemy) end
		self:NextThink(CurTime())
		return true
	elseif(self.m_entAttacking && (!self.m_entAttacking:IsValid() || !self.m_entAttacking:Alive())) then self:ClearAttachment() end
end

function ENT:PlayIdleSound()
	self.cspIdleLoop = CreateSound(self,self.sSoundDir .. "spiderfrostbite_breathe_lp.wav")
	self:StopSoundOnDeath(self.cspIdleLoop)
	self.cspIdleLoop:SetSoundLevel(40)
	self.cspIdleLoop:Play()
end

function ENT:OnDeath(dmginfo)
end

function ENT:EventHandle(...)
	local event = select(1,...)
	if(event == "mattack") then
		if(!self.m_entAttacking || !IsValid(self.m_entAttacking)) then return true end
		local ent = self.m_entAttacking
		local posDmg = ent:NearestPoint(self:GetCenter())
		local dmgInfo = DamageInfo()
		dmgInfo:SetDamage(GetConVarNumber("sk_" .. self.skName .. "_dmg_slash"))
		dmgInfo:SetAttacker(self)
		dmgInfo:SetInflictor(self)
		dmgInfo:SetDamageType(DMG_SLASH)
		dmgInfo:SetDamagePosition(posDmg)
		ent:TakeDamageInfo(dmgInfo)
		if(ent:IsPlayer()) then
			ent:ViewPunch(Angle(5,0,0))
			util.ParticleEffect("blood_impact_red_01",posDmg,Angle(0,0,0),ent)
		end
		if(self.m_bAttackFreeze) then ent:SetFrozen(8) end
		return true
	end
	return self.BaseClass.EventHandle(self,...)
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)
	if(self.m_entAttacking) then
		self:PlayActivity(ACT_MELEE_ATTACK1,true)
		return
	end
	if(disp == D_HT) then
		if(dist <= self.fMeleeDistanceJump && self:CanSee(self.entEnemy)) then
			self:PlaySound("Attack")
			self:AttackJump()
			return
		end
		self:ChaseEnemy()
	elseif(disp == D_FR) then
		self:Hide()
	end
end