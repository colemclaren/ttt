AddCSLuaFile("shared.lua")

include('shared.lua')

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_PLAYER","npc_horse")
ENT.NPCFaction = NPC_FACTION_PLAYER
ENT.iClass = CLASS_PLAYER_ALLY
util.AddNPCClassAlly(CLASS_PLAYER_ALLY,"npc_horse")
ENT.sModel = "models/skyrim/horse.mdl"
ENT.fMeleeDistance	= 60
ENT.fSearchDistance = 600
ENT.bFlinchOnDamage = false
ENT.m_bKnockDownable = true
ENT.DontPossess = true
ENT.BoneRagdollMain = "NPC Root [Root]"
ENT.skName = "horse"
ENT.bPlayDeathSequence = false
ENT.UseActivityTranslator = true
ENT.UseCustomMovement = false
ENT.m_bDontGetBurnt = true
ENT.HullNav = HULL_WIDE_SHORT
ENT.CollisionBounds = Vector(46,46,88)

ENT.iBloodType = BLOOD_COLOR_RED
ENT.sSoundDir = "npc/horse/"

local tbSounds = {
	["Attack"] = "horse_attack0[1-2].mp3",
	["Death"] = "horse_death0[1-2].mp3",
	["Dismount"] = "horse_dismount01.mp3",
	["Graze"] = "horse_idle_graze0[1-3].mp3",
	["Idle"] = {"horse_idle_head01_a0[1-3].mp3","horse_idle_head01_b0[1-3].mp3"},
	["HeadShake"] = "horse_idle_headshake0[1-2].mp3",
	["Paw"] = "horse_idle_paw01.mp3",
	["Tail"] = "horse_idle_tail0[1-3].mp3",
	["Pain"] = "horse_injured0[1-3].mp3",
	["Mount"] = "horse_mount01.mp3",
	["RearUp"] = "horse_rearup0[1-3].mp3",
	["FootWalkFront"] = "foot/horse_walk_front0[1-6].mp3",
	["FootWalkBack"] = "foot/horse_walk_back0[1-6].mp3",
	["FootSprintFront"] = "foot/horse_sprint_front0[1-6].mp3",
	["FootSprintBack"] = "foot/horse_sprint_back0[1-6].mp3"
}

function ENT:GetSoundEvents() return tbSounds end

function ENT:OnInit()
	self:SetHullType(HULL_WIDE_SHORT)
	self:SetHullSizeNormal()
	self:SetCollisionBounds(self.CollisionBounds,Vector(self.CollisionBounds.x *-1,self.CollisionBounds.y *-1,0))
	
	self:CapabilitiesAdd(CAP_MOVE_GROUND)
	self:SetHealth(GetConVarNumber("sk_" .. self.skName .. "_health"))
	self.m_bMounted = false
	
	self.m_exhaustion = 0
	local cspLoop = CreateSound(self,self.sSoundDir .. "horse_breathe0" .. math.random(1,2) .. "_lp.wav")
	cspLoop:SetSoundLevel(58)
	cspLoop:Play()
	self.cspBreathe = cspLoop
	self:StopSoundOnDeath(cspLoop)
	self:SetSkin(math.random(1,4))
	self:SetUseType(SIMPLE_USE)
end

function ENT:OnUse(activator,caller,type,value)
	if(self:Disposition(activator) == D_LI) then
		if(!GAMEMODE.Aftermath) then self:Mount(activator)
		else
			activator:HolsterWeapon(function()
				if(activator:Alive() && self:OBBDistance(activator) <= 60) then
					self:Mount(activator)
				end
			end)
		end
	end
end

