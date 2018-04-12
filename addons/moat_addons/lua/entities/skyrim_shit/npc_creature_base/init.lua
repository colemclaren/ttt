AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_aftm.lua")
AddCSLuaFile("cl_gestures.lua")
AddCSLuaFile("sh_gestures.lua")

include('sv_factions.lua')
include('shared.lua')
include('schedules.lua')
include('sv_gestures.lua')
include('sh_gestures.lua')
// include('animevents.lua')

AccessorFunc(ENT,"iClass","NPCClass",FORCE_NUMBER)
AccessorFunc(ENT,"AIType","AIType",FORCE_NUMBER)
AccessorFunc(ENT,"m_fMaxYawSpeed","MaxYawSpeed",FORCE_NUMBER)
AccessorFunc(ENT,"m_fMaxYawMoveSpeed","MaxYawMoveSpeed",FORCE_NUMBER)
AccessorFunc(ENT,"fSoundLevel","SoundLevel",FORCE_NUMBER)
AccessorFunc(ENT,"fSoundPitch","SoundPitch",FORCE_NUMBER)
AccessorFunc(ENT,"fSoundVolume","SoundVolume",FORCE_NUMBER)
AccessorFunc(ENT,"m_iSpeakAttenuation","SpeakAttenuation",FORCE_NUMBER)

ENT.m_fMaxYawSpeed 				= 20 // Max turning speed
ENT.iClass					= CLASS_NONE // NPC Class
ENT.AIType = AI_TYPE_GROUND				// AI_TYPE_STATIC(e.g. Sentry),AI_TYPE_GROUND,AI_TYPE_AIR,AI_TYPE_WATER

ENT.bScripted = true
ENT.bWander = true
ENT.UseActivityTranslator = false	// This allows the use of ENT.TranslateActivity
ENT.UseIdleSystem = false
ENT.UseRagdollPhysicsProp = false
ENT.UseCustomMovement = false
ENT.iWanderDelay = 10
ENT.fWanderDistance = 100
ENT.fFollowDistance = 380	-- Obsolete. Kept for backwards compatibility
ENT.m_fFollowDistance = 60
ENT.m_fFollowDistanceDefensive = 200
ENT.m_fFollowDistanceDefensiveAttack = 200
ENT.nHostileOnDamage = 3

---- Not yet implemented
--ENT.bAgressive = true
--ENT.AggroRadius = 512
--ENT.nConfidence = 3			-- 0 = Cowardly, 1 = Cautious, 2 = Average, 3 = Brave, 4 = Foolhardy
--ENT.nAssistance = 0			-- 0 = Helps Nobody, 1 = Helps Allies, 2 = Helps Friends and Allies
----

ENT.fHearDistance = 350
ENT.fViewDistance = 20000
ENT.fViewAngle = 90

ENT.iBloodType = BLOOD_COLOR_RED
ENT.bInvincible = false
ENT.bPlayIdle = true
ENT.bIgnoreRagdollDamage = true
ENT.bIgnitable = true
ENT.bFreezable = true
ENT.bFlinchOnDamage = true
ENT.HullNav = HULL_HUMAN
ENT.tblIgnoreDamageTypes = {}
ENT.tblFlinchActivities = {}
ENT.tblDeathActivities = {}

ENT.bPlayDeathSequence = false
ENT.bFadeOnDeath = false
ENT.bRemoveOnDeath = false
ENT.bExplodeOnDeath = false
ENT.bSpecialDeath = false
ENT.Essential = false

ENT.m_tbSounds = {}
ENT.sSoundDir = ""
ENT.fSoundPitch = 100
ENT.fSoundVolume = 100
ENT.Faction = FACTION_NONE || 0

ENT.tblAlertAct = {}
ENT.iAlertRandom = 1
ENT.idleChance = 3

ENT.tblCRelationships = {
	[D_NU] = {"monster_gman", "npc_seagull", "npc_antlion_grub", "npc_barnacle", "monster_cockroach", "npc_pigeon", "npc_crow"},
	[D_FR] = {"npc_strider","npc_combinegunship","npc_combinedropship", "npc_helicopter"},
	[D_HT] = {"obj_sentrygun", "npc_clawscanner", "npc_headcrab_poison", "npc_stalker"}
}

ENT.bNeutral = false

local cvCheat = CreateConVar("ai_use_cheating_behavior",0,{FCVAR_ARCHIVE},"If set to 1, enemies will always know the current position of their targets. If set to 0, enemies only remember where they've last seen their target.")
//local cv = CreateConVar("ai_teleport_along_path",1,{FCVAR_ARCHIVE},"Allows the NPC to teleport if it can't move any further on its path and it is not seen by a player. 0 = Don't teleport, 1 = Teleport if the path is clear, 2 = Teleport no matter what.")

local schdWander = ai_schedule_slv.New("Wnd")
schdWander:EngTask("TASK_GET_PATH_TO_RANDOM_NODE", 384)
schdWander:AddTask("TASK_WALK_PATH")
schdWander:EngTask("TASK_WAIT_FOR_MOVEMENT")
schdWander.bForceSelSched = true

function ENT:Task_TASK_WALK_PATH()
end

