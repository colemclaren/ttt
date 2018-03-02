local cvarThawTime = CreateConVar("sv_freeze_thawtime",6,FCVAR_ARCHIVE)
local cvarThawDelay = CreateConVar("sv_freeze_thawdelay",1,FCVAR_ARCHIVE)

require("ai_schedule_slv")
local ai_schedule_slvNew = ai_schedule_slv.New
function ai_schedule_slv.New(...)
	local name = ...
	local schd = ai_schedule_slvNew(...)
	schd.Name = name
	return schd
end

local meta = FindMetaTable("Weapon")
local tblPlayerSpeed = {}
meta = FindMetaTable("Player")
if(!meta.KnockedDown) then function meta:KnockedDown() return false end end

local SetWalkSpeed = meta.SetWalkSpeed
local SetRunSpeed = meta.SetRunSpeed
function meta:SetWalkSpeed(...)
	local flSpeed = ...
	tblPlayerSpeed[self] = tblPlayerSpeed[self] || {}
	tblPlayerSpeed[self].walk = flSpeed
	return SetWalkSpeed(self, ...)
end

function meta:SetRunSpeed(...)
	local flSpeed = ...
	tblPlayerSpeed[self] = tblPlayerSpeed[self] || {}
	tblPlayerSpeed[self].run = flSpeed
	return SetRunSpeed(self, ...)
end

function meta:GetWalkSpeed()
	return tblPlayerSpeed[self] && tblPlayerSpeed[self].walk || 250
end

function meta:GetRunSpeed()
	return tblPlayerSpeed[self] && tblPlayerSpeed[self].run || 500
end

function meta:FadeScreen(col, durFade, durHold)
	col = col || Color(0,0,0,255)
	durFade = durFade || 2
	durHold = durHold || 0
	umsg.Start("HLR_FadeScreen", self)
		umsg.String(col.r .. "," .. col.g .. "," .. col.b .. "," .. col.a)
		umsg.Float(durFade)
		umsg.Float(durHold)
	umsg.End()
end

local SetDuckSpeed = meta.SetDuckSpeed
local SetUnDuckSpeed = meta.SetUnDuckSpeed
function meta:SetDuckSpeed(...)
	local flSpeed = ...
	tblPlayerSpeed[self] = tblPlayerSpeed[self] || {}
	tblPlayerSpeed[self].duckSpeed = flSpeed
	SetDuckSpeed(self, ...)
end

function meta:SetUnDuckSpeed(...)
	local flSpeed = ...
	tblPlayerSpeed[self] = tblPlayerSpeed[self] || {}
	tblPlayerSpeed[self].unDuckSpeed = flSpeed
	SetUnDuckSpeed(self, ...)
end

function meta:GetDuckSpeed()
	return tblPlayerSpeed[self] && tblPlayerSpeed[self].duckSpeed || 0.315
end

function meta:GetUnDuckSpeed()
	return tblPlayerSpeed[self] && tblPlayerSpeed[self].unDuckSpeed || 0.21
end

hook.Add("PlayerStepSoundTime", "PlayerStepSoundTime_Frozen", function(pl, iType, bWalking)
	if pl:IsFrozen() then
		local iPercentFrozen = pl:PercentageFrozen()
		local fStepTime = 350
		local fMaxSpeed = pl:GetMaxSpeed()
		if iType == STEPSOUNDTIME_NORMAL || iType == STEPSOUNDTIME_WATER_FOOT then
			if fMaxSpeed <= 100 then 
				fStepTime = 400
			elseif fMaxSpeed <= 300 then 
				fStepTime = 350
			else 
				fStepTime = 250 
			end
		elseif iType == STEPSOUNDTIME_ON_LADDER then
			fStepTime = 450 
		elseif iType == STEPSOUNDTIME_WATER_KNEE then
			fStepTime = 600 
		end
		if pl:Crouching() then
			fStepTime = fStepTime + 50
		end
		return fStepTime *math.Clamp(iPercentFrozen /50, 1, 2)
	end
end)

function meta:SetPermanentlyFrozen(bPerm)
	if bPerm then
		self:SetFrozen(100)
		self.tblFrozen.permanent = true
		return
	end
	if !self.tblFrozen then return end
	self.tblFrozen.permanent = nil
end