function ENT:Mount(pl)
	if(self:IsMounted() || !pl:Alive()) then return end
	if(gamemode.Call("CanPlayerMount",pl,self) == true) then return end
	self:PlaySound("Mount")
	self:SetBodygroup(1,1)
	self:SetOwner(pl)
	local owner = self:GetNetworkedEntity("plOwner")
	if(!owner:IsValid()) then self:SetNetworkedEntity("plOwner",pl) end
	self:SetNetworkedEntity("mount",pl)
	self:SetNetworkedBool("mounted",true)
	self.m_turnSpeed = 0
	self.m_tMounted = CurTime()
	pl:SetNetworkedEntity("mount",self)
	//pl:Spectate(OBS_MODE_CHASE)
	pl:DrawViewModel(false)
	pl:DrawWorldModel(false)
	//pl:SpectateEntity(ent)
	//pl:SetMoveType(MOVETYPE_OBSERVER)
	if(GAMEMODE.Aftermath) then
		pl:SetHUDTarget(self)
		hook.Add("CanPlayerEquip","horsenoequip" .. self:EntIndex(),function(plTgt,item,cnd)
			if(plTgt == pl) then if(!item) then return true end end
		end)
		pl:SetParent(self)
		pl:Fire("SetParentAttachment","mount",0)
		pl:AddEffects(EF_BONEMERGE)
	else
		local pos = self:GetPos()
		pl:SetPos(pos +self:GetUp() *40 +self:GetForward() *6)
		pl:SetParent(self)
		pl:Fire("SetParentAttachmentMaintainOffset","mount",0)
	end
end

function ENT:Dismount()
	if(!self:IsMounted()) then return end
	if(GAMEMODE.Aftermath) then hook.Remove("CanPlayerEquip","horsenoequip" .. self:EntIndex()) end
	local pl = self:GetOwner()
	if(IsValid(pl)) then
		self:PlaySound("Dismount")
		local forward = self:GetForward()
		local right = self:GetRight()
		local tbCheck = {right,right *-1,forward,forward *-1}
		local pos = self:GetPos() +self:OBBCenter()
		local posTgt
		local min,max = pl:OBBMins(),pl:OBBMaxs()
		for _,dir in ipairs(tbCheck) do
			posTgt = pos +dir *88 +Vector(0,0,50)
			local tr = util.TraceHull({
				start = pos,
				endpos = posTgt,
				mins = min,
				maxs = max,
				filter = {self,pl},
				mask = MASK_PLAYERSOLID
			})
			if(!tr.Hit) then break
			elseif(_ == 4) then return end
		end
		pl:SetParent()
		self:SetNetworkedEntity("mount",NULL)
		pl:SetNetworkedEntity("mount",NULL)
		if(GAMEMODE.Aftermath) then
			pl:RemoveEffects(EF_BONEMERGE)
			pl:ClearHUDTarget(self)
		end
		//pl:UnSpectate()
		pl:DrawViewModel(true)
		pl:DrawWorldModel(true)
		//pl:SetMoveType(MOVETYPE_OBSERVER)
		pl:SetMoveType(MOVETYPE_WALK)
		if(pl:Alive()) then
			local ang = self:GetAngles()
			ang.r = 0
			ang.p = 0
			//pl:KillSilent()
			//pl:Spawn()
			pl:SetPos(posTgt)
			pl:SetAngles(ang)
			pl:DropToFloor()
		end
	end
	self.m_tMounted = nil
	self.bInSchedule = nil
	self:SetBodygroup(1,0)
	self:SetNetworkedBool("mounted",false)
	self.m_turnSpeed = nil
	self.m_bExhausted = nil
	self:ChangeBreathVolume(58)
	self:SetOwner()
	local ang = self:GetAngles()
	if(ang.p != 0 || ang.r != 0) then self:SetAngles(Angle(0,ang.y,0)) end
end

function ENT:_PossStart(pl)
	self:Mount(pl)
end

function ENT:_PossEnd(pl)
	self:Dismount(pl)
end

function ENT:OnKnockedDown()
	self:Dismount()
end

function ENT:OnDeath(dmginfo)
	self:Dismount()
end

function ENT:Removed()
	self:Dismount()
end

function ENT:ChangeBreathVolume(vol)
	self.cspBreathe:Stop()
	self.cspBreathe:SetSoundLevel(vol)
	self.cspBreathe:Play()
end

function ENT:_PossMovement() // Movement is handled through MountThink
end

