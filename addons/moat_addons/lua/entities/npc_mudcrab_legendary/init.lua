AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_MUDCRAB","npc_mudcrab_legendary")
util.AddNPCClassAlly(CLASS_MUDCRAB,"npc_mudcrab_legendary")
ENT.sModel = "models/skyrim/mudcrab_legendary.mdl"
ENT.fMeleeDistance	= 34
ENT.CanBurrow = false
ENT.skName = "mudcrab_legendary"
ENT.CollisionBounds = Vector(80,80,70)
ENT.tblIgnoreDamageTypes = {DMG_DISSOLVE}

function ENT:SubInit()
	self.cspBreathe:SetSoundLevel(100)
	self.cspBreathe:ChangePitch(50,0)
	self:SetSoundPitch(50)
	self.m_tbSummons = {}
	self.m_numSummons = 0
	self.m_summonStage = 0
end

function ENT:InitAftermath()
end

local colBoundsCrabMax = Vector(22,22,26)
local colBoundsCrabMin = Vector(-22,-22,0)
local vecOffset = Vector(0,0,100)
function ENT:OnDamaged(healthOld,healthNew,dmgTagen,attacker,inflictor,dmgInfo)
	local hpMax = self:GetMaxHealth()
	local hpScOld = healthOld /hpMax
	local hpScNew = healthNew /hpMax
	if(self.m_summonStage == 0 && hpScOld >= 0.75 && hpScNew < 0.75 || self.m_summonStage == 1 && hpScOld >= 0.5 && hpScNew < 0.5 || self.m_summonStage == 2 && hpScOld >= 0.25 && hpScNew < 0.25) then
		if(self:SpawnGuardCrabs() > 0) then
			self.m_summonStage = self.m_summonStage +1
			if(hpScNew >= 0.25) then self:Burrow() end
		end
	end
end

function ENT:InitSandbox()
	local hp = self:Health() *10
	self:SetHealth(hp)
	self:SetMaxHealth(hp)
end

function ENT:OnGuardCrabDeath(ent)
	if(self.m_numSummons == 0) then
		self:UnBurrow()
	end
end

function ENT:SpawnGuardCrabs()
	local numCrabs = 0
	if(!IsValid(self.entEnemy)) then return numCrabs end
	for i = 1, 3 do
		local posEnemy = self.entEnemy:GetCenter()
		local posSelf = self:GetCenter()
		local dir = (posEnemy -posSelf):GetNormal()
		if(i != 1) then
			local ang = dir:Angle()
			dir = dir +ang:Right() *(i == 2 && 0.5 || -0.5)
		end
		
		local pos = posEnemy +dir *colBoundsCrabMax.x *8
		local tr = util.TraceLine({
			start = posEnemy,
			endpos = pos,
			mask = MASK_NPCSOLID,
			filter = self.entEnemy
		})
		if(tr.Hit) then
			pos = posSelf
			if(i != 1) then pos = pos +self:GetRight() *40 *(i == 2 && 1 || -1) end
		else
			tr = util.TraceHull({
				start = pos +vecOffset,
				endpos = pos,
				mask = MASK_NPCSOLID,
				filter = self.entEnemy,
				mins = colBoundsCrabMin,
				maxs = colBoundsCrabMax
			})
			if(tr.Hit) then
				pos = posSelf
				if(i != 1) then pos = pos +self:GetRight() *40 *(i == 2 && 1 || -1) end
			end
		end
		numCrabs = numCrabs +1
		local ent = ents.Create("npc_mudcrab")
		ent:SetNetworkedString("name","Guard Crab")
		local posSpawn = pos +vecOffset
		local ang = (posEnemy -posSpawn):Angle()
		ang.p = 0
		ang.r = 0
		ent:SetPos(posSpawn)
		ent:SetAngles(ang)
		ent:SetDTBool(3,true)
		self:NoCollide(ent)
		ent:Spawn()
		ent:Activate()
		ent:DropToFloor()
		ent:InitAftermath()
		ent.CanBurrow = false
		local hp = ent:Health() *5
		ent:SetMaxHealth(hp)
		ent:SetHealth(hp)
		ent:SetNoTarget(true)
		ent:SetAttackPlayerOnly(true)
		ent:CallOnDeath(function()
			if(!self:IsValid() || self:IsDead()) then return end
			self.m_numSummons = self.m_numSummons -1
			self:OnGuardCrabDeath(ent)
		end)
		for _, npc in ipairs(self.m_tbSummons) do
			if(npc:IsValid()) then
				ent:NoCollide(npc)
			end
		end
		table.insert(self.m_tbSummons,ent)
		self.m_numSummons = self.m_numSummons +1
	end
	return numCrabs
end