function ENT:TaskStart_TASK_WALK_PATH()
	self:SetCustomMovementActivity(self:GetWalkActivity())
	local tasks = self.CurrentSchedule.Tasks
	if tasks[#tasks].FunctionName != "Task_TASK_RESET_MOVEMENT" then
		self.CurrentSchedule:AddTask("TASK_RESET_MOVEMENT")
	end
	self.customMoveSched = self.CurrentSchedule
	self:TaskComplete()
end

function ENT:Task_TASK_RUN_PATH()
end

function ENT:TaskStart_TASK_RUN_PATH()
	self:SetCustomMovementActivity(self:GetRunActivity())
	local tasks = self.CurrentSchedule.Tasks
	if tasks[#tasks].FunctionName != "Task_TASK_RESET_MOVEMENT" then
		self.CurrentSchedule:AddTask("TASK_RESET_MOVEMENT")
	end
	self.customMoveSched = self.CurrentSchedule
	self:TaskComplete()
end

function ENT:Task_TASK_CUSTOM_MOVE_PATH()
end

function ENT:TaskStart_TASK_CUSTOM_MOVE_PATH(data)
	self:SetCustomMovementActivity(data)
	local tasks = self.CurrentSchedule.Tasks
	if tasks[#tasks].FunctionName != "Task_TASK_RESET_MOVEMENT" then
		self.CurrentSchedule:AddTask("TASK_RESET_MOVEMENT")
	end
	self.customMoveSched = self.CurrentSchedule
	self:TaskComplete()
end

function ENT:Task_TASK_RESET_MOVEMENT()
end

function ENT:TaskStart_TASK_RESET_MOVEMENT()
	self:SetCustomMovementActivity()
	self:TaskComplete()
end

local schdWanderNoNode = ai_schedule_slv.New("Wnd")
schdWanderNoNode:EngTask("TASK_GET_PATH_TO_LASTPOSITION")
schdWanderNoNode:AddTask("TASK_WALK_PATH")
schdWanderNoNode:EngTask("TASK_WAIT_FOR_MOVEMENT")
schdWanderNoNode:EngTask("TASK_WAIT", 0.2)
schdWanderNoNode:AddTask("TASK_CHECK_PATH_TIME_WND", 0)
schdWanderNoNode.bForceSelSched = true

function ENT:Task_TASK_CHECK_PATH_TIME_WND()
end

function ENT:TaskStart_TASK_CHECK_PATH_TIME_WND()
	self.fWanderDelay = CurTime() +self:GetPathTimeToGoal() +math.Rand(0,6)
	self:TaskComplete()
end

local schdFollow = ai_schedule_slv.New("Flw")
schdFollow:EngTask("TASK_GET_PATH_TO_TARGET", 0)
schdFollow:EngTask("TASK_WAIT", 0.1)
//schdFollow:EngTask("TASK_RUN_PATH_WITHIN_DIST", 125)
//schdFollow:EngTask("TASK_STOP_MOVING")

local schdMoveToLastPosition = ai_schedule_slv.New("MvLP")
schdMoveToLastPosition:EngTask("TASK_GET_PATH_TO_LASTPOSITION")
schdMoveToLastPosition:EngTask("TASK_WAIT_FOR_MOVEMENT")

local schdMoveToLastPositionGoTo = table.Copy(schdMoveToLastPosition)
schdMoveToLastPositionGoTo.Move = true

local schdMoveToLastPositionTimed = ai_schedule_slv.New("MvLPTmd")
schdMoveToLastPositionTimed:EngTask("TASK_GET_PATH_TO_LASTPOSITION")
schdMoveToLastPositionTimed:EngTask("TASK_WAIT", 0.2)

local schdChase = ai_schedule_slv.New("ChsEnmy")
schdChase:EngTask("TASK_GET_CHASE_PATH_TO_ENEMY")
schdChase.ArrivalSpeed = 1000
--schdChase:EngTask("TASK_WAIT", 0.2)

local schdChaseTarget = ai_schedule_slv.New("ChsTgt")
schdChaseTarget:EngTask("TASK_GET_PATH_TO_TARGET")
schdChaseTarget.ArrivalSpeed = 1000
--schdChaseTarget:EngTask("TASK_WAIT", 0.2)

function ENT:TaskStart_TASK_RUN_PATH_TIMED(data)
	self.pathMoveEnd = CurTime() +data
end

function ENT:Task_TASK_RUN_PATH_TIMED(data)
	local posSelf = self:GetPos()
	local posMove
	local fDist = self:OBBDistance(self.entEnemy)
	if /*fDist <= 500 || */#self.path == 0 || (#self.path == 1 && (posSelf:Distance(self.path[1].pos) <= 120 || posSelf:Distance(self.path[1].pos) > fDist)) then
		if fDist > 260 then fDist = 230 else fDist = fDist -(self.entEnemy:OBBMaxs().x +self:OBBMaxs().x) end
		posMove = posSelf +(self.entEnemy:GetPos() -posSelf):GetNormal() *fDist
	elseif self.path[1] then
		if self:GetPos():Distance(self.path[1].pos) <= 60 || self:GetPathTimeToGoal() < 1 then	// 120
			table.remove(self.path, 1)
		end
		if self.path[1] then
			local flDist = self:GetPos():Distance(self.path[1].pos) //self.path[1].pos:Distance(self:NearestPoint(self.path[1].pos))
			if flDist > 260 then flDist = 230 end// else flDist = flDist -(self.entEnemy:OBBMaxs().x +self:OBBMaxs().x) end
			posMove = posSelf +(self.path[1].pos -posSelf):GetNormal() *flDist //self.path[1].pos
		end
	end
	if !posMove then self:TaskComplete(); return end
	self:SetLastPosition(posMove)
	self:SetMovementActivity(self:GetRunActivity())
	self:StartSchedule(schdMoveToLastPosition)
	if CurTime() < self.pathMoveEnd then return end
	self:TaskComplete()
end

function ENT:UpdateModel() self:SetModel(self.sModel) if (self.iClass == CLASS_DRAGON) then self:SetModelScale(0.8, 0) end end

function ENT:PreInit() end

function ENT:Initialize()
	self:PreInit()
	self:UpdateModel()

	self:SetSolid(SOLID_BBOX)
	self:SetMoveType(MOVETYPE_STEP)

	self:SetMaxYawSpeed(self.m_fMaxYawSpeed)
	
	self:CapabilitiesAdd(CAP_SQUAD)
	self:SetUpEnemies()
	self.tblSounds = {}
	self:InitSounds()
	self.tblMemory = {}
	self.iMemCount = 0
	self:ClearBlockedLinks()
	self.tblDeleteOnDeathEnts = {}
	self.tblGestureLayers = {}
	self.lastHitGroupDamage = 0
	self.iDmgCount = 0
	self.nextFlinch = 0
	self.nextIdle = 0
	self.m_lastThink = CurTime()
	self.m_fMaxYawMoveSpeed = self.m_fMaxYawMoveSpeed || self:GetMaxYawSpeed()
	self.m_tmLastSound = CurTime()
	self.schdWait = CurTime() +0.2
	self.nextPathGenSteps = 0
	self.nextTurnOnDmg = 0
	self.m_iSpeakAttenuation = 1
	self.m_posLast = self:GetPos()
	self.m_lastTimeMoved = 0
	self.m_nextEnemySearch = 0
	self.m_nextUpdate = 0
	self.iState = NPC_STATE_IDLE
	self.tblHostilePlayers = {}
	
	self:SetShouldPlayPickupSound(false)
	if self.bWander then self.fWanderDelay = 0 end
	self:SetBehavior(0)
	self:SetUseType(SIMPLE_USE)
	self:SetSchedule(SCHED_IDLE_STAND)
	
	if table.HasValue(self.tblIgnoreDamageTypes, DMG_DISSOLVE) then
		self:AddEFlags(EFL_NO_DISSOLVE)
	end
	self.tblIncomingGrenades = {}
	
	if(self.UseActivityTranslator) then
		local wep = self:Give("ai_translator")
		if(wep:IsValid()) then wep:SetNoDraw(true); wep:DrawShadow(false) end
	end
	
	if self.tblKeyValues then
		for k, v in pairs(self.tblKeyValues) do
			self:KeyValueHandle(k, v)
		end
	end
	self:OnInit()
	self:InitLimbs()
	self:InitBodyCaps()
	self.m_bInitialized = true
end

function ENT:OnKilledTarget(ent)
end

hook.Add("PlayerDeath","npckilledplayer",function(pl,inflictor,killer)
	if(IsValid(killer) && killer:IsNPC() && killer.OnKilledTarget) then
		killer:OnKilledTarget(pl)
	end
end)

function ENT:TranslateActivity(act)
	//return self:TranslateMovementActivity(act)
	/*local str
	for key,val in pairs(_G) do
		if(val == act && string.Left(key,3) == "ACT") then
			str = key
			break
		end
	end
	print("Translating Activity '" .. (str || "ACT_INVALID") .. "' (" .. act .. ")")*/
end		-- Only called if ENT.UseActivityTranslator is set to true

function ENT:GetFaction() return self.Faction end

function ENT:GetSoundEvents() return self.m_tbSounds end

function ENT:SetNeutral(b) self.bNeutral = b end

function ENT:IsNeutral() return self.bNeutral end

/*local function GetState(st)
	return st == NPC_STATE_INVALID && "NPC_STATE_INVALID" || st == NPC_STATE_PRONE && "NPC_STATE_PRONE" || st == NPC_STATE_IDLE && "NPC_STATE_IDLE" || st == NPC_STATE_SCRIPT && "NPC_STATE_SCRIPT" || st == NPC_STATE_DEAD && "NPC_STATE_DEAD" || st == NPC_STATE_PLAYDEAD && "NPC_STATE_PLAYDEAD" || st == NPC_STATE_COMBAT && "NPC_STATE_COMBAT" || st == NPC_STATE_ALERT && "NPC_STATE_ALERT" || st == NPC_STATE_NONE && "NPC_STATE_NONE" || st == NPC_STATE_LOST && "NPC_STATE_LOST"
end*/
function ENT:OnStateChanged(old, new)
	/*Entity(1):ChatPrint("STATE CHANGED FROM " .. GetState(old) .. " TO " .. GetState(new))*/
end

function ENT:SetDefaultState(state)
	self.m_stateDefault = state
	local stateCur = self:GetState()
	if(stateCur == NPC_STATE_IDLE || stateCur == NPC_STATE_NONE) then
		self:SetState(state)
	elseif(state == stateCur && (state == NPC_STATE_ALERT || state == NPC_STATE_LOST)) then
		self.nextAlertToIdle = nil
	end
end

function ENT:GetDefaultState()
	return self.m_stateDefault || NPC_STATE_IDLE
end

function ENT:SetState(state)
	if(state == self.iState) then return end
	if((state == NPC_STATE_ALERT || state == NPC_STATE_LOST) && state != self:GetDefaultState()) then self.nextAlertToIdle = CurTime() +math.Rand(12,18) end
	local old = self.iState
	self.iState = state
	if(self:IsGuarding() && (old == NPC_STATE_ALERT || old == NPC_STATE_COMBAT) && new != NPC_STATE_ALERT && new != NPC_STATE_COMBAT) then self.m_guard.nextRetreat = CurTime() +8 end
	self:OnStateChanged(old,state)
end

function ENT:GetState()
	return self.iState
end

function ENT:OnInit()
end

function ENT:_PossAttackThink(entPossessor, iInAttack)
	self:TurnDegree(3,entPossessor:GetAimVector():Angle())
end
/*	// Currently unused
function ENT:TranslateMovementActivity(act)
	//if(self.CurrentTask && self.CurrentTask.UseMovementActivity) then return self.CurrentTask.UseMovementActivity end
	local actNew = act
	if(act == ACT_WALK) then actNew = self:GetWalkActivity()
	elseif(act == ACT_RUN) then actNew = self:GetRunActivity() end
	if(act != actNew) then self:SetMovementActivity(actNew) end
	return actNew
end
*/
function ENT:SetWalkActivity(act)
	if self:IsWalking() then self:SetMovementActivity(act) end
	self.actWalk = (act != ACT_WALK && act) || nil
end

function ENT:SetRunActivity(act)
	if self:IsRunning() then self:SetMovementActivity(act) end
	self.actRun = (act != ACT_RUN && act) || nil
end

function ENT:SetCustomMovementActivity(act)
	if self:IsMoving() then self:SetMovementActivity(act) end
	self.actCMove = act
end

function ENT:SetDefaultArrivalActivity(act)
	if self:IsMoving() then self:SetArrivalActivity(act) end
	self.m_actArrival = act
end

function ENT:GetWalkActivity()
	return self.actWalk || ACT_WALK
end

function ENT:GetRunActivity()
	return self.actRun || ACT_RUN
end

function ENT:SetIdleActivity(act)
	self.actIdle = (act != ACT_IDLE && act) || nil
end

function ENT:GetIdleActivity()
	return self.actIdle || ACT_IDLE
end

function ENT:InitSandbox()
	if !self:GetSquad() then self:SetSquad(self:GetClass() .. "_sbsquad") end
end

function ENT:Ignitable()
	return self.bIgnitable
end

function ENT:KeyValueHandle(key, value)
end

function ENT:KeyValue(key, value)
	key = string.lower(key)
	//print("Keyvalue: " .. key .. " = " .. value)
	
	self.tblKeyValues = self.tblKeyValues || {}
	if tonumber(value) then value = tonumber(value) end
	self.tblKeyValues[key] = value
end

function ENT:InitSounds()
	self.tblSounds = {}
	local tb = self:GetSoundEvents()
	tb["BaseClass"] = nil
	for name, sounds in pairs(tb) do
		local tbl = type(sounds) == "table" && sounds || {sounds}
		for _, sound in pairs(tbl) do
			local br = string.find(sound, "[[]")
			if br then
				local _br = string.find(sound, "[]]", br +1)
				if _br then
					local str = string.sub(sound, br +1, _br -1)
					local sep = string.find(str, "-")
					if sep then
						local Start = string.sub(str, 1, sep -1)
						Start = tonumber(Start)
						local End = string.sub(str, sep +1, string.len(str))
						End = tonumber(End)
						if Start && End then
							if type(sounds) != "table" then tb[name] = {}
							else tb[name][_] = nil end
							local strStart = string.sub(sound, 1, br -1)
							local strEnd = string.sub(sound, _br +1, string.len(sound))
							for i = Start, End do
								table.insert(tb[name], strStart .. i .. strEnd)
							end
						end
					end
				end
			end
		end
		if type(sounds) == "table" then table.refresh(tb[name]) end
		self.tblSounds[name] = {}
	end
	self.tblCSPStopOnDeath = {}
end

function ENT:SelectScheduleHandle()
end

function ENT:Flinch(hitgroup)
	local act = self.tblFlinchActivities[hitgroup] || self.tblFlinchActivities[HITGROUP_GENERIC] || self.tblFlinchActivities[HITBOX_GENERIC]
	if !act then return end
	self:PlayActivity(act)
end

local schdChaseNoNode = ai_schedule_slv.New("ChsEnmyDr")
schdChaseNoNode:EngTask("TASK_GET_PATH_TO_LASTPOSITION")
schdChaseNoNode.ArrivalSpeed = 1000
--schdChaseNoNode:EngTask("TASK_WAIT", 0.2)

local schdChaseNoNodeGoTo = table.Copy(schdChaseNoNode)
schdChaseNoNodeGoTo.Move = true

local schdChaseNoNodeClose = ai_schedule_slv.New("ChsEnmyDrCl")
schdChaseNoNodeClose:EngTask("TASK_GET_PATH_TO_TARGET")
schdChaseNoNodeClose.ArrivalSpeed = 1000
--schdChaseNoNodeClose:EngTask("TASK_WAIT", 0.1)

function ENT:ChaseDirect(entTarget)
	entTarget = entTarget || self.entEnemy
	self.bDirectChase = true
	local posSelf = self:GetPos()
	local posRun
	local enemyData = self:GetMemory()[entTarget]
	local ent = self:GetTargetEntity(entTarget)
	local posEnemyLast,dirEnemyLast
	if ent == entTarget then
		if enemyData then
			posEnemyLast = enemyData.lastPos
			dirEnemyLast = enemyData.lastDir
		end
	else posEnemyLast = ent:GetPos(); dirEnemyLast = Vector(0,0,0) end
	if posEnemyLast && entTarget == self.entEnemy then
		entTarget = ent
		self.nextNodeMovement = nil
		local fDist = posSelf:Distance(posEnemyLast)
		if fDist < 270 || self.moveEnemyStart then
			if !self.moveEnemyStart then self.moveEnemyStart = CurTime() end
			local flDist = 230
			local posStart = posSelf +Vector(0,0,10)
			local obbMax = self:OBBMaxs()
			local dirEnemyLast = enemyData.visible && (entTarget:GetPos() -self:GetPos()):GetNormal() || dirEnemyLast
			local tr = util.TraceHull({
				start = posStart,
				endpos = posStart +dirEnemyLast *flDist,
				--mask = MASK_NPCSOLID,
				filter = {self,self.entEnemy},
				mins = self:OBBMins(),
				maxs = obbMax
			})
			if(tr.Hit) then
				flDist = posSelf:Distance(tr.HitPos) -self:OBBMaxs().y
				if flDist < 40 then
					if(self.UseCustomMovement) then self:MoveFacing(tr.HitPos)
					else
						self:ClearCondition(COND_TASK_FAILED)
						self:StartSchedule(schdChase)
						if !self:HasCondition(COND_TASK_FAILED) then
							self.nextNodeMovement = nil
							self.moveEnemyStart = nil
							return
						end
						self:RemoveFromMemory(self.entEnemy)
					end
					return
				end
			end
			posRun = posSelf +dirEnemyLast *flDist
		else
			if fDist > 260 then fDist = 230 end
			local normal = (posEnemyLast -posSelf):GetNormal()
			local posStart = posSelf +Vector(0,0,10)
			local posEnd = posStart +normal *fDist
			local tr = self:CreateTrace(posEnd +Vector(0,0,10), nil, posStart)
			if tr.Hit then fDist = posSelf:Distance(tr.HitPos) -(self:OBBMaxs().y +10) end
			posRun = posSelf +normal *fDist
		end
	else
		entTarget = ent
		if !self.UseCustomMovement && self:OBBDistance(entTarget) <= 550 then
			self:SetTarget(entTarget)
			self:StartSchedule(schdChaseNoNodeClose)
			return
		end
		local fDist = entTarget:NearestPoint(posSelf +entTarget:OBBCenter()):Distance(posSelf)
		fDist = fDist -(self:OBBMaxs().x +30)
		fDist = math.min(fDist, 550)
		posRun = posSelf +(entTarget:GetPos() -posSelf):GetNormal() *fDist
	end
	
	local tr = util.TraceHull({
		start = posSelf +Vector(0,0,10),
		endpos = posRun +Vector(0,0,10),
		filter = self,
		mins = self:OBBMins(),
		maxs = self:OBBMaxs()
	})
	posRun = tr.HitPos
	local trace = util.TraceLine({start = posRun +Vector(0,0,100), endpos = posRun -Vector(0,0,100), mask = MASK_NPCSOLID,filter = self})
	posRun = trace.HitPos
	if(self.UseCustomMovement) then self:MoveFacing(posRun); return end
	self:SetLastPosition(posRun)
	self:StartSchedule(schdChaseNoNode)
end

local schdChaseCustomNode = ai_schedule_slv.New("RnLP")
schdChaseCustomNode:EngTask("TASK_GET_PATH_TO_LASTPOSITION")
schdChaseCustomNode:EngTask("TASK_WAIT", 0.2)
schdChaseCustomNode:AddTask("TASK_CHECK_PATH_TIME")
schdChaseCustomNode.ArrivalSpeed = 1000

local schdChaseCustomNodeGoTo = table.Copy(schdChaseCustomNode)
schdChaseCustomNodeGoTo.Move = true

function ENT:Task_TASK_CHECK_PATH_TIME()
end

function ENT:TaskStart_TASK_CHECK_PATH_TIME()
	self:TaskComplete()
	self.currentPathTime = self:GetPathTimeToGoal()
	if !self.currentNodePos || self.currentNodePos != self.currentPath[1].pos || (self.lastPathCheck && CurTime() -self.lastPathCheck >= 0.65) then
		local tm = CurTime() +self.currentPathTime
		if self.pathTargetDistToNode > 0 then tm = tm +(self.currentPathTime /450) *self.pathTargetDistToNode end
		self.estimPathArrival = tm
	elseif(CurTime() -self:LastTimeMoved() > 4) then-- self.estimPathArrival -CurTime() <= -1 then
		if #self.currentPath > 1 then
			local IDCur = self.currentPath[1].ID
			local IDNext = self.currentPath[2].ID
			self:AddBlockedNodeLink(IDCur,IDNext)
			self.currentPath = nil
			self.pathObj = nil
			self.pathObjTgt = nil
			return
		else
			local iAIType = self:GetAIType()
			local nodeClosest = nodegraph.GetClosestNode(self:GetPos(), iAIType,util.GetMoveHull(self:GetHullType()))
			local nodeNext = self.currentPath[1]
			local nodes = nodegraph.GetNodes(iAIType)
			for _, data in pairs(nodeClosest.links) do
				if nodes[data.dest].pos == nodeNext.pos then
					local IDCur = nodeClosest.ID
					local IDNext = nodeNext.ID
					self:AddBlockedNodeLink(IDCur,IDNext)
					self.currentPath = nil
					self.pathObj = nil
					self.pathObjTgt = nil
					return
				end
			end
		end
	end
	self.lastPathCheck = CurTime()
	self.currentNodePos = self.currentPath && self.currentPath[1] && self.currentPath[1].pos || nil
end

function ENT:GeneratePath(tTarget)
	local bEnt = type(tTarget) != "Vector"
	local tTargetR = tTarget
	if bEnt then tTarget = self:GetTargetEntity(tTarget) end
	if bEnt && !tTarget:IsValid() then return end
	local pos = bEnt && tTarget:GetPos() || tTarget
	local iAIType = self:GetAIType()
	local numPath = self.currentPath && #self.currentPath || 0
	if self.pathObj then return self.currentPath -- Path hasn't been completely calculated yet, returning last path
	elseif !self.currentPath || numPath == 0 || nodegraph.GetClosestNode(pos, iAIType,util.GetMoveHull(self:GetHullType())).pos != self.currentPath[numPath].pos then
		/*
		if self.currentPath && self.estimPathArrival && #self.currentPath == 0 && self.estimPathArrival -CurTime() <= -1 then
			local nodeSelf = nodegraph.GetClosestNode(self:GetPos(), iAIType)
			local nodeTgt = nodegraph.GetClosestNode(pos, iAIType)
			local nodes = nodegraph.GetNodes(iAIType)
			for _, data in pairs(nodeSelf.links) do
				if nodes[data.dest].pos == nodeTgt.pos then
					self.m_tbNodesBlocked[nodeSelf.ID] = self.m_tbNodesBlocked[nodeSelf.ID] || {}
					table.insert(self.m_tbNodesBlocked[nodeSelf.ID], nodeTgt.ID)
					self.estimPathArrival = nil
					break
				end
			end
		end*/
		self.pathObj = nodegraph.CreateAstarObject(self:GetPos(), pos, iAIType, self:GetHullType(), function(nodeCur,nodeNeigh,link)
			local flags = link && link.flags || 0
			local IDCur = nodeCur.ID
			local IDNext = nodeNeigh.ID
			if(self:HasCapability(CAP_MOVE_JUMP)) then
				if(bit.band(flags,NODE_LINK_FLAG_JUMP_DOWN) == NODE_LINK_FLAG_JUMP_DOWN && bit.band(flags,NODE_LINK_FLAG_JUMP_UP) == 0) then -- Link allows to jump down, but not up
					if(nodeCur.pos.z < nodeNeigh.pos.z) then return false end -- We're on the wrong end of this link
				end
				if(bit.band(flags,NODE_LINK_FLAG_JUMP_UP) == NODE_LINK_FLAG_JUMP_UP && bit.band(flags,NODE_LINK_FLAG_JUMP_DOWN) == 0) then -- Link allows to jump up, but not down
					if(nodeCur.pos.z > nodeNeigh.pos.z) then return false end -- We're on the wrong end of this link
				end
			elseif(bit.band(flags,NODE_LINK_FLAG_JUMP_DOWN) == NODE_LINK_FLAG_JUMP_DOWN || bit.band(flags,NODE_LINK_FLAG_JUMP_UP) == NODE_LINK_FLAG_JUMP_UP) then return false end
			return (!self.m_tbNodesBlocked[IDCur] || !table.HasValue(self.m_tbNodesBlocked[IDCur], IDNext)) && (!self.m_tbNodesBlocked[IDNext] || !table.HasValue(self.m_tbNodesBlocked[IDNext], IDCur))
		end,self.MovementCost && function(...)
			return self:MovementCost(...)
		end) -- Creating new astar object
		self.pathObjTgt = tTargetR
		if(numPath == 0) then return end
	else
		local posSelf = self:GetPos()
		local bPathValid
		if #self.currentPath > 0 then
			local nodeClosest = nodegraph.GetClosestNode(posSelf, iAIType,util.GetMoveHull(self:GetHullType()))
			if self.currentPath[1].pos == nodeClosest.pos || self.currentPath[1].pos:DistanceSqr(pos) <= nodeClosest.pos:DistanceSqr(pos) then bPathValid = true -- Path is valid (Closest node is first node in path)
			else
				local tblNodes = nodegraph.GetNodes(iAIType)
				for k, data in pairs(self.currentPath[1].links) do
					if tblNodes[data.dest] && tblNodes[data.dest].pos == nodeClosest.pos then
						bPathValid = true -- Path is valid(Closest node is linked to first node in path)
						break
					end
				end
			end
		end
		if !bPathValid then -- Path is invalid
			self.pathObj = nodegraph.CreateAstarObject(posSelf, pos, iAIType, self:GetHullType(), function(nodeCur,nodeNeigh,link)
				local flags = link && link.flags || 0
				local IDCur = nodeCur.ID
				local IDNext = nodeNeigh.ID
				if(self:HasCapability(CAP_MOVE_JUMP)) then
					if(bit.band(flags,NODE_LINK_FLAG_JUMP_DOWN) == NODE_LINK_FLAG_JUMP_DOWN && bit.band(flags,NODE_LINK_FLAG_JUMP_UP) == 0) then -- Link allows to jump down, but not up
						if(nodeCur.pos.z < nodeNeigh.pos.z) then return false end -- We're on the wrong end of this link
					end
					if(bit.band(flags,NODE_LINK_FLAG_JUMP_UP) == NODE_LINK_FLAG_JUMP_UP && bit.band(flags,NODE_LINK_FLAG_JUMP_DOWN) == 0) then -- Link allows to jump up, but not down
						if(nodeCur.pos.z > nodeNeigh.pos.z) then return false end -- We're on the wrong end of this link
					end
				elseif(bit.band(flags,NODE_LINK_FLAG_JUMP_DOWN) == NODE_LINK_FLAG_JUMP_DOWN || bit.band(flags,NODE_LINK_FLAG_JUMP_UP) == NODE_LINK_FLAG_JUMP_UP) then return false end
				return (!self.m_tbNodesBlocked[IDCur] || !table.HasValue(self.m_tbNodesBlocked[IDCur], IDNext)) && (!self.m_tbNodesBlocked[IDNext] || !table.HasValue(self.m_tbNodesBlocked[IDNext], IDCur))
			end,self.MovementCost && function(...)
				return self:MovementCost(...)
			end) -- Creating new astar object
			self.pathObjTgt = tTargetR
			return
		end
	end
	self:ImprovePath(pos,tTarget)
	return self.currentPath
end

function ENT:UpdateCurrentNode()
	local path = self.currentPath
	local posSelf = self:GetPos()
	posSelf.z = 0
	local posNode = Vector(path[1].pos.x,path[1].pos.y,0)
	if(posSelf:Distance(posNode) <= math.max(self:OBBMaxs().x *0.25,6) && self:VisibleVec(path[1].pos +self:OBBCenter())) then
		table.remove(path,1)
		return true
	end
	return false
end

function ENT:ImprovePath(pos,tTarget)
	local path = self.currentPath
	local numPath = #path
	local link = self:GetCurrentPathLink()
	local bSpecialLink
	if(link && link.flags && (bit.band(link.flags,NODE_LINK_FLAG_JUMP_DOWN) == NODE_LINK_FLAG_JUMP_DOWN || bit.band(link.flags,NODE_LINK_FLAG_JUMP_UP) == NODE_LINK_FLAG_JUMP_UP)) then bSpecialLink = true end
	if(!bSpecialLink && numPath > 0 && self:UpdateCurrentNode()) then numPath = numPath -1 end
	if(numPath >= 2) then
		if(path[2].pos:Distance(path[1].pos) >= self:NearestPoint(path[2].pos):Distance(path[2].pos)) then
			local bRem = self:NearestPoint(path[1].pos):Distance(path[1].pos) <= 10
			if(!bRem) then
				local obbCenter = self:OBBCenter()
				local posSelf = self:GetPos() +obbCenter
				local z
				if(self.UseCustomMovement) then z = 30
				else z = 3 end
				local posEnd = path[2].pos +Vector(0,0,z)
				local tr = util.TraceHull({
					start = posSelf,
					endpos = posEnd,
					filter = self.Entity,
					mask = MASK_NPCWORLDSTATIC,
					mins = Vector(-12,-12,-1),
					maxs = Vector(12,12,1)
				})
				bRem = !tr.Hit
				if(!bRem) then
					local dirA = (path[2].pos -posSelf):GetNormal()
					local dirB = (path[1].pos -posSelf):GetNormal()
					local dotProd = math.abs(dirA:DotProduct(dirB))
					bRem = dotProd >= 0.75
				end
			end
			if(bRem) then
				table.remove(path,1)
				numPath = numPath -1
			end
		end
	end
	if(pos && numPath == 1) then
		if self:VisibleVec(pos) && self:NearestPoint(path[1].pos):Distance(path[1].pos) >= (type(tTarget) != "Vector" && self:OBBDistance(tTarget) || self:NearestPoint(tTarget):Distance(tTarget)) then
			table.remove(path, 1)
			numPath = numPath -1
		end
	end
end

function ENT:GetCurrentPathLink()
	local path = self.currentPath
	local numPath = #path
	if(#path <= 1) then return false end
	return nodegraph.GetLink(path[1],path[2])
end

function ENT:JumpToPos(vecEnd)
	self:SetGroundEntity(NULL)
	local vecStart = self:GetPos()
	local distZ = math.abs(vecStart.z -vecEnd.z)
	local speed = math.Clamp(distZ,80,160)
	local dirTgt = (vecEnd -vecStart):GetNormal()
	local vecToss = util.CalcArcVelocity(self,vecStart,vecEnd,speed,nil,true)
	self:StopMoving()
	self:StopMoving()
	if(self:SelectWeightedSequence(ACT_JUMP) != -1) then
		self:PlayActivity(ACT_JUMP)
	end
	self:SetVelocity(vecToss)
end

function ENT:GetCurrentPath()
	return self.currentPath || {}
end

function ENT:MoveToPosDirect(pos, bWalk, bTimed)
	local tr = util.TraceLine({start = pos +Vector(0,0,100), endpos = pos -Vector(0,0,100), filter = self})
	pos = tr.HitPos
	local posSelf = self:GetPos()
	local dist = posSelf:Distance(pos)
	tr = util.TraceLine({start = posSelf +Vector(0,0,10), endpos = pos +Vector(0,0,10), filter = self})
	if tr.Hit then dist = posSelf:Distance(tr.HitPos) -self:OBBMaxs().y end
	self:SetLastPosition(posSelf +(pos -posSelf):GetNormal() *dist)
	self:SetMovementActivity(bWalk == true && self:GetWalkActivity() || bWalk || self:GetRunActivity())
	self:StartSchedule(!bTimed && schdMoveToLastPosition || schdMoveToLastPositionTimed)
end

function ENT:GetOBBDistanceToTarget(ent)
	return self:OBBDistance(self:GetTargetEntity(ent))
end

function ENT:GetTargetEntity(ent)
	return (ent:IsScriptedNPC() || ent:IsPlayer()) && ent:KnockedDown() && ent:GetRagdollEntity() || ent
end

function ENT:MoveDirect(pos)
	local posSelf = self:GetPos()
	local dir = (pos -posSelf):GetNormal()
	self.nextNodeMovement = nil
	local fDist = posSelf:Distance(pos)
	if(fDist < 270 || self.moveEnemyStart) then
		if(!self.moveEnemyStart) then self.moveEnemyStart = CurTime() end
		local flDist = 230
		local dist = posSelf:Distance(pos)
		local mvMax = math.max(self:OBBMaxs().y,50)
		if(dist <= mvMax) then flDist = dist
		else
			local posStart = posSelf +Vector(0,0,10)
			local obbMax = self:OBBMaxs()
			local tr = util.TraceHull({
				start = posStart,
				endpos = posStart +dir *flDist,
				filter = {self,self.entEnemy},
				mins = self:OBBMins(),
				maxs = obbMax
			})
			if(tr.Hit) then flDist = math.max(posSelf:Distance(tr.HitPos) -self:OBBMaxs().y,mvMax) end
		end
		posRun = posSelf +dir *flDist
	else
		if fDist > 260 then fDist = 230 end
		local posStart = posSelf +Vector(0,0,10)
		local posEnd = posStart +dir *fDist
		local tr = self:CreateTrace(posEnd +Vector(0,0,10), nil, posStart)
		if tr.Hit then fDist = posSelf:Distance(tr.HitPos) -(self:OBBMaxs().y +10) end
		posRun = posSelf +dir*fDist
	end
	
	local tr = util.TraceHull({
		start = posSelf +Vector(0,0,10),
		endpos = posRun +Vector(0,0,10),
		filter = self,
		mins = self:OBBMins(),
		maxs = self:OBBMaxs()
	})
	posRun = tr.HitPos
	
	local trace = util.TraceLine({start = posRun +Vector(0,0,100), endpos = posRun -Vector(0,0,100), mask = MASK_NPCSOLID,filter = self})
	posRun = trace.HitPos
	
	self:SetLastPosition(posRun)
	self:StartSchedule(schdChaseNoNodeGoTo)
end

function ENT:LookForObstructions()
	--if(CurTime() -self:LastTimeMoved() <= 0.4) then return false end -- Don't bother if we were able to move recently
	local obbCenter = self:OBBCenter()
	local pos = self:GetPos() +obbCenter
	local ang = self:GetAngles()
	local tr
	local obb = self:OBBMaxs()
	obb.z = obbCenter.z
	if(tracex) then
		tr = tracex.TraceHull({
			start = pos,
			endpos = pos +ang:Forward() *(self:OBBMaxs().x +80),
			mask = MASK_SOLID,
			mins = obb *-0.5,
			maxs = obb *0.5
		},function(ent)
			return !ent:IsNPC() && !ent:IsPlayer() -- Ignore players and NPCs
		end,false)
	else -- In case the tracex module couldn't be loaded
		tr = util.TraceHull({
			start = pos,
			endpos = pos +ang:Forward() *(self:OBBMaxs().x +80),
			filter = self,
			mask = MASK_SOLID,
			mins = obb *-0.5,
			maxs = obb *0.5
		})
		if(tr.Entity:IsNPC() || tr.Entity:IsPlayer()) then tr.Entity = nil end
	end
	if(IsValid(tr.Entity)) then return self:OnMovementObstructed(tr) end
	return false
end

local doors = {"func_door","func_door_rotating","prop_door_rotating"}
function ENT:LookForDoors(pos)
	if(!self:HasCapability(CAP_OPEN_DOORS)) then return end
	local posSelf = self:GetPos()
	local tbEnts = {}
	for _,class in ipairs(doors) do table.Add(tbEnts,ents.FindByClass(class)) end
	local distMove = self:GetPos():Distance(pos)
	for _, ent in ipairs(tbEnts) do
		local posDoor = ent:GetPos()
		posDoor.z = posSelf.z
		local dist = self:NearestPoint(posDoor):Distance(posDoor)
		if(distMove >= dist && dist <= 50) then
			ent:Fire("OpenAwayFrom",self:GetClass(),0)
		end
	end
end

function ENT:OnMovementObstructed(tr)
	if(self.AttackMelee && tr.Entity:Health() > 0) then
		self:AttackMelee(tr.Entity)
		return true
	end
	return false
end

function ENT:HandleNodeLink(nodeA,nodeB,link)
	if(link.flags && (bit.band(link.flags,NODE_LINK_FLAG_JUMP_DOWN) == NODE_LINK_FLAG_JUMP_DOWN || bit.band(link.flags,NODE_LINK_FLAG_JUMP_UP) == NODE_LINK_FLAG_JUMP_UP)) then
		local dist = self:GetPos():Distance(nodeA.pos)
		local distMax = math.max(self:OBBMaxs().x *0.25,7)
		if(dist <= distMax) then
			self:JumpToPos(nodeB.pos)
			return true
		end
	end
end

function ENT:MoveOnPath(path,tgt,dist,bVisible,bGoTo)
	local entGround = self:GetGroundEntity()
	if(!entGround:IsWorld() && !entGround:IsValid()) then return end
	local numPath = #path
	local bVec = type(tgt) == "Vector"
	if(numPath > 1) then
		local link = self:GetCurrentPathLink()
		if(link) then
			if(self:HandleNodeLink(path[1],path[2],link)) then return end
		end
	end
	if(numPath > 0 && (numPath != 1 || (bVec && dist > tgt:Distance(path[1].pos)) || (!bVec && dist > tgt:NearestPoint(path[1].pos):Distance(path[1].pos)))) then
		self:UpdateCurrentNode()
		numPath = #path
		if self.currentNodePos && self.currentPathTime then
			local estTime
			if numPath > 1 then
				local yawA = (path[1].pos -self:GetPos()):GetNormal():Angle().y
				local yawB = (path[1].pos -path[2].pos):GetNormal():Angle().y
				local yaw = yawA -yawB
				local sin = math.abs(math.cos(math.rad(yaw)))
				estTime = 0.8 *sin
			else estTime = 0.8 end
			if(self.currentNodePos == path[1].pos && self.currentPathTime > 0 && self.currentPathTime <= estTime) then --|| self:NearestPoint(path[1].pos):Distance(path[1].pos) <= 85 then
				table.remove(self.currentPath, 1)
				numPath = numPath -1
				path = self.currentPath
			end
		end
		if numPath > 0 then
			local pos = path[1].pos
			if bVisible && self:NearestPoint(pos):Distance(pos) > dist then
				if(self:LookForObstructions(bVec && tgt || tgt:GetPos())) then return end
				if(bVec) then self:MoveDirect(tgt)
				else self:ChaseDirect(tgt) end
				return
			end
			if(self:LookForObstructions(pos)) then return end
			local posSelf = self:GetPos()
			local dist = posSelf:Distance(pos)
			if dist > 600 then
				pos = posSelf +(pos -posSelf):GetNormal() *600
				self.pathTargetDistToNode = dist -600
			else self.pathTargetDistToNode = 0 end
			self:LookForDoors(pos)
			local obbCenter = self:OBBCenter()
			local tr = util.TraceLine({
				start = posSelf +obbCenter,
				endpos = pos +obbCenter,
				filter = self
			})
			if(!tr.Hit) then -- Do a more thorough check
				local vecOffset = Vector(0,0,20) -- Small offset to make sure we don't hit every single bump in the way
				tr = util.TraceHull({
					start = posSelf +vecOffset,
					endpos = pos +vecOffset,
					mins = self:OBBMins(),
					maxs = self:OBBMaxs(),
					filter = self
				})
			end
			if(tr.Hit) then
				local obbDist = self:OBBMaxs().x *2
				local dist = posSelf:Distance(pos) *tr.Fraction
				if(tr.HitWorld) then dist = math.max(dist,100) end
				dist = dist -obbDist
				if(dist > 10) then pos = posSelf +tr.Normal *dist end
			end
			local tr = util.TraceLine({start = pos +Vector(0,0,100), endpos = pos -Vector(0,0,100), mask = MASK_NPCSOLID,filter = self})
			self:SetLastPosition(tr.HitPos)--path[1].pos)
			//if(self.UseCustomMovement) then self:MoveFacing(tr.HitPos)
			if !bCMove && !self.UseCustomMovement then self:StartSchedule(!bGoTo && schdChaseCustomNode || schdChaseCustomNodeGoTo)
			else self:MoveFacing(tr.HitPos)
				//self.m_MoveCPos = tr.HitPos
				//self.m_tMoveCTimeOut = CurTime() +0.2
			end
			self.bDirectChase = false
		elseif(bVec) then self:MoveDirect(tgt)
		else self:ChaseDirect(tgt) end
	else
		local pos = bVec && tgt || tgt:GetPos()
		self:LookForDoors(pos)
		if(self:LookForObstructions(pos)) then return end
		if(bVec) then self:MoveDirect(tgt)
		else self:ChaseDirect(tgt) end
	end
end

function ENT:MoveFacing(posMove)
	self.m_MoveCPos = posMove
	self.m_tMoveCTimeOut = CurTime() +0.2
	/*MsgPrint("MoveFacing")
	local ang = self:GetAngles()
	local speedYaw = self:GetMaxYawSpeed()
	local pos = self:GetPos()
	local dir = (posMove -pos):GetNormal()
	local angTgt = dir:Angle()
	ang.y = math.ApproachAngle(ang.y,angTgt.y,speedYaw)
	self:PlayActivity(ACT_RUN)*/
end

function ENT:GetMoveTimeToTarget(ent)
	if(!self.UseCustomMovement) then return self:GetPathTimeToGoal() end
	if(self.bDirectChase || !self.currentPath || #self.currentPath <= 1) then
		local dist = self:OBBDistance(ent)
		local vel = self:GetMovementVelocity()
		return dist /vel:Length()
	end
	local path = self.currentPath
	local numNodes = #path
	local dist = self:NearestPoint(path[1].pos):Distance(path[1].pos)
	for i = 1,numNodes -1 do
		local node = path[i]
		local nodeNext = path[i +1]
		dist = dist +node.pos:Distance(nodeNext.pos)
	end
	dist = dist +ent:NearestPoint(path[numNodes].pos):Distance(path[numNodes].pos)
	return dist /self:GetMovementVelocity():Length()
end

function ENT:GetMovementVelocity()
	return self.m_velLast || vector_origin
end

function ENT:GoToPos(pos,bWalk,bDontInterrupt,minDist)
	self.m_moveTo = {
		pos = pos,
		walk = bWalk,
		interrupt = !bDontInterrupt,
		dist = minDist || 25
	}
	self:MoveToPos(pos,bWalk)
end

local cvNodeGraph = GetConVar("sv_customnodegraph_enabled")
function ENT:MoveToPos(pos,bWalk)
	self:SetMovementActivity(bWalk == true && self:GetWalkActivity() || bWalk || self:GetRunActivity())
	if(nodegraph.Exists()) then--&& !self:HasCondition(COND_TASK_FAILED) then
		if(nodegraph.IsEdited() && cvNodeGraph:GetInt() == 1) then
			local dist = self:NearestPoint(pos):Distance(pos)
			local bVisible = self:VisibleVec(pos)
			if(!bVisible || dist > 80) then	-- && > 550 && !self:HasCondition(COND_TASK_FAILED) then???
				local path = self:GeneratePath(pos)
				if(path) then self:MoveOnPath(path,pos,dist,bVisible,true) end
			else self:MoveDirect(pos) end
		else
			self:SetLastPosition(pos)
			self:StartSchedule(schdMoveToLastPositionGoTo)
			self.bDirectChase = true
		end
	else
		--if nodegraph.Exists() then
			if !self.nextNodeMovement then self.nextNodeMovement = CurTime() +3
			elseif CurTime() >= self.nextNodeMovement then
				self.nextNodeMovement = CurTime() +3
				self.bDirectChase = true
				self:ClearCondition(COND_TASK_FAILED)
				self:SetLastPosition(pos)
				self:StartSchedule(schdMoveToLastPositionGoTo)
				self.bDirectChase = false
				if !self:HasCondition(COND_TASK_FAILED) then
					self.nextNodeMovement = nil
					self.moveEnemyStart = nil
					return
				end
			end
		--end
		self:MoveDirect(pos)
	end
end

function ENT:DisplayPath()	-- For debug purposes only!
	if(!self.currentPath) then return end
	umsg.Start("slv_dbg_path")
		umsg.Short(#self.currentPath)
		for _,node in ipairs(self.currentPath) do
			umsg.Vector(node.pos)
		end
	umsg.End()
end

function ENT:ChaseTarget(ent, bEnemy, bCMove)
	self:SetMovementActivity(self:GetRunActivity())
	if(nodegraph.Exists()) then--&& !self:HasCondition(COND_TASK_FAILED) then
		if(nodegraph.IsEdited() && cvNodeGraph:GetInt() == 1) then
			local mem = self:GetMemory()
			local bVisible
			if !bEnemy then bVisible = self:Visible(ent)
			else bVisible = mem[ent].visible end
			local posLast
			if bEnemy && !bVisible then
				self:UpdateLastEnemyPositions()
				posLast = self:GetLastEnemyPosition()
			end
			local dist = posLast && self:NearestPoint(posLast):Distance(posLast) || self:GetOBBDistanceToTarget(ent)
			if posLast && dist <= 50 then
				posLast = nil
				local dir = self:GetLastEnemyMovement()
				if !mem[ent].lost && dir then
					local center = self:OBBCenter()
					local posStart = self:GetPos() +center
					--local posEnemyLast = mem[ent].lastPos
					local tr = util.TraceLine({
						start = posStart,
						endpos = posStart +dir *800,
						filter = self,
						mask = MASK_NPCSOLID
					})
					local trB = util.TraceLine({
						start = tr.HitPos,
						endpos = tr.HitPos -Vector(0,0,100),
						filter = self,
						mask = MASK_NPCSOLID
					})
					mem[ent].lost = true
					mem[ent].lastPos = nodegraph.GetClosestNode(trB.HitPos,self:GetAIType()).pos
					posLast = mem[ent].lastPos
					self.currentPath = nil
					self.pathObj = nil
				elseif !bVisible then
					self.currentPath = nil
					self:SetState(NPC_STATE_LOST)
					self:RemoveFromMemory(ent)
					self:OnLostEnemy(ent)
					return
				end
			end
			if posLast then bVisible = self:VisibleVec(posLast) end
			if !bVisible || dist > 80 then	-- && > 550 && !self:HasCondition(COND_TASK_FAILED) then???
				local path = self:GeneratePath(posLast || ent)
				if path then self:MoveOnPath(path,posLast || ent,dist,bVisible)
				else self:ChaseDirect(ent) end
			else self:ChaseDirect(ent) end
		else
			if bEnemy then self:StartSchedule(schdChase)
			else
				self:SetTarget(ent)
				self:StartSchedule(schdChaseTarget)
			end
			self.bDirectChase = true
		end
	else
		--if nodegraph.Exists() then
			if !self.nextNodeMovement then self.nextNodeMovement = CurTime() +3
			elseif CurTime() >= self.nextNodeMovement then
				self.nextNodeMovement = CurTime() +3
				self.bDirectChase = true
				self:ClearCondition(COND_TASK_FAILED)
				if bEnemy then self:StartSchedule(schdChase)
				else
					self:SetTarget(ent)
					self:StartSchedule(schdChaseTarget)
				end
				self.bDirectChase = false
				if !self:HasCondition(COND_TASK_FAILED) then
					self.nextNodeMovement = nil
					self.moveEnemyStart = nil
					return
				end
			end
		--end
		self:ChaseDirect(ent)
	end
end

function ENT:ChaseEnemy()
	self:ChaseTarget(self.entEnemy, true)
end

local schdHide = ai_schedule_slv.New("Hid") 
schdHide:EngTask("TASK_FIND_COVER_FROM_ENEMY", 0) 
schdHide:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)

local schdHideCustomNode = ai_schedule_slv.New("HidNG") 
schdHideCustomNode:EngTask("TASK_GET_PATH_TO_LASTPOSITION")
schdHideCustomNode:EngTask("TASK_WAIT", 0.2)
schdHideCustomNode:AddTask("TASK_CHECK_PATH_TIME_HIDE")

function ENT:Task_TASK_CHECK_PATH_TIME_HIDE()
end

function ENT:TaskStart_TASK_CHECK_PATH_TIME_HIDE()
	self:TaskComplete()
	self.currentPathTime = self:GetPathTimeToGoal()
	if !self.currentNodePos || self.currentNodePos != self.currentPath[1].pos || (self.lastPathCheck && CurTime() -self.lastPathCheck >= 0.65) then
		local tm = CurTime() +self.currentPathTime
		if self.pathTargetDistToNode > 0 then tm = tm +(self.currentPathTime /600) *self.pathTargetDistToNode end
		self.estimPathArrival = tm
	elseif(CurTime() -self:LastTimeMoved() > 4) then-- self.estimPathArrival -CurTime() <= -1 then
		if #self.currentPath > 1 then
			local IDCur = self.currentPath[1].ID
			local IDNext = self.currentPath[2].ID
			self:AddBlockedNodeLink(IDCur,IDNext)
			self.currentPath = nil
			self.pathObj = nil
			self.pathObjTgt = nil
			return
		else
			local iAIType = self:GetAIType()
			local nodeClosest = nodegraph.GetClosestNode(self:GetPos(), iAIType,util.GetMoveHull(self:GetHullType()))
			local nodeNext = self.currentPath[1]
			local nodes = nodegraph.GetNodes(iAIType)
			for _, data in pairs(nodeClosest.links) do
				if nodes[data.dest].pos == nodeNext.pos then
					local IDCur = nodeClosest.ID
					local IDNext = nodeNext.ID
					self:AddBlockedNodeLink(IDCur,IDNext)
					self.currentPath = nil
					self.pathObj = nil
					self.pathObjTgt = nil
					return
				end
			end
		end
	end
	self.lastPathCheck = CurTime()
	self.currentNodePos = self.currentPath[1].pos
end

function ENT:Hide(vec)
	self:SetMovementActivity(self:GetRunActivity())
	if nodegraph.IsEdited() && GetConVarNumber("sv_customnodegraph_enabled") == 1 then
		if !self.nodeHide then
			local pos = self:GetPos()
			local nodes = nodegraph.FindNodesInSphere(pos,2000,self:GetAIType())
			local nodeHide
			local dist = 2000
			local i = 0
			for _, node in pairs(nodes) do
				i = i +1
				local bVis
				if(!vec) then bVis = self.entEnemy:VisibleVec(node.pos +Vector(0,0,20))
				else
					bVis = !util.TraceLine({
						start = vec +Vector(0,0,20),
						endpos = node.pos +Vector(0,0,20),
						filter = self,
						mask = MASK_NPCSOLID
					}).Hit
				end
				if !bVis || !nodeHide then
					local _dist = node.pos:Distance(pos)
					if _dist < dist then
						nodeHide = node
						dist = _dist
					end
				end
				if i >= 50 then break end
			end
			self.nodeHide = nodeHide
		end
		if self.nodeHide then
			local posSelf = self:GetPos()
			local dist = posSelf:Distance(self.nodeHide.pos)
			local bVisible = vec && self:VisibleVec(vec) || !vec && self:Visible(self.entEnemy)
			//if bVisible then
				local path = self:GeneratePath(self.nodeHide.pos)
				if path then
					local numPath = #path
					if numPath > 0 then
						if self.currentNodePos && self.currentPathTime then
							local estTime
							if numPath > 1 then
								local yawA = (path[1].pos -self:GetPos()):GetNormal():Angle().y
								local yawB = (path[1].pos -path[2].pos):GetNormal():Angle().y
								local yaw = (360 +yawA) -yawB
								local sin = math.abs(math.cos(math.rad(yaw)))
								estTime = 0.8 *sin
							else estTime = 0.8 end
							if (self.currentNodePos == path[1].pos && self.currentPathTime > 0 && self.currentPathTime <= estTime) then --|| self:NearestPoint(path[1].pos):Distance(path[1].pos) <= 85 then
								table.remove(self.currentPath, 1)
								numPath = numPath -1
								path = self.currentPath
							end
						end
						if numPath > 0 then
							local pos = path[1].pos
							local dist = posSelf:Distance(pos)
							if dist > 600 then
								pos = posSelf +(pos -posSelf):GetNormal() *600
								self.pathTargetDistToNode = dist -600
							else self.pathTargetDistToNode = 0 end
							local tr = util.TraceLine({start = pos +Vector(0,0,100), endpos = pos -Vector(0,0,100), mask = MASK_NPCSOLID, filter = self})
							self:SetLastPosition(tr.HitPos)--path[1].pos)
							self:StartSchedule(schdHideCustomNode)
							self.bDirectChase = false
						else self.nodeHide = nil end
					else self.nodeHide = nil end
				end
			//end
		end
	else self:StartSchedule(schdHide) end
end

function ENT:OnWander() end

function ENT:Wander()
	if(self:OnWander()) then return end
	self:SetMovementActivity(self:GetWalkActivity())
	if self.OnWander then self:OnWander() end
	local bNodegraphExists = nodegraph.Exists()
	if bNodegraphExists && (!nodegraph.IsEdited() || GetConVarNumber("sv_customnodegraph_enabled") == 0) then
		self:StartSchedule(schdWander)
	else
		local posWander
		if bNodegraphExists then
			local posSelf = self:GetPos()
			local iAIType = self:GetAIType()
			local nodes = nodegraph.GetNodes(iAIType)
			local nodesSphere = nodegraph.FindNodesInSphere(posSelf, 600, iAIType)
			local nodeClosest = nodegraph.GetClosestNode(posSelf, iAIType,util.GetMoveHull(self:GetHullType()))
			local nodeTgt = {}
			for _, node in pairs(nodesSphere) do
				if node != nodeClosest && node.pos:Distance(posSelf) >= 200 then
					for _, link in pairs(nodeClosest.links) do
						if nodes[link.dest] && nodes[link.dest].pos == node.pos then
							table.insert(nodeTgt, node)
							break
						end
					end
				end
			end
			if #nodeTgt > 1 then
				local node = nodeTgt[math.random(1,#nodeTgt)]
				posWander = node && node.pos
			end
		end
		if !posWander then
			local vecRand = VectorRand()
			vecRand.z = 0
			posWander = self:GetPos() +vecRand *600
			local tr = util.TraceLine({start = self:GetPos() +Vector(0,0,20), endpos = posWander +Vector(0,0,20), filter = self})
			posWander = tr.HitPos -tr.Normal *(self:OBBMaxs().x +10)
			tr = util.TraceLine({start = posWander +Vector(0,0,80), endpos = posWander -Vector(0,0,100), filter = self})
			posWander = tr.HitPos
		end
		self:SetLastPosition(posWander)
		self:StartSchedule(schdWanderNoNode)
	end
	self.fWanderDelay = CurTime() +12
end

function ENT:OnScheduleSelection()
end

function ENT:OnDanger(vecPos, iType)
end

function ENT:GetLastEnemyPosition(ent)
	ent = ent || self.entEnemy
	local mem = self:GetMemory()
	return mem[ent] && mem[ent].lastPos
end

function ENT:GetLastEnemyMovement(ent)
	ent = ent || self.entEnemy
	local mem = self:GetMemory()
	return mem[ent] && mem[ent].lastDir
end

function ENT:GetLastTimeSeen(ent)
	local mem = self:GetMemory()
	return mem[ent] && mem[ent].lastTimeSeen || CurTime()
end

function ENT:UpdateLastEnemyPositions()
	local mem = self:GetMemory()
	for ent, data in pairs(mem) do
		if IsValid(ent) then
			local bVisible = self:Visible(ent)
			if bVisible || cvCheat:GetBool() then -- && self:EntInViewCone(ent, self.fViewAngle) - too slow if there are a lot of enemies
				if ent == self.entEnemy then self.moveEnemyStart = nil end
				mem[ent].lost = false
				local vel = ent:GetVelocity()
				local pos = ent:GetPos()
				mem[ent].lastDir = (vel:Length() > 0 || !mem[ent].lastPos || mem[ent].lastPos:Length() == 0) && vel:GetNormal() || (pos -mem[ent].lastPos):GetNormal()
				mem[ent].lastPos = pos
				mem[ent].lastTimeSeen = CurTime()
			end
			mem[ent].visible = bVisible
		end
	end
end

function ENT:RunFollowBehavior()
	self:ChaseTarget(self.entFollow)
end

function ENT:CanBeKnockedDown()
	return self.m_bKnockDownable
end

function ENT:CanBeFrozen() return self.bFreezable end

function ENT:Sleep()
	self:SetNoDraw(true)
	self.m_iKDMovetype = self:GetMoveType()
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetNotSolid(true)
	self:SetNoTarget(true)
	self:SetInvincible(true)
	self:DrawShadow(false)
	self:SetMoveType(MOVETYPE_NONE)
	self.m_bSleeping = true
end

function ENT:Wake()
	self:SetNoDraw(false)
	self:SetCollisionGroup(COLLISION_GROUP_NPC)
	self:SetNotSolid(false)
	self:SetNoTarget(false)
	self:SetInvincible(false)
	self:DrawShadow(true)
	self:SetMoveType(self.m_iKDMovetype)
	self.m_iKDMovetype = nil
	self.m_bSleeping = false
end

function ENT:Sleeping() return self.m_bSleeping end

function ENT:KnockDown(delay,ragdoll,attacker)
	if !self.m_bKnockDownable || self:KnockedDown() || !self:ShouldKnockDown(attacker || NULL) || gamemode.Call("ShouldNotKnockDown",self,attacker) then return end
	local ragdoll = ragdoll || self:CreateRagdoll()
	if !ragdoll then return end
	self.m_tGetUp = CurTime() +(delay || 6)
	self:DeleteOnRemove(ragdoll)
	ragdoll:DeleteOnRemove(self)
	local index = self:EntIndex()
	hook.Add("EntityTakeDamage", "knockdown_rgdolldmg" .. index, function(ent,dmginfo)
		local attacker = dmginfo:GetAttacker()
		if ent == ragdoll && !attacker:IsWorld() then
			local dmg = DamageInfo()
			dmg:SetAttacker(dmginfo:GetAttacker())
			dmg:SetDamage(dmginfo:GetDamage())
			dmg:SetDamageForce(dmginfo:GetDamageForce())
			dmg:SetDamagePosition(dmginfo:GetDamagePosition())
			dmg:SetDamageType(dmginfo:GetDamageType())
			dmg:SetInflictor(dmginfo:GetInflictor())
			dmg:SetMaxDamage(dmginfo:GetMaxDamage())
			self.m_bRagdollDamage = true
			self:TakeDamageInfo(dmg)
			self.m_bRagdollDamage = nil
		end
	end)
	self:CallOnRemove("ClrKnckDn",function()
		hook.Remove("EntityTakeDamage", "knockdown_rgdolldmg" .. index)
	end)
	self:Interrupt()
	self.ragdoll = ragdoll
	self:SetNetworkedEntity("ragdoll",ragdoll)
	self.m_bKnockedDown = true
	self:Sleep()
	self:SetParent(self.ragdoll)
	self:SetSchedule(SCHED_IDLE_STAND)
	self:OnKnockedDown(self.ragdoll)
	//self:CancelCurrentSchedule()
end

function ENT:OnKnockedDown()
end

function ENT:KnockedDown()
	return self.m_bKnockedDown || false
end

function ENT:StandUp()
	if !self:KnockedDown() || !self.m_tGetUp || self:Paralyzed() then return end
	self.m_tGetUp = nil
	self:SetParent()
	if(self.ragdoll:IsValid()) then
		self:SetAngles(Angle(0,self.ragdoll:GetAngles().y,0))
		self:MoveToClearSpot(self.ragdoll:GetPos() +Vector(0,0,60))
	end
	self.m_actGetUp = self:SelectGetUpActivity()
	self:PlayActivity(self.m_actGetUp)
	self:OnStandUp()
end

function ENT:OnStandUp()
end

function ENT:Paralyze(delay)
	if(self:Paralyzed()) then
		if(self.paralyze -CurTime() < delay) then self.paralyze = CurTime() +delay end
		return
	end
	self:KnockDown()
	local ent = self:GetRagdollEntity()
	if(!IsValid(ent)) then return end
	local bones = ent:GetPhysicsObjectCount()
	for bone = 1, bones do
		local phys = ent:GetPhysicsObjectNum()
		if(phys:IsValid()) then phys:EnableMotion(false) end
	end
	
	timer.Simple(0,function()
		if(!IsValid(self) || !ent:IsValid()) then return end
		self.m_bParalyzed = true
		local forcelimit = 0
		self.paralyze = CurTime() +delay
		self.paralyzeWelds = {}
		local bones = ent:GetPhysicsObjectCount()
		for bone = 1, bones do
			local phys = ent:GetPhysicsObjectNum()
			if(phys:IsValid()) then phys:EnableMotion(true) end
			local bone1 = bone -1
			local bone2 = bones -bone
			
			if(!self.paralyzeWelds[bone2]) then
				local constraint1 = constraint.Weld(ent,ent,bone1,bone2,forcelimit)
				if(constraint1) then
					self.paralyzeWelds[bone1] = constraint1
				end
			end
			local constraint2 = constraint.Weld(ent,ent,bone1,0,forcelimit)
			if(constraint2) then
				self.paralyzeWelds[bone1 +bones] = constraint2
			end
		end
	end)
end

function ENT:StopParalyzation()
	if(!self:Paralyzed()) then return end
	for _, weld in pairs(self.paralyzeWelds) do
		if(IsValid(weld)) then
			weld:Remove()
		end
	end
	self.paralyzeWelds = nil
	self.m_bParalyzed = false
	if(self:KnockedDown() && self.m_tGetUp -CurTime() < 3) then self.m_tGetUp = CurTime() +3 end
end

function ENT:Paralyzed() return self.m_bParalyzed end

function ENT:PreIdle() end

function ENT:OnIdle() end

function ENT:SetCustomIdleActivity(act)
	self.m_iCustomIdle = act
end

function ENT:RunDefaultBehavior(bIgnoreEnemies)
	local iState = self:GetState()
	local iBehavior = self:GetBehavior()
	local bGuard = self:IsGuarding()
	if (!bGuard && (bIgnoreEnemies || (iState != NPC_STATE_COMBAT && (self.iBehavior != 1 || self.iMemCount == 0) && !self:HearEnemy()))) || self.bInSchedule then
		local AIType = self:GetAIType()
		if self.bWander && AIType == 2 && (bIgnoreEnemies || iState == NPC_STATE_ALERT || iState == NPC_STATE_LOST) && iBehavior != 1 && CurTime() >= self.fWanderDelay then
			if(self.nextAlertToIdle && CurTime() >= self.nextAlertToIdle) then self:SetState(self:GetDefaultState())
			elseif(self:GetScheduleName() != "Wnd") then self:Wander(); return true end
		elseif !self.m_iCustomIdle && (AIType == 2 || AIType == 3) && self.bPlayIdle && !self.bInSchedule && !self:IsMoving() then
			local actIdle = self:GetIdleActivity()
			if self:GetActivity() != actIdle then self:StartEngineTask(GetTaskID("TASK_SET_ACTIVITY"), actIdle)
			elseif CurTime() >= self.nextIdle && self:GetCycle() < 0.1 then
				if math.random(1,self.idleChance) <= 2 then
					self:PlayIdle()
				end
				self.nextIdle = CurTime() +self:SequenceDuration() *1.5
			end
		end
		if(self.SelectDefaultSchedule) then self:SelectDefaultSchedule() end
		return true
	end
	return false
end

function ENT:PlayIdle()
	self:PlaySound((!self:GetSoundEvents()["IdleAlert"] || self:GetState() == NPC_STATE_IDLE) && "Idle" || "IdleAlert")
end

function ENT:SelectSchedule(iNPCState)
	if GetConVarNumber("ai_disabled") == 1 || self:IsPossessed() || self:PercentageFrozen() == 100 || self:GetState() == NPC_STATE_DEAD || CurTime() < self.schdWait then return end
	if self.m_iCustomIdle && !self.CurrentSchedule && !self:IsMoving() && (!self.bInSchedule || self:GetActivity() == ACT_IDLE) then
		if !self:PreIdle() then
			local schdAct = ai_schedule_slv.New("ActIdle")
			schdAct:EngTask("TASK_PLAY_SEQUENCE", self.m_iCustomIdle)
			schdAct.bForceSelSched = true
			self:StartEngineTask(GetTaskID("TASK_RESET_ACTIVITY"), 0)
			self:StartSchedule(schdAct)
			self:OnIdle()
		end
	end
	local bSkip = self:OnScheduleSelection()
	if bSkip then return end
	for ent, v in pairs(self.tblIncomingGrenades) do
		if !IsValid(ent) then self.tblIncomingGrenades[ent] = nil
		else
			local flDist = self:OBBDistance(ent)
			if flDist <= 200 then
				self.tblIncomingGrenades[ent] = nil
				local bSkip = self:OnDanger(ent:GetPos(), v)
				if bSkip then return end
			end
		end
	end
	local iState = self:GetState()
	local iBehavior = self:GetBehavior()
	if iBehavior == 1 then
		local entFollow = self.entFollow
		if !IsValid(entFollow) || entFollow:Health() <= 0 then self:SetBehavior(0)
		else
			local fDist = entFollow:OBBDistance(self)
			if fDist > self:GetFollowDistance() then
				if(self.bInSchedule) then
					if(self:IsInIdlePosture()) then self:EndIdlePosture(); return end
					self:OnBehaviorInterrupt(1)
				else
					--self:SetTarget(entFollow)
					--self:StartSchedule(schdFollow)
					--if self:HasCondition(COND_TASK_FAILED) then
					--	self:OnBehaviorFailed(1)
					--	self:ClearCondition(COND_TASK_FAILED)
					--end
					self:RunFollowBehavior()
				end
				return
			else
				if self.DoFollowBehavior then self:DoFollowBehavior(entFollow)
				else
					if !IsValid(self.entEnemy) then
						local schd = self:GetScheduleName()
						if schd != "MvLP" && schd != "MvLPTmd" then self:StopMoving() end
					end
					if entFollow:IsPlayer() && self:OBBDistance(entFollow) <= 10 && self:EntityIsPushing(entFollow) then
						if(self:IsInIdlePosture()) then self:EndIdlePosture(); return end
						if self.bInSchedule then self:OnBehaviorInterrupt(1)
						else
							self:SetLastPosition(self:GetPos() +(self:GetPos() -entFollow:GetPos()):GetNormal() *50)
							self:SetMovementActivity(self:GetWalkActivity())
							self:StartSchedule(schdMoveToLastPosition)
						end
					end
				end
			end
		end
	elseif iBehavior == 2 && !self:IsGuarding() then
		local posPatrol = self.posPatrol
		local fDist = self:GetPos():Distance(posPatrol)
		if fDist > self.distPatrol then
			self:SetLastPosition(posPatrol)
			self:SetMovementActivity(self:GetRunActivity())
			self:StartSchedule(schdMoveToLastPosition)
			return
		end
	end
	if(self:RunDefaultBehavior()) then return end
	if(CurTime() >= self.m_nextEnemySearch) then
		self:UpdateEnemies()
		if(IsValid(self.entEnemy)) then self.m_nextEnemySearch = CurTime() +1
		else self.m_nextEnemySearch = CurTime() +0.4 end
	end
	if !IsValid(self.entEnemy) then
		if(bGuard && (!self.IsInteracting || !self:IsInteracting())) then
			local guard = self.m_guard
			if(guard.nextRetreat && CurTime() >= guard.nextRetreat) then
				guard.nextRetreat = nil
				guard.retreating = true
			end
			if(guard.retreating) then
				if(self:NearestPoint(guard.posRetreat):Distance(guard.posRetreat) <= 50) then
					if(guard.yawRetreat && math.abs(math.AngleDifference(guard.yawRetreat,self:GetAngles().y)) > 5) then
						if(!self:IsMoving()) then
							local ang = Angle(0,guard.yawRetreat,0)
							self:TurnDegree(self.m_fMaxYawSpeed *2,ang)
						end
					else
						self:OnGuardRetreated()
						guard.retreating = nil
					end
				elseif(!self.CurrentSchedule || self.CurrentSchedule.Idle) then self:Retreat() end
				return
			end
		end
		if(self.SelectDefaultSchedule) then self:SelectDefaultSchedule() end
		return
	end
	local iDisposition = self:Disposition(self.entEnemy)
	
	local posEnemy = self.entEnemy:NearestPoint(self:GetPos() +self.entEnemy:OBBCenter())
	local posSelf = self:NearestPoint(self.entEnemy:GetPos() +self:OBBCenter())
	posEnemy.z = self.entEnemy:GetPos().z
	posSelf.z = self:GetPos().z
	
	local posEnemyPredicted = posEnemy +self.entEnemy:GetVelocity() *0.9
	local fDistPredicted = posEnemyPredicted:Distance(posSelf)
	local fDist = posEnemy:Distance(posSelf)
	
	if iDisposition == D_FR then
		self:SetTarget(self.entEnemy)
		self:UpdateEnemyMemory(self.entEnemy, self.entEnemy:GetPos())
		if(self:SelectScheduleHandle(self.entEnemy,fDist,fDistPredicted,iDisposition)) then self:RunDefaultBehavior(true) end
		return
	end
	if fDist <= 20 && self:GetAIType() != 1 then
		self:FaceEnemy()
	end
	self:UpdateEnemyMemory(self.entEnemy, self.entEnemy:GetPos())
	if(self:SelectScheduleHandle(self.entEnemy,fDist,fDistPredicted,iDisposition)) then self:RunDefaultBehavior(true) end
end

function ENT:OnGuardRetreated() end

function ENT:GetPredictedEnemyPosition(flDelta)
	if(!IsValid(self.entEnemy)) then return false end
	return self.entEnemy:GetCenter() +self.entEnemy:GetVelocity() *(flDelta || 0.5)
end

function ENT:OnBehaviorInterrupt(iBehavior)
end

function ENT:Interrupt()		-- Called on flinch, possession start or ai disabled
	if self.actReset then self:SetMovementActivity(self.actReset); self.actReset = nil end
	if self:IsPossessed() then self:_PossScheduleDone() end
	self.bInSchedule = false
	self:OnInterrupt()
end

function ENT:OnInterrupt()
end

cvars.AddChangeCallback("ai_disabled", function(cvar, prevValue, newValue)
	if tobool(newValue) then
		for k, ent in pairs(ents.GetAll()) do
			if ent:IsNPC() && ent.bScripted then
				ent:Interrupt()
			end
		end
	end
end)

function ENT:_PossStart(entPossessor)
	self:Interrupt()
end

function ENT:EntityIsPushing(ent)
	local angEnt = Angle(0,0,0)
	if ent:KeyDown(IN_FORWARD) then
		angEnt = angEnt +ent:GetForward():Angle()
	end
	if ent:KeyDown(IN_BACK) then
		angEnt = angEnt +(ent:GetForward() *-1):Angle()
	end
	if ent:KeyDown(IN_MOVERIGHT) then
		angEnt = angEnt +ent:GetRight():Angle()
	end
	if ent:KeyDown(IN_MOVELEFT) then
		angEnt = angEnt +(ent:GetRight() *-1):Angle()
	end
	local angEntSelf = (self:GetPos() -ent:GetPos()):GetNormal():Angle()
	local angDiff = angEnt.y -angEntSelf.y
	if angDiff < 0 then angDiff = angDiff +360 end
	if angDiff > 360 then angDiff = angDiff -360 end
	if angDiff >= 310 || angDiff <= 50 then
		return true
	end
	return false
end

function ENT:OnBehaviorFailed(iBehavior)
end

function ENT:OnFoundEnemy(iEnemies)
	--self:SelectSchedule()
end

function ENT:Retreat()
	if(!self.m_guard) then return end
	self:MoveToPos(self.m_guard.posRetreat)
end

function ENT:FoundEnemy(iEnemies)
	self:EndIdlePosture()
	if(self.m_guard) then
		self.m_guard.nextRetreat = nil
		self.m_guard.retreating = false
	end
	self:OnFoundEnemy(iEnemies)
end

function ENT:OnLostEnemy(entEnemy)
end

function ENT:OnAreaCleared()
	self:PlaySound("AreaClear")
end

function ENT:GetFollowingTarget() return self.entFollow end

function ENT:IsGuarding() return self.m_guard && true || false end

function ENT:Guard(posGuard,guardRadius,posRetreat,yawRetreat)
	if(!posGuard) then
		self.m_guard = nil
		self:SetBehavior(0)
		return
	end
	self.m_guard = {
		pos = posGuard,
		radius = guardRadius,
		posRetreat = posRetreat,
		yawRetreat = yawRetreat,
		nextRetreat = CurTime() +8
	}
	self:SetBehavior(2,posGuard,guardRadius)
end

function ENT:SetBehavior(iBehavior,tArg,tArgb)
	if self:GetAIType() == 3 then return end
	if iBehavior != self.iBehavior then
		if self.iBehavior == 1 then
			if self.iEntFollowDisposition then
				if IsValid(self.entFollow) then
					self:AddEntityRelationship(self.entFollow,self.iEntFollowDisposition,10)
				end
				self.iEntFollowDisposition = nil
			end
			self.entFollow = nil
		elseif self.iBehavior == 2 then
			self.posPatrol = nil
			self.distPatrol = nil
		end
	end
	if iBehavior > 2 || iBehavior < 0 then iBehavior = 0 end
	self.iBehavior = iBehavior	// 0 = No Behavior, 1 = Follow Behavior, 2 = Patrol Behavior, --[3 == Lead Behavior]--
	if iBehavior == 1 then
		self.entFollow = tArg
		if !IsValid(tArg) then return end
		if !tArgb then
			self.iEntFollowDisposition = self:Disposition(tArg)
			self:AddEntityRelationship(tArg,D_LI,10)
		end
		if IsValid(self.entEnemy) && self.entEnemy == tArg then self.entEnemy = nil; self:SetEnemy(NULL) end
	elseif iBehavior == 2 then
		if !tArg then self.iBehavior = 0; return end
		self.posPatrol = tArg
		self.distPatrol = tArgb || 420
		self:SetLastPosition(self.posPatrol)
		self:SetMovementActivity(self:GetRunActivity())
		self:StartSchedule(schdMoveToLastPosition)
	end
end

function ENT:GetViewDistance()
	return (self.iBehavior == 1 || self.iBehavior == 2) && (self.fFollowAttackDistance || self:GetFollowDistance() -50) || self.fViewDistance
end

function ENT:GetSearchDistance() return self.fSearchDistance || self:GetViewDistance() end

function ENT:SetViewDistance(dist) self.fViewDistance = dist end

function ENT:GetFollowDistance()
	return self.fFollowDistance
end

function ENT:GetBehavior()
	return self.iBehavior
end

function ENT:DoSchedule(schedule)
	if self:TaskFinished() then
		self:NextTask(schedule)
	end
	if self.CurrentTask then
		self:RunTask(self.CurrentTask)
	end
end

function ENT:OnTaskComplete()
	self.bTaskComplete = true
	//self:DoSchedule(self.CurrentSchedule)
end

function ENT:OnPlayAlert() end

function ENT:OnCondition(iCondition)
	if self.bDead then return end
	--Msg(self, " Condition: ", iCondition, " - ", self:ConditionName(iCondition), "\n")
	local iNPCState = self:GetState()
	if iNPCState == NPC_STATE_DEAD then return end
	if iNPCState != NPC_STATE_COMBAT && (iCondition == COND_SEE_HATE || iCondition == COND_SEE_FEAR) then --|| #self.tblMemory > 0) then TODO: CHEATING BEHAVIOR?
		self:UpdateEnemies()
		if iNPCState != NPC_STATE_LOST && IsValid(self.entEnemy) then
			self:PlaySound("Alert")
			if(!self:IsPossessed()) then
				if(self.Alert) then self:Alert()
				elseif(#self.tblAlertAct > 0) then
					local bPlay
					if(self.AlertChance) then bPlay = math.random(1,100) <= self.AlertChance
					elseif(self.iAlertRandom) then bPlay = math.random(1,self.iAlertRandom) < 3 end
					if(bPlay) then
						self:PlayActivity(self.tblAlertAct[math.random(1,#self.tblAlertAct)], true)
						self:OnPlayAlert()
					end
				end
			end
		end
		if(IsValid(self.entEnemy)) then self:SetState(NPC_STATE_COMBAT) end
		return
	end
	--if iNPCState == NPC_STATE_COMBAT && !self:HasCondition(COND_SEE_HATE) && !self:HasCondition(COND_SEE_FEAR) && self.iMemCount && (self:HasCondition(COND_ENEMY_UNREACHABLE) || self:HasCondition(COND_ENEMY_DEAD) || self:HasCondition(COND_ENEMY_OCCLUDED) || self:HasCondition(COND_ENEMY_WENT_NULL)) then
		--self:SetState(NPC_STATE_ALERT)
	--end
end

function ENT:HearEnemy(ent)
	if(ent) then
		return self:OBBDistance(ent) <= self.fHearDistance && (!ent:IsPlayer() || !ent:Crouching() && (ent:KeyDown(IN_FORWARD) || ent:KeyDown(IN_BACK) || ent:KeyDown(IN_MOVELEFT) || ent:KeyDown(IN_MOVERIGHT) || ent:KeyDown(IN_JUMP)) || self:OBBDistance(ent) <= 75)
	end
	for _, ent in pairs(ents.FindInSphere(self:GetPos(), self.fHearDistance)) do
		if(self:IsEnemy(ent) && (!ent:IsPlayer() || !ent:Crouching() && (ent:KeyDown(IN_FORWARD) || ent:KeyDown(IN_BACK) || ent:KeyDown(IN_MOVELEFT) || ent:KeyDown(IN_MOVERIGHT) || ent:KeyDown(IN_JUMP)) || self:OBBDistance(ent) <= 75)) then
			return true
		end
	end
	return false
end

function ENT:FaceEnemy()
	self:SetAngles(Angle(0,(self.entEnemy:GetPos() -self:GetPos()):Angle().y,0))
end

function ENT:GetEnemies(ang)
	local tbEnts
	if(self.bIgnoreNPCs) then tbEnts = {}
	else tbEnts = ents.GetNPCs() end
	local bIgnorePlayers = tobool(GetConVarNumber("ai_ignoreplayers")) || self.bIgnorePlayers
	if(!bIgnorePlayers) then table.Add(tbEnts,player.GetAll()) end
	local tbEnemies = {}
	local posSelf = self:GetPos()
	local viewDist = self:GetSearchDistance()
	for _, ent in ipairs(tbEnts) do
		if(ent != self && ent:Alive() && !ent:GetNoTarget() && (self:GetAIType() != AI_TYPE_WATER || ent:WaterLevel() > 1) && !ent.bSelfDestruct) then
			local disp = self:Disposition(ent)
			if((disp == D_HT || disp == D_FR) && !gamemode.Call("NPCCanSee",self,ent) && (!ent:IsPlayer() || !ent:IsPossessing()) && self:InSight(ent,ang)) then
				local dist = posSelf:Distance(ent:GetPos())
				if((dist <= viewDist || self:HearEnemy(ent,dist)) && self:IsInAttackRange(ent)) then
					table.insert(tbEnemies,ent)
				end
			end
		end
	end
	self:AddToMemory(tbEnemies)
	return tbEnemies
end

function ENT:InSight(ent,ang)
	return self:CanSee(ent,nil,ang)
end

function ENT:IsVisible(ent)
	local posCenter = ent:GetPos() +ent:OBBCenter()
	local posStart = self:NearestPoint(posCenter)
	local posEnd = posCenter
	local tr = util.TraceLine({start = posStart, endpos = posEnd, filter = self})
	return tr.Entity == ent
end

function ENT:InMemory(ent)
	return self:GetMemory()[ent] && true || false
end

function ENT:IsInteracting() return self.m_bInteracting end

function ENT:GetPlayerOwner()
	return IsValid(self.m_plOwner) && self.m_plOwner || nil
end

function ENT:SetPlayerOwner(pl) self.m_plOwner = pl end

function ENT:GetOrigin()
	local bh = self:GetBehavior()
	local plOwner = self:GetPlayerOwner()
	return bh == 2 && self.posPatrol || (bh == 1 && self.entFollow:GetPos()) || (plOwner && plOwner:GetPos())
end

function ENT:ResetActivity()
	self:StartEngineTask(GetTaskID("TASK_RESET_ACTIVITY"),0)
end

function ENT:GetActivityName(act) -- For debugging purposes only!!!
	for key,val in pairs(_G) do
		if(val == act && string.Left(key,4) == "ACT_") then
			return key
		end
	end
	return "ACT_INVALID"
end

function ENT:GetOriginDistance()
	local bh = self:GetBehavior()
	local plOwner = self:GetPlayerOwner()
	return bh == 2 && self:GetPos():Distance(self.posPatrol) || (bh == 1 && self:OBBDistance(self.entFollow)) || (plOwner && self:OBBDistance(plOwner))
end

function ENT:GetTargetDistanceToOrigin(ent)
	local bh = self:GetBehavior()
	local plOwner = self:GetPlayerOwner()
	return bh == 2 && ent:GetPos():Distance(self.posPatrol) || (bh == 1 && ent:OBBDistance(self.entFollow)) || (plOwner && ent:OBBDistance(plOwner))
end

function ENT:IsCompanion() return false end

function ENT:IsInAttackRange(ent)
	return !self.GetAttackDistance || (self:GetTargetDistanceToOrigin(ent) <= self:GetAttackDistance())
end

function ENT:IsEnemy(ent)
	if(self:IsInteracting()) then return false end
	return IsValid(ent) && !ent.bNeutral && (ent:IsNPC() || ent:IsPlayer()) && !ent:GetNoTarget() && self:Disposition(ent) <= 2 && (!ent:IsPlayer() || (!tobool(GetConVarNumber("ai_ignoreplayers")) && !ent:IsPossessing())) && ent != self && ent:Health() > 0 && gamemode.Call("ShouldIgnoreEnemy",self,ent) != true && (!ent.IsCompanion || !ent:IsCompanion()) && self:IsInAttackRange(ent)
end

// What's this for again?
function ENT:IsEnemyPlayer(ent)
	return IsValid(ent) && ((ent:IsNPC() && ent.Charmed && ent:Charmed()) || ent:IsPlayer()) && !ent:GetNoTarget() && self:Disposition(ent) <= 2 && (!ent:IsPlayer() || (!tobool(GetConVarNumber("ai_ignoreplayers")) && !ent:IsPossessing())) && ent != self && ent:Health() > 0
end

function ENT:ForceEnemyFocus(ent)
	if(!ent) then self.m_entEnemyFocus = nil; return end
	self.entEnemy = ent
	self.m_entEnemyFocus = ent
end

function ENT:SetAttackPlayerOnly(b)
	if(b) then
		if(self.m__IsEnemy) then return end
		self.m__IsEnemy = self.IsEnemy
		self.IsEnemy = self.IsEnemyPlayer
		return
	end
	if(!self.m__IsEnemy) then return end
	self.IsEnemy = self.m__IsEnemy
	self.m__IsEnemy = nil
end

function ENT:MergeMemory(memTgt)
	local num = self.iMemCount
	local mem = self:GetMemory()
	for ent, data in pairs(memTgt) do
		if(data.visible) then
			if(!mem[ent]) then self.iMemCount = self.iMemCount +1 end
			mem[ent] = data
		end
	end
	if num == 0 && self.iMemCount > 0 then self:OnCondition(COND_SEE_HATE); self:FoundEnemy(self.iMemCount); return
	elseif num > 0 && self.iMemCount == 0 then self:SetState(self:GetDefaultState()); self:OnAreaCleared(); self:ClearBlockedLinks() end
end

function ENT:AddToMemory(TEnts,bForceAdd)
	local num = self.iMemCount
	local mem = self:GetMemory()
	local sType = type(TEnts)
	if sType == "NPC" || sType == "Player" then
		if !mem[TEnts] && (bForceAdd || self:IsEnemy(TEnts)) then
			mem[TEnts] = {}
			self.iMemCount = self.iMemCount +1
		end
		if num == 0 && self.iMemCount > 0 then self:OnCondition(COND_SEE_HATE); self:FoundEnemy(self.iMemCount) end
		return true
	elseif sType == "table" then
		for _, ent in pairs(TEnts) do
			if !mem[ent] && (bForceAdd || self:IsEnemy(ent)) then
				mem[ent] = {}
				self.iMemCount = self.iMemCount +1
			end
		end
		if num == 0 && self.iMemCount > 0 then self:OnCondition(COND_SEE_HATE); self:FoundEnemy(self.iMemCount) end
		return true
	end
	return false
end

function ENT:GetMemory(ent)
	if(ent) then return self.tblMemory[ent] end
	return self.tblMemory
end

function ENT:GetEnemyCount()
	return self.iMemCount;
end

function ENT:HasSpotted(ent)
	return self.tblMemory[ent] && true || false
end

function ENT:RemoveFromMemory(ent)
	local mem = self:GetMemory()
	if !mem[ent] then return false end
	if self.iMemCount == 0 then return false end
	mem[ent] = nil
	self.iMemCount = self.iMemCount -1
	if(ent == self.entEnemy) then self.entEnemy = nil; self:SetEnemy(NULL) end
	if(self.iMemCount == 0) then
		if(self:GetState() != NPC_STATE_LOST) then
			self:SetState(self:GetDefaultState())
			self:OnAreaCleared()
		end
		self:ClearBlockedLinks()
	end
	return true
end

function ENT:ClearMemory()
	self.entEnemy = nil
	self.tblMemory = {}
	self.iMemCount = 0
end

function ENT:CreateTrace(posEnd, iMask, posStart)
	return util.TraceLine({start = posStart || self:GetPos(), endpos = posEnd, mask = iMask, filter = self}) 
end

function ENT:TurnToTarget(ent,deg)
	self:TurnDegree(deg || 2,(ent:GetPos() -self:GetPos()):Angle())
end

local schdTurnToEnemy = ai_schedule_slv.New()
schdTurnToEnemy:EngTask("TASK_FACE_ENEMY")
schdTurnToEnemy.bForceSelSched = true
function ENT:TurnToEnemy(ent)
	self:StartSchedule(schdTurnToEnemy)
end

function ENT:GetAimDir()
	if(IsValid(self.entEnemy)) then
		local posEye = self:EyePos()
		local wep = self:GetActiveWeapon()
		if(wep:IsValid()) then
			local dir = wep:GetAimDir(self.entEnemy)
			return self:GetConstrictedDirection(posEye,40,90,posEye +dir)
		end
		local posEnemy = self.entEnemy:GetHeadPos()
		return self:GetConstrictedDirection(posEye,40,90,posEnemy)
	end
	return self:GetAimAngles():Forward()
end

function ENT:GetFirePos()
	local wep = self:GetActiveWeapon()
	if(wep:IsValid()) then
		local att = wep:LookupAttachment("muzzle")
		if(att == 0) then
			att = self:LookupAttachment("weapon")
			if(att == 0) then return end
			return self:GetAttachment(att).Pos
		end
		return wep:GetAttachment(att).Pos
	end
end

function ENT:CancelCurrentSchedule()
	self:StartEngineTask(GetTaskID("TASK_SET_ACTIVITY"), ACT_IDLE)
	self.CurrentSchedule = nil
	self.CurrentTask = nil
	self.CurrentTaskID = nil
end

function ENT:PlayActivity(TAct,bFaceEnemy,fcDone,bDontResetAct,bDontStopMoving)
	local schdAct = ai_schedule_slv.New("Act" .. TAct)
	local task = "TASK_PLAY_SEQUENCE"
	if bFaceEnemy then
		/*if type(bFaceEnemy) == "Vector" then
			self:SetLastPosition(bFaceEnemy)
			schdAct:EngTask("TASK_FACE_LASTPOSITION", 0)
		else task = task .. "_FACE_ENEMY" end*/
		if(bFaceEnemy == 2) then task = task .. "_FACE_TARGET"
		else task = task .. "_FACE_ENEMY" end
	end
	if !bDontStopMoving && (self:IsMoving() || (!self.bInSchedule && self.CurrentSchedule)) then
		--schdAct:EngTask("TASK_STOP_MOVING", 0)
		--schdAct:EngTask("TASK_STOP_MOVING", 0)
		self:StopMoving()
		self:StopMoving()
	elseif !bDontResetAct then self:StartEngineTask(GetTaskID("TASK_RESET_ACTIVITY"), 0) end
	schdAct:EngTask(task, TAct)
	if fcDone then
		self.TaskStart_TASK_ACTIVITY_END = fcDone
		schdAct:AddTask("TASK_ACTIVITY_END")
	end
	//if !bDontForceIdle then schdAct:EngTask("TASK_SET_ACTIVITY", self:GetIdleActivity()) end
	self:StartSchedule(schdAct)
	--self.CurrentSchedule.Name = "PlayActivity" .. TAct
end

function ENT:Task_TASK_ACTIVITY_END()
end

function ENT:UpdateMemory()
	local mem = self:GetMemory()
	//local viewDist = self:GetViewDistance()
	local posSelf = self:GetPos()
	for ent, data in pairs(mem) do
		local bValid = IsValid(ent)
		local iDisposition = bValid && self:Disposition(ent)
		if !bValid || ent:Health() <= 0/* || self:OBBDistance(ent) > viewDist*/ || !self:IsInAttackRange(ent) || ent:GetNoTarget() || (ent:IsPlayer() && (!ent:Alive() || tobool(GetConVarNumber("ai_ignoreplayers")))) || (iDisposition != 1 && iDisposition != 2) || (self:GetAIType() == AI_TYPE_WATER && ent:WaterLevel() < 2) || ent.bSelfDestruct then
			self:RemoveFromMemory(ent)
		end
	end
end

function ENT:OnPrimaryTargetChanged(ent)
end

function ENT:SelectEnemy()
	local mem = self:GetMemory()
	local fDistClosest = self:GetViewDistance()
	local posSelf = self:GetPos()
	local bClosestVisible
	local entEnemy
	for ent, data in pairs(mem) do
		local posEnemy = ent:GetPos()
		local fDist = posSelf:Distance(posEnemy)
		local bVis = self:Visible(ent)
		if(fDist < fDistClosest && (bVis || !bClosestVisible)) then
			bClosestVisible = bVis
			entEnemy = ent
			fDistClosest = fDist
		end
	end
	return entEnemy
end

function ENT:UpdateEnemies()
	local num = self.iMemCount
	if self.entEnemy && (!IsValid(self.entEnemy) || self.entEnemy:Health() <= 0 || self.entEnemy:GetNoTarget() || !self:IsInAttackRange(self.entEnemy) || (self:GetAIType() == 5 && self.entEnemy:WaterLevel() < 2) || (self.entEnemy:IsPlayer() && (tobool(GetConVarNumber("ai_ignoreplayers")) || self.entEnemy:IsPossessing())) || self.entEnemy.bSelfDestruct) then self:RemoveFromMemory(self.entEnemy) end
	self:UpdateMemory()
	self:GetEnemies()
	local enemyLast = self.entEnemy
	local mem = self:GetMemory()
	self.entEnemy = self.m_entEnemyFocus || self:SelectEnemy() || self.entEnemy
	if self.entEnemy != enemyLast then self:SetEnemy(self.entEnemy); self:OnPrimaryTargetChanged(self.entEnemy) end
	
	if self.sSquad && self.tblSquadMembers && self.iMemCount > 0 then
		for _, ent in pairs(self.tblSquadMembers) do
			if !IsValid(ent) then self.tblSquadMembers[_] = nil
			else ent:MergeMemory(mem) end
		end
		table.refresh(self.tblSquadMembers)
	end
	if num == 0 && self.iMemCount > 0 then self:FoundEnemy(self.iMemCount); return end
	return mem
end

function ENT:GetMeleePos()
	local yaw = self:GetAimAngles().y
	yaw = yaw < 0 && yaw *-1 || yaw
	while yaw > 90 do
		yaw = yaw -90
	end
	while yaw > 45 do
		yaw = 45 -(yaw -45)
	end
	local a = self:OBBMaxs().y
	local beta = yaw
	local alpha = math.rad(90 -beta)
	local c = a /math.sin(alpha) +8
	return self:GetPos() +(self:GetForward() *c)
end

function ENT:GetAimAngles() return self:GetAngles() end

--------
	-- OBSOLETE, USE ENT.DealMeleeDamage INSTEAD!
	-- LEFT FOR BACKWARDS COMPATIBILITY
--------
function ENT:DoMeleeDamage(fDist,iDmg,angViewPunch,iAttachment,funcAdd,bIgnoreAngle,sHitSound,attacker)
	local posDmg
	if !iAttachment then posDmg = self:GetMeleePos()
	else posDmg = self:GetAttachment(iAttachment).Pos end
	local posSelf = self:GetPos()
	local posSelfCenter = posSelf +self:OBBCenter()
	local bHit
	for _, ent in pairs(ents.FindInSphere(posDmg,fDist)) do
		if IsValid(ent) && (self:IsEnemy(ent) || ent:IsPhysicsEntity()) && self:Visible(ent) && ent:Health() > 0 then
			local tgt = self:GetTargetEntity(ent)
			local posEnemy = tgt:GetPos()
			local angToEnemy = self:GetAngleToPos(posEnemy,self:GetAimAngles()).y
			if bIgnoreAngle || ((angToEnemy <= 70 && angToEnemy >= 0) || (angToEnemy <= 360 && angToEnemy >= 290)) then
				bHit = true
				if funcAdd then funcAdd(ent) end
				local posDmg = tgt:NearestPoint(posSelfCenter)
				local dmgInfo = DamageInfo()
				dmgInfo:SetDamage(iDmg)
				dmgInfo:SetAttacker(attacker || self)
				dmgInfo:SetInflictor(self)
				dmgInfo:SetDamageType(DMG_SLASH)
				dmgInfo:SetDamagePosition(posDmg)
				tgt:TakeDamageInfo(dmgInfo)
				if ent:IsPlayer() then
					ent:ViewPunch(angViewPunch)
					util.ParticleEffect("blood_impact_red_01",posDmg,Angle(0,0,0),ent)
				end
				if tgt:GetClass() == "npc_turret_floor" && !tgt.bSelfDestruct then
					tgt:Fire("selfdestruct", "", 0)
					tgt:GetPhysicsObject():ApplyForceCenter(self:GetForward() *10000) 
					tgt.bSelfDestruct = true
				end
			end
		end
	end
	if sHitSound == false then return end
	local sSound = sHitSound || "npc/zombie/claw_strike" ..math.random(1,3).. ".wav"
	if bHit then
		self:EmitSound(sSound, 75, 100)
	else
		self:EmitSound("npc/zombie/claw_miss" ..math.random(1,2).. ".wav", 75, 100)
	end
end

function ENT:DealMeleeDamage(dist,dmg,viewPunch,force,dmgType,fcFilter,bDontPlayDefSounds,bFullRot,fcOnHit)
	local pos = self:GetMeleePos()
	local posSelf = self:GetPos()
	local center = posSelf +self:OBBCenter()
	local bHit
	if force then
		local forward,right,up = self:GetForward(),self:GetRight(),self:GetUp()
		force = forward *force.x +right *force.y +up *force.z
	end
	for _, ent in ipairs(ents.FindInSphere(pos,dist)) do
		if ent:IsValid() && (self:IsEnemy(ent) || ent:IsPhysicsEntity()) && self:IsVisible(ent) && ent:Health() > 0 && (!fcFilter || fcFilter(ent)) then
			local posTgt = ent:GetPos()
			local yaw = !bFullRot && self:GetAngleToPos(posTgt,self:GetAimAngles()).y
			if bFullRot || ((yaw <= 70 && yaw >= 0) || (yaw <= 360 && yaw >= 290)) then
				bHit = true
				local posDmg = ent:NearestPoint(center)
				local dmgInfo = DamageInfo()
				dmgInfo:SetDamage(dmg)
				dmgInfo:SetAttacker(self)
				dmgInfo:SetInflictor(self)
				dmgInfo:SetDamageType(dmgType || DMG_SLASH)
				dmgInfo:SetDamagePosition(posDmg)
				if force then dmgInfo:SetDamageForce(force) end
				if(fcOnHit) then fcOnHit(ent,dmgInfo) end
				ent:TakeDamageInfo(dmgInfo)
				if ent:IsPlayer() then
					ent:ViewPunch(viewPunch)
					if(!Swords_Installed || !ent.Parry) then util.ParticleEffect("blood_impact_red_01",posDmg,Angle(0,0,0),ent) end
				elseif ent:GetClass() == "npc_turret_floor" && !ent.bSelfDestruct then
					ent:Fire("selfdestruct", "", 0)
					ent:GetPhysicsObject():ApplyForceCenter(self:GetForward() *10000) 
					ent.bSelfDestruct = true
				end
			end
		end
	end
	if bDontPlayDefSounds then return bHit end
	self:EmitSound(bHit && ("npc/zombie/claw_strike" .. math.random(1,3) .. ".wav") || ("fx/melee_miss" .. math.random(1,5) .. ".mp3"),75,100)
end

function ENT:DealFlameDamage(dist,dmg,attacker)
	local dist = dist || self.fRangeDistance
	local dmg = dmg || GetConVarNumber("sk_" .. self.skName .. "_dmg_flame")
	local posDmg = self:GetPos() +(self:GetForward() *self:OBBMaxs().y)
	for _, ent in pairs(ents.FindInSphere(posDmg,dist)) do
		if(ent:IsValid() && (self:IsEnemy(ent) || ent:IsPhysicsEntity()) && self:Visible(ent)) then
			local posEnt = ent:GetPos()
			local yaw = self:GetAngleToPos(posEnt,self:GetAimAngles()).y
			if((yaw <= 70 && yaw >= 0) || (yaw <= 360 && yaw >= 290)) then
				ent:Ignite(6,0)
				local dmginfo = DamageInfo()
				dmginfo:SetDamageType(DMG_BURN)
				dmginfo:SetDamage(dmg)
				dmginfo:SetAttacker(attacker || self)
				dmginfo:SetInflictor(self)
				ent:TakeDamageInfo(dmginfo)
			end
		end
	end
end

function ENT:CallOnDeath(fc)
	if self.bDead then fc(); return end
	self.m_tbOnDeath = self.m_tbOnDeath || {}
	table.insert(self.m_tbOnDeath,fc)
end

function ENT:CallOnRagdollDeath(fc)
	if(self.bDead) then
		local ragdoll = self:GetRagdollEntity()
		if(IsValid(ragdoll)) then fc(); return end
	end
	self.m_tbOnRagDeath = self.m_tbOnRagDeath || {}
	table.insert(self.m_tbOnRagDeath,fc)
end

function ENT:CallOnInitialized(fc)
	if self.m_bAIInitialized then fc(); return end
	self.m_tbOnAIInit = self.m_tbOnAIInit || {}
	table.insert(self.m_tbOnAIInit,fc)
end

function ENT:StopSoundOnDeath(csp)
	table.insert(self.tblCSPStopOnDeath, csp)
end

function ENT:StopSounds()
	for k, v in pairs(self.tblSounds) do
		if k != "Death" then
			for _k, _v in pairs(v) do
				_v:Stop()
			end
		end
		self.tblSounds[k] = {}
	end
end

function ENT:StopSoundPatch(sSound)
	if !self.tblSounds[sSound] then return end
	for k, v in pairs(self.tblSounds[sSound]) do
		v:Stop()
	end
	self.tblSounds[sSound] = {}
end

umsg.PoolString("slv_create_soundevent")
function ENT:PlaySoundEvent(ev)
	umsg.Start("slv_create_soundevent")
		umsg.Vector(self:GetCenter())
		umsg.Char(ev)
	umsg.End()
	
end

function ENT:PlaySound(sSound, bOver, bDontStop)
	if !self:GetSoundEvents()[sSound] || (self.nextSoundPlay && CurTime() < self.nextSoundPlay) then return end
	if !bOver then self:StopSounds() end
	self.m_tmLastSound = CurTime()
	local cspSound,_sSound = self:CreateSound(sSound,bDontStop)
	if self.fSoundLevel then cspSound:SetSoundLevel(self.fSoundLevel) end
	cspSound:Play()
	if self.fSoundPitch != 100 then cspSound:ChangePitch(self.fSoundPitch,0) end
	if self.fSoundVolume != 100 then cspSound:ChangeVolume(self.fSoundVolume,0) end
	return self.sSoundDir .. _sSound
end

function ENT:CreateSound(sSound,bDontStop)
	local sType = type(self:GetSoundEvents()[sSound])
	local _sSound
	if sType == "string" then _sSound = self:GetSoundEvents()[sSound]
	else _sSound = self:GetSoundEvents()[sSound][math.random(1,table.Count(self:GetSoundEvents()[sSound]))] end
	local csp = CreateSound(self, self.sSoundDir .. _sSound)
	if !bDontStop then table.insert(self.tblSounds[sSound],csp) end
	return csp,_sSound
end

function ENT:EmitEventSound(sSound,vol,pitch)
	if (!self:GetSoundEvents()[sSound]) then return end
	local snd = self:GetSoundEvents()[sSound]
	self:EmitSound(self.sSoundDir .. (type(snd) == "string" && snd || snd[math.random(1,#snd)]), vol || self.fSoundVolume, pitch || self.fSoundPitch)
end

function ENT:SetUpEnemies()
	self:UpdateFactionRelationships()
	/*for i = 0, 4 do
		if self.tblCRelationships[i] && self.tblCRelationships[i]["BaseClass"] then self.tblCRelationships[i]["BaseClass"] = nil end
	end
	
	local tblRelationships = {
		[D_NU] = self.tblCRelationships[D_NU] && table.Copy(self.tblCRelationships[D_NU]) || {},
		[D_HT] = self.tblCRelationships[D_HT] && table.Copy(self.tblCRelationships[D_HT]) || {},
		[D_LI] = self.tblCRelationships[D_LI] && table.Copy(self.tblCRelationships[D_LI]) || {},
		[D_FR] = self.tblCRelationships[D_FR] && table.Copy(self.tblCRelationships[D_FR]) || {}
	}
	for _, class in pairs(self:GetAlliedNPCClasses()) do if !table.HasValue(tblRelationships[D_LI], class) then table.insert(tblRelationships[D_LI], class) end end
	
	local tblList = list.Get("NPC")
	for class, data in pairs(list.Get("NPC")) do
		if class != self:GetClass() then
			local bExists
			for disp, classes in pairs(tblRelationships) do
				if table.HasValue(classes, class) then bExists = true; break end
			end
			if !bExists then table.insert(tblRelationships[D_HT],class); if class == "player" then bPlayerRel = true end end
		end
	end
	local bPlayerRel
	for disp, classes in pairs(tblRelationships) do
		if table.HasValue(classes, "player") then bPlayerRel = true; break end
	end
	if !bPlayerRel then table.insert(tblRelationships[D_HT],"player") end
	local iDispPly
	for disp, classes in pairs(tblRelationships) do
		if table.HasValue(classes, "player") then iDispPly = disp; break end
	end
	
	for _, pl in pairs(player.GetAll()) do
		local rel = gamemode.Call("SetupRelationship",self,pl)
		if(rel != true && (!self.SetupRelationship || !self:SetupRelationship(pl))) then self:AddEntityRelationship(pl, iDispPly || D_LI, 10) end
	end
	hook.Add("PlayerSpawn", "PlayerSpawn_AddRelationship" .. self:EntIndex(), function(ply)
		if IsValid(ply) then
			local rel = gamemode.Call("SetupRelationship",self,ply)
			if(rel != true && (!self.SetupRelationship || !self:SetupRelationship(ply))) then self:AddEntityRelationship(ply, iDispPly, 10) end
		end
	end)
	
	for _, ent in pairs(ents.GetAll()) do
		if ent:IsNPC() then
			local class = ent:GetClass()
			local disp = self.GetDisposition && self:GetDisposition(ent,class) || ent.GetDisposition && ent:GetDisposition(self,self:GetClass())
			if(disp == nil) then
				for disp, classes in pairs(tblRelationships) do
					if table.HasValue(classes, class) then
						local rel = gamemode.Call("SetupRelationship",self,ent)
						if(rel != true && (!self.SetupRelationship || !self:SetupRelationship(ent))) then self:AddEntityRelationship(ent, disp, 10) end
						rel = gamemode.Call("SetupRelationship",ent,self)
						if(rel != true && (!self.SetupRelationship || !self:SetupRelationship(ent))) then ent:AddEntityRelationship(self, disp, 10) end
						break
					end
				end
			else
				local rel = gamemode.Call("SetupRelationship",self,ent)
				if(rel != true && (!self.SetupRelationship || !self:SetupRelationship(ent))) then self:AddEntityRelationship(ent,disp,10) end
				rel = gamemode.Call("SetupRelationship",ent,self)
				if(rel != true && (!self.SetupRelationship || !self:SetupRelationship(ent))) then ent:AddEntityRelationship(self,disp,10) end
			end
		end
	end
	if self.bNeutral == true || self.bNeutral == 1 then return end
	hook.Add("OnEntityCreated", "OnEntityCreated_AddRelationship" .. self:EntIndex(), function(ent)
		timer.Simple(0, function()
			if IsValid(ent) && self:IsValid() then
				local class = ent:GetClass()
				if ent:IsNPC() then
					if !self.SetCRelationship || !self:SetCRelationship(ent, class) then
						local disp = self.GetDisposition && self:GetDisposition(ent,class) || ent.GetDisposition && ent:GetDisposition(self,self:GetClass())
						if(disp == nil) then
							for disp, classes in pairs(tblRelationships) do
								if table.HasValue(classes, class) then
									local rel = gamemode.Call("SetupRelationship",self,ent)
									if(rel != true && (!self.SetupRelationship || !self:SetupRelationship(ent))) then self:AddEntityRelationship(ent, disp, 10) end
									rel = gamemode.Call("SetupRelationship",ent,self)
									if(rel != true && (!self.SetupRelationship || !self:SetupRelationship(ent))) then ent:AddEntityRelationship(self, disp, 10) end
									break
								end
							end
						else
							local rel = gamemode.Call("SetupRelationship",self,ent)
							if(rel != true && (!self.SetupRelationship || !self:SetupRelationship(ent))) then self:AddEntityRelationship(ent,disp,10) end
							rel = gamemode.Call("SetupRelationship",ent,self)
							if(rel != true && (!self.SetupRelationship || !self:SetupRelationship(ent))) then ent:AddEntityRelationship(self,disp,10) end
						end
					end
				else
					local iType
					if class == "npc_grenade_frag" || class == "obj_handgrenade" || (class == "obj_spore" && ent.bGrenade) then iType = 0
					elseif class == "obj_portal" || class == "obj_grenade_flechette" || class == "hunter_flechette" then iType = -1 end
					if iType then
						self.tblIncomingGrenades[ent] = iType
					end
				end
			end
		end)
	end)*/
end

function ENT:GetDisposition(ent,class) end

function ENT:OnRemove()
	hook.Remove("PlayerSpawn", "PlayerSpawn_AddRelationship" .. self:EntIndex())
	hook.Remove("OnEntityCreated", "OnEntityCreated_AddRelationship" .. self:EntIndex())
	self:StopSounds()
	for k, v in pairs(self.tblCSPStopOnDeath) do
		v:Stop()
	end
	if self.m_tbOnDeath then
		for _, fc in ipairs(self.m_tbOnDeath) do
			fc()
		end
		self.m_tbOnDeath = nil
	end
	self:Removed()
end

function ENT:Removed() end

function ENT:BloodDecal(dmginfo)
	if !dmginfo:IsBulletDamage() && !dmginfo:IsExplosionDamage() && !dmginfo:IsDamageType(DMG_CLUB) then return end
	local force = dmginfo:GetDamageForce()
	local length = math.Clamp(force:Length() *0.25, 0, 180)
	local bPaint = tobool(math.random(0, math.Round(length *0.125)) <= 10)
	if !bPaint then return end
	local posStart = dmginfo:GetDamagePosition()
	local posEnd = posStart +force:GetNormal() *length
	local tr = util.TraceLine({start = posStart, endpos = posEnd, filter = self})
	if !tr.HitWorld then return end
	local iBloodCol = self.iBloodType
	local sDecal
	if iBloodCol == BLOOD_COLOR_RED then sDecal = "Blood"
	elseif iBloodCol == BLOOD_COLOR_GREEN || iBloodCol == BLOOD_COLOR_YELLOW || iBloodCol == BLOOD_COLOR_ANTLION || iBloodCol == BLOOD_COLOR_ANTLION_WORKER || iBloodCol == BLOOD_COLOR_ZOMBIE then sDecal = "YellowBlood"
	else return end
	util.Decal(sDecal,tr.HitPos +tr.HitNormal,tr.HitPos -tr.HitNormal)
end

function ENT:GetBloodParticle(bloodCol)
	bloodCol = bloodCol || self.iBloodType
	return bloodCol == BLOOD_COLOR_RED && "blood_impact_red_01"
		|| (bloodCol == BLOOD_COLOR_YELLOW || bloodCol == BLOOD_COLOR_ANTLION || bloodCol == BLOOD_COLOR_ANTLION_WORKER) && "blood_impact_yellow_01"
		|| (bloodCol == BLOOD_COLOR_GREEN || bloodCol == BLOOD_COLOR_ZOMBIE) && "blood_impact_green_01"
		|| bloodCol == BLOOD_COLOR_BLUE && "blood_impact_blue_01"
		|| bloodCol == BLOOD_COLOR_MECH && "impact_metal" || nil
end

function ENT:BloodSplash(vecPos)
	if vecPos == Vector(0,0,0) || !self.iBloodType then return false end
	local particle = self:GetBloodParticle()
	if !particle then return false end
	util.ParticleEffect(particle, vecPos, self:GetAngles(), self)
	return true
end

function ENT:CreateRagdoll()
	local mdl = self:GetModel()
	local ragdoll
	if(self.UseRagdollPhysicsProp) then ragdoll = ents.Create("prop_physics")
	else
		if(!util.IsValidRagdoll(mdl)) then return end
		ragdoll = ents.Create("prop_ragdoll")
	end
	ragdoll:SetModel(self:GetModel())
	for i = 0,18 do ragdoll:SetBodygroup(i,self:GetBodygroup(i)) end
	ragdoll:SetPos(self:GetPos())
	ragdoll:SetAngles(self:GetAngles())
	ragdoll:Spawn()
	
	if !ragdoll:IsValid() then return end
	local entPhys = self:GetPhysicsObject()
	local entVel = entPhys:IsValid() && entPhys:GetVelocity() || self:GetVelocity()

	for i=0,ragdoll:GetPhysicsObjectCount() -1 do
		local bone = ragdoll:GetPhysicsObjectNum(i)
		if IsValid(bone) then
			local bonepos, boneang = self:GetBonePosition(ragdoll:TranslatePhysBoneToBone(i))
			
			if(bonepos) then
				bone:SetPos(bonepos)
				bone:SetAngles(boneang)// +Angle(0,90,0))
			end
			
			--bone:ApplyForceOffset(dmgForce /3, forcepos)
			bone:AddVelocity(entVel)
		end
	end
	ragdoll:SetSkin(self:GetSkin())
	ragdoll:SetColor(self:GetColor())
	ragdoll:SetMaterial(self:GetMaterial())
	if self:IsOnFire() then ragdoll:Ignite(math.Rand(8,10),0) end
	self:OnRagdollCreated(ragdoll)
	self:SetNetworkedEntity("ragdoll",ragdoll)
	ragdoll:NoCollide(self)
	return ragdoll
end

function ENT:OnRagdollCreated(ragdoll) end

function ENT:OnRagdollDeath(dmginfo)
end

local tblRagdolls = {}
function ENT:DoRagdollDeath(dmginfo)
	local ragdoll
	if IsValid(self.ragdoll) then
		if(self:Paralyzed()) then
			self:StopParalyzation()
		end
		ragdoll = self.ragdoll
		self:DontDeleteOnDeath(ragdoll)
	else
		local iKeepRagdolls = self.BodyCaps && 1 || GetConVarNumber("ai_serverragdolls")
		if(iKeepRagdolls == 0 && !self.UseRagdollPhysicsProp) then
			local bKeepRagdoll = tobool(iKeepRagdolls)
			if !bKeepRagdoll then
				self:SetSchedule(SCHED_DIE_RAGDOLL)
				timer.Simple(0.1, function()
					if !IsValid(self) then return end
					self:SetSchedule(SCHED_DIE_RAGDOLL)
					timer.Simple(0.1, function()
						if !IsValid(self) then return end
						self:FadeOut()
					end)
				end)
				return
			end
		end
		ragdoll = self:CreateRagdoll()
		if !ragdoll then self:Remove(); return end
		self.ragdoll = ragdoll
	end
	self:OnRagdollDeath(dmginfo)
	undo.ReplaceEntity(self, ragdoll)
	cleanup.ReplaceEntity(self, ragdoll)
	if self.BodyCaps then
		ragdoll:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		local bodyCaps = table.Copy(self.BodyCaps)
		for model, data in pairs(self.BodyCaps) do
			for _, bone in pairs(data.bones) do
				bodyCaps[model].bones[_] = ragdoll:LookupBone(bone)
			end
			bodyCaps[model].numAtt = ragdoll:LookupAttachment(data.att)
			bodyCaps[model].health = 45
		end
		local index = ragdoll:EntIndex()
		table.insert(tblRagdolls, ragdoll)
		for _, ragdoll in ipairs(tblRagdolls) do
			if !ragdoll:IsValid() then tblRagdolls[_] = nil end
		end
		table.MakeSequential(tblRagdolls)
		local numRag = #tblRagdolls
		if numRag > 8 then
			for i = 1, numRag -8 do
				tblRagdolls[i]:FadeOut()
				if tblRagdolls[i].BodyParts then
					for _, ent in pairs(tblRagdolls[i].BodyParts) do
						if IsValid(ent) then
							ent:FadeOut()
						end
					end
				end
				tblRagdolls[i] = nil
			end
		end
		local tblBodyParts = {}
		ragdoll.BodyParts = {}
		ragdoll:CallOnRemove("FLT_ClearRagdollHook", function()
			hook.Remove("EntityTakeDamage", "FT_RagdollDamage_ent" .. index)
			for _, ent in pairs(tblBodyParts) do
				if IsValid(ent) then ent:Remove() end
			end
		end)
		local part = self:GetBloodParticle()
		local fcLostLimb = self.OnLimbLost
		local function RemoveLimb(model,dmginfo)
			local data = bodyCaps[model]
			ragdoll.bCrippled = true
			ragdoll:SetBodygroup(data.bodygroup,1)
			local bone = ragdoll:LookupBone(data.boneCap)
			if bone then
				local pos = ragdoll:GetBonePosition(bone)
				local cap = ents.Create("prop_physics")--ragdoll")
				cap:SetModel(model)
				cap:SetPos(pos)
				cap:SetAngles(ragdoll:GetAngles())
				cap:SetSkin(ragdoll:GetSkin())
				cap:SetColor(ragdoll:GetColor())
				cap:SetMaterial(ragdoll:GetMaterial())
				cap:Spawn()
				cap:Activate()
				if(dmginfo) then cap:TakeDamageInfo(dmginfo) end
				cap:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
				cap.parent = ragdoll
				cap:SetNetworkedEntity("ragdoll",ragdoll)
				table.insert(tblBodyParts,cap)
				table.insert(ragdoll.BodyParts,cap)
				cap:EmitSound("fx/fx_flinder_body_bloodspout0" .. math.random(1,6) .. ".wav",75,100)
				local phys = cap:GetPhysicsObject()
				if(dmginfo && phys:IsValid()) then
					phys:SetVelocity(dmginfo:GetDamageForce() *0.5)
				end
				if(fcLostLimb) then fcLostLimb(ragdoll,data.hitbox,cap,dmginfo) end
				gamemode.Call("OnRagdollLostLimb",ragdoll,data.hitbox,cap,dmginfo)
				local numAtt = cap:LookupAttachment(data.att)
				local indexCap = cap:EntIndex()
				if numAtt then
					timer.Create("tm_bloodspout_" .. indexCap,0.1,math.random(10,30),function()
						if cap:IsValid() then
							local posAtt = cap:GetAttachment(numAtt)
							if(posAtt) then util.ParticleEffect(part,posAtt.Pos,posAtt.Ang,cap,data.att,0.3) end
						end
					end)
				end
				if(data.numAtt && data.numAtt != 0) then
					timer.Create("tm_bloodspout_" .. index .. "_" .. indexCap,0.1,math.random(10,30),function()
						if ragdoll:IsValid() then
							local posAtt = ragdoll:GetAttachment(data.numAtt)
							util.ParticleEffect(part,posAtt.Pos,posAtt.Ang,ragdoll,data.att,0.3)
						end
					end)
				end
			else print("Invalid bone '" .. data.boneCap .. "' on " .. tostring(ragdoll) .. ". Unable to create bodycap!") end
		end
		function ragdoll:RemoveLimb(hitbox)
			for mdl, data in pairs(bodyCaps) do
				if(data.hitbox == hitbox) then
					RemoveLimb(mdl)
					return true
				end
			end
			return false
		end
		hook.Add("EntityTakeDamage", "FT_RagdollDamage_ent" .. index, function(ent,dmginfo)
			if ent == ragdoll then
				local posDmg = dmginfo:GetDamagePosition()
				ent:EmitSound("fx/bullet/impact/newflesh/fx_bullet_impact_flesh0" .. math.random(6,9) .. ".wav",75,100)
				local pos = dmginfo:GetDamagePosition()
				local bone
				local distClosest = math.huge
				for i = 0, ent:GetBoneCount() -1 do
					local _pos, _ang = ent:GetBonePosition(i)
					local dist = _pos:Distance(pos)
					if dist < distClosest then bone = i; distClosest = dist end
				end
				if bone then
					for model, data in pairs(bodyCaps) do
						if table.HasValue(data.bones, bone) then
							if data.health > 0 then
								bodyCaps[model].health = math.max(data.health -dmginfo:GetDamage(), 0)
								if bodyCaps[model].health == 0 then
									RemoveLimb(model,dmginfo)
								end
							end
							break
						end
					end
				end
			end
		end)
	else ragdoll:SetCollisionGroup(iKeepRagdolls != 2 && COLLISION_GROUP_INTERACTIVE_DEBRIS || COLLISION_GROUP_DEBRIS) end
	if dmginfo then ragdoll:TakeDamageInfo(dmginfo) end
	gamemode.Call("CreateEntityRagdoll", self, ragdoll)
	if(self.m_tbOnRagDeath) then
		for _, fc in ipairs(self.m_tbOnRagDeath) do
			fc(ragdoll)
		end
	end
	self:Remove()
end

function ENT:GetRagdollEntity()
	return self.ragdoll
end

function ENT:DeleteOnDeath(ent)
	if table.HasValue(self.tblDeleteOnDeathEnts, ent) then return end
	table.insert(self.tblDeleteOnDeathEnts, ent)
	self:DeleteOnRemove(ent)
end

function ENT:DontDeleteOnDeath(ent)
	for k, v in pairs(self.tblDeleteOnDeathEnts) do
		if v == ent then
			table.remove(self.tblDeleteOnDeathEnts,k)
			break
		end
	end
	self:DontDeleteOnRemove(ent)
end

function ENT:OnDeath(dmginfo)
end

function ENT:SetSquad(sSquad)
	if self.sSquad then
		if self.sSquad == sSquad then return end
		for k, v in pairs(self.tblSquadMembers) do
			if IsValid(v) then
				for k, v in pairs(v.tblSquadMembers) do
					if v == self then
						table.remove(v.tblSquadMembers,k)
						break
					end
				end
			end
		end
		self.sSquad = nil
		self.tblSqadMembers = nil
	end
	
	if !sSquad || string.len(sSquad) == 0 then self.sSquad = nil; return end
	self.sSquad = sSquad
	self.tblSquadMembers = {}
	local tblEnts = ents.FindByClass("monster_*")
	table.Add(tblEnts,ents.FindByClass("npc_*"))
	for _, ent in pairs(tblEnts) do
		if ent.bScripted then
			local sSquadEnt = ent:GetSquad()
			if sSquadEnt && sSquadEnt == sSquad && ent != self then
				table.insert(self.tblSquadMembers,ent)
				table.insert(ent.tblSquadMembers,self)
				self:MergeMemory(ent:GetMemory())
				ent:MergeMemory(self:GetMemory())
			end
		end
	end
end

function ENT:GetSquad()
	return self.sSquad
end

function ENT:GetSquadMembers()
	return self.tblSquadMembers || {}
end

function ENT:IsSquadMember(ent)
	return ent:GetSquad() == self:GetSquad()
end

function ENT:DoDeleteOnDeath()
	for k, v in pairs(self.tblDeleteOnDeathEnts) do
		if IsValid(v) then
			v:Remove()
		end
	end
end

local tblDamageTypes = {DMG_ACID, DMG_AIRBOAT, DMG_ALWAYSGIB, DMG_BLAST, DMG_BLAST_SURFACE, DMG_BUCKSHOT,
DMG_BULLET, DMG_BURN, DMG_CLUB, DMG_CRUSH, DMG_DIRECT, DMG_DISSOLVE, DMG_DROWN, DMG_DROWNRECOVER, 
DMG_ENERGYBEAM, DMG_FALL, DMG_GENERIC, DMG_NERVEGAS, DMG_NEVERGIB, DMG_PARALYZE, DMG_PHYSGUN,
DMG_PLASMA, DMG_POISON, DMG_PREVENT_PHYSICS_FORCE, DMG_RADIATION, DMG_REMOVENORAGDOLL, DMG_SHOCK, 
DMG_SLASH, DMG_SLOWBURN, DMG_SONIC, DMG_VEHICLE}
function ENT:GetDamageTypes(dmginfo)
	local _tblDamageTypes = {}
	for k, v in ipairs(tblDamageTypes) do
		if dmginfo:IsDamageType(v) then table.insert(_tblDamageTypes,v) end
	end
	return _tblDamageTypes
end
/*
local _tblDamageTypes = {}
_tblDamageTypes[DMG_ACID] = "DMG_ACID"
_tblDamageTypes[DMG_AIRBOAT] = "DMG_AIRBOAT"
_tblDamageTypes[DMG_ALWAYSGIB] = "DMG_ALWAYSGIB"
_tblDamageTypes[DMG_BLAST] = "DMG_BLAST"
_tblDamageTypes[DMG_BLAST_SURFACE] = "DMG_BLAST_SURFACE"
_tblDamageTypes[DMG_BUCKSHOT] = "DMG_BUCKSHOT"
_tblDamageTypes[DMG_BULLET] = "DMG_BULLET"
_tblDamageTypes[DMG_BURN] = "DMG_BURN"
_tblDamageTypes[DMG_CLUB] = "DMG_CLUB"
_tblDamageTypes[DMG_CRUSH] = "DMG_CRUSH"
_tblDamageTypes[DMG_DIRECT] = "DMG_DIRECT"
_tblDamageTypes[DMG_DISSOLVE] = "DMG_DISSOLVE"
_tblDamageTypes[DMG_DROWN] = "DMG_DROWN"
_tblDamageTypes[DMG_DROWNRECOVER] = "DMG_DROWNRECOVER"
_tblDamageTypes[DMG_ENERGYBEAM] = "DMG_ENERGYBEAM"
_tblDamageTypes[DMG_FALL] = "DMG_FALL"
_tblDamageTypes[DMG_GENERIC] = "DMG_GENERIC"
_tblDamageTypes[DMG_NERVEGAS] = "DMG_NERVEGAS"
_tblDamageTypes[DMG_NEVERGIB] = "DMG_NEVERGIB"
_tblDamageTypes[DMG_PARALYZE] = "DMG_PARALYZE"
_tblDamageTypes[DMG_PHYSGUN] = "DMG_PHYSGUN"
_tblDamageTypes[DMG_PLASMA] = "DMG_PLASMA"
_tblDamageTypes[DMG_POISON] = "DMG_POISON"
_tblDamageTypes[DMG_PREVENT_PHYSICS_FORCE] = "DMG_PREVENT_PHYSICS_FORCE"
_tblDamageTypes[DMG_RADIATION] = "DMG_RADIATION"
_tblDamageTypes[DMG_REMOVENORAGDOLL] = "DMG_REMOVENORAGDOLL"
_tblDamageTypes[DMG_SHOCK] = "DMG_SHOCK"
_tblDamageTypes[DMG_SLASH] = "DMG_SLASH"
_tblDamageTypes[DMG_SLOWBURN] = "DMG_SLOWBURN"
_tblDamageTypes[DMG_SONIC] = "DMG_SONIC"
_tblDamageTypes[DMG_VEHICLE] = "DMG_VEHICLE"
function ENT:GetDamageTypeName(iType)
	return _tblDamageTypes[iType] || "DMG_INVALID"
end*/

function ENT:SetInvincible(bInvincible)
	self.bInvincible = bInvincible == nil || bInvincible
	if self.bInvincible then self:NoCollide("prop_combine_ball")
	elseif !table.HasValue(self.tblIgnoreDamageTypes, DMG_DISSOLVE) then self:Collide("prop_combine_ball") end
end

function ENT:IsInvincible()
	return self.bInvincible
end

function ENT:SetInvincibleToTarget(tgt)
	self.m_tbInvincible = self.m_tbInvincible || {}
	self.m_tbInvincible[tgt] = true
end

function ENT:SetVincibleToTarget(tgt)
	if !self.m_tbInvincible then return end
	self.m_tbInvincible[tgt] = nil
end

function ENT:OnFlinch()
	self:Interrupt()
end

function ENT:DamageHandle(dmginfo,hitgroup)
end

local schdFaceLastPos = ai_schedule_slv.New("FceLP")
schdFaceLastPos:EngTask("TASK_FACE_LASTPOSITION")
function ENT:FacePosition(pos)
	self:Interrupt()
	self:SetLastPosition(pos)
	self:StartSchedule(schdFaceLastPos)
end

function ENT:ScaleDamage(dmginfo, hitgroup)
	--gamemode.Call("ScaleNPCDamage", self, 1, dmginfo)
	if hitgroup == HITBOX_HEAD then
		dmginfo:ScaleDamage(2)
	elseif hitgroup == HITBOX_GEAR then dmginfo:SetDamage(0)
	elseif hitgroup == HITBOX_LEFTARM || hitgroup == HITBOX_RIGHTARM || hitgroup == HITBOX_LEFTLEG || hitgroup == HITBOX_RIGHTLEG || hitgroup == HITBOX_ADDLIMB then
		dmginfo:ScaleDamage(0.25)
	end
end

ENT.Limbs = {
	[HITBOX_RIGHTARM] = "Right Arm",
	[HITBOX_LEFTLEG] = "Left Leg",
	[HITBOX_HEAD] = "Head",
	[HITBOX_RIGHTLEG] = "Right Leg",
	[HITBOX_LEFTARM] = "Left Arm",
	[HITBOX_STOMACH] = HITBOX_CHEST,
	[HITBOX_CHEST] = "Torso"
}

function ENT:GetBodyCaps() return self.BodyCaps end

function ENT:InitBodyCaps()
	local bodyCaps = self:GetBodyCaps()
	self.BodyCaps = bodyCaps
	if(!self.BodyCaps) then return end
	for mdl, data in pairs(self.BodyCaps) do
		util.PrecacheModel(mdl)
	end
end

function ENT:InitLimbs()
	local limbs = self.Limbs
	self.Limbs = {}
	local hpMax = self:Health()
	local health = hpMax *math.Clamp((((2500 -hpMax) /2500) *0.25),0.1,0.25)
	for hitbox, limbName in pairs(limbs) do
		if type(limbName) == "number" then self.Limbs[hitbox] = {parent = limbName}
		else
			self.Limbs[hitbox] = {
				name = limbName,
				health = health
			}
		end
	end
end

function ENT:LimbCrippled(hitbox)
	return self.Limbs[hitbox] && self.Limbs[hitbox].health == 0 && true || false
end

function ENT:OnLimbCrippled(hitbox, attacker)
end

function ENT:IsDead() return self.bDead end

function ENT:IsEssential() return self.Essential end

function ENT:OnSquadMemberDied(ent)
end

local schdFlinch = ai_schedule_slv.New("Hrt")
schdFlinch:EngTask("TASK_SMALL_FLINCH")
function ENT:OnTakeDamage(dmginfo)
	if self.bDead then return end
	if(self:KnockedDown()) then
		if(!self.m_bRagdollDamage) then return end
	elseif(self:Sleeping()) then return end
	local entAttacker = dmginfo:GetAttacker()
	if(/*cvCheat:GetBool() &&*/ entAttacker:IsValid()) then self:AddToMemory(entAttacker) end
	if self:GetAIType() != 1 && !self:IsPossessed() && self:GetState() != NPC_STATE_COMBAT && self.iMemCount == 0 && !self.bInSchedule && entAttacker:IsValid() && self:Disposition(entAttacker) == D_HT then
		if self:GetState() == NPC_STATE_IDLE then
			self:SetState(NPC_STATE_ALERT)
			self:FacePosition(dmginfo:GetDamagePosition())
			self.nextTurnOnDmg = CurTime() +math.Rand(2,4)
		elseif CurTime() >= self.nextTurnOnDmg then
			self:FacePosition(dmginfo:GetDamagePosition())
			self.nextTurnOnDmg = CurTime() +math.Rand(2,4)
		end
	end
	local bAttackerValid = IsValid(entAttacker)
	local sAttackerClass = entAttacker:GetClass()
	
	local entInflictor = dmginfo:GetInflictor()
	local bInflictorValid = IsValid(entInflictor)
	
	local hitgroup = entAttacker:IsPlayer() && self.lastHitGroupDamage
	local fDmg = dmginfo:GetDamage()
	if self.iBloodType && (!hitgroup || hitgroup != HITBOX_GEAR) then
		self:BloodSplash(dmginfo:GetDamagePosition())
		self:BloodDecal(dmginfo)
	end
	
	local bIgnoreDamage
	
	if self.bInvincible || (self.m_tbInvincible && (self.m_tbInvincible[entAttacker] || self.m_tbInvincible[sAttackerClass])) || (bAttackerValid && ((entAttacker:IsNPC() && (entAttacker != self || entInflictor == self) && entAttacker:Disposition(self) >= 3 && !entAttacker:IsPossessed()) || (self.bIgnoreRagdollDamage && sAttackerClass == "prop_ragdoll"))) then bIgnoreDamage = true
	else
		for k, v in ipairs(self.tblIgnoreDamageTypes) do
			if dmginfo:IsDamageType(v) then bIgnoreDamage = true; break end
		end
	end
	if bIgnoreDamage || (self.ShouldTakeDamage && self:ShouldTakeDamage(entAttacker) == false) then
		dmginfo:SetDamage(0)
		dmginfo:SetDamageForce(vector_origin)
	elseif(self.DamageScales) then
		local dmgType = dmginfo:GetDamageType()
		if(self.DamageScales[dmgType]) then
			if(self.DamageScales[dmgType] < 0) then
				local hp = self:Health()
				local hpMax = self:GetMaxHealth()
				self:SetHealth(math.min(hp +fDmg *(self.DamageScales[dmgType] *-1),hpMax))
			end
			dmginfo:ScaleDamage(math.max(self.DamageScales[dmgType],0))
		end
	end
	self:SetGroundEntity(NULL)
	if(GAMEMODE.NPCDamageForce) then
		local force = dmginfo:GetDamageForce()
		if(dmginfo:IsExplosionDamage() || dmginfo:IsBulletDamage() || dmginfo:IsDamageType(DMG_CRUSH) || dmginfo:IsDamageType(DMG_BURN)) then force = force *0.1
		else force = force *10 end
		local ragdoll = self:GetRagdollEntity()
		if(IsValid(ragdoll)) then ragdoll:AddVelocity(force)
		else self:SetVelocity(force) end
	end;
	
	if !self:DamageHandle(dmginfo,hitgroup) && hitgroup then self:ScaleDamage(dmginfo, hitgroup) end
	--if self.fDamageScale != 1 then dmginfo:ScaleDamage(self.fDamageScale); gamemode.Call("ScaleNPCDamage", self, 1, dmginfo) end
	local health = self:Health()
	local dmg = dmginfo:GetDamage()
	self:SetHealth(health -dmg)

	if (self.entPossessor) then
    	self.entPossessor:SetHealth(self:Health())
    end

	local dmgTaken = math.min(health,dmg)
	gamemode.Call("OnNPCTakeDamage",self,dmgTaken,dmginfo,hitgroup || HITBOX_GENERIC)
	self:OnDamaged(health,self:Health(),dmgTagen,entAttacker,entInflictor,dmginfo)
	if self.OnHalfHealth then
		local healthHalf = self:GetMaxHealth() *0.5
		if self:Health() <= healthHalf && health > healthHalf then self:OnHalfHealth() end
	end
	--self:SetNetworkedInt("health", self:Health())
	
	if self:Health() <= 0 then
		if(self:IsEssential()) then
			self:SetHealth(self:GetMaxHealth())
			self:KnockDown(12)
			return
		end

		if (self.entPossessor) then
        	self.entPossessor:Kill()
        end

		self:OnDeath(dmginfo)
		self:DoDeleteOnDeath()
		for k, v in pairs(self.tblCSPStopOnDeath) do
			v:Stop()
		end
		self.bDead = true
		self:StopParticles()
		gamemode.Call("OnNPCKilled",self,entAttacker,entInflictor,dmginfo)
		if(entAttacker:IsNPC() && entAttacker.OnKilledTarget) then entAttacker:OnKilledTarget(self) end
		self:PlaySound("Death")

		if entAttacker:IsPlayer() then
			entAttacker:AddFrags(1)
		end
		for _, ent in pairs(self:GetSquadMembers()) do
			if(ent:IsValid()) then ent:OnSquadMemberDied(self) end
		end
		self:DoDeath(dmginfo)
		if self.m_tbOnDeath then
			for _, fc in ipairs(self.m_tbOnDeath) do
				fc()
			end
			self.m_tbOnDeath = nil
		end
	elseif dmginfo:GetDamage() > 0 then
		local hitGroup = self.lastHitGroupDamage
		local bCrippled
		if entAttacker:IsPlayer() then --&& self.Limbs[hitGroup] && self.Limbs[hitGroup].health > 0 then
			bCrippled = self:TakeLimbDamage(hitGroup, dmginfo:GetDamage(), dmginfo:GetAttacker())
			if self.nHostileOnDamage then
				local disp = self:Disposition(entAttacker)
				if disp == D_LI || disp == D_NU then
					self.tblHostilePlayers[entAttacker] = (self.tblHostilePlayers[entAttacker] && self.tblHostilePlayers[entAttacker] != self.nHostileOnDamage && self.tblHostilePlayers[entAttacker] || 0) +1
					local numDmg = self.tblHostilePlayers[entAttacker]
					if numDmg == self.nHostileOnDamage then
						if self:GetBehavior() == 1 && self.entFollow == entAttacker then
							self:SetBehavior(0)
						end
						self:AddEntityRelationship(entAttacker,1,10)
						self:OnTurnedHostileToAlliedPlayer(entAttacker,dmginfo)
					end
					self:OnDamagedByAlliedPlayer(entAttacker,dmginfo,numDmg)
				end
			end
		end
		self.iDmgCount = self.iDmgCount +math.random(0,2)
		local bTorsoCrippled = self:LimbCrippled(HITBOX_CHEST) || self:LimbCrippled(HITBOX_STOMACH) || self:LimbCrippled(HITGROUP_CHEST) || self:LimbCrippled(HITGROUP_STOMACH)
		if self.bFlinchOnDamage && (self.iDmgCount >= (bTorsoCrippled && 3 || 6) || dmginfo:IsDamageType(DMG_BLAST) || bCrippled) then
			self.iDmgCount = 0
			if CurTime() >= self.nextFlinch && math.random(1,3) < 3 || bCrippled then
				if self.CustomFlinch then self:CustomFlinch(dmginfo,entAttacker:IsPlayer() && self.lastHitGroupDamage || HITBOX_GENERIC)
				else
					self:StopMoving()
					local hitgroup = entAttacker:IsPlayer() && self.lastHitGroupDamage || HITBOX_GENERIC
					if self.tblFlinchActivities && table.Count(self.tblFlinchActivities) > 0 then self:Flinch(hitgroup)
					else self:StartSchedule(schdFlinch) end
					self:PlaySound("Pain")
					self:OnFlinch(entAttacker,hitgroup)
				end
			end
			self.nextFlinch = CurTime() +(bTorsoCrippled && math.Rand(1,6) || math.Rand(3,12))
		end
	end
end

function ENT:ShouldKnockDown(attacker) return true end

function ENT:OnDamaged(healthOld,healthNew,dmgTagen,attacker,inflictor,dmgInfo)
end

function ENT:CrippleLimb(hitgroup,attacker)
	local limb = self.Limbs[hitgroup]
	if(limb) then
		local hg = hitgroup
		if(limb.parent) then hg = limb.parent; limb = self.Limbs[limb.parent] end
		if(limb.health > 0) then
			limb.health = 0
			gamemode.Call("OnEntityLimbCrippled",self,hg,attacker)
			self:OnLimbCrippled(hg,attacker)
		end
	end
end

function ENT:TakeLimbDamage(hitgroup, dmg, attacker)
	local bCrippled
	local limb = self.Limbs[hitgroup]
	if limb then
		local hg = hitgroup
		if limb.parent then hg = limb.parent; limb = self.Limbs[limb.parent] end
		if limb.health > 0 then
			local health = math.max(limb.health -dmg, 0)
			self.Limbs[hg].health = health
			if health == 0 then
				gamemode.Call("OnEntityLimbCrippled",self,hg,attacker)
				bCrippled = true
				self:OnLimbCrippled(hg,attacker)
			end
		end
	end
	return bCrippled || false
end

function ENT:GetLimbName(hitgroup)
	return self.Limbs[hitgroup].name
end

function ENT:OnDamagedByAlliedPlayer(pl,dmginfo,nTimesShot)
end

function ENT:OnTurnedHostileToAlliedPlayer(pl,dmginfo)
end

function ENT:DoDeath(dmginfo)
	if self:KnockedDown() then self:DoRagdollDeath(dmginfo); return end
	local attacker = dmginfo:GetAttacker()
	if (!IsValid(attacker) || attacker:GetClass() != "npc_barnacle") && !dmginfo:IsDamageType(DMG_DISSOLVE) then
		if self.bExplodeOnDeath then self:DoExplode(); return end
		self:SetNPCState(NPC_STATE_DEAD)
		self:SetState(NPC_STATE_DEAD)
		if self.bFadeOnDeath then self:FadeOut(4) end
		local bRagdoll = util.IsValidRagdoll(self:GetModel())
		if self.bPlayDeathSequence then
			if((bRagdoll && (self.BodyCaps && true || tobool(GetConVarNumber("ai_serverragdolls")))) || self.UseRagdollPhysicsProp) then self:DoRagdollDeath(dmginfo)
			else
				//self:SetSchedule(SCHED_DIE)
				local bMoving = self:IsMoving()
				if bMoving && !self.m_bForceDeathAnim && (!self.DeathActChance || math.random(1,100) > self.DeathActChance) then
					if bRagdoll then self:SetSchedule(SCHED_DIE_RAGDOLL)
					else
						self:SetSchedule(SCHED_DIE)
						if !self.bSpecialDeath then
							timer.Simple(0.1,function()
								if !IsValid(self) then return end
								self:FadeOut(self:SequenceDuration() -0.1)
							end)
						end
					end
				else
					if bMoving then self:StopMoving(); self:StopMoving() end
					if !IsValid(attacker) || !attacker:IsPlayer() || !self.lastHitGroupDamage || (!self.tblDeathActivities[self.lastHitGroupDamage] && !self.tblDeathActivities[HITGROUP_GENERIC] && !self.tblDeathActivities[HITBOX_GENERIC]) then self:SetSchedule(SCHED_DIE)
					else
						local act = self.tblDeathActivities[self.lastHitGroupDamage] || self.tblDeathActivities[HITGROUP_GENERIC] || self.tblDeathActivities[HITBOX_GENERIC]
						if type(act) == "table" then act = table.Random(act) end
						local SCHED_DIE = ai_schedule_slv.New("Die")
						SCHED_DIE:EngTask("TASK_PLAY_SEQUENCE", act)
						self:StartSchedule(SCHED_DIE)
					end
					if !self.bSpecialDeath then
						timer.Simple(0.1,function()
							if !IsValid(self) then return end
							if bRagdoll then
								timer.Simple(self:SequenceDuration() -0.1, function()
									if !IsValid(self) then return end; self:DoRagdollDeath(dmginfo)
								end)
							elseif !self.bSpecialDeath then
								self:FadeOut(self:SequenceDuration() -0.1)
							end
						end)
					end
				end
			end
		elseif(bRagdoll || self.UseRagdollPhysicsProp) then self:DoRagdollDeath(dmginfo) end
		if self.bRemoveOnDeath then self:Remove() end
	elseif dmginfo:IsDamageType(DMG_DISSOLVE) then
		if self:Disposition(attacker) == D_LI then self:Dissolve(nil, nil, 0) end
		if self.bRemoveOnDeath then self:Remove(); return end
		self:SetNPCState(NPC_STATE_DEAD)
		self:SetState(NPC_STATE_DEAD)
		self:SetSchedule(SCHED_DIE_RAGDOLL)
	end
end

function ENT:GetMainRagdollBone()
	return self.ragdoll:LookupBone(self.BoneRagdollMain)
end

function ENT:GetUpAngle()
	local pos,ang = self.ragdoll:GetBonePosition(self:GetMainRagdollBone())
	return ang
end

function ENT:GetSoundDir() return self.sSoundDir end

function ENT:IsInIdlePosture() return self.m_tbPosture && true || false end

function ENT:StartIdlePosture(actIn,actOut)
	if(self:IsInIdlePosture()) then return end
	self.m_tbPosture = {
		iAlertRandom = self.iAlertRandom,
		bFlinchOnDamage = self.bFlinchOnDamage,
		UseIdleSystem = self.UseIdleSystem
	}
	self.m_iPostureActOut = actOut
	self.iAlertRandom = nil
	self.bFlinchOnDamage = false
	self.UseIdleSystem = false
	self.bInSchedule = true
	self:PlayActivity(actIn)
end

function ENT:EndIdlePosture()
	if(!self:IsInIdlePosture()) then return end
	for key, val in pairs(self.m_tbPosture) do
		self[key] = val
	end
	self.m_tbPosture = nil
	self.bInSchedule = false
	self:PlayActivity(self.m_iPostureActOut)
	self.m_iPostureActOut = nil
	self:OnIdlePostureEnded()
end

function ENT:OnIdlePostureEnded() end

function ENT:HandleDefaultEvents(...)
	local event = select(1,...)
	if(event == "getup") then
		if(IsValid(self.ragdoll)) then
			local angR = self:GetUpAngle()
			local pos, ang = self:GetBonePosition(self:LookupBone(self.BoneRagdollMain))
			local angNew = self:GetAngles()
			angNew.y = angNew.y +(angR.y -ang.y)
			self:SetAngles(angNew)
			
			self.ragdoll:DontDeleteOnRemove(self)
			self.ragdoll:Remove()
		end
		self:DropToFloor()
		self.m_bKnockedDown = false
		self.m_actGetUp = nil
		self.ragdoll = nil
		self:Wake()
		return true
	end
	if(event == "play") then
		if(self:Sleeping()) then return true end
		local sndEv = select(2,...)
		if(sndEv) then
			if(string.Right(sndEv,4) != ".wav") then self:PlaySound(sndEv)//,true,true)
			else
				local snd = self:GetSoundDir() .. sndEv
				sound.Play(snd,self:GetPos(),75,self:GetSoundPitch())
			end
		end
		return true
	end
	if(event == "emit") then
		if(self:Sleeping()) then return true end
		local sndEv = select(2,...)
		if(!sndEv) then return true end
		local vol = select(3,...)
		local pitch = select(4,...)
		if(string.Right(sndEv,4) != ".wav") then
			local sndEvents = self:GetSoundEvents()
			if(!sndEvents[sndEv]) then return true end
			local sndType = type(sndEvents[sndEv])
			if(sndType == "string") then self:EmitSound(self:GetSoundDir() .. sndEvents[sndEv],vol || 75,pitch || self:GetSoundPitch())
			else self:EmitEventSound(sndEv,vol,pitch) end
		else self:EmitSound(self:GetSoundDir() .. sndEv,vol || 75,pitch || 100) end
		return true
	end
	if(event == "dropdead") then
		self:DoRagdollDeath()
		return true
	end
	if(event == "skin") then
		local skin = select(2,...)
		if(skin) then
			skin = tonumber(skin)
			if(skin) then self:SetSkin(skin) end
		end
		return true
	end
	if(event == "bodygroup") then
		local bgroup = select(2,...)
		local subgroup = select(3,...)
		if(bgroup && subgroup) then
			bgroup = tonumber(bgroup)
			subgroup = tonumber(subgroup)
			if(bgroup && subgroup) then
				self:SetBodygroup(bgroup,subgroup)
			end
		end
		return true
	end
	if(event == "run") then
		self:SetMovementActivity(ACT_RUN)
		return true
	end
	if(event == "activity") then
		local evAct = select(2,...)
		local act = tonumber(evAct) || _G[evAct]
		if(act) then self:PlayActivity(act) end
		return true
	end
	if(event == "resetactivity") then
		self:ResetActivity()
		return true
	end
	if(event == "task") then
		local task = select(2,...)
		local act = select(3,...)
		self:StartEngineTask(GetTaskID(task),_G[act])
		return true
	end
	if(event == "stopparticles") then
		self:StopParticles()
		return true
	end
	return false
end

local argsDef = {}
function ENT:Event(strEv)
	local sp = string.find(strEv,"%s")
	local evEnd = sp || string.find(strEv,"$")
	local event = string.Left(strEv,evEnd -1)
	local args
	if(sp) then
		args = string.sub(strEv,sp +1)
		args = string.Explode(",",args)
	else args = argsDef end
	//print("Handling event '" .. event .. "'" .. (args && ("('" .. table.concat(args,"','") .. "')") || "") .. " for " .. tostring(self) .. "...")
	if(!self:EventHandle(event,unpack(args)) && !self:HandleDefaultEvents(event,unpack(args))) then
		MsgN("WARNING: Unhandled animation event '" .. event .. "'" .. (args && ("('" .. table.concat(args,"','") .. "')") || "") .. " for " .. tostring(self))
	end
end

function ENT:EventHandle(...)
	//local event = select(1,...)
	//local arg1 = select(2,...)
	//local arg2 = select(3,...)
	//etc
end

function ENT:GetSentenceLength(sSentence)
	sSentence = string.Replace(sSentence,"!","")
	local content = file.Read("scripts/sentences.txt",true)
	local iSenStart = string.find(content,sSentence)
	if !iSenStart then return 0 end
	local iLenStart = string.find(content,"Len ",iSenStart) +4
	local iLenEnd = string.find(content,"}",iLenStart) -1
	local iLenEndB = string.find(content,"%s",iLenStart)
	if iLenEndB && iLenEndB < iLenEnd then
		iLenEnd = iLenEndB -1
	end
	local fLength = string.sub(content,iLenStart,iLenEnd)
	fLength = tonumber(fLength)
	return fLength
end

function ENT:SpeakSentence(sSentence, entListener, fcDone, entSpeaker, iRadius, iVolume, iAttenuation, bRepeat, bInterrupt, bConcurrent, bToActivator)
	entSpeaker = entSpeaker || self
	entListener = entListener || self
	
	local entSentenceScript = ents.Create("scripted_sentence")
	entSentenceScript:SetPos(self:GetPos())
	entSentenceScript:SetKeyValue("sentence", sSentence)
	local sSpeaker
	if entSpeaker:GetName() == "" then sSpeaker = entSpeaker:GetClass()
	else sSpeaker = entSpeaker:GetName() end
	entSentenceScript:SetKeyValue("entity", sSpeaker)

	local sListener
	if entListener:GetName() != "" and !entListener:IsPlayer() then sListener = entListener:GetName()
	else sListener = entListener:GetClass() end
	entSentenceScript:SetKeyValue("listener", sListener)
	entSentenceScript:SetKeyValue("radius", iRadius || 2)
	entSentenceScript:SetKeyValue("volume", iVolume || 10)
	entSentenceScript:SetKeyValue("attenuation", iAttenuation || self:GetSpeakAttenuation())
	
	local iSpawnflags = 0
	if !bRepeat then iSpawnflags = iSpawnflags +1 end
	if bInterrupt then iSpawnflags = iSpawnflags +4 end
	if bConcurrent then iSpawnflags = iSpawnflags +8 end
	if bToActivator then iSpawnflags = iSpawnflags +16 end
	entSentenceScript:SetKeyValue("spawnflags", iSpawnflags)
	
	if fcDone then
		timer.Simple(self:GetSentenceLength(sSentence), function() if IsValid(self) then fcDone() end end)
	end
	
	entSentenceScript:Spawn()
	entSentenceScript:Activate()
	entSentenceScript:Fire("BeginSentence", "", 0)
	entSentenceScript:Fire("kill", "", 0.1)
end

/*---------------------------------------------------------
   Name: AcceptInput
   Desc: Accepts input, return true to override/accept input
---------------------------------------------------------*/
function ENT:AcceptInput(cvar,activator,caller,data)
	if(activator == self && string.Left(cvar,6) == "event_") then
		self:Event(string.sub(cvar,7))
		return true
	end
	cvar = string.lower(cvar)
	if(cvar == "setsquad") then
		self:SetSquad(data)
		return true
	end
	if(cvar == "use") then
		self:OnUse(activator,caller,SIMPLE_USE)
		return true
	end
	return self:InputHandle(cvar,activator,caller,data)
end

function ENT:InputHandle(cvar,activator,caller,data)
	return false
end

// ENT.Use is a function in the meta table now (gm13), so we'll have to call it something else.
function ENT:OnUse(activator,caller,type,value)
end

function ENT:StartTouch(ent)
end

function ENT:EndTouch(ent)
end

function ENT:Touch(ent)
end

function ENT:GetRelationship(ent)
	//return self:Disposition(ent)
end

function ENT:SetEntityRelationship(ent,disp)
	self:AddEntityRelationship(ent,disp,100)
end

function ENT:SetRelationship(ent,disp)
	self:AddEntityRelationship(ent,disp,100)
end

function ENT:ExpressionFinished(strExp)
end

function ENT:UpdateNPCState()
	local state = self:GetNPCState(true)
	if state != NPC_STATE_COMBAT && state != NPC_STATE_DEAD then self:SetNPCState(NPC_STATE_COMBAT) end
end

function ENT:UpdatePath()
	if self.pathObj then--&& CurTime() -self.nextPathGenSteps >= 0 then
		--self.nextPathGenSteps = CurTime() +0.1
		local path, bFailed
		for i = 1, 5 do
			local bFinished, bWorked, _path, nStatus = astar.Step(self.pathObj)
			if bFinished then
				path = _path
				bFailed = !bWorked
				break
			end
		end
		if path then
			self.pathObj = nil
			local tTarget = self.pathObjTgt
			self.pathObjTgt = nil
			local _path = {}
			for i = #path, 1, -1 do
				_path[(#path +1) -i] = path[i]
			end
			--local nodeCur = nodegraph.GetClosestNode(self:GetPos(), iAIType,util.GetMoveHull(self:GetHullType()))
			if self.currentNodePos && self.currentPath && #self.currentPath > 0 then --self.currentNodePos
				local b = false
				for k, node in pairs(_path) do
					if node.pos == self.currentNodePos then
						for i = 1, k -1 do
							table.remove(_path, 1) -- Improving path in case NPC has moved since astar object was created
						end
						b = true
						break
					end
				end
				if b then
					self.currentPath = _path -- Path is valid. Setting current path to new path
					self:ImprovePath()
				else self:GeneratePath(tTarget); self.currentNodePos = nil; return end -- Path is invalid (Current node doesn't exist in path?), regenerating
			else
				self.currentPath = _path -- Path is valid. Setting current path to new path
				self:ImprovePath()
				self.currentNodePos = nil
				self.currentPathTime = nil
				self.estimPathArrival = nil
			end
			if bFailed then
				self.currentPath = nil
				if tTarget && type(tTarget) != "Vector" then
					self:SetState(NPC_STATE_LOST)
					self:RemoveFromMemory(tTarget)
					self:OnLostEnemy(tTarget)
				end -- Failed to generate path, removing enemy from memory
				return
			end
		end
	end
end

function ENT:SetActivitySchedule(act)
	self.bInSchedule = act
end

function ENT:AttackMove(act, duration)
	self.actReset = self:GetMovementActivity()
	self:SetMovementActivity(act)
	self.bInSchedule = true
	timer.Simple(duration, function()
		if IsValid(self) then
			if self.actReset then
				self:SetMovementActivity(self.actReset)
				self.actReset = nil
			end
			self.bInSchedule = false
		end
	end)
end

function ENT:OnMovementBlocked(ent)
	if(self.CurrentSchedule) then return end
	local pos = self:GetPos()
	local posEnt = ent:GetPos()
	posEnt.z = pos.z
	local dir = (posEnt -pos):GetNormal()
	dir:Rotate(Angle(0,90,0))	-- TODO: Randomize direction? (90/-90)
	self:MoveToPosDirect(pos +dir *80)	-- Try to move out of the way
end

function ENT:LastTimeMoved() return self.m_lastTimeMoved end

function ENT:AddBlockedNodeLink(nodeSrc,nodeTgt)
	self.m_tbNodesBlocked[nodeSrc] = self.m_tbNodesBlocked[nodeSrc] || {}
	self.m_tbNodesBlocked[nodeSrc][nodeTgt] = true
	self.m_tbNodesBlockedTimed[nodeSrc] = CurTime() +30 -- Automatically clear all links to this node if no links have been blocked within the last 20 seconds (We're assuming the path has cleared by now). Crude, but it works.
end

function ENT:MarkNodeLinksAsClear(nodeID)
	self.m_tbNodesBlocked[nodeID] = nil
	self.m_tbNodesBlockedTimed[nodeID] = nil
end

function ENT:ClearBlockedLinks()
	self.m_tbNodesBlocked = {}
	self.m_tbNodesBlockedTimed = {}
end

function ENT:MarkCurrentLinkAsBlocked()
	if(!self.currentPath || !self.currentPath[2]) then return end
	local IDCur = self.currentPath[1].ID
	local IDNext = self.currentPath[2].ID
	self:AddBlockedNodeLink(IDCur,IDNext)
	self.currentPath = nil
	self.pathObj = nil
	self.pathObjTgt = nil
end

function ENT:StopCustomMovement()
	self.m_tMoveCTimeOut = nil
	self.m_MoveCPos = nil
	if(self.CurrentSchedule && self.CurrentSchedule.Name == "CustomMove") then
		self:CancelCurrentSchedule()
		self:StopMoving()
	end
end

function ENT:FindClearMovementDirection()
	local pos = self:GetPos()
	local mins = self:OBBMins()
	local maxs = self:OBBMaxs()
	local dir = self:GetForward()
	local dist = maxs.x +32
	local tr = util.TraceHull({
		start = pos,
		endpos = pos +dir *dist,
		mins = mins,
		maxs = maxs,
		filter = self,
		mask = MASK_NPCWORLSTATIC
	})
	if(!tr.Hit) then return dir end
	local posHit
	if(tr.HitWorld || !IsValid(tr.Entity)) then posHit = tr.HitPos
	else posHit = tr.Entity:NearestPoint(tr.HitPos) end
	local trBack = util.TraceHull({
		start = pos,
		endpos = pos -dir *dist,
		mins = mins,
		maxs = maxs,
		filter = self,
		mask = MASK_NPCWORLSTATIC
	})
	local dirRight = self:GetRight()
	local trRight = util.TraceHull({
		start = pos,
		endpos = pos +dirRight *dist,
		mins = mins,
		maxs = maxs,
		filter = self,
		mask = MASK_NPCWORLSTATIC
	})
	local trLeft = util.TraceHull({
		start = pos,
		endpos = pos -dirRight *dist,
		mins = mins,
		maxs = maxs,
		filter = self,
		mask = MASK_NPCWORLSTATIC
	})
	if(trBack.Fraction == 1 || (trBack.Fraction > trRight.Fraction && trBack.Fraction > trLeft.Fraction)) then return trBack.Normal end
	if(trRight.Fraction == 1 && trLeft.Fraction == 1) then return math.random(1,2) == 1 && trRight.Normal || trLeft.Normal end
	if(trRight.Fraction > trLeft.Fraction) then return trRight.Normal end
	return trLeft.Normal
end

function ENT:Think()
	local tmThink = CurTime() -self.m_lastThink
	self.m_lastThink = CurTime()
	local ent = self:GetBlockingEntity()
	if(IsValid(ent)) then
		self:OnMovementBlocked(ent)
	end
	if(self.CurrentSchedule) then
		local pos = self:GetPos()
		if(pos != self.m_posLast) then
			if(self.m_lastPosCheck) then
				local tmDiff = CurTime() -self.m_lastPosCheck
				local posDiff = pos -self.m_posLast
				self.m_velLast = posDiff /tmDiff
			end
			self.m_lastTimeMoved = CurTime()
		else self.m_velLast = vector_origin end
		self.m_lastPosCheck = CurTime()
		self.m_posLast = pos
	end
	for ID,tm in pairs(self.m_tbNodesBlockedTimed) do
		if(CurTime() >= tm) then
			self:MarkNodeLinksAsClear(ID)
		end
	end
	if(self:Paralyzed()) then if(CurTime() >= self.paralyze) then self:StopParalyzation() end
	elseif(self:KnockedDown()) then
		if(self.m_tGetUp) then
			if(CurTime() >= self.m_tGetUp) then
				local ragdoll = self:GetRagdollEntity()
				if(!IsValid(ragdoll)) then
					self:StandUp()
					self.m_tGetUp = nil
				elseif(ragdoll:GetVelocity():Length() <= 30) then
					local start = ragdoll:GetPos()
					local endpos = start -Vector(0,0,self:OBBMaxs().z +20)
					local tr = util.TraceLine({
						start = start,
						endpos = endpos,
						mask = MASK_SOLID_BRUSHONLY
					})
					if(tr.Hit) then
						self:StandUp()
						self.m_tGetUp = nil
					end
				end
			end
		elseif(self:GetActivity() != self.m_actGetUp) then
			self:PlayActivity(self.m_actGetUp)
		end
		return self:OnThink()
	end
	if self.m_MoveCPos then
		local bSel
		if(!self.CurrentSchedule) then bSel = true; self:SelectSchedule() end
		if CurTime() >= self.m_tMoveCTimeOut then
			self.m_MoveCPosOverride = nil
			self:StopCustomMovement()
			if(!self.CurrentSchedule && !bSel) then self:SelectSchedule() end
		end
		if(self.m_MoveCPos && (!self.CurrentSchedule || self.CurrentSchedule.bForceSelSched || self.CurrentSchedule.Name == "CustomMove")) then
			if(self.currentPath) then self:ImprovePath() end
			local posMove = self.m_MoveCPosOverride || self.m_MoveCPos
			self:SetLastPosition(posMove)
			local schdChase = ai_schedule_slv.New("CustomMove")
			schdChase:EngTask("TASK_PLAY_SEQUENCE",self:GetMovementActivity())
			schdChase.bForceSelSched = true
			//self:StartEngineTask(GetTaskID("TASK_RESET_ACTIVITY"),0)
			self:StartSchedule(schdChase)
			local pos = self:GetPos()
			local dirTgt = (posMove -pos):GetNormal()
			
			/*local dir = self:GetForward()
			local dotProd = dir:DotProduct(dirTgt)
			if(dotProd <= 0) then
				--self:ImprovePath()
				Entity(1):ChatPrint("Passed target position?")
				MsgPrint("Distance to target position: ",self:NearestPoint(posMove):Distance(posMove))
				local node = self.currentPath[1]
				util.CreateSpriteTrace(node.pos,node.pos +Vector(0,0,260),1,50,Color(0,0,255,255))
				local nodeNext = self.currentPath[2]
				if(nodeNext) then
					util.CreateSpriteTrace(node.pos +Vector(0,0,260),nodeNext.pos +Vector(0,0,260),1,50,Color(0,255,0,255))
				end
			end
			util.CreateSpriteTrace(posMove,posMove +Vector(0,0,260),1,50,Color(255,0,0,255))*/
			
			local angTgt = dirTgt:Angle()
			local ang = self:GetAngles()
			local speedYaw = self:GetMaxYawMoveSpeed() *tmThink *10
			self:SetAngles(Angle(0,math.ApproachAngle(ang.y,angTgt.y,speedYaw),0))
			if(CurTime() -self:LastTimeMoved() >= 0.2) then
				if(!self.m_tmStuck) then self.m_tmStuck = CurTime()
				else
					local tmStuck = CurTime() -self.m_tmStuck
					if(tmStuck >= 0.2) then
						self.m_tmStuck = nil
						self:MarkCurrentLinkAsBlocked()
						self:StopCustomMovement()
						//if(tmStuck >= 0.4) then
							local dir = self:FindClearMovementDirection()
							self.m_MoveCPosOverride = self:GetPos() +dir *(self:OBBMaxs().x +250)
							self.m_tMoveCTimeOut = CurTime() +0.2
							//self:MoveFacing(self:GetPos() +dir *(self:OBBMaxs().x +250))
						//end
					end
				end
			else self.m_tmStuck = nil end
		end
	else self.m_tmStuck = nil end
	if(self.m_moveTo) then
		if(self:NearestPoint(self.m_moveTo.pos):Distance(self.m_moveTo.pos) <= self.m_moveTo.dist) then self.m_moveTo = nil
		else self:MoveToPos(self.m_moveTo.pos,self.m_moveTo.walk) end
	end
	--if self.bInSchedule && self:GetActivity() != self.bInSchedule then self:Interrupt() end
	if(CurTime() >= self.m_nextUpdate) then
		self.m_nextUpdate = CurTime() +0.1
		self:UpdatePath()
		self:UpdateNPCState()
	end
	if(self.m_MoveCPos) then
		self:NextThink(CurTime() +0.1)
		self:OnThink()
		return true
	end
	return self:OnThink()
end

function ENT:OnThink()
	self:UpdateLastEnemyPositions()
	self:MaintainAnimations()
end

function ENT:GetAttackSpread(Weapon, Target)
	return 0.1
end

util.AddNetworkString("slv_npc_soundtrack")
function ENT:PlaySoundtrack()
	net.Start("slv_npc_soundtrack")
		net.WriteEntity(self)
	net.Broadcast()
end