hook.Add("Move","MovePlFrozen",function(pl,move)
	if(pl:IsFrozen()) then
		local flScale = 1 -(pl:PercentageFrozen() /100);
		move:SetForwardSpeed(move:GetForwardSpeed() *flScale);
		move:SetSideSpeed(move:GetSideSpeed() *flScale);
		move:SetUpSpeed(move:GetUpSpeed() *flScale);
	end
end)
// TODO: Redo this whole system. It's a mess
util.AddNetworkString("slv_freeze_start")
util.AddNetworkString("slv_freeze_end")
function meta:SetFrozen(iPercent)
	if(self:IsPossessing()) then return end
	iPercent = iPercent || 100
	iPercent = gamemode.Call("ScalePlayerFreeze",self,iPercent) || iPercent
	if(iPercent > 0 && self:IsOnFire()) then self:Extinguish() end
	local r,g,b,a = self:GetColor()
	local bNew = !self.tblFrozen
	if(bNew) then
		self.tblFrozen = {}
		self.tblFrozen.jumpPower = self:GetJumpPower()
		self.tblFrozen.duckSpeed = self:GetDuckSpeed()
		self.tblFrozen.unDuckSpeed = self:GetUnDuckSpeed()
		self.tblFrozen.iPercent = 0
		self.tblFrozen.nextUnfreeze = CurTime()
		self.tblFrozen.tmFreeze = CurTime();
		self.bFrozen = true
		local ang
		local entIndex = self:EntIndex()
		hook.Add("Think", "ThinkEntFrozen" .. entIndex, function()
			if(!self:IsValid()) then hook.Remove("Think", "ThinkEntFrozen" .. entIndex)
			elseif(self:Health() <= 0) then self:UnFreeze()
			else
				local vm = self:GetViewModel()
				if(vm:IsValid()) then
					vm:SetPlaybackRate((100 -self.tblFrozen.iPercent) /100)
				end
				local wep = self:GetActiveWeapon()
				if(wep:IsValid()) then
					if(self.tblFrozen.iPercent == 100) then
						wep:SetNextPrimaryFire(CurTime() +0.2)
						wep:SetNextSecondaryFire(CurTime() +0.2)
					else
						local nextPrimary = wep:GetNextPrimaryFire()
						if(!wep.nextPrimaryFire || nextPrimary != wep.nextPrimaryFire) then
							local delayMin = nextPrimary -CurTime()
							local delayMax = delayMin *10
							wep.nextDefaultPrimaryFire = nextPrimary -CurTime()
							wep.primaryEnd = nextPrimary +CurTime()
							wep.nextPrimaryFire = ((delayMin /100) *(100 -self.tblFrozen.iPercent) +(delayMax /100) *self.tblFrozen.iPercent) +CurTime()
							wep:SetNextPrimaryFire(wep.nextPrimaryFire)
							wep.nextPrimaryFire = wep:GetNextPrimaryFire()
						end
						local nextSecondary = wep:GetNextSecondaryFire()
						if(!wep.nextSecondaryFire || nextSecondary != wep.nextSecondaryFire) then
							local delayMin = nextSecondary -CurTime()
							local delayMax = delayMin *10
							wep.nextDefaultSecondaryFire = nextSecondary -CurTime()
							wep.secondaryEnd = nextSecondary +CurTime()
							wep.nextSecondaryFire = ((delayMin /100) *(100 -self.tblFrozen.iPercent) +(delayMax /100) *self.tblFrozen.iPercent) +CurTime()
							wep:SetNextSecondaryFire(wep.nextSecondaryFire)
							wep.nextSecondaryFire = wep:GetNextSecondaryFire()
						end
					end
				end
				if(self.tblFrozen.iPercent >= 80) then
					ang = ang || self:GetAngles()
					self:SetAngles(ang)
				end
				if(!self.tblFrozen.permanent && CurTime() >= self.tblFrozen.tmFreeze +cvarThawDelay:GetFloat() && CurTime() >= self.tblFrozen.nextUnfreeze +(cvarThawTime:GetFloat() *0.01)) then
					self.tblFrozen.nextUnfreeze = CurTime()
					self:UnFreeze(1)
				end
			end
		end)
	else self.tblFrozen.tmFreeze = CurTime(); if(self.tblFrozen.iPercent >= 100) then return; end end
	if(self.tblFrozen.iPercent == 0) then
		net.Start("slv_freeze_start")
			net.WriteEntity(self)
			net.WriteUInt(iPercent,8)
		net.Broadcast()
	end
	if self.tblFrozen.iPercent +iPercent >= 100 then iPercent = 100 -self.tblFrozen.iPercent end
	self.tblFrozen.iPercent = self.tblFrozen.iPercent +iPercent
	
	local flScale = 100 -self.tblFrozen.iPercent
	self:SetJumpPower((self.tblFrozen.jumpPower /100) *flScale)
	
	local flDuckScale = math.Clamp(self.tblFrozen.iPercent /10, 1, 10)
	self:SetDuckSpeed(self.tblFrozen.duckSpeed *flDuckScale)
	self:SetUnDuckSpeed(self.tblFrozen.unDuckSpeed *flDuckScale)
	self:SetNetworkedFloat("FreezePercent", self.tblFrozen.iPercent)
	if(bNew) then
		net.Start("slv_freeze_start")
			net.WriteEntity(self)
			net.WriteUInt(self.tblFrozen.iPercent,8)
		net.Broadcast()
	end
end

function meta:PercentageFrozen()
	return self.bFrozen && self.tblFrozen.iPercent || 0
end

local function BreakIceGibs(ent)
	local tblIceShards = {}
	local i = 0
	local bonepos, boneang = ent:GetBonePosition(i)
	while bonepos do
		local flDistMin = 999
		for k, v in pairs(tblIceShards) do
			if i != k then
				local flDist = bonepos:Distance(ent:GetBonePosition(k))
				if flDist < flDistMin then flDistMin = flDist end
			end
		end
		if flDistMin > 4 then
			local ent = ents.Create("obj_gib")
			ent:SetModel("models/gibs/ice_shard0" .. math.random(1,6) .. ".mdl")
			ent:SetPos(bonepos)
			ent:SetAngles(boneang)
			ent:Spawn()
			ent:Activate()
			tblIceShards[i] = ent
		end
		i = i +1
		bonepos, boneang = ent:GetBonePosition(i)
	end
	ent:EmitSound("physics/glass/glass_largesheet_break" .. math.random(1,3) .. ".wav", 75, 100)
	if ent:IsPlayer() then
		local pos = ent:GetPos()
		ent:Spawn()
		ent:SetPos(pos)
		ent:KillSilent()
	else ent:Remove() end
end

hook.Add("OnNPCKilled", "HLR_BreakFrozen_NPC", function(npc, entKiller, entWeapon)
	if npc:PercentageFrozen() >= 80 then
		BreakIceGibs(npc)
	end
end)

hook.Add("PlayerDeath", "HLR_BreakFrozen_Player", function(entVictim, entInflictor, entKiller)
	if entVictim:PercentageFrozen() >= 80 then
		BreakIceGibs(entVictim)
	end
end)

