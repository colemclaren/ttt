AddCSLuaFile("shared.lua")

include('shared.lua')

util.AddNPCClassAlly(CLASS_DWARVEN,"npc_dwarven_centurion")
local _R = debug.getregistry()
_R.NPCFaction.Create("NPC_FACTION_DWARVEN","npc_dwarven_centurion")
ENT.NPCFaction = NPC_FACTION_DWARVEN
ENT.iClass = CLASS_DWARVEN
ENT.sModel = "models/skyrim/steamcenturion.mdl"
ENT.fRangeDistance = 340
ENT.fMeleeDistance	= 60
ENT.fMeleeForwardDistance = 200
ENT.bFlinchOnDamage = true
ENT.m_bKnockDownable = false
ENT.bIgnitable = false
ENT.BoneRagdollMain = "NPC Root [Root]"
ENT.bPlayDeathSequence = false
ENT.UseActivityTranslator = true
ENT.CollisionBounds = Vector(38,38,160)
ENT.tblIgnoreDamageTypes = {DMG_DISSOLVE}

ENT._PossNoHealthRegen = true

ENT.iBloodType = false
ENT.sSoundDir = "npc/dwarvencenturion/"

ENT.tblFlinchActivities = {
	[HITBOX_GENERIC] = ACT_SMALL_FLINCH,
	[HITBOX_CHEST] = ACT_FLINCH_CHEST,
	[HITBOX_HEAD] = ACT_BIG_FLINCH
}

ENT.m_tbSounds = {
	["AttackBack"] = "dwarvencenturion_attack_back01.mp3",
	["AttackBash"] = "dwarvencenturion_attack_bash01.mp3",
	["AttackChop"] = "dwarvencenturion_attack_chop01.mp3",
	["AttackForwardPower"] = "dwarvencenturion_attack_forwardpower01.mp3",
	["AttackForwardPowerRush"] = "dwarvencenturion_attack_forwardpowerrush01.mp3",
	["AttackSlash"] = "dwarvencenturion_attack_slash01.mp3",
	["AttackStab"] = "dwarvencenturion_attack_stab01.mp3",
	["Equip"] = "dwarvencenturion_equip01.mp3",
	["FullScan"] = "dwarvencenturion_fullscanmp3",
	["HibernateExit"] = "dwarvencenturion_hibernateexit01.mp3",
	["Recoil"] = "dwarvencenturion_recoil01.mp3",
	["Stall"] = "dwarvencenturion_stall.mp3",
	["Death"] = "dwarvencenturtion_death01.mp3",
	["Pain"] = "dwarvencenturtion_injured0[1-3].mp3",
	["FootLeft"] = "foot/dwarvencenturion_foot_l0[1-2].mp3",
	["FootRight"] = "foot/dwarvencenturion_foot_r0[1-2].mp3"
}

ENT.DamageScales = {
	[DMG_BURN] = 0.2,
	[DMG_BLAST] = 0.2,
	[DMG_SHOCK] = 1.4,
	[DMG_SONIC] = 2,
	[DMG_PARALYZE] = 0.6,
	[DMG_NERVEGAS] = 0.6,
	[DMG_POISON] = 0.5,
	[DMG_ACID] = 0.65,
	[DMG_DIRECT] = 0.3,
	[DMG_DIRECT] = 0.2,
	[DMG_ACID] = 1.2,
	[DMG_BURN] = 0.2,
	[DMG_DROWN] = 0,
	[DMG_RADIATION] = 1.2,
	[DMG_SLOWBURN] = 0.2,
	[DMG_PARALYZE] = 0.4,
	[DMG_DISSOLVE] = 0.4,
	[DMG_ENERGYBEAM] = 0.4,
	[DMG_SHOCK] = 0.3,
	[DMG_BLAST] = 1.2,
	[DMG_NERVEGAS] = 0.1,
	[DMG_SONIC] = 0.8,
	[DMG_POISON] = 0.2
}

