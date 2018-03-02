AddCSLuaFile("shared.lua")

include('shared.lua')

SHOUT_UNRELENTING_FORCE = 1
SHOUT_DISMAY = 2
SHOUT_ICE_STORM = 4
SHOUT_DISARM = 8
SHOUT_FROST_BREATH = 64

local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_DRAUGR","npc_draugr")
ENT.NPCFaction = NPC_FACTION_DRAUGR
ENT.iClass = CLASS_DRAUGR
util.AddNPCClassAlly(CLASS_DRAUGR,"npc_draugr")
ENT.sModel = "models/skyrim/draugr.mdl"
ENT.sModelFemale = "models/skyrim/draugrfemale.mdl"
ENT.m_shouts = 0
ENT.m_bKnockDownable = false
ENT.skName = "draugr"

ENT.sSoundDir = "npc/draugr/"

ENT.tblFlinchActivities = {
	[HITBOX_GENERIC] = ACT_FLINCH_CHEST,
	[HITBOX_HEAD] = ACT_FLINCH_HEAD,
	[HITBOX_LEFTARM] = ACT_FLINCH_LEFTARM,
	[HITBOX_RIGHTARM] = ACT_FLINCH_RIGHTARM
}

local shoutParticles = {
	[SHOUT_ICE_STORM] = "dragonshout_icestorm",
	[SHOUT_DISMAY] = "dragonshout_fireball",
	[SHOUT_FROST_BREATH] = "dragonshout_icestorm"
}

ENT.m_tbSounds = {
	["Shout1"] = "voicepowers_shout01a_fus.mp3",
	["Shout1B"] = "voicepowers_shout03_ro_dah.mp3",
	["Shout2"] = "voicepowers_shout01a_faas.mp3",
	["Shout2B"] = "voicepowers_shout03_ru_maar.mp3",
	["Shout4"] = "voicepowers_shout01a_liz.mp3",
	["Shout4B"] = "voicepowers_shout03_slen_nus.mp3",
	["Shout8"] = "voicepowers_shout01a_zun.mp3",
	["Shout8B"] = "voicepowers_shout03_haal_viik.mp3",
	["Shout64"] = "voicepowers_shout01a_fo.mp3",
	["Shout64B"] = "voicepowers_shout03_krah_diin.mp3",
	
	["Taunt"] = {"dialoguedraugr_aar_vin_ok.mp3","dialoguedraugr_aav_dilon.mp3","dialoguedraugr_bolog_aaz_mal_lir.mp3",
		"dialoguedraugr_dir_volaan.mp3","dialoguedraugr_faas_pook_dinok.mp3","dialoguedraugr_kren_sos_aal.mp3",
		"dialoguedraugr_laugh.mp3","dialoguedraugr_qiilaan_us_dilon.mp3","dialoguedraugr_sovngarde_saraan.mp3",
		"dialoguedraugr_unslaad_krosis.mp3"},
	["Attack"] = "draugr_attack0[1-2].mp3",
	["Alert"] = "draugr_aware0[1-3].mp3",
	["Death"] = "draugr_death0[1-3].mp3",
	["Pain"] = "draugr_injured0[1-2].mp3",
	["1hmTauntA"] = "draugr_combatidle_1hmtaunta01.mp3",
	["1hmTauntB"] = "draugr_combatidle_1hmtauntb01.mp3",
	["1hmTauntC"] = "draugr_combatidle_1hmtauntc01.mp3",
	["2gsTauntA"] = "draugr_combatidle_2gstaunta01.mp3",
	["shieldTaunt"] = "draugr_combatidle_shieldrally01.mp3",
	["AlcoveExitA"] = "draugr_alcoveexit_a0[1-2].mp3",
	["AlcoveExitB"] = "draugr_alcoveexit_b01[1-2].mp3",
	["FootLeft"] = "foot/draugr_foot_walk_l0[1-2].mp3",
	["FootRight"] = "foot/draugr_foot_walk_r0[1-2].mp3"
}

ENT.DamageScales = {
	[DMG_POISON] = 0
}

local GENDER_MALE = 0
local GENDER_FEMALE = 1
local BaseClass = "npc_humanoid_base"
function ENT:OnInit()
	if(self.m_gender == GENDER_MALE) then self:SetBodygroup(2,math.random(0,2)) end
	self:GetBaseClass(BaseClass).OnInit(self)
	
	self.m_cspIdle = CreateSound(self,self.sSoundDir .. "draugr_conscious_0" .. math.random(1,3) .. "_lp.wav")
	self.m_cspIdle:Play()
	self:StopSoundOnDeath(self.m_cspIdle)
	
	ParticleEffectAttach("draugr_eye",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("leye"))
	ParticleEffectAttach("draugr_eye",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("reye"))
	
	local helmet = self:GetBodygroup(4)
	if(helmet == 0) then self:SetBodygroup(1,math.random(0,2)) end