function meta:UnFreeze(iPercent)
	iPercent = iPercent || 100
	if !self.bFrozen then return end
	if self.tblFrozen.iPercent -iPercent < 0 then iPercent = self.tblFrozen.iPercent end
	self.tblFrozen.iPercent = self.tblFrozen.iPercent -iPercent
	self:SetNetworkedFloat("FreezePercent", self.tblFrozen.iPercent)
	local iScale = 255 -((self.tblFrozen.iPercent /100) *155)
	
	local flScale = 100 -self.tblFrozen.iPercent
	self:SetJumpPower((self.tblFrozen.jumpPower /100) *flScale)
	
	local flDuckScale = math.Clamp(self.tblFrozen.iPercent /10, 1, 10)
	self:SetDuckSpeed(self.tblFrozen.duckSpeed *flDuckScale)
	self:SetUnDuckSpeed(self.tblFrozen.unDuckSpeed *flDuckScale)
	
	if self.tblFrozen.iPercent > 0 then return end
	hook.Remove("Think", "ThinkEntFrozen" .. self:EntIndex())
	net.Start("slv_freeze_end")
		net.WriteEntity(self)
	net.Broadcast()
	self:SetJumpPower(self.tblFrozen.jumpPower)
	self:SetDuckSpeed(self.tblFrozen.duckSpeed)
	self:SetUnDuckSpeed(self.tblFrozen.unDuckSpeed)
	self:SetPlaybackRate(1)
	self.bFrozen = false
	self.tblFrozen = nil
end

function meta:IsFrozen()
	return self.bFrozen
end

meta = FindMetaTable("NPC")
function meta:HasCapability(cap) return bit.band(self:CapabilitiesGet(),cap) == cap end

function meta:CapabilitiesGet() -- Default function is broken, so we're doing a workaround; Only works for SNPCs
	return self.m_iCapabilities || 0
end

local CapabilitiesAdd = meta.CapabilitiesAdd
function meta:CapabilitiesAdd(...)
	local cap,bSkipEngine = ...
	self.m_iCapabilities = bit.bor(self.m_iCapabilities || 0,cap)
	if(bSkipEngine) then return end
	return CapabilitiesAdd(self,...)
end

local CapabilitiesClear = meta.CapabilitiesClear
function meta:CapabilitiesClear(...)
	self.m_iCapabilities = 0
	return CapabilitiesClear(self,...)
end

local CapabilitiesRemove = meta.CapabilitiesRemove
function meta:CapabilitiesRemove(...)
	local cap = ...
	self.m_iCapabilities = self.m_iCapabilities -bit.band(self.m_iCapabilities,cap)
	return CapabilitiesRemove(self,...)
end

function meta:Alive() return self:Health() > 0 end

local Classify = meta.Classify
function meta:Classify(...)
	return self.bScripted && self:GetNPCClass() || Classify(self,...)
end

local tblEntRelationshipExcept = {}
hook.Add("Think", "HLR_CheckNPCRelationships_Except", function()
	for src, rel in pairs(tblEntRelationshipExcept) do
		if !IsValid(src) then tblEntRelationshipExcept[src] = nil
		elseif src:GetNPCState() != NPC_STATE_COMBAT && CurTime() >= src.schdWait then
			local iMemory = #src.tblMemory
			local tblEnemies = src:UpdateEnemies()
			local _iMemory = #src.tblMemory
			//if iMemory == 0 && _iMemory > 0 then src:OnFoundEnemy(_iMemory)
			//elseif iMemory > 0 && _iMemory == 0 then src:OnAreaCleared() end
		end
	end
end)
local tblNoTargetNPCs = {}
local AddEntityRelationship = meta.AddEntityRelationship
function meta:AddEntityRelationship(...)
	local ent, disp, priority = ...
	local dispLast = self:Disposition(ent)
	if !ent.bScripted && ent:GetNoTarget() && !ent:IsPlayer() then
		tblNoTargetNPCs[ent][self] = disp
		gamemode.Call("OnRelationshipChanged",self,ent,self:Disposition(ent),dispLast)
		return
	end
	if self.bScripted && ent.bScripted && self:GetModel() == ent:GetModel() then
		tblEntRelationshipExcept[self] = tblEntRelationshipExcept[self] || {}
		tblEntRelationshipExcept[self][ent] = disp
		gamemode.Call("OnRelationshipChanged",self,ent,self:Disposition(ent),dispLast)
		return
	end
	local ret = AddEntityRelationship(self, ...)
	gamemode.Call("OnRelationshipChanged",self,ent,self:Disposition(ent),dispLast)
	return ret
end

function meta:SetNoTarget(bNoTarget)
	if bNoTarget then
		if !table.HasValue(tblNoTargetNPCs, self) then
			tblNoTargetNPCs[self] = {}
			for k, ent in pairs(ents.GetNPCs()) do
				if !ent.bScripted && ent != self then
					tblNoTargetNPCs[self][ent] = ent:Disposition(self)
					AddEntityRelationship(ent, self, D_NU, 100)
				end
			end
		end
		return
	end
	if !tblNoTargetNPCs[self] then return end
	for ent, disp in pairs(tblNoTargetNPCs[self]) do
		if IsValid(ent) then
			AddEntityRelationship(ent, self, disp, 100)
		end
	end
	tblNoTargetNPCs[self] = nil
	for ent, rel in pairs(tblNoTargetNPCs) do
		if !IsValid(ent) then tblNoTargetNPCs[ent] = nil end
	end
end