function ENT:OnInit()
	self:SetHullType(HULL_LARGE)
	self:SetHullSizeNormal()
	self:SetCollisionBounds(self.CollisionBounds,Vector(self.CollisionBounds.x *-1,self.CollisionBounds.y *-1,0))
	
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND,CAP_OPEN_DOORS))
	self:SetHealth(GetConVarNumber("sk_centurion_dwarven_health"))
	self.m_nextForwardAttack = 0
	
	self.m_cspIdle = CreateSound(self,self.sSoundDir .. "dwarvencenturion_conscious_lp.wav")
	self.m_cspIdle:SetSoundLevel(68)
	self.m_cspIdle:Play()
	self:StopSoundOnDeath(self.m_cspIdle)
	
	ParticleEffectAttach("centurion_steam_arm",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("steamlarm"))
	ParticleEffectAttach("centurion_steam_arm",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("steamrarm"))
	ParticleEffectAttach("centurion_steam_head",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("steamhead"))
	self.m_cspSteam = CreateSound(self,self.sSoundDir .. "dwemer_steam0" .. math.random(1,3) .. "_lp.wav")
	self.m_cspSteam:Play()
	self:StopSoundOnDeath(self.m_cspSteam)
	self.m_tNextRangeAttack = 0
end

function ENT:_PossPrimaryAttack(entPossessor,fcDone)
	self:PlayActivity(ACT_MELEE_ATTACK1,false,fcDone)
end

function ENT:_PossSecondaryAttack(entPossessor,fcDone)
	self:PlayActivity(ACT_RANGE_ATTACK1,false,fcDone)
end

function ENT:_PossJump(entPossessor,fcDone)
	self:PlayActivity(ACT_MELEE_ATTACK2,false,fcDone)
end

function ENT:OnInterrupt()
	self:EventHandle("shout","end")
end

