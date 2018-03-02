AddCSLuaFile("shared.lua")

include('shared.lua')

ENT.fMeleeDistance	= 44
ENT.fMeleeForwardDistance = 200
ENT.bFlinchOnDamage = true
ENT.m_bKnockDownable = true
ENT.bPlayDeathSequence = false
ENT.CollisionBounds = Vector(10,10,84)
ENT._PossNoHealthRegen = true
ENT.Humanoid = true
ENT.fBowDistance = 1800

util.AddNetworkString("sky_bow_draw")
util.AddNetworkString("sky_human_poss")
util.AddNetworkString("sky_human_poss_wep")
local _R = debug.getregistry()
function ENT:OnInit()
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetCollisionBounds(self.CollisionBounds,Vector(self.CollisionBounds.x *-1,self.CollisionBounds.y *-1,0))
	self.m_tbHolstered = {}
	
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND,CAP_OPEN_DOORS))
	self:SetHealth(GetConVarNumber("sk_" .. self.skName .. "_health"))
	
	local addon = SLVBase.GetDerivedAddon("Skyrim")
	self.m_tEquipment = _R.Inventory.Create(addon:GetItems())
	self:GenerateEquipment()
	
	self:GenerateArmor()
	self.m_nextAttack = 0
	self.m_nextChargeAttack = 0
	self.m_tNextShieldKnockback = 0
	self.m_tNextDrawShield = 0
	self.m_tNextShout = 0
	self.m_tNextTaunt = 0
end

function ENT:_PossDuck(possessor,fcDone)
	if(!self:Taunt()) then fcDone(true) end
end

function ENT:OnFoundEnemy(iEnemies)
	local enemy = self.entEnemy
	if(!IsValid(enemy)) then return end
	local pos = enemy:GetPos() +enemy:OBBCenter()
	if(select(2,self:IsLOSBlocked(pos)) == enemy && math.random(1,5) <= 4) then self:Taunt() end
end

function ENT:SelectTauntActivity()
	local wep = self:GetActiveWeapon()
	local eq = self:GetEquipment()
	local item = eq:GetItem(wep.itemID)
	if(item && self:HasShieldEquipped()) then
		local data = item:GetData()
		if(data.holdType == "1hm" && math.random(1,2) == 1) then
			return ACT_SIGNAL_HALT
		end
	end
	return ACT_SIGNAL_ADVANCE
end

function ENT:Taunt()
	local wep = self:GetActiveWeapon()
	if(!wep:IsValid() || !wep.Taunt || !self:CanTaunt()) then return false end
	self:PlayActivity(wep:TranslateActivity(self:SelectTauntActivity()),false,self._PossScheduleDone)
	return true
end

function ENT:CanTaunt() return true end

function ENT:_PossShouldFaceMoving(possessor)
	//if(self:IsBowDrawn() || self:IsShieldDrawn()) then return false end
	//return true
	return false
end

function ENT:_PossPrimaryAttack(possessor,fcDone)
	local wep = self:GetActiveWeapon()
	if(!wep:IsValid() || wep:GetClass() == "translator" || CurTime() < self.m_nextAttack) then fcDone(true); return end
	local holdType = self:GetWeaponType()
	if(holdType == "bow") then
		fcDone(true)
		if(self:IsBowDrawn()) then return end
		local g = self:GetGestureName()
		if(g && g == "bowrelease") then return end
		self:DrawArrow()
		return
	end
	if(self:IsShieldDrawn()) then self:PlayActivity(ACT_SHIELD_ATTACK,false,fcDone); return end
	self.m_nextAttack = CurTime() +wep.Primary.Delay
	self:PlayGestureActivity(wep:TranslateGesture(ACT_MELEE_ATTACK1))
	fcDone(true)
end

function ENT:_PossSecondaryAttack(possessor,fcDone)
	fcDone(true)
	local g = self:GetGestureName()
	if(g && (g == "1hmidletoshieldidle" || g == "shieldidleto1hmidle")) then return end
	if(!self:HasShieldEquipped()) then return end
	if(self:IsShieldDrawn()) then self:LowerShield(); return end
	self:DrawShield()
end

function ENT:GetSquadInfo()
	local entsSquad = self:GetSquadMembers()
	local numSquad = #entsSquad
	local items = {}
	local eq = self:GetEquipment()
	local numBows = 0
	for i = 1,numSquad do
		local npc = entsSquad[i]
		if(npc:IsValid()) then
			local wep = npc:GetActiveWeapon()
			if(wep:IsValid() && wep.itemID && eq:HasItem(wep.itemID)) then
				local itemID = wep.itemID
				local equipment = npc:GetEquipment()
				local item = equipment:GetItem(itemID)
				if(item) then
					local data = item:GetData()
					if(data.itemType == ITEM_TYPE_WEAPON) then
						local ID = item:GetID()
						if(!items[ID]) then items[ID] = 0
						else items[ID] = items[ID] +1 end
						if(data.holdType == "bow") then numBows = numBows +1 end
					end
				end
			end
		end
	end
	return items,numBows