hook.Add("OnEntityCreated", "HLR_EntCreated_ApplyNoTarget", function(ent)
	if IsValid(ent) && ent:IsNPC() && !ent.bScripted then
		for _ent, rel in pairs(tblNoTargetNPCs) do
			if IsValid(_ent) then
				tblNoTargetNPCs[_ent][ent] = ent:Disposition(_ent)
				AddEntityRelationship(ent, _ent, D_NU, 100)
			else tblNoTargetNPCs[_ent] = nil end
		end
	end
end)

function meta:GetNoTarget()
	return tblNoTargetNPCs[self] && true || false
end

function meta:GetAlliedNPCClasses()
	local tblNPCClasses = util.GetNPCClassAllies()
	if self.GetNPCClass then
		local npcClass = self:GetNPCClass()
		if tblNPCClasses[npcClass] then return tblNPCClasses[npcClass] end
	end
	local class = self:GetClass()
	for k, v in pairs(tblNPCClasses) do
		if table.HasValue(v, class) then
			return v
		end
	end
	return {}
end

function meta:IsMonster()
	local npcClass
	if self.GetNPCClass then npcClass = self:GetNPCClass()
	else
		local class = self:GetClass()
		for k, v in pairs(util.GetNPCClassAllies()) do
			if table.HasValue(v, class) then
				npcClass = k
				break
			end
		end
	end
	return npcClass == CLASS_XENIAN || npcClass == CLASS_RACEX || npcClass == CLASS_TREMOR || npcClass == CLASS_NONE || npcClass == VORTIGAUNT || npcClass == CLASS_ZOMBIE || npcClass == CLASS_HEADCRAB || npcClass == CLASS_STALKER || npcClass == CLASS_ANTLION || npcClass == CLASS_BARNACLE
end

function meta:CanSee(ent,yawMax,ang)
	if (ent:IsScriptedNPC() || ent:IsPlayer()) && ent:KnockedDown() then ent = ent:GetRagdollEntity() end
	local ang = self:GetAngleToPos(ent:GetPos(),ang)
	local yawMax = self.fViewAngle || yawMax || 90
	if(ang.y <= yawMax || ang.y >= 360 -yawMax) && self:Visible(ent) then return true end
	return false
end

function meta:IsMoving()
	local iAct = self:GetActivity()
	return iAct == ACT_WALK || iAct == ACT_RUN || iAct == ACT_WALK_HURT || iAct == ACT_RUN_HURT || iAct == ACT_WALK_AIM || iAct == ACT_RUN_AIM || iAct == ACT_WALK_SCARED || iAct == ACT_RUN_SCARED || iAct == ACT_WALK_RELAXED || iAct == ACT_WALK_STIMULATED || iAct == ACT_WALK_AGITATED || iAct == ACT_RUN_RELAXED || iAct == ACT_RUN_STIMULATED || iAct == ACT_RUN_AGITATED || iAct == ACT_WALK_AIM_RELAXED || iAct == ACT_WALK_AIM_STIMULATED || iAct == ACT_WALK_AGITATED || iAct == ACT_RUN_RELAXED || iAct == ACT_RUN_STIMULATED || iAct == ACT_RUN_AGITATED
end

function meta:IsWalking()
	local iAct = self:GetActivity()
	return iAct == ACT_WALK || iAct == ACT_WALK_HURT || iAct == ACT_WALK_AIM || iAct == ACT_WALK_SCARED || iAct == ACT_WALK_RELAXED || iAct == ACT_WALK_STIMULATED || iAct == ACT_WALK_AGITATED || iAct == ACT_WALK_AIM_RELAXED || iAct == ACT_WALK_AIM_STIMULATED || iAct == ACT_WALK_AGITATED
end

function meta:IsRunning()
	local iAct = self:GetActivity()
	return iAct == ACT_RUN || iAct == ACT_RUN_HURT || iAct == ACT_RUN_AIM || iAct == ACT_RUN_SCARED || iAct == ACT_RUN_RELAXED || iAct == ACT_RUN_STIMULATED || iAct == ACT_RUN_AGITATED || iAct == ACT_RUN_RELAXED || iAct == ACT_RUN_STIMULATED || iAct == ACT_RUN_AGITATED
end

function meta:PercentageFrozen()
	return self.bFrozen && self.tblFrozen.iPercent || 0
end

function meta:SetPermanentlyFrozen(bPerm)
	if self:IsBoss() then return end
	if bPerm then
		self:SetFrozen(100)
		self.tblFrozen.permanent = true
		return
	end
	if !self.tblFrozen then return end
	self.tblFrozen.permanent = nil
end