util.AddNetworkString("sky_cent_shout")
function ENT:EventHandle(...)
	local event = select(1,...)
	if(event == "steam") then
		local attID = self:LookupAttachment("mouth")
		local att = self:GetAttachment(attID)
		if(!att) then return true end
		local dir = att.Ang:Forward()
		local pos = att.Pos
		local tbEnts = ents.FindInSphere(pos,400)
		for _,ent in ipairs(tbEnts) do
			if(ent:IsNPC() || ent:IsPlayer()) then
				local disp = self:Disposition(ent)
				if(disp == D_HT || disp == D_FR) then
					local posEnt = ent:GetPos() +ent:OBBCenter()
					local dirEnt = (posEnt -pos):GetNormal()
					local dotProd = dir:DotProduct(dirEnt)
					if(dotProd >= 0.74) then
						local tr = util.TraceLine({
							start = pos,
							endpos = posEnt,
							filter = self,
							mask = MASK_SOLID
						})
						if(!tr.Hit || tr.Entity == ent) then
							local dmgInfo = DamageInfo()
							dmgInfo:SetDamage(2)
							dmgInfo:SetAttacker(self)
							dmgInfo:SetInflictor(self)
							dmgInfo:SetDamageType(DMG_GENERIC)
							dmgInfo:SetDamagePosition(tr.HitPos)
							ent:TakeDamageInfo(dmgInfo)
						end
					end
				end
			end
		end
		return true
	end
	if(event == "foot") then
		local ft = select(2,...)
		if(!self:OnGround()) then return true end
		local att = self:GetAttachment(self:LookupAttachment(ft .. "foot"))
		if(!att) then return true end
		sound.Play(self.sSoundDir .. "foot/dwarvencenturion_foot_" .. ft .. "0" .. math.random(1,2) .. ".mp3",att.Pos,100,100)
		util.ScreenShake(att.Pos,80,80,0.4,420)
		/*local tr = util.TraceLine({start = att.Pos +Vector(0,0,20),endpos = att.Pos -Vector(0,0,30),filter = self})
		if(tr.MatType == 68 || tr.MatType == 78) then
			local e = EffectData()
			e:SetOrigin(tr.HitPos)
			e:SetScale(80)
			util.Effect("ThumperDust",e) 
		end*/
		return true
	end
	if(event == "scan") then
		local ang = self:GetAngles()
		ang.y = ang.y +180
		self:GetEnemies(ang)
		return true
	end
	if(event == "mattack") then
		local dist = self.fMeleeDistance +40
		local dmg
		local ang
		local force
		local atk = select(2,...)
		if(atk == "back") then
			dmg = GetConVarNumber("sk_centurion_dwarven_dmg_slash")
			ang = Angle(0,0,0)
			force = Vector(0,0,0)
		elseif(atk == "forwardpower") then
			dist = dist +40
			dmg = GetConVarNumber("sk_centurion_dwarven_dmg_slash_power")
			ang = Angle(-33,-48,4)
			force = Vector(630,-420,340)
		elseif(atk == "leftchop") then
			dmg = GetConVarNumber("sk_centurion_dwarven_dmg_slash")
			ang = Angle(32,34,-3)
			force = Vector(350,120,200)
		elseif(atk == "leftslash") then
			dmg = GetConVarNumber("sk_centurion_dwarven_dmg_slash")
			ang = Angle(-35,-38,3)
			force = Vector(280,-420,360)
		elseif(atk == "leftstab") then
			dmg = GetConVarNumber("sk_centurion_dwarven_dmg_slash")
			ang = Angle(48,0,0)
			force = Vector(480,0,200)
		elseif(atk == "bash") then
			dmg = GetConVarNumber("sk_centurion_dwarven_dmg_slash")
			ang = Angle(-35,-38,3)
			force = Vector(280,-420,360)
		end
		self:DealMeleeDamage(dist,dmg,ang,force,DMG_SLASH,nil,false,nil,function(ent,dmginfo)
			local vel = self:GetForward() *force.x +self:GetRight() *force.y +self:GetUp() *force.z
			ent:SetVelocity(vel)
		end)
		return true
	end
	if(event == "shout") then
		local type = select(2,...)
		if(IsValid(self.m_entSteam)) then self.m_entSteam:Remove(); self.m_entSteam = nil end
		if(self.m_cspFire) then
			if(type == "end") then self:EmitSound(self.sSoundDir .. "dwarvensteam_fire_end.wav",75,100) end
			self.m_cspFire:Stop()
			self.m_cspFire = nil
		end
		if(type == "start") then
			local ent = ents.Create("info_particle_system")
			ent:SetKeyValue("effect_name","centurion_steam_shout")
			ent:SetKeyValue("start_active","1")
			ent:SetPos(self:GetPos())
			ent:SetParent(self)
			ent:Spawn()
			ent:Activate()
			ent:Fire("SetParentAttachment","mouth",0)
			self:DeleteOnRemove(ent)
			self.m_entSteam = ent
			local csp = CreateSound(self,self.sSoundDir .. "dwarvensteam_fire_lp.wav")
			csp:Play()
			self:StopSoundOnDeath(csp)
			self.m_cspFire = csp
		end
		return true
	end
end

function ENT:SelectScheduleHandle(enemy,dist,distPred,disp)
	if(disp == D_HT) then
		if(self:CanSee(self.entEnemy)) then
			if(dist <= self.fMeleeDistance -35 || distPred <= self.fMeleeDistance -35) then
				self:PlayActivity(ACT_MELEE_ATTACK1, true)
				return
			end
			if(!self:LimbCrippled(HITBOX_LEFTLEG) && !self:LimbCrippled(HITBOX_RIGHTLEG) && CurTime() >= self.m_nextForwardAttack) then
				local ang = self:GetAngleToPos(self.entEnemy:GetPos())
				if(ang.y <= 35 || ang.y >= 325) then
					local fTimeToGoal = self:GetPathTimeToGoal()
					if(self.bDirectChase && fTimeToGoal <= 1.2 && fTimeToGoal >= 0.55 && distPred <= self.fMeleeForwardDistance) then
						self:PlayActivity(ACT_MELEE_ATTACK2)
						self.m_nextForwardAttack = CurTime() +math.Rand(4,12)
						return
					end
				end
			end
			if(dist <= self.fRangeDistance && dist > 100) then
				if(CurTime() >= self.m_tNextRangeAttack) then
					self.m_tNextRangeAttack = CurTime() +math.Rand(4,12)
					if(math.random(1,3) <= 2) then self:PlayActivity(ACT_RANGE_ATTACK1,true); return end
				end
			end
		end
		self:ChaseEnemy()
	elseif(disp == D_FR) then
		self:Hide()
	end
end