end

function ENT:_PossJump(possessor,fcDone)
	local wep = self:GetActiveWeapon()
	if(!wep:IsValid() || wep:GetClass() == "translator" || !wep.PowerAttack || self:LegsCrippled() || self:IsShieldDrawn()) then fcDone(true); return end
	local act = self:GetActivity()
	local actAttack
	if(act == ACT_WALK || act == ACT_RUN || !wep.PowerAttackSlow) then actAttack = ACT_MELEE_ATTACK2
	else actAttack = ACT_GESTURE_MELEE_ATTACK1 end
	self:PlayActivity(wep:TranslateActivity(actAttack),false,fcDone)
end

net.Receive("sky_human_poss_wep",function(len,pl)
	local bNext = net.ReadUInt(1) == 1
	local ent = pl:GetPossessedNPC()
	if(!IsValid(ent) || !ent.Humanoid) then return end
	local eq = ent:GetEquipment()
	local items = eq:GetItems()
	local wep = ent:GetActiveWeapon()
	local tbWeps = {}
	for itemID,item in pairs(items) do
		local data = item:GetData()
		if(data.itemType && data.itemType == ITEM_TYPE_WEAPON) then
			table.insert(tbWeps,itemID)
		end
	end
	if(!wep:IsValid() || !wep.itemID) then ent:EquipWeapon(tbWeps[1]); return end
	if(#tbWeps == 1) then return end
	for _,itemID  in ipairs(tbWeps) do
		if(itemID == wep.itemID) then
			local next = tbWeps[_ +1] || tbWeps[1]
			ent:EquipWeapon(next)
			break
		end
	end
end)

function ENT:IsShieldDrawn() return self.m_bShieldDrawn end

if(Swords_Installed) then
	util.AddNetworkString("sky_swords_parry")
	util.AddNetworkString("sky_swords_parry_req")
	net.Receive("sky_swords_parry_req",function(len,pl)
		local ent = net.ReadEntity()
		if(!ent:IsValid() || !ent:IsNPC() || !ent:IsShieldDrawn()) then return end
		ent.Parry = true
		net.Start("sky_swords_parry")
			net.WriteEntity(ent)
			net.WriteUInt(1,1)
		net.Send(pl)
	end)
end
function ENT:DrawShield()
	if(!self:HasShieldEquipped()) then return end
	self:PlayGestureActivity(ACT_SHIELD_UP)
	self.m_bShieldDrawn = true
	if(Swords_Installed) then
		self.Parry = true
		net.Start("sky_swords_parry")
			net.WriteEntity(self)
			net.WriteUInt(1,1)
		net.Broadcast()
	end
	self:StopMoving()
end

function ENT:LowerShield()
	if(!self:HasShieldEquipped()) then return end
	self:PlayGestureActivity(ACT_SHIELD_DOWN)
	self.m_bShieldDrawn = false
	if(Swords_Installed) then
		self.Parry = false
		net.Start("sky_swords_parry")
			net.WriteEntity(self)
			net.WriteUInt(0,1)
		net.Broadcast()
	end
	self:StopMoving()
end

util.AddNetworkString("sky_human_arrow")
function ENT:CreateArrow()
	local wep = self:GetActiveWeapon()
	if(!wep:IsValid()) then return end
	net.Start("sky_human_arrow")
		net.WriteEntity(self)
	net.Broadcast()
	self:RemoveArrow()
end

util.AddNetworkString("sky_human_arrow_undeploy")
function ENT:RemoveArrow()
	local entQuiver = self.m_entQuiver
	if(!IsValid(entQuiver)) then return end
	local bg = 8 -self.m_numArrows
	entQuiver:SetBodygroup(1,bg)
	self.m_numArrows = self.m_numArrows -1
	if(self.m_numArrows == 0) then self.m_numArrows = 8 end
end

function ENT:LegsCrippled()
	return self:LimbCrippled(HITBOX_LEFTLEG) || self:LimbCrippled(HITBOX_RIGHTLEG)
end

function ENT:IsBowDrawn() return self.m_bBowDrawn end

function ENT:_PossStart(possessor)
	net.Start("sky_human_poss")
		net.WriteUInt(1,1)
		net.WriteEntity(self)
	net.Send(possessor)
end

function ENT:_PossEnd(possessor)
	net.Start("sky_human_poss")
		net.WriteUInt(0,1)
	net.Send(possessor)
end

function ENT:FireArrow(bBlank)
	if(!self:IsBowDrawn()) then return end
	self:PlayGestureActivity(ACT_POLICE_HARASS1)
	self.m_bBowDrawn = nil
	local wep = self:GetActiveWeapon()
	if(!wep:IsValid()) then return end
	net.Start("sky_bow_draw")
		net.WriteEntity(wep)
		net.WriteUInt(0,1)
	net.Broadcast()
	net.Start("sky_human_arrow_undeploy")
		net.WriteEntity(self)
	net.Broadcast()
	if(self.m_cspPull) then self.m_cspPull:Stop(); self.m_cspPull = nil end
	if(bBlank) then return end
	local attID = self:LookupAttachment("arrow")
	local att = self:GetAttachment(attID)
	if(!att) then return end
	local posSrc = self:GetArrowFirePosition()
	sound.Play("weapons/bow/bow_fire0" .. math.random(1,3) .. ".mp3",att.Pos,75,100)
	local dir = self:GetForward()
	local ang = self:GetAimAngles()
	if(self:IsPossessed()) then
		local pos = self:GetPossessor():GetPossessionEyeTrace().HitPos
		dir = util.GetConstrictedDirection(posSrc,pos,ang,Angle(12,12,12))
	elseif(IsValid(self.entEnemy)) then
		local pos = self.entEnemy:GetPos() +self.entEnemy:OBBCenter() +self.entEnemy:GetVelocity() *math.Rand(0.2,0.7)
		dir = util.GetConstrictedDirection(posSrc,pos,ang,Angle(12,12,12))
	end
	if(!self.m_arrowID) then return end
	local eq = self:GetEquipment()
	local item = eq:GetItem(self.m_arrowID)
	if(!item) then return end
	local ent = ents.Create("obj_arrow")
	ent:SetPos(posSrc)
	ent:SetAngles(dir:Angle())
	ent:SetEntityOwner(self)
	ent:SetItem(self.m_arrowID,item:GetData())
	ent:Spawn()
	ent:Activate()
	local phys = ent:GetPhysicsObject()
	if(phys:IsValid()) then
		phys:ApplyForceCenter(dir *10000)
	end
end

function ENT:DrawArrow()
	local wep = self:GetActiveWeapon()
	self:PlayGestureActivity(ACT_VM_RECOIL1)
	self.m_bBowDrawn = true
end

function ENT:IsLOSBlocked(posTgt)
	local posSrc = self:GetArrowFirePosition()
	local tr = util.TraceLine({
		start = posSrc,
		endpos = posTgt,
		filter = self,
		mask = MASK_SOLID
	})
	return tr.Hit,tr.Entity
end

function ENT:EquipRandomBow()
	local eq = self:GetEquipment()
	local itemIDs = {}
	local num = 0
	for itemID,item in pairs(eq:GetItems()) do
		local data = item:GetData()
		if(data.holdType == "bow") then
			table.insert(itemIDs,item:GetID())
			num = num +1
		end
	end
	if(num == 0) then return false end
	self:StopMoving()
	local itemID = table.Random(itemIDs)
	self:EquipWeapon(itemID)
	return true
end

function ENT:EquipRandomMeleeWeapon()
	local eq = self:GetEquipment()
	local itemIDs = {}
	local num = 0
	for itemID,item in pairs(eq:GetItems()) do
		local data = item:GetData()
		if(data.holdType == "h2h" || data.holdType == "2hm" || data.holdType == "1hm" || data.holdType == "2gs") then
			table.insert(itemIDs,item:GetID())
			num = num +1
		end
	end
	if(num == 0) then return false end
	local itemID = table.Random(itemIDs)
	self:EquipWeapon(itemID)
	return true
end

function ENT:GetArrowFirePosition()
	return self:GetPos() +self:GetForward() *7.225620 +self:GetRight() *-9.063400 +self:GetUp() *75.862442
end

function ENT:OnThink()
	local holdType = self:GetWeaponType()
	local g = self:GetGestureName()
	if(holdType == "bow" || self:IsShieldDrawn() || (g && g == "shout")) then
		if(self:IsPossessed()) then
			if(holdType == "bow") then
				if(self:IsBowDrawn() && g != "bow_draw") then
					local possessor = self:GetPossessor()
					if(!possessor:KeyDown(IN_ATTACK)) then self:FireArrow() end
				end
			end
		else
			local enemy = self.entEnemy
			if(IsValid(enemy)) then
				local posLook
				local posTgt = enemy:GetPos() +enemy:OBBCenter()
				if(select(2,self:IsLOSBlocked(posTgt)) == enemy) then posLook = posTgt
				else
					if(!self:IsLOSBlocked(self.m_posEnemyLast)) then posLook = self.m_posEnemyLast end
				end
				if(posLook) then
					self:TurnDegree(6,(posLook -self:GetPos()):Angle())
				end
			end
		end
	end
	self:MaintainPoseParameters()
	self:UpdateLastEnemyPositions()
	self:MaintainAnimations()
	self:NextThink(CurTime())
	return true
end

function ENT:MaintainPoseParameters()
	local ent = self.entEnemy
	local yawTgt = 0
	local pitchTgt = 0
	if(IsValid(ent)) then
		local posSrc = self:GetPos() +self:OBBCenter()
		local posTgt = ent:GetPos() +ent:OBBCenter()
		local ang = self:GetAngles()
		local angTgt = (posTgt -posSrc):Angle()
		pitchTgt = math.AngleDifference(angTgt.p,ang.p)
		yawTgt = math.AngleDifference(angTgt.y,ang.y)
	end
	local ppYaw = self:GetPoseParameter("aim_yaw")
	self:SetPoseParameter("aim_yaw",math.ApproachAngle(ppYaw,yawTgt,2))
	
	local ppPitch = self:GetPoseParameter("aim_pitch")
	self:SetPoseParameter("aim_pitch",math.ApproachAngle(ppPitch,pitchTgt,2))
end

function ENT:DamageHandle(dmginfo,hitgroup)
	if(self:HasShieldEquipped()) then
		local bMeleeDamage = dmginfo:IsDamageType(DMG_CLUB) || dmginfo:IsDamageType(DMG_SLASH)
		if(bMeleeDamage || (hitgroup && (hitgroup == HITBOX_STOMACH || hitgroup == HITBOX_CHEST))) then
			local attacker = dmginfo:GetAttacker()
			if(IsValid(attacker)) then
				local pos = dmginfo:GetDamagePosition()
				pos.z = 0
				local dir = self:GetForward()
				local posAttacker = attacker:GetPos()
				posAttacker.z = 0
				local dirDmg = (pos -posAttacker):GetNormal()
				local dotProd = dirDmg:DotProduct(dir)
				if(dotProd < 0.35) then
					if(!self:IsShieldDrawn()) then
						if(!self:IsPossessed() && CurTime() >= self.m_tNextDrawShield && math.random(1,4) <= 3) then
							self:DrawShield()
							self.m_tShieldHolster = CurTime() +math.Rand(3,5)
						end
					else
						local ent = self.m_entShield
						local itemID = ent.itemID
						local eq = self:GetEquipment()
						local item = eq:GetItem(itemID)
						if(item) then
							local data = item:GetData()
							if(data.armor) then
								local dmg = dmginfo:GetDamage()
								local armor = data.armor
								if(!bMeleeDamage) then armor = math.ceil(armor *0.25) end
								dmginfo:SetDamage(math.max(dmg -armor,1))
								if(CurTime() >= self.m_tNextShieldKnockback) then
									self:PlayGestureActivity(ACT_SHIELD_KNOCKBACK)
									self.m_tNextShieldKnockback = CurTime() +math.Rand(2,6)
								end
								if(data.shield) then sound.Play("weapons/shield/block_shield_" .. data.shield .. "0" .. math.random(1,3) .. ".mp3",dmginfo:GetDamagePosition(),75,100) end
								if(math.random(1,4) == 1) then self.m_tShieldHolster = CurTime() +math.Rand(1,5) end
							end
						end
					end
				end
			end
		end
	end
end

function ENT:EquipSuitedArrowType()
	local eq = self:GetEquipment()
	local maxDmg = 0
	local arrowID
	for itemID,item in pairs(eq:GetItems()) do
		local data = item:GetData()
		if(data.itemType == ITEM_TYPE_ARROW) then
			if(data.dmg && data.dmg > maxDmg) then
				arrowID = itemID
				maxDmg = data.dmg
			end
		end
	end
	self:RemoveQuiver()
	if(!arrowID) then return end
	self.m_arrowID = arrowID
	self:CreateQuiver()
end

function ENT:RemoveQuiver()
	if(IsValid(self.m_entQuiver)) then self.m_entQuiver:Remove() end
	self.m_entQuiver = nil
end

function ENT:CreateQuiver()
	local ID = self.m_arrowID
	if(!ID) then return end
	local eq = self:GetEquipment()
	local item = eq:GetItem(ID)
	if(!item) then return end
	local data = item:GetData()
	self.m_numArrows = data.arrows
	if(IsValid(self.m_entQuiver)) then self.m_entQuiver:Remove() end
	local attID = self:LookupAttachment("quiver")
	local att = self:GetAttachment(attID)
	local ent = ents.Create("prop_dynamic")
	ent:SetModel(data.quiver)
	ent:SetPos(att.Pos)
	ent:SetAngles(att.Ang)
	ent:SetParent(self)
	ent:Spawn()
	ent:Activate()
	ent:Fire("SetParentAttachment","quiver",0)
	self:DeleteOnRemove(ent)
	self.m_entQuiver = ent
end

function ENT:IsArmed() return self:GetActiveWeapon():IsValid() end

function ENT:GetWeaponType()
	local wep = self:GetActiveWeapon()
	return wep:IsValid() && wep.Type || ""
end

function ENT:GenerateEquipment()
end

function ENT:GenerateArmor()
end

function ENT:EquipSuitedEquipment()
	self:EquipShield()
	self:EquipRandomWeapon()
end

function ENT:EquipRandomWeapon()
	local eq = self:GetEquipment()
	local itemIDs = {}
	local num = 0
	for itemID,item in pairs(eq:GetItems()) do
		local data = item:GetData()
		if(data.itemType == ITEM_TYPE_WEAPON) then
			table.insert(itemIDs,item:GetID())
			num = num +1
		end
	end
	if(num == 0) then return end
	local itemID = table.Random(itemIDs)
	self:EquipWeapon(itemID)
end

function ENT:EquipShield(ID)
	if(!self:CanEquipShield()) then return end
	self:HolsterShield()
	local equipment = self:GetEquipment()
	if(!ID) then
		local armorMax = 0
		for itemID,item in pairs(equipment:GetItems()) do
			local data = item:GetData()
			if(data.itemType == ITEM_TYPE_SHIELD && data.armor) then
				if(!ID || data.armor > armorMax) then
					ID = itemID
					armorMax = data.armor
				end
			end
		end
		if(!ID) then return end
	end
	local item = equipment:GetItem(ID)
	if(!item) then return end
	local data = item:GetData()
	local attID = self:LookupAttachment("shield")
	local att = self:GetAttachment(attID)
	local ent = ents.Create("prop_dynamic")
	ent:SetModel(data.model)
	ent:SetPos(att.Pos)
	ent:SetAngles(att.Ang)
	ent:SetParent(self)
	ent:Spawn()
	ent:Activate()
	ent:Fire("SetParentAttachment","shield",0)
	ent.itemID = ID
	self:DeleteOnRemove(ent)
	self.m_entShield = ent
end

function ENT:OnKnockedDown(ragdoll)
	local entQuiver = self.m_entQuiver
	if(IsValid(entQuiver)) then
		entQuiver:SetParent(ragdoll)
		entQuiver:Fire("SetParentAttachment","quiver",0)
	end
	local entShield = self.m_entShield
	if(IsValid(entShield)) then
		entShield:SetParent(ragdoll)
		entShield:Fire("SetParentAttachment","quiver",0)
	end
	for holster,ent in pairs(self.m_tbHolstered) do
		if(ent:IsValid()) then
			ent:SetParent(ragdoll)
			ent:Fire("SetParentAttachment",holster,0)
		end
	end
	local wep = self:GetActiveWeapon()
	if(wep:IsValid() && wep:GetClass() != "translator") then wep:SetParent(ragdoll) end
end

function ENT:OnAreaCleared()
	if(self:IsShieldDrawn()) then self:LowerShield(); return end
	if(self:IsBowDrawn()) then self:FireArrow(true); return end
end

function ENT:OnStandUp()
	local entQuiver = self.m_entQuiver
	if(IsValid(entQuiver)) then
		entQuiver:SetParent(self)
		entQuiver:Fire("SetParentAttachment","quiver",0)
	end
	local entShield = self.m_entShield
	if(IsValid(entShield)) then
		entShield:SetParent(self)
		entShield:Fire("SetParentAttachment","quiver",0)
	end
	for holster,ent in pairs(self.m_tbHolstered) do
		if(ent:IsValid()) then
			ent:SetParent(self)
			ent:Fire("SetParentAttachment",holster,0)
		end
	end
	local wep = self:GetActiveWeapon()
	if(wep:IsValid()) then wep:SetParent(self) end
end

function ENT:CanEquipShield()
	local wep = self:GetActiveWeapon()
	if(!wep:IsValid() || !wep.itemID) then return true end
	local equipment = self:GetEquipment()
	local item = equipment:GetItem(wep.itemID)
	if(!item) then return false end
	local data = item:GetData()
	return data.holdType == "1hm"
end

function ENT:HasShieldEquipped()
	return IsValid(self.m_entShield)
end

function ENT:AddToEquipment(itemID,am,cnd)
	local item = self:GetEquipment():AddItem(itemID,am,cnd)
	if(!item) then return end
	local data = item:GetData()
	if(data.itemType == ITEM_TYPE_ARROW) then self:EquipSuitedArrowType()
	elseif(data.itemType == ITEM_TYPE_WEAPON) then self:CreateHolsteredWeapon(itemID) end
end

function ENT:GetEquipment() return self.m_tEquipment end

function ENT:HasEquipment(ID) return self:GetEquipment():HasItem(ID) end

function ENT:HolsterShield()
	local entShield = self.m_entShield
	if(IsValid(entShield)) then entShield:Remove() end
end

function ENT:EquipWeapon(ID)
	local equipment = self:GetEquipment()
	local item = equipment:GetItem(ID)
	if(!item) then return end
	local wep = self:GetActiveWeapon()
	if(wep:IsValid() && wep:GetClass() != "translator") then
		if(wep.itemID == ID) then return end
		self:HolsterWeapon(function() self:EquipWeapon(ID) end)
		return
	end
	local data = item:GetData()
	local class = data.class
	local wep = self:Give(class)
	if(wep:IsValid()) then
		self:StartEngineTask(GetTaskID("TASK_SET_ACTIVITY"),self:GetActivity())
		self:MaintainActivity()
		//self.bFlinchOnDamage = false
		self:PlayGestureActivity(wep:TranslateGesture(ACT_ARM))
	end
end

function ENT:HolsterWeapon(fcOnHolstered)
	self.m_tUnequip = nil
	local wep = self:GetActiveWeapon()
	if(!wep:IsValid()) then if(fcOnHolstered) then fcOnHolstered() end return end
	if(wep:GetClass() == "translator") then if(fcOnHolstered) then fcOnHolstered() end; return end
	wep:Undeploy()
	self:PlayGestureActivity(wep:TranslateGesture(ACT_DISARM),1,function()
		if(!wep:IsValid()) then return end
		self:RemoveWeapon()
		if(fcOnHolstered) then fcOnHolstered() end
	end)
	//local data = GAMEMODE:GetItem(wep.itemID)
	//if(data && data.soundUnEquip) then GAMEMODE:PlaySound(data.soundUnEquip,self) end
end

function ENT:CreateHolsteredWeapon(itemID)
	local eq = self:GetEquipment()
	local item = eq:GetItem(itemID)
	if(!item) then return end
	local data = item:GetData()
	local tbHolstered = self.m_tbHolstered
	local holster = data.holster
	if(IsValid(tbHolstered[holster])) then tbHolstered[holster]:Remove() end
	local attID = self:LookupAttachment(holster)
	local att = self:GetAttachment(attID)
	if(!att) then return end
	local ent = ents.Create("prop_dynamic")
	ent:SetModel(data.model)
	ent:SetPos(att.Pos)
	ent:SetAngles(att.Ang)
	ent:SetParent(self)
	ent:Spawn()
	ent:Activate()
	ent:Fire("SetParentAttachment",holster,0)
	self:DeleteOnRemove(ent)
	self.m_tbHolstered[holster] = ent
end

function ENT:RemoveWeapon()
	local wep = self:GetActiveWeapon()
	if(wep:IsValid()) then
		wep.m_invalid = true
		wep:Remove()
		local wep = self:Give("ai_translator")
		if(wep:IsValid()) then wep:SetNoDraw(true); wep:DrawShadow(false) end
	end
	self:StartEngineTask(GetTaskID("TASK_SET_ACTIVITY"),self:GetIdleActivity())
	self:MaintainActivity()
	//self.bFlinchOnDamage = true
end

function ENT:TranslateGesture(act)
	return act
end

function ENT:GetItem(itemID)
	local eq = self:GetEquipment()
	return eq:GetItem(itemID)
end

function ENT:RemoveHolster(holster)
	local entsHolstered = self.m_tbHolstered
	if(IsValid(entsHolstered[holster])) then entsHolstered[holster]:Remove() end
	entsHolstered[holster] = nil
end

function ENT:EventHandle(...)
	local event = select(1,...)
	if(event == "bowdraw") then
		local wep = self:GetActiveWeapon()
		if(!wep:IsValid()) then return true end
		self:EmitSound("weapons/bow/bow_draw0" .. math.random(1,2) .. ".mp3",75,100)
		net.Start("sky_bow_draw")
			net.WriteEntity(wep)
			net.WriteUInt(1,1)
		net.Broadcast()
		return true
	end
	if(event == "bowdrawarrow") then
		self:EmitSound("weapons/bow/bow_nock0" .. math.random(1,3) .. ".mp3",75,100)
		self:CreateArrow()
		return true
	end
	if(event == "holster") then
		local wep = self:GetActiveWeapon()
		if(!wep:IsValid()) then return true end
		wep:PlaySound("Sheathe")
		wep:SetNoDraw(true)
		self:CreateHolsteredWeapon(wep.itemID)
		return true
	end
	if(event == "deploy") then
		local wep = self:GetActiveWeapon()
		if(!wep:IsValid()) then return true end
		wep:PlaySound("Draw")
		wep:SetNoDraw(false)
		wep:DrawShadow(true)
		local item = self:GetItem(wep.itemID)
		if(!item) then return true end
		local data = item:GetData()
		self:RemoveHolster(data.holster)
		return true
	end
	if(event == "shieldbash") then
		local wep = self:GetActiveWeapon()
		if(!wep:IsValid()) then return true end
		local ent,tr = wep:FindMeleeTarget(self.fMeleeDistance +10)
		if(!ent) then return true end
		local entShield = self.m_entShield
		if(!IsValid(entShield)) then return true end
		local dmgInfo = DamageInfo()
		dmgInfo:SetDamage(GetConVarNumber("sk_" .. self.skName .. "_dmg_shield_bash"))
		dmgInfo:SetAttacker(self)
		dmgInfo:SetInflictor(self)
		dmgInfo:SetDamageType(DMG_CLUB)
		dmgInfo:SetDamagePosition(tr.HitPos)
		dmgInfo:SetDamageForce(self:GetForward() *200 +self:GetUp() *100)
		ent:TakeDamageInfo(dmgInfo)
		local itemID = entShield.itemID
		local eq = self:GetEquipment()
		local item = eq:GetItem(itemID)
		if(item) then
			local data = item:GetData()
			if(data.shield) then
				local r
				if(data.shield == "light") then r = math.random(1,2)
				else r = math.random(1,3) end
				sound.Play("weapons/shield/bash_shield_" .. data.shield .. "0" .. r .. ".mp3",tr.HitPos,75,100)
			end
		end
		if(ent:IsPlayer()) then ent:ViewPunch(Angle(-20,0,0)) end
		ent:SetGroundEntity(NULL)
		ent:SetVelocity(self:GetForward() *200 +Vector(0,0,100))
		return true
	end
end

function ENT:HandleBowBehavior(enemy,dist,distPred,disp,wep)
	local g = self:GetGestureName()
	local bDrawn = self:IsBowDrawn()
	if(g && (g == "bow_equip" || g == "bow_unequip")) then return end
	if(dist > self.fBowDistance) then self.m_bBowWalk = false; self:ChaseEnemy(); return end
	if(dist > 1000) then
		if(self:GetActivity() == ACT_RUN_AIM_STIMULATED) then self:StopMoving(); self:StopMoving() end
		self.m_bBowWalk = true
		self:ChaseEnemy()
	end
	if(dist <= 150 && !bDrawn) then
		if(dist <= 55) then if(self:EquipRandomMeleeWeapon()) then return end
		else
			local tbSquad = self:GetSquadMembers()
			local numSquad = #tbSquad
			if(numSquad <= 1 || select(2,self:GetSquadInfo()) > numSquad *0.5) then
				if(self:EquipRandomMeleeWeapon()) then return end
			end
			local posEnt = enemy:GetPos()
			local pos = self:GetPos()
			local dir = (pos -posEnt):GetNormal()
			local posTgt = pos +dir *200
			self:MoveToPos(posTgt)
		end
	end
	if(self:CanSee(enemy)) then
		if(!self:IsGesturePlaying("bow_equip") && !self:IsGesturePlaying("bowrelease")) then
			if(!bDrawn) then
				self:DrawArrow()
				self.m_tMinFireArrowDelay = CurTime() +math.Rand(1.2,3.4)
			elseif(g != "bow_draw" && g != "bow_drawidle") then
				local hit,hitEnt = self:IsLOSBlocked(enemy:GetPos() +enemy:OBBCenter())
				if(hitEnt != enemy) then
					if(IsValid(hitEnt) && (hitEnt:IsNPC() || hitEnt:IsPlayer())) then
						local disp = self:Disposition(hitEnt)
						if(disp == D_LI || disp == D_NU) then
							local posEnt = hitEnt:GetPos()
							local pos = self:GetPos()
							local posEnemy = enemy:GetPos()
							posEnt.z = 0
							pos.z = 0
							posEnemy.z = 0
							local dirEnemy = (posEnemy -pos):GetNormal()
							local dirEnt = (posEnt -pos):GetNormal()
							local ang = dirEnemy:Angle() -dirEnt:Angle()
							local dirMove
							if(ang.y < 0) then dirMove = self:GetRight()
							else dirMove = self:GetRight() *-1 end
							pos = pos +dirMove *200
							self:MoveToPos(pos) // Move to side to avoid allies and try to get clear sight to enemy
						else self:ChaseEnemy() end
					else self:ChaseEnemy() end
				elseif(CurTime() >= self.m_tMinFireArrowDelay) then self:FireArrow() end
			end
		end
		self.m_tLastEnemySeen = CurTime()
		self.m_posEnemyLast = enemy:GetPos() +enemy:OBBCenter() -enemy:GetVelocity() *0.1
	elseif(!self.m_tLastEnemySeen || (CurTime() -self.m_tLastEnemySeen) >= 5) then self:ChaseEnemy() end
end

function ENT:HandleSwordBehavior(enemy,dist,distPred,disp,wep)
	local g = self:GetGestureName()
	if(self:IsShieldDrawn()) then
		if(CurTime() >= self.m_tShieldHolster || dist >= 250) then
			self:LowerShield()
			self.m_tNextDrawShield = CurTime() +math.Rand(2,7)
			return
		end
		if(dist <= self.fMeleeDistance +10) then
			if(dist <= self.fMeleeDistance -25) then
				self:PlayActivity(ACT_SHIELD_ATTACK)
				return
			end
			self.m_tShieldHolster = self.m_tShieldHolster -0.25
		end
		self:ChaseEnemy()
		return
	end
	if(g == "shieldidleto1hmidle") then return end
	if(!g || (g != "1hmunequip" && g != "2gsunequipgreatsword" && g != "2hmunequipaxe")) then
		if(dist >= 750) then if(self:EquipRandomBow()) then return end end
		if(dist >= 200) then
			local tbSquad = self:GetSquadMembers()
			local numSquad = #tbSquad
			if(numSquad > 1) then
				local items,numBows = self:GetSquadInfo()
				if(numBows /numSquad <= 0.45) then if(self:EquipRandomBow()) then return end end
			end
		end
	end
	if(CurTime() < self.m_nextAttack || self:IsPlayingGestureActivity(wep:TranslateGesture(ACT_MELEE_ATTACK1))) then
		//if(dist >= 80) then
			self:ChaseEnemy()
		//end
		return
	end
	if(dist <= self.fMeleeDistance || distPred <= self.fMeleeDistance) then
		self:PlayGestureActivity(wep:TranslateGesture(ACT_MELEE_ATTACK1))
		self.m_nextAttack = CurTime() +wep.Primary.Delay
		self:ChaseEnemy()
		return
	end
	if(wep.PowerAttack) then
		local bCrippled = self:LegsCrippled()
		if(!bCrippled && CurTime() >= self.m_nextChargeAttack) then
			local ang = self:GetAngleToPos(enemy:GetPos())
			if(ang.y <= 35 || ang.y >= 325) then
				local fTimeToGoal = self:GetPathTimeToGoal()
				if(self.bDirectChase && distPred <= self.fMeleeForwardDistance) then
					if(fTimeToGoal <= 0.85 && fTimeToGoal >= 0.5) then
						self.m_nextChargeAttack = CurTime() +math.Rand(3,8)
						if(math.random(1,3) >= 2) then
							self:PlayActivity(wep:TranslateActivity(ACT_MELEE_ATTACK2))
							return
						end
					elseif(wep.PowerAttackSlow && fTimeToGoal <= 0.4) then
						self.m_nextChargeAttack = CurTime() +math.Rand(3,8)
						if(math.random(1,5) >= 4) then
							self:PlayActivity(wep:TranslateActivity(ACT_GESTURE_MELEE_ATTACK1))
							return
						end
					end
				end
			end
		end
	end
	self:ChaseEnemy()
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)
	if(disp == D_HT) then
		local wep = self:GetActiveWeapon()
		if(!wep:IsValid()) then self:Hide(); return end
		local holdType = self:GetWeaponType()
		if(holdType == "bow") then self:HandleBowBehavior(enemy,dist,distPred,disp,wep); return end
		if(holdType == "h2h" || holdType == "2hm" || holdType == "1hm" || holdType == "2gs") then
			self:HandleSwordBehavior(enemy,dist,distPred,disp,wep)
			return
		end
		self:Hide()
	elseif(disp == D_FR) then self:Hide() end
end