function meta:SetFrozen(iPercent)
	if self.bScripted && !self.bFreezable then return end
	iPercent = iPercent || 100
	iPercent = gamemode.Call("ScaleNPCFreeze",self,iPercent) || iPercent
	if iPercent > 0 && self:IsOnFire() then self:Extinguish() end
	local r,g,b,a = self:GetColor()
	local bNew = !self.tblFrozen
	if(bNew) then
		self.tblFrozen = {}
		self.tblFrozen.actMove = self:GetMovementActivity()
		self.tblFrozen.iPercent = 0
		self.tblFrozen.nextUnfreeze = CurTime()
		self.tblFrozen.tmFreeze = CurTime();
		if self.bScripted then
			self.tblFrozen.iYawSpeed = self:GetMaxYawSpeed()
		end
		self.bFrozen = true
		
		local ang
		local entIndex = self:EntIndex()
		hook.Add("Think", "ThinkEntFrozen" .. entIndex, function()
			if !IsValid(self) then hook.Remove("Think", "ThinkEntFrozen" .. entIndex); return end
			if self:Health() <= 0 then
				self:UnFreeze()
				return
			end
			self:SetPlaybackRate((100 -self.tblFrozen.iPercent) /100)
			//self:SetLocalVelocity(Vector(0,0,0))
			if self.tblFrozen.iPercent >= 80 then if !ang then ang = self:GetAngles() end; self:SetAngles(ang) elseif ang then ang = nil end
			if !self.tblFrozen.permanent && CurTime() >= self.tblFrozen.tmFreeze +cvarThawDelay:GetFloat() && CurTime() >= self.tblFrozen.nextUnfreeze +(cvarThawTime:GetFloat() *0.01) then
				self.tblFrozen.nextUnfreeze = CurTime()
				self:UnFreeze(1)
			end
		end)
	else self.tblFrozen.tmFreeze = CurTime(); if(self.tblFrozen.iPercent >= 100) then return; end end
	if self.tblFrozen.iPercent +iPercent > 100 then iPercent = 100 -self.tblFrozen.iPercent end
	if self.tblFrozen.iPercent < 80 && self.tblFrozen.iPercent +iPercent >= 80 then self:SetMovementActivity(ACT_IDLE) end
	
	self.tblFrozen.iPercent = self.tblFrozen.iPercent +iPercent
	self:SetNetworkedFloat("FreezePercent", self.tblFrozen.iPercent)
	if(bNew) then
		net.Start("slv_freeze_start")
			net.WriteEntity(self)
			net.WriteUInt(iPercent,8)
		net.Broadcast()
	end
	local iScale = 255 -((self.tblFrozen.iPercent /100) *155)
	if self:IsScriptedNPC() then
		local iMax = self.tblFrozen.iYawSpeed
		self:SetMaxYawSpeed((100 -(self.tblFrozen.iPercent /100)) *iMax)
		if(self.tblFrozen.iPercent == 100) then self:Paralyze(cvarThawDelay:GetFloat()) end
	end
end

function meta:UnFreeze(iPercent)
	iPercent = iPercent || 100
	if !self.bFrozen then return end
	if self.tblFrozen.iPercent -iPercent < 0 then iPercent = -self.tblFrozen.iPercent end
	self.tblFrozen.iPercent = self.tblFrozen.iPercent -iPercent
	self:SetNetworkedFloat("FreezePercent", self.tblFrozen.iPercent)
	local iScale = 255 -((self.tblFrozen.iPercent /100) *155)
	if self.bScripted then
		local iMax = self.tblFrozen.iYawSpeed
		self:SetMaxYawSpeed((100 -(self.tblFrozen.iPercent /100)) *iMax)
	end
	if self.tblFrozen.iPercent > 0 then return end
	hook.Remove("Think", "ThinkEntFrozen" .. self:EntIndex())
	net.Start("slv_freeze_end")
		net.WriteEntity(self)
	net.Broadcast()
	self:SetMovementActivity(self.tblFrozen.actMove)
	self:SetPlaybackRate(1)
	self.bFrozen = false
	self.tblFrozen = nil
end

function meta:IsFrozen()
	return self.bFrozen
end

function meta:IsPossessed()
	return self.bPossessed
end

function meta:GetPossessor()
	return self.entPossessor
end

meta = FindMetaTable("Entity")
local SetSpawnEffect = meta.SetSpawnEffect
function meta:SetSpawnEffect(...)
	local b = ...
	if(b && self.DisablePropCreateEffect) then return end
	return SetSpawnEffect(self,...)
end

function meta:AddVelocity(vel)
	for i=0,self:GetPhysicsObjectCount() -1 do
		local bone = self:GetPhysicsObjectNum(i)
		if(bone:IsValid()) then
			bone:AddVelocity(vel)
		end
	end
end

local SetHealth = meta.SetHealth
function meta:SetHealth(...)
	if(self.OnHealthChanged) then self:OnHealthChanged(self:Health(),...) end
	return SetHealth(self,...)
end

function meta:MoveToClearSpot(origin)
	local mins = self:OBBMins()
	local maxs = self:OBBMaxs()
	local pos = origin || self:GetPos()
	local tbEnts = ents.FindInBox(pos +mins,pos +maxs)
	maxs.x = maxs.x *2
	maxs.y = maxs.y *2
	local zMax = 0
	local entTgt
	for _, ent in ipairs(tbEnts) do
		if(ent != self && ent:GetSolid() != SOLID_NONE && ent:GetSolid() != SOLID_BSP && gamemode.Call("ShouldCollide",self,ent) != false) then
			local obbMaxs = ent:OBBMaxs()
			if(obbMaxs.z > zMax) then
				zMax = obbMaxs.z
				entTgt = ent
			end
		end
	end
	local tbFilter = {self,entTgt}
	local bAvoid = zMax > 0
	if(!bAvoid) then pos.z = pos.z +10
	else zMax = zMax +10 end
	local left = Vector(0,1,0)
	local right = left *-1
	local forward = Vector(1,0,0)
	local back = forward *-1
	local trLeft = util.TraceLine({
		start = pos,
		endpos = pos +left *maxs.y,
		filter = tbFilter
	})
	local trRight = util.TraceLine({
		start = pos,
		endpos = pos +right *maxs.y,
		filter = tbFilter
	})
	if(trLeft.Hit || trRight.Hit) then
		if(trLeft.Fraction < trRight.Fraction) then -- Move to the right
			pos = pos +right *((trRight.Fraction -trLeft.Fraction) *maxs.y)
		elseif(trRight.Fraction < trLeft.Fraction) then
			pos = pos +left *((trLeft.Fraction -trRight.Fraction) *maxs.y)
		end
	elseif(bAvoid) then
		pos = pos +(math.random(1,2) == 1 && left || right) *maxs.y *1.8
		bAvoid = false
	end
	local trForward = util.TraceLine({
		start = pos,
		endpos = pos +forward *maxs.x,
		filter = tbFilter
	})
	local trBack = util.TraceLine({
		start = pos,
		endpos = pos +back *maxs.x,
		filter = tbFilter
	})
	if(trForward.Hit || trBack.Hit) then
		if(trForward.Fraction < trBack.Fraction) then -- Move to the back
			pos = pos +back *((trBack.Fraction -trForward.Fraction) *maxs.x)
		elseif(trBack.Fraction < trForward.Fraction) then
			pos = pos +forward *((trForward.Fraction -trBack.Fraction) *maxs.x)
		end
	elseif(bAvoid) then
		pos = pos +(math.random(1,2) == 1 && forward || back) *maxs.x *1.8
		bAvoid = false
	end
	if(bAvoid) then -- Looks like we can't completely avoid whatever we're stuck it.
		-- Try to place on top of it
		local start = entTgt:GetPos()
		start.z = start.z +zMax
		local endpos = start
		endpos.z = endpos.z +maxs.z
		local tr = util.TraceLine({
			start = start,
			endpos = endpos,
			filter = tbFilter
		})
		if(!tr.Hit || (!tr.HitWorld && gamemode.Call("ShouldCollide",self,tr.Entity) == false)) then -- Area above appears to be clear
			pos.z = start.z
			bAvoid = false
		else -- Just try to move to whatever direction seems best
			local trTgt = trLeft
			if(trRight.Fraction < trTgt.Fraction) then trTgt = trRight end
			if(trForward.Fraction < trTgt.Fraction) then trTgt = trForward end
			if(trBack.Fraction < trTgt.Fraction) then trTgt = trBack end
			pos = pos +trTgt.Normal *maxs.x
		end
	end
	self:SetPos(pos)
	self:DropToFloor()