function ENT:MountThink()
	local act = self:GetActivity()
	if(self.bInSchedule) then
		if(act != ACT_LAND && act != ACT_STAND) then
			local vel = self:GetVelocity()
			if(vel.z > 0) then self:SetGroundEntity(NULL); return end
			local pos = self:GetPos()
			local tr = util.TraceLine({
				start = pos,
				endpos = pos +vel *0.25,
				filter = self,
				mask = MASK_NPCSOLID
			})
			if((vel.z == 0 && (CurTime() -self.m_tJumpStart) >= 1) || tr.Hit) then
				local len = vel:Length()
				if(len > 710) then
					self:PlaySound("Pain")
					local dmg = (len -710) *1
					local dmginfo = DamageInfo()
					dmginfo:SetDamage(dmg)
					dmginfo:SetAttacker(game.GetWorld())
					dmginfo:SetInflictor(game.GetWorld())
					dmginfo:SetDamageType(DMG_CRUSH)
					dmginfo:SetDamagePosition(self:GetPos())
					self:TakeDamageInfo(dmginfo)
					if(!self:Alive()) then return end
				end
				local pl = self:GetOwner()
				local actLand = pl:KeyDown(IN_SPEED) && ACT_STAND || ACT_LAND
				self:PlayActivity(actLand,false,nil,true,true)
			end
		end
		return
	end
	local pl = self:GetOwner()
	if(!pl:IsValid() || !pl:Alive()) then self:Dismount(); return end
	if(pl:KeyPressed(IN_USE) && CurTime() -self.m_tMounted > 0.1) then
		self:Dismount()
		return
	end
	local dir = pl:GetAimVector()
	local angTgt = dir:Angle()
	angTgt.r = 0
	local ang = self:GetAngles()
	local yawDiff = math.AngleDifference(angTgt.y,ang.y)
	if(yawDiff < 0) then yawDiff = math.min(yawDiff +10,0)
	else yawDiff = math.max(yawDiff -10,0) end
	angTgt.y = ang.y +yawDiff *0.8
	local bMove
	if(pl:KeyDown(IN_FORWARD)) then
		if(!pl:KeyDown(IN_BACK)) then
			bMove = true
			if(pl:KeyDown(IN_MOVERIGHT)) then if(!pl:KeyDown(IN_MOVELEFT)) then angTgt.y = angTgt.y -45 end
			elseif(pl:KeyDown(IN_MOVELEFT)) then angTgt.y = angTgt.y +45 end
		end
	elseif(pl:KeyDown(IN_BACK)) then
		bMove = true
		angTgt.y = angTgt.y +180
		if(pl:KeyDown(IN_MOVERIGHT)) then if(!pl:KeyDown(IN_MOVELEFT)) then angTgt.y = angTgt.y +45 end
		elseif(pl:KeyDown(IN_MOVELEFT)) then angTgt.y = angTgt.y -45 end
	elseif(pl:KeyDown(IN_MOVERIGHT)) then if(!pl:KeyDown(IN_MOVELEFT)) then bMove = true; angTgt.y = angTgt.y -90 end
	elseif(pl:KeyDown(IN_MOVELEFT)) then bMove = true; angTgt.y = angTgt.y +90 end
	local speedTurn
	if(bMove) then
		local actRun
		if(pl:KeyDown(IN_SPEED) && !self.m_bExhausted && self.m_exhaustion < 800) then
			self.m_exhaustion = math.min(self.m_exhaustion +0.75,800)
			actRun = ACT_RUN
			if(self.m_exhaustion == 800) then self.m_bExhausted = true; self:ChangeBreathVolume(90) end
		elseif(self.m_bExhausted || pl:KeyDown(IN_WALK)) then
			self.m_exhaustion = math.max(self.m_exhaustion -1,0)
			actRun = ACT_WALK
			if(self.m_bExhausted && self.m_exhaustion <= 400) then self.m_bExhausted = nil; self:ChangeBreathVolume(58) end
		else
			self.m_exhaustion = math.max(self.m_exhaustion -0.5,0)
			actRun = ACT_RUN_AIM
		end
		self:PlayActivity(actRun)
		speedTurn = 1
		if(pl:KeyPressed(IN_JUMP) && self.m_exhaustion < 520) then
			self.m_exhaustion = self.m_exhaustion +180
			self.bInSchedule = true
			local ang = self:GetAngles()
			ang.p = 0
			ang.r = 0
			self:SetAngles(ang)
			local actJump = pl:KeyDown(IN_SPEED) && ACT_LEAP || ACT_HOP
			self:PlayActivity(actJump,false,nil,false,true)
			self.m_bJumping = true
			self.m_tJumpStart = CurTime()
			return
		end
		local diff = math.AngleDifference(ang.y,angTgt.y)
		if(diff > 0) then angTgt.r = math.min(diff,10)
		elseif(diff < 0) then angTgt.r = math.max(diff,-10) end
		speedTurn = math.max((math.abs(diff) /30) *speedTurn,0.5)
	else
		if((yawDiff >= -25 && yawDiff < 0) || (yawDiff <= 25 && yawDiff > 0)) then angTgt.y = ang.y; yawDiff = 0 end
		self.m_exhaustion = math.max(self.m_exhaustion -1.25,0)
		if(self.m_bExhausted && self.m_exhaustion <= 400) then self.m_bExhausted = nil; self:ChangeBreathVolume(58) end
		speedTurn = 1
		if(yawDiff < -0.4) then self:PlayActivity(ACT_TURN_RIGHT)
		elseif(yawDiff > 0.4) then self:PlayActivity(ACT_TURN_LEFT)
		elseif(self:GetActivity() != ACT_IDLE) then self:PlayActivity(ACT_IDLE) end
	end
	speedTurn = math.Approach(self.m_turnSpeed,speedTurn,0.025)
	self.m_turnSpeed = speedTurn
	ang.y = math.ApproachAngle(ang.y,angTgt.y,speedTurn)
	ang.r = math.ApproachAngle(ang.r,angTgt.r,speedTurn *0.5)
	self:SetAngles(ang)
	self:NextThink(CurTime())
	return true
