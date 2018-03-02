
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

local schdRunToLastPosition = ai_schedule_slv.New("RnLP")
schdRunToLastPosition:EngTask("TASK_GET_PATH_TO_LASTPOSITION")
schdRunToLastPosition:AddTask("TASK_RUN_PATH")
schdRunToLastPosition:EngTask("TASK_WAIT_FOR_MOVEMENT")

local schdWalkToLastPosition = ai_schedule_slv.New("WlkLP") 
schdWalkToLastPosition:EngTask("TASK_GET_PATH_TO_LASTPOSITION")
schdWalkToLastPosition:AddTask("TASK_WALK_PATH")
schdWalkToLastPosition:EngTask("TASK_WAIT_FOR_MOVEMENT")

AccessorFunc(ENT,"m_dontEndOnUse","DontStopOnUse",FORCE_BOOL)
function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01_chunk02c.mdl")
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self.bActive = false
	if(self.m_dontEndOnUse == nil) then self.m_dontEndOnUse = false end
	self.nextSprint = 0
end

function ENT:SetPossessor(ent)
	self.entPossessor = ent
end

util.AddNetworkString("slv_possessor_start")
function ENT:StartPossession()
	if self.bActive then self:EndPossession() end
	self.entCam = ents.Create("obj_target")
	local pos = self.entTarget.possOffset && self.entTarget:LocalToWorld(self.entTarget.possOffset) || (self.entTarget:GetPos() +self.entTarget:OBBCenter() +Vector(0,0,self.entTarget:OBBMaxs().z *0.5))
	self.entCam:SetPos(pos)
	self.entCam:SetParent(self.entTarget)
	self.entCam:Spawn()
	if self.entTarget:LookupAttachment("possession_cam") > 0 then
		self.entCam:Fire("SetParentAttachment", "possession_cam", 0)
	end
	self:DeleteOnRemove(self.entCam)
	
	self.iHealthTarget = self.entTarget:Health()
	local class = self.entTarget:GetClass()
	net.Start("slv_possessor_start")
		net.WriteString(class)
		net.WriteUInt(self.entTarget:GetMaxHealth(),20)
		net.WriteUInt(self.iHealthTarget,20)
	net.Send(self.entPossessor)
	self.entPossessor.entPossessionManager = self
	self.entPossessor.bInPossessionMode = true
	self.entPossessor.entPossessionCam = self.entCam
	self.entPossessor.entPossessing = self.entTarget
	self.entPossessor:Spectate(OBS_MODE_CHASE)
	self.entPossessor:SetMaterial("player_invis")
	self.entPossessor:DrawViewModel(false)
	self.entPossessor:DrawWorldModel(false)
	self.entPossessor:UnFreeze()
	//self.entPossessor:CrosshairDisable()
	
	self.entPossessor:SpectateEntity(self.entCam)
	self.entPossessor:SetMoveType(MOVETYPE_OBSERVER)
	self.entTarget.entPossessor = self.entPossessor
	self.entTarget:ClearPoseParameters()
	
	self.tblPlayer = {}
	self.tblPlayer["Health"] = self.entPossessor:Health()
	self.tblPlayer["Armor"] = self.entPossessor:Armor()
	local wep = self.entPossessor:GetActiveWeapon()
	if(IsValid(wep)) then self.tblPlayer["ActiveWeapon"] = wep:GetClass() end
	self.tblPlayer["Weapons"] = {}
	for k, v in pairs(self.entPossessor:GetWeapons()) do
		table.insert(self.tblPlayer["Weapons"],v:GetClass())
	end
	self.entPossessor:StripWeapons()
	
	self.bActive = true
	if self.entTarget._PossStart then self.entTarget:_PossStart(self.entPossessor) end
	self.nextHealthRegen = CurTime() +2
end