end

function meta:SetArcVelocity(vecStart,vecEnd,speed,dirRef,tolerance,dirOffset)
	local phys = self:GetPhysicsObject()
	if(!phys:IsValid()) then return false end
	local dirTgt = (vecEnd -vecStart):GetNormal()
	if(dirOffset) then dirTgt = dirTgt +dirOffset end
	if(tolerance) then dirTgt:ClampToDir(dirRef,tolerance) end
	vecEnd = vecStart +dirTgt *vecStart:Distance(vecEnd)
	local vecToss = util.CalcArcVelocity(self,vecStart,vecEnd,speed)
	local bObstacle = vecToss == vector_origin
	if(bObstacle) then vecToss = self:GetForward() *speed *0.8 +self:GetUp() *speed *0.2
	end/*elseif(tolerance) then
		local dir = self:GetForward()
		local dirVel = vecToss:GetNormal()
		dirVel:ClampToDir(dir,tolerance)
		vecToss = dirVel *vecToss:Length()
	end*/
	local vecToTarget = (vecEnd -vecStart):GetNormal()
	local flVelocity = vecToss:GetNormal():Length2D()
	local flCosTheta = vecToTarget:DotProduct(vecToss)
	local flTime = (vecStart -vecEnd):Length2D() /(flVelocity *flCosTheta)
	phys:SetVelocity(vecToss)
	return flTime,bObstacle
end

function meta:IsScriptedNPC()
	return self:IsNPC() && self.bScripted
end

local Disposition = meta.Disposition
function meta:Disposition(...)
	local ent = ...
	return tblEntRelationshipExcept[self] && tblEntRelationshipExcept[self][ent] || Disposition(self, ...)
end
umsg.PoolString("slv_ignite")
umsg.PoolString("slv_extinguish")
PrecacheParticleSystem("burning_gib_01")
local tblEntsIgnited = {}
local Ignite = meta.Ignite
function meta:Ignite(...)
	local dur, radius, attacker = ...
	local bNPC = self:IsNPC()
	if(self.Ignitable && !self:Ignitable()) then return end
	if bNPC || self:IsPlayer() then
		local iPercentFrozen = self:PercentageFrozen()
		if iPercentFrozen >= 20 then return end
		if bNPC && self.bScripted then
			if tblEntsIgnited[self] then tblEntsIgnited[self].duration = CurTime() +dur; return end
			local cspBurn = CreateSound(self, "General.BurningFlesh")
			cspBurn:Play()
			tblEntsIgnited[self] = {duration = CurTime() +dur, nextDmg = 0, cspBurn = cspBurn}
			umsg.Start("slv_ignite")
				umsg.Entity(self)
			umsg.End()
			hook.Add("Think", "HLR_EntityIgniteThink", function()
				for ent, data in pairs(tblEntsIgnited) do
					if(!IsValid(ent) || ent:Health() <= 0) then
						data.cspBurn:Stop()
						tblEntsIgnited[ent] = nil
					elseif CurTime() >= data.duration || ent:WaterLevel() == 3 then
						ent:Extinguish()
					else
						if CurTime() >= data.nextDmg then
							local inflictor = IsValid(self) && self || ent
							data.nextDmg = CurTime() +0.2
							local dmg = DamageInfo()
							dmg:SetDamage(1)
							dmg:SetDamageType(DMG_DIRECT)
							dmg:SetAttacker(IsValid(attacker) && attacker || game.GetWorld())
							dmg:SetInflictor(inflictor)
							ent:TakeDamageInfo(dmg)
							if !ent.m_bDontGetBurnt then
								local col = ent:GetColor()
								col.r = math.Clamp(col.r -8,45,255)
								col.g = math.Clamp(col.g -8,45,255)
								col.b = math.Clamp(col.b -8,45,255)
								ent:SetColor(col)
							end
						end
					end
				end
			end)
			self:CallOnRemove("IgniteStop", function()
				if !tblEntsIgnited[self] then return end
				tblEntsIgnited[self].cspBurn:Stop()
				tblEntsIgnited[self] = nil
			end)
		return end
	end
	return Ignite(self, ...)
end