end

function ENT:OnThink()
	if(self:IsMounted()) then
		return self:MountThink()
	end
	self:UpdateLastEnemyPositions()
	self:NextThink(CurTime())
	return true
end

function ENT:TranslateActivity(act)
	return act
end

function ENT:GenerateInventory()
	self:AddToInventory("000446gfk")
end

function ENT:SelectGetUpActivity()
	local _, ang = self.ragdoll:GetBonePosition(self:GetMainRagdollBone())
	return ang.p >= 0 && ACT_ROLL_RIGHT || ACT_ROLL_LEFT
end

function ENT:EventHandle(...)
	local event = select(1,...)
	if(event == "mattack") then
		local dist = self.fMeleeDistance
		local dmg = GetConVarNumber("sk_" .. self.skName .. "_dmg_slash")
		local ang
		local force
		local atk = select(2,...)
		if(atk == "hooves") then
			ang = Angle(30,0,0)
			force = Vector(220,0,0)
		else
			ang = Angle(-30,0,0)
			force = Vector(320,0,0)
		end
		self:DealMeleeDamage(dist,dmg,ang,force)
		return true
	elseif(event == "jump") then
		local type = select(2,...)
		self:SetGroundEntity(NULL)
		local vel
		if(type == "hop") then
			vel = self:GetForward() *500 +self:GetUp() *300
		else
			vel = self:GetForward() *650 +self:GetUp() *320
		end
		self:SetVelocity(vel)
		return true
	elseif(event == "land") then
		self.bInSchedule = false
		self:PlayActivity(ACT_RUN)
		return true
	elseif(event == "graze") then
		//self:PlayActivity(ACT_IDLE_STIMULATED)
		return true
	end
end

function ENT:CanUseMeleeAttack(entTarget)
	local ang = self:GetAngleToPos(entTarget:GetCenter())
	return (ang.y <= 35 || ang.y >= 325) && (ang.p <= 45 || ang.p >= 315)
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)
	if(self:IsMounted()) then return end
	if(disp == D_HT && self:Health() >= self:GetMaxHealth() *0.3) then
		if(self:CanSee(enemy) && self:CanUseMeleeAttack(enemy)) then
			if(dist <= self.fMeleeDistance || distPred <= self.fMeleeDistance) then
				self:PlayActivity(ACT_MELEE_ATTACK1,false)
				return
			end
		end
		self:ChaseEnemy()
	else
		self:Hide()
	end
end