util.AddNetworkString("slv_possessor_end")
function ENT:EndPossession()
	if IsValid(self.entPossessor) then
		net.Start("slv_possessor_end")
		net.Send(self.entPossessor)
		self.entPossessor:UnSpectate()
		self.entPossessor:SetMaterial()
		self.entPossessor:DrawViewModel(true)
		self.entPossessor:DrawWorldModel(true)
		//self.entPossessor:CrosshairEnable()
		self.entPossessor.entPossessing = nil
		self.entPossessor.bInPossessionMode = false
		self.entPossessor.entPossessionCam = nil
		self.entPossessor.entPossessionManager = nil
		
		self.entPossessor:SetMoveType(MOVETYPE_OBSERVER)
		
		local pos = self.entPossessor:GetPos()
		self.entPossessor:KillSilent()
		self.entPossessor:Spawn()
		if IsValid(self.entTarget) then
			pos = self.entTarget:GetPos() +Vector(0,0,self.entTarget:OBBMaxs().z +20)
		end
		self.entPossessor:SetPos(pos)
		for k, v in pairs(self.tblPlayer["Weapons"]) do
			self.entPossessor:Give(v)
		end
		if(self.tblPlayer["ActiveWeapon"]) then self.entPossessor:SelectWeapon(self.tblPlayer["ActiveWeapon"]) end
		//self.entPossessor:SetHealth(self.tblPlayer["Health"])
		//self.entPossessor:SetArmor(self.tblPlayer["Armor"])
	end
	
	if IsValid(self.entCam) then self.entCam:Remove() end
	if IsValid(self.entTarget) then
		if self.entTarget._PossEnd then self.entTarget:_PossEnd(self.entPossessor) end
		self.entTarget.bPossessed = false
		self.entTarget.entPossessor = nil
		self.entTarget._PossScheduleDone = nil
	end
	self.bActive = false
	
	self.tblPlayer = nil
	gamemode.Call("OnPossessionEnd",self.entPossessor,self.entTarget)
	self:Remove()
end

function ENT:SetTarget(ent)
	if IsValid(self.entCam) then self.entCam:Remove() end
	self.entTarget = ent
	ent.bPossessed = true
	ent:SetEnemy(NULL)
	ent.entEnemy = nil
	ent:ClearMemory()
	
	local entPoss = self
	function ent:_PossScheduleDone()
		self.bInSchedule = false
		entPoss.bInSchedule = false
		self:StartEngineTask(GetTaskID("TASK_SET_ACTIVITY"),ACT_IDLE)
	end
end

function ENT:OnRemove()
end

function ENT:TargetFaceForward(fcDone)
	if(self.entTarget._PossFaceForward && !self.entTarget:_PossFaceForward(self.entPossessor, fcDone)) then return end
	self.entTarget:SetLastPosition(self.entCam:GetPos() +self.entPossessor:GetAimVector() *400)
	local schdFaceLastPosition = ai_schedule_slv.New( "Face to last position" ) 
	schdFaceLastPosition:EngTask( "TASK_FACE_LASTPOSITION" )
	if fcDone then
		self.entTarget.TaskStart_TASK_FACE_END = fcDone
		self.entTarget.Task_TASK_FACE_END = function() end
		schdFaceLastPosition:AddTask( "TASK_FACE_END" )
	end
	
	self.entTarget:StartSchedule(schdFaceLastPosition)
end

function ENT:RunAttack(iKey, func)
	if self.entPossessor:KeyDown(iKey) && func then
		self.bInSchedule = true
		self.iInAttack = iKey
		//self:TargetFaceForward(function()
			//if !self.entPossessor:KeyDown(iKey) then self.bInSchedule = false; return end
			func(self.entTarget, self.entPossessor, function(bFailed)
				self.bInSchedule = false
				if !bFailed && IsValid(self.entTarget) then self.entTarget:TaskComplete(); self:Think() end
			end)
		//end)
		self:NextThink(CurTime() +0.02)
		return self.bInSchedule
	end
	return false