end

function ENT:_PossReload(possessor,fcDone)
	fcDone(true)
	local g = self:GetGestureName()
	if(g && g == "shout" || self:IsShieldDrawn() || self:IsBowDrawn()) then return end
	local shout = self:SelectShout()
	if(!shout) then return end
	self:UseShout(shout)
end

function ENT:PreInit() self.m_gender = math.random(1,2) == 1 && GENDER_MALE || GENDER_FEMALE end

function ENT:UpdateModel()
	local gender = self:GetGender()
	if(gender == GENDER_MALE) then self:SetModel(self.sModel)
	else self:SetModel(self.sModelFemale) end
end

function ENT:GetGender() return self.m_gender end

function ENT:Flinch(hitgroup)
	local wepType = self:GetWeaponType()
	if(wepType == "bow" || wepType == "2gs") then return end
	self:PlayGestureActivity(ACT_FLINCH_CHEST)
	self:StopMoving()
	self:StopMoving()
end

function ENT:SelectShout(ent)
	local valid = IsValid(ent)
	local shouts = {}
	if(self:CanUseShout(SHOUT_UNRELENTING_FORCE,ent)) then table.insert(shouts,SHOUT_UNRELENTING_FORCE) end
	if(self:CanUseShout(SHOUT_DISMAY,ent) && (!valid || (ent:IsNPC() && ent:Disposition(self) != D_FR))) then table.insert(shouts,SHOUT_DISMAY) end
	if(self:CanUseShout(SHOUT_ICE_STORM,ent) && (!valid || ent:IsPlayer() || (ent.CanBeFrozen && ent:CanBeFrozen()))) then table.insert(shouts,SHOUT_ICE_STORM) end
	if(self:CanUseShout(SHOUT_DISARM,ent) && (!valid || ((ent:IsPlayer() || ent.Humanoid) && IsValid(ent:GetActiveWeapon()) && ent:GetActiveWeapon():GetClass() != "translator"))) then table.insert(shouts,SHOUT_DISARM) end
	if(self:CanUseShout(SHOUT_FIREBALL,ent) && (!valid || ent:IsPlayer() || (ent.Ignitable && ent:Ignitable()))) then table.insert(shouts,SHOUT_FIREBALL) end
	if(#shouts == 0) then return false end
	return table.Random(shouts)
end

function ENT:CanUseShout(shout,ent)
	if(bit.band(self.m_shouts,shout) == 0) then return false end
	if(!ent) then return true end
	if(!ent:IsValid()) then return false end
	if(shout == SHOUT_DISARM) then
		if(ent:IsNPC() && (ent:Classify() == CLASS_DRAUGR || ent:Classify() == CLASS_FALMER)) then return false end
		local wep = ent:GetActiveWeapon()
		if(!wep:IsValid()) then return false end
		return wep:GetClass() != "translator"
	elseif(shout == SHOUT_UNRELENTING_FORCE) then
		if(ent:IsNPC()) then return ent.CanBeKnockedDown && ent:CanBeKnockedDown() || false end
		return true
	end
	return true
end

function ENT:UseShout(shout)
	self.m_rattackShout = shout
	self:PlayGestureActivity(ACT_BUSY_LEAN_BACK_ENTRY)
	self:StopMoving()
	self:StopMoving()
	local cspSound = self:CreateSound("Shout" .. shout)
	cspSound:SetSoundLevel(85)
	cspSound:Play()
	return shout
end

function ENT:InitSandbox()
	if(!self:GetSquad()) then self:SetSquad("npc_draugr_sbsquad") end
end

function ENT:GenerateArmor()
	local gender = self:GetGender()
	if(gender == GENDER_MALE) then self:SetBodygroup(3,math.random(1,3))
	else self:SetBodygroup(3,math.random(1,2)) end
	local helmet = 0
	self:SetBodygroup(4,helmet)
end

function ENT:GenerateEquipment()
	local r = math.random(1,3)
	if(r == 1) then
		self:AddToEquipment("000302CA") // Ancient Nord Bow
		self:AddToEquipment("0002C672") // Ancient Nord War Axe
		self:AddToEquipment("00034182") // Ancient Nord Arrow
	elseif(r == 2) then self:AddToEquipment(table.Random({"0001CB64","000236A5"})) // Ancient Nord Battle Axe / Ancient Nord Greatsword
	else
		self:AddToEquipment("00012EB6") // Iron Shield
		self:AddToEquipment(table.Random({"0002C672","0002C66F"})) // Ancient Nord War Axe / Ancient Nord Sword
	end
	self:EquipSuitedEquipment()
end

function ENT:CanShout()
	local wep = self:GetActiveWeapon()
	if(!wep:IsValid() || !wep.itemID) then return true end
	local equipment = self:GetEquipment()
	local item = equipment:GetItem(wep.itemID)
	if(!item) then return false end
	local data = item:GetData()
	return data.holdType == "1hm"
end

ENT.fShoutDistance = 1200
function ENT:EventHandle(...)
	if(self:GetBaseClass(BaseClass).EventHandle(self,...)) then return true end
	local event = select(1,...)
	if(event == "1hm") then
		local wep = self:GetActiveWeapon()
		if(!wep:IsValid() || !wep.Strike) then return true end
		local atk = select(2,...)
		if(atk == "a") then
			local hit = wep:Strike(false)
		elseif(atk == "f") then
			local hit = wep:Strike(false)
		elseif(atk == "forwarda") then
			local hit = wep:Strike(true)
		elseif(atk == "powerchop") then
			local hit = wep:Strike(true)
		elseif(atk == "powerslash") then
			local hit = wep:Strike(true)
		elseif(atk == "x1") then
			local hit = wep:Strike(false)
		elseif(atk == "x2") then
			local hit = wep:Strike(false)
		end
		return true
	end
	if(event == "2gs") then
		local wep = self:GetActiveWeapon()
		if(!wep:IsValid() || !wep.Strike) then return true end
		local atk = select(2,...)
		if(atk == "b") then
			local hit = wep:Strike(false)
		elseif(atk == "backslash") then
			local hit = wep:Strike(false)
		elseif(atk == "forwardb") then
			local hit = wep:Strike(true)
		elseif(atk == "forwardpowerchop2") then
			local hit = wep:Strike(true)
		elseif(atk == "x1") then
			local hit = wep:Strike(false)
		elseif(atk == "x2") then
			local hit = wep:Strike(false)
		end
		return true
	end
	if(event == "2hm") then
		local wep = self:GetActiveWeapon()
		if(!wep:IsValid() || !wep.Strike) then return true end
		local atk = select(2,...)
		if(atk == "a") then
			local hit = wep:Strike(false)
		elseif(atk == "b") then
			local hit = wep:Strike(false)
		elseif(atk == "backswipe") then
			local hit = wep:Strike(false)
		elseif(atk == "c") then
			local hit = wep:Strike(false)
		elseif(atk == "forwardb") then
			local hit = wep:Strike(true)
		elseif(atk == "forwardswipe") then
			local hit = wep:Strike(true)
		end
		return true
	end
	if(event == "shout") then
		util.ScreenShake(self:GetPos(),10,5,0.75,1200)
		local shout = self.m_rattackShout
		if(!shout) then return true end
		local cspSound = self:CreateSound("Shout" .. shout .. "B")
		cspSound:SetSoundLevel(85)
		cspSound:Play()
		local attID = self:LookupAttachment("mouth")
		local att = self:GetAttachment(attID)
		if(!att) then return true end
		local pos = att.Pos
		local ang = att.Ang
		if(self:IsPossessed()) then
			local posTgt = self:GetPossessor():GetPossessionEyeTrace().HitPos
			ang = util.GetConstrictedDirection(pos,posTgt,ang,Angle(30,30,30)):Angle()
		elseif(IsValid(self.entEnemy)) then ang = util.GetConstrictedDirection(pos,self.entEnemy:GetPos() +self.entEnemy:OBBCenter(),ang,Angle(30,30,30)):Angle() end
		local dir = ang:Forward()
		local dist = self.fShoutDistance
		local cone = 0.4
		for _, ent in ipairs(ents.FindInSphere(pos,dist)) do
			if(ent:IsValid() && ent != self && self:IsEnemy(ent) && self:Visible(ent)) then
				local posEnt = ent:GetPos() +ent:OBBCenter()
				local dirEnt = (posEnt -pos):GetNormal()
				if(1 -dirEnt:DotProduct(dir) <= cone) then
					self:OnShoutHit(shout,ent)
				end
			end
		end
		ParticleEffect(shoutParticles[self.m_rattackShout] || "dragonshout",pos,ang,self)
		return true
	end
end

function ENT:DisarmTarget(ent)
	if(!ent:IsPlayer() && (!ent:IsNPC() || ent:Classify() == CLASS_DRAUGR || ent:Classify() == CLASS_FALMER)) then return end
	local wep = ent:GetActiveWeapon()
	if(!wep:IsValid() || wep:GetClass() == "translator") then return end
	if(wep.Holster) then wep:Holster() end
	local class = wep:GetClass()
	if(ent:IsPlayer()) then
		ent:StripWeapon(class)
		if(ent:GetWeapon(class):IsValid()) then return end // Can't remove the weapon?
	else wep:Remove() end
	local pos = ent:GetShootPos()
	local attID = self:LookupAttachment("mouth")
	local att = self:GetAttachment(attID)
	local dir = (pos -att.Pos):GetNormal()
	local ent = ents.Create(class)
	ent:SetPos(pos +dir *60)
	ent:SetAngles(dir:Angle())
	ent:SetKeyValue("spawnflags","2") // Disable player pickup
	ent:Spawn()
	ent:Activate()
	timer.Simple(0.5,function()
		if(ent:IsValid()) then
			ent:SetKeyValue("spawnflags","0") // Enable player pickup
		end
	end)
	local phys = ent:GetPhysicsObject()
	if(!phys:IsValid()) then ent:DropToFloor()
	else phys:ApplyForceCenter(dir *500 *phys:GetMass()) end
end

function ENT:OnShoutHit(shout,ent)
	if(shout == SHOUT_UNRELENTING_FORCE) then
		if(!ent:IsPlayer() && ent.CanBeKnockedDown && ent:CanBeKnockedDown()) then
			local ragdoll = ent:KnockDown(3)
			if(IsValid(ragdoll)) then
				local att = self:GetAttachment(self:LookupAttachment("mouth"))
				local pos = att.Pos
				ragdoll:SetVelocity((pos -ragdoll:GetPos()):GetNormal() *2000)
			end
			return
		end
		local pos = self:GetPos()
		local posEnt = ent:GetPos()
		pos.z = 0
		posEnt.z = 0
		local dist = pos:Distance(posEnt)
		local dir = (posEnt -pos):GetNormal()
		ent:SetGroundEntity(NULL)
		ent:SetVelocity(dir *math.max(2000 -dist,0) +Vector(0,0,200))
		return
	end
	if(shout == SHOUT_DISMAY) then
		if(!ent:IsNPC()) then return end
		ent:AddEntityRelationship(self,D_FR,100)
		timer.Simple(math.Rand(6,20),function()
			if(!self:IsValid() || !ent:IsValid()) then return end
			ent:AddEntityRelationship(self,D_HT,100)
		end)
		return
	end
	if(shout == SHOUT_ICE_STORM) then
		if(ent:IsPlayer() || (ent.CanBeFrozen && ent:CanBeFrozen())) then ent:SetFrozen(60) end
		local dmginfo = DamageInfo()
		dmginfo:SetDamageType(DMG_GENERIC)
		dmginfo:SetDamage(GetConVarNumber("sk_" .. self.skName .. "_shout_icestorm"))
		dmginfo:SetAttacker(self)
		dmginfo:SetInflictor(self)
		ent:TakeDamageInfo(dmginfo)
		return
	end
	if(shout == SHOUT_DISARM) then
		self:DisarmTarget(ent)
		return
	end
	if(shout == SHOUT_FROST_BREATH) then
		self:OnShoutHit(SHOUT_ICE_STORM,ent)
		return
	end
end

function ENT:GetAimAngles()
	local ang = self:GetAngles()
	local ppPitch = self:GetPoseParameter("aim_pitch")
	local ppYaw = self:GetPoseParameter("aim_yaw")
	ang.p = ang.p +ppPitch
	ang.y = ang.y +ppYaw
	return ang
end

function ENT:TranslateActivity(act)
	if(self:IsBowDrawn()) then if(act == ACT_WALK_AIM_STIMULATED || act == ACT_RUN_AIM_STIMULATED) then return ACT_WALK_PACKAGE end end
	if(self:IsShieldDrawn()) then if(act == ACT_RUN_RELAXED || act == ACT_WALK_RELAXED) then return ACT_HL2MP_WALK_KNIFE end end
	local holdType = self:GetWeaponType()
	if(holdType == "bow" && self.m_bBowWalk && !self:IsPossessed()) then
		if(act == ACT_RUN_AIM_STIMULATED) then return ACT_WALK_AIM_STIMULATED end
	end
	return act
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)
	local g = self:GetGestureName()
	if(g && (g == "shout" || g == "mtstaggerlight")) then return end
	if(disp == D_HT) then
		if(CurTime() >= self.m_tNextTaunt) then
			self.m_tNextTaunt = CurTime() +math.Rand(4,16)
			if(math.random(1,3) == 1) then self:PlaySound("Taunt") end
		end
		if(CurTime() >= self.m_tNextShout) then
			self.m_tNextShout = CurTime() +math.Rand(8,14)
			if(math.random(1,3) == 1 && !self:IsShieldDrawn() && !self:IsBowDrawn()) then
				local shout = self:SelectShout(enemy)
				if(shout) then self:UseShout(shout); return end
			end
		end
	end
	self:GetBaseClass(BaseClass).SelectScheduleHandle(self,enemy,dist,distPred,disp)
end