local Extinguish = meta.Extinguish
function meta:Extinguish()
	if !tblEntsIgnited[self] then Extinguish(self); return end
	tblEntsIgnited[self].cspBurn:Stop()
	umsg.Start("slv_extinguish")
		umsg.Entity(self)
	umsg.End()
	tblEntsIgnited[self] = nil
end

local IsOnFire = meta.IsOnFire
function meta:IsOnFire()
	return tblEntsIgnited[self] != nil || IsOnFire(self)
end

function meta:FadeOut(fDelay)
	if !fDelay then fDelay = 1 elseif fDelay < 0 then fDelay = 0 end
	local iAlpha = 255
	local iLoops = fDelay /0.015
	local iAlphaSub = (255 /fDelay) *0.015
	local index = self:EntIndex()
	timer.Create("FadeOutTimer" .. index, 0.01, iLoops, function()
		if !IsValid(self) then timer.RemoveSafely("FadeOutTimer" .. index); return end
		iAlpha = iAlpha -iAlphaSub
		if iAlpha <= iAlphaSub then self:Remove(); timer.RemoveSafely("FadeOutTimer" .. index); return end
		self:SetColor(Color(255, 255, 255, iAlpha))
	end)
end

function meta:FadeIn(fDelay)
	if !fDelay then fDelay = 1 end
	local iAlpha = 0
	local iLoops = fDelay /0.015
	local iAlphaSub = (255 /fDelay) *0.015
	local index = self:EntIndex()
	timer.Create("FadeInTimer" .. index, 0.01, iLoops, function()
		if !IsValid(self) then timer.RemoveSafely("FadeInTimer" .. index); return end
		iAlpha = math.min(iAlpha +iAlphaSub, 255)
		self:SetColor(Color(255, 255, 255, iAlpha))
		if iAlpha == 255 then timer.RemoveSafely("FadeInTimer" .. index); return end
	end)
end

function meta:Dissolve(entAttacker, entInflictor, iType)
	if self:IsPlayer() then
		local dmgInfo = DamageInfo()
		dmgInfo:SetDamage(self:Health())
		dmgInfo:SetAttacker(entAttacker)
		dmgInfo:SetInflictor(entInflictor)
		dmgInfo:SetDamageType(DMG_DISSOLVE)
		dmgInfo:SetDamagePosition(self:GetPos())
		self:TakeDamageInfo(dmgInfo)
		return
	end
	entAttacker = entAttacker || self
	entInflictor = entInflictor || self
	local _sName = self:GetName()
	local sName = _sName
	if string.len(sName) == 0 then
		sName = "entDissolve" .. self:EntIndex() .. "_entTarget"
		self:SetName(sName)
	end
	
	local entDissolver = ents.Create("env_entity_dissolver")
	entDissolver:SetKeyValue("dissolvetype", iType || 2)
	entDissolver:Spawn()
	entDissolver:Activate()
	entDissolver:SetOwner(entAttacker)
	entDissolver:Fire("Dissolve", sName, 0)
	self:TakeDamage(self:Health(), entAttacker, entInflictor)
	timer.Simple(0, function()
		if IsValid(entDissolver) then entDissolver:Remove() end
		if IsValid(self) then self:SetName(_sName) end
	end)
end

function meta:TurnDegree(iDeg, posAng, bPitch, iPitchMax)
	if posAng then
		local sType = type(posAng)
		local angTgt
		if sType == "Vector" then angTgt = (posAng -self:GetPos()):Angle()
		else angTgt = posAng end
		local ang = self:GetAngles()
		if !iDeg then ang.y = angTgt.y; if bPitch then ang.p = angTgt.p end
		else
			while angTgt.y < 0 do angTgt.y = angTgt.y +360 end
			while angTgt.y > 360 do angTgt.y = angTgt.y -360 end
			local _ang = ang -angTgt
			_ang.y = math.floor(_ang.y)
			while _ang.y < 0 do _ang.y = _ang.y +360 end
			while _ang.y > 360 do _ang.y = _ang.y -360 end
			local _iDeg = iDeg
			if _ang.y > 0 && _ang.y <= 180 then
				if _ang.y < _iDeg then _iDeg = _ang.y end
				ang.y = ang.y -_iDeg
			elseif _ang.y > 180 then
				if 360 -_ang.y < _iDeg then _iDeg = 360 -_ang.y end
				ang.y = ang.y +_iDeg
			end
			
			if bPitch then
				iPitchMax = iPitchMax || 360
				_ang.p = math.floor(_ang.p)
				while _ang.p < 0 do _ang.p = _ang.p +360 end
				while _ang.p > 360 do _ang.p = _ang.p -360 end
				if _ang.p > 0 then
					local _iDeg = iDeg
					if _ang.p < 180 then
						if ang.p > -iPitchMax then
							if _ang.p < _iDeg then _iDeg = _ang.p end
							ang.p = ang.p -_iDeg
						end
					else
						if ang.p < iPitchMax then
							if 360 -_ang.p < _iDeg then _iDeg = 360 -_ang.p end
							ang.p = ang.p +_iDeg
						end
					end
				end
			end
			self:SetAngles(ang)
		end
		return
	end
	local ang = self:GetAngles()
	ang.y = ang.y +iDeg
	self:SetAngles(ang)
end

function meta:DoExplode(dmg, radius, owner, bDontRemove)
	util.CreateExplosion(self:GetPos(),dmg,radius,self,owner)
	if !bDontRemove then self:Remove() end
end

meta = FindMetaTable("Player")
tblNoTargetPlayers = {}
local SetNoTarget = meta.SetNoTarget
function meta:SetNoTarget(...)
	local bNoTarget = ...
	if(bNoTarget) then tblNoTargetPlayers[self] = true
	else tblNoTargetPlayers[self] = nil end
	return SetNoTarget(self, ...)