end

--util.AddNetworkString("slv_possessor_updatehp")
function ENT:Think()
	if !IsValid(self.entTarget) || !IsValid(self.entPossessor) || self.entPossessor:Health() <= 0 then self:EndPossession(); return end
	local iHealth = self.entTarget:Health()
	if iHealth != self.iHealthTarget then
		self.iHealthTarget = iHealth
		/*net.Start("slv_possessor_updatehp")
			net.WriteUInt(iHealth,20)
		net.Send(self.entPossessor)*/
	end
	if self.entTarget.bDead then return end
	if !self.entTarget._PossNoHealthRegen && self.nextHealthRegen && CurTime() >= self.nextHealthRegen then
		self.nextHealthRegen = CurTime() +2
		local health = self.entTarget:Health()
		local healthNew = math.Clamp(health +4, 0, self.entTarget:GetMaxHealth())
		if healthNew > health then
			//self.entTarget:SetHealth(healthNew)
			//self.entTarget:SetNetworkedInt("health", healthNew)
		end
	end
	if #self.entPossessor:GetWeapons() > 0 then self.entPossessor:StripWeapons() end
	if self.bInSchedule then
		if self.entTarget._PossAttackThink then self.entTarget:_PossAttackThink(self.entPossessor, self.iInAttack) end
		if self.entTarget._PossMovement then self.entTarget:_PossMovement(self.entPossessor, true) end
		self:NextThink(CurTime() +0.02)
		return true
	end
	--if CurTime() < self.nextSprint then return end
	self.bInSchedule = self:RunAttack(IN_ATTACK, self.entTarget._PossPrimaryAttack) || self:RunAttack(IN_ATTACK2, self.entTarget._PossSecondaryAttack) || self:RunAttack(IN_RELOAD, self.entTarget._PossReload) || self:RunAttack(IN_JUMP, self.entTarget._PossJump) || self:RunAttack(IN_DUCK,self.entTarget._PossDuck)
	if self.bInSchedule then return true end
	if self.entTarget._PossMovement then self.entTarget:_PossMovement(self.entPossessor); self:TargetFaceForward(); self:NextThink(CurTime() +0.02) return true end
	if self.entTarget.bScripted && self.entTarget:GetAIType() != 2 then self:TargetFaceForward(); return end
	local bMove
	local posMove = self.entTarget:GetPos()
	if self.entPossessor:KeyDown(IN_MOVELEFT) then
		posMove = posMove +self.entPossessor:GetRight() *-400
		bMove = true
	end
	if self.entPossessor:KeyDown(IN_MOVERIGHT) then
		posMove = posMove +self.entPossessor:GetRight() *400
		bMove = true
	end
	if self.entPossessor:KeyDown(IN_FORWARD) then
		local viewNormal = self.entPossessor:GetAimVector()
		viewNormal.z = 0
		posMove = posMove +viewNormal *400
		bMove = true
	end
	if self.entPossessor:KeyDown(IN_BACK) then
		local viewNormal = self.entPossessor:GetAimVector() *-1
		viewNormal.z = 0
		posMove = posMove +viewNormal *400
		bMove = true
	end
	if !bMove then self.entTarget:StopMoving(); self:TargetFaceForward(); return end
	/*local schd
	if self.entPossessor:KeyDown(IN_SPEED) then
		schd = schdRunToLastPosition
		self.nextSprint = CurTime() +0.2
	else schd = schdWalkToLastPosition end*/
	local act
	if self.entPossessor:KeyDown(IN_SPEED) then
		act = self.entTarget:GetRunActivity()
		self.nextSprint = CurTime() +0.2
	else act = self.entTarget:GetWalkActivity() end
	
	local obbMins, obbMaxs = self.entTarget:OBBMins(), self.entTarget:OBBMaxs()
	local posStart = self.entTarget:GetPos() +Vector(0,0,5)
	local posEnd = posMove +Vector(0,0,5)
	local filter = {self, self.entTarget}
	local tr = util.TraceHull({
		start = posStart,
		endpos = posEnd,
		filter = filter,
		mins = obbMins,
		maxs = obbMaxs
	})
	if tr.Hit then posMove = tr.HitPos -tr.Normal *20 end
	if tr.HitPos:Distance(posStart) <= obbMaxs.x +100 then
		local p = -5
		local posStart = posStart +Vector(0,0,obbMaxs.z *0.5)
		local ang = tr.Normal:Angle()
		local tr
		local ceilNormal = Vector(0,0,-1)
		for i = 1, 6 do
			ang.p = p
			local posEnd = posStart +(posEnd:Distance(posStart)) *ang:Forward()
			tr = util.TraceLine({
				start = posStart,
				endpos = posEnd,
				filter = filter
			})
			p = p -5
			if !tr.Hit || tr.HitNormal == ceilNormal then break end
		end
		if tr.HitNormal != ceilNormal then
			local pos = tr.HitPos -tr.Normal *(obbMaxs.x +30)
			posMove = util.TraceLine({start = pos, endpos = pos -Vector(0,0,400), filter = filter}).HitPos
		else posMove = util.TraceLine({start = tr.HitPos, endpos = tr.HitPos -Vector(0,0,400), filter = filter}).HitPos end
	else
		local trA = util.TraceLine({start = tr.HitPos, endpos = tr.HitPos -Vector(0,0,400), filter = filter})
		local trB = util.TraceLine({start = trA.HitPos +Vector(0,0,5), endpos = posStart, filter = filter})
		if trB.HitNormal == Vector(0,1,0) || trB.HitNormal == Vector(-1,0,0) || trB.HitNormal == Vector(0,-1,0) || trB.HitNormal == Vector(1,0,0) || trB.HitNormal == Vector(0,0,-1) then
			local dist = posStart:Distance(posEnd)
			local normal = (posEnd -posStart):GetNormal()
			local step = obbMaxs.x *0.5
			for i = step, dist, step do
				local pos = posStart +normal *i
				local tr = util.TraceLine({start = pos,endpos = pos -Vector(0,0,obbMaxs.z),filter = filter})
				if tr.Hit then
					posMove = tr.HitPos -tr.Normal *(obbMaxs.x +30)
				end
			end
		else posMove = trA.HitPos end
	end

	local ang = self.entTarget:GetAngles()
	local angTgt = (posMove -self.entTarget:GetPos()):Angle()
	if(!self.entTarget._PossShouldFaceMoving || self.entTarget:_PossShouldFaceMoving(self.entPossessor)) then
		--self.entTarget:SetAngles(Angle(0,math.ApproachAngle(ang.y,angTgt.y,4),0))
		self.entTarget:SetAngles(Angle(0,angTgt.y,0))
		self.entTarget:SetPoseParameter("move_yaw",0)
	else
		local angPossessor = self.entPossessor:GetAimVector():Angle()
		--self.entTarget:SetAngles(Angle(0,math.ApproachAngle(ang.y,angPossessor.y,4),0))
		self.entTarget:SetAngles(Angle(angPossessor.p,angPossessor.y,angPossessor.r))
		local yaw = self.entTarget:GetPoseParameter("move_yaw")
		local yawTgt = math.NormalizeAngle(angTgt.y -ang.y)
		--self.entTarget:SetPoseParameter("move_yaw",math.NormalizeAngle(math.ApproachAngle(yaw,yawTgt,8)))
		self.entTarget:SetPoseParameter("move_yaw",math.NormalizeAngle(yawTgt))
	end
	self.entTarget:PlayActivity(act)
	self:NextThink(CurTime())
	return true
	--self.entTarget:SetLastPosition(posMove)
	--self.entTarget:StartSchedule(schd)
end