end

function meta:GetNoTarget()
	return tblNoTargetPlayers[self] && true || false
end

hook.Add("PlayerSpawn", "SVL_PlayerSpawn", function(ply)
	if !IsValid(ply) then return end
	for k, v in pairs(util.GetCustomAmmoTypes()) do
		ply:SetAmmunition(k,0)
	end
	if ply:IsOnFire() then ply:Extinguish() end
end)

local tblAmmoCount = {}
local tblAmmoTypeNames = {
	[1] = "ar2",
	[2] = "ar2altfire",
	[3] = "pistol",
	[4] = "smg1",
	[5] = "357",
	[6] = "xbowbolt",
	[7] = "buckshot",
	[8] = "rpg_round",
	[9] = "smg1_grenade",
	[10] = "grenade",
	[11] = "slam",
	[12] = "alyxgun",
	[13] = "sniperround",
	[14] = "sniperpenetratedround",
	[15] = "thumper",
	[16] = "gravity",
	[17] = "battery",
	[18] = "gaussenergy",
	[19] = "combinecannon",
	[20] = "airboatgun",
	[21] = "striderminigun",
	[22] = "helicoptergun"
}
local function ToAmmoName(i)
	return tblAmmoTypeNames[i] || ""
end
function meta:GetAmmunition(ammo)
	if type(ammo) == "number" then ammo = ToAmmoName(ammo) end
	if util.IsDefaultAmmoType(ammo) then return self:GetAmmoCount(ammo) end
	return tblAmmoCount[self] && tblAmmoCount[self][ammo] || 0
end

function meta:SetAmmoCount(iAmount, ammo) -- A replacement for the broken player.SetAmmo
	local iAmmo = self:GetAmmoCount(ammo)
	if iAmmo == iAmount then return end
	if iAmmo > iAmount then
		self:RemoveAmmo(iAmmo -iAmount, ammo)
		return
	end
	self:GiveAmmo(iAmount -iAmmo, ammo, true)
end

function meta:SetAmmunition(ammo, iAmount)
	if iAmount < 0 then iAmount = 0 end
	if util.IsDefaultAmmoType(ammo) then
		self:SetAmmoCount(iAmount, ammo)
		return
	end
	umsg.Start("SLV_SetAmmunition", self)
		umsg.String(ammo)
		umsg.Short(iAmount)
	umsg.End()
	tblAmmoCount[self] = tblAmmoCount[self] || {}
	tblAmmoCount[self][ammo] = iAmount
end

function meta:AddAmmunition(ammo, iAmount)
	local _iAmmo = self:GetAmmunition(ammo)
	if _iAmmo +iAmount < 0 then iAmount = -_iAmmo end
	self:SetAmmunition(ammo, _iAmmo +iAmount)
end

function meta:GetPossessionEyeTrace()
	local tracedata = {}
	tracedata.start = self:EyePos()
	tracedata.endpos = tracedata.start +self:GetAimVector() *32768
	tracedata.filter = {self, self:GetPossessedNPC()}
	return util.TraceLine(tracedata)
end

function meta:GetPossessionManager()
	return self.entPossessionManager
end

function meta:GetPossessedNPC()
	return self.entPossessing
end

function meta:IsPossessing()
	return self.bInPossessionMode
end

function meta:GetPossessionCamPos()
	return self.entPossessionCam:GetPos()
end

function meta:SetPossessionCamPos(pos)
	local ent = self:GetPossessedNPC()
	self.entPossessionCam:SetPos(ent:LocalToWorld(pos))
end

meta = FindMetaTable("PhysObj")
function meta:SetAngleVelocity(ang)
	self:AddAngleVelocity(self:GetAngleVelocity() *-1 +ang)
end

local function faggot()

end

local FLY_HOVER = 1
local FLY_GLIDE = 2

hook.Add("KeyPress", "Moat.Poss.Faggot", function(pl, key)
	if (pl:IsValid() and pl.bInPossessionMode and pl.entPossessing and pl.entPossessing and pl.entPossessing._PossReload) then
		if (key == IN_RELOAD) then
			pl.entPossessing._PossReload(pl.entPossessing, pl, faggot, true)
		end
		
		if (key == IN_FORWARD) then
			local flying = pl.entPossessing:IsFlying()
			if (flying) then
				pl.entPossessing:StartGliding()
			end

			pl.entPossessing:StopMoving()
			pl.entPossessing:StopMoving()
		end
	end
end)

hook.Add("KeyRelease", "Moat.Poss.Faggot2", function(pl, key)
	if (pl:IsValid() and pl.bInPossessionMode and pl.entPossessing and pl.entPossessing and pl.entPossessing._PossReload) then
		if (key == IN_FORWARD) then
			local flying = pl.entPossessing:IsFlying()
			if (flying) then
				pl.entPossessing:StartHovering()
			end

			pl.entPossessing:StopMoving()
			pl.entPossessing:StopMoving()
		end
	end
end)

/*
	local flying = self:IsFlying()
	if(flying) then
		if(flying == FLY_HOVER) then
			if(self:IsCrippled()) then fcDone(); return end
			self:StartGliding()
		else self:StartHovering() end
		return
	end
	//if(yaw <= 0) then return yaw >= -45 && ACT_MELEE_ATTACK1 || yaw >= -135 && ACT_MELEE_ATTACK_SWING_GESTURE || ACT_MELEE_ATTACK2 end
	//return yaw <= 45 && ACT_MELEE_ATTACK1 || yaw <= 135 && ACT_MELEE_ATTACK_SWING || ACT_MELEE_ATTACK2
	self:StopMoving()
	self:StopMoving()
	*/