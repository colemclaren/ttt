function util.CreateSpriteTrace(posStart, posEnd, fLifeTime, width, col)
	fLifeTime = fLifeTime || 5
	width = width || 50
	col = col || Color(255,0,0,255)
	local rp = RecipientFilter()
	rp:AddAllPlayers()

	umsg.Start("HLR_CreateSpriteTrace", rp)
		umsg.Vector(posStart)
		umsg.Vector(posEnd)
		umsg.Float(fLifeTime)
		umsg.Float(width)
		umsg.String(col.r .. "," .. col.g .. "," .. col.b .. "," .. col.a)
	umsg.End()
end

function util.StopSound(csp)	-- Stopping a sound doesn't seem to work in some cases (e.g. stopping from console), can be fixed using a timer
	timer.Simple(0,function() csp:Stop() end)
end

function util.CreateSpriteBox(posStart, posEnd, fLifeTime, width, col)
	local tblPositions = {
		{posStart, Vector(posStart.x, posStart.y, posEnd.z)},
		{posStart, Vector(posStart.x, posEnd.y, posStart.z)},
		{posStart, Vector(posEnd.x, posStart.y, posStart.z)},
		{posEnd, Vector(posEnd.x, posEnd.y, posStart.z)},
		{posEnd, Vector(posEnd.x, posStart.y, posEnd.z)},
		{posEnd, Vector(posStart.x, posEnd.y, posEnd.z)},
		{Vector(posStart.x, posEnd.y, posStart.z), Vector(posStart.x, posEnd.y, posEnd.z)},
		{Vector(posEnd.x, posStart.y, posEnd.z), Vector(posEnd.x, posStart.y, posStart.z)},
		{Vector(posStart.x, posStart.y, posEnd.z), Vector(posEnd.x, posStart.y, posEnd.z)},
		{Vector(posEnd.x, posEnd.y, posStart.z), Vector(posStart.x, posEnd.y, posStart.z)},
		{Vector(posStart.x, posStart.y, posEnd.z), Vector(posStart.x, posEnd.y, posEnd.z)},
		{Vector(posEnd.x, posEnd.y, posStart.z), Vector(posEnd.x, posStart.y, posStart.z)}
	}
	for k, v in pairs(tblPositions) do
		util.CreateSpriteTrace(v[1], v[2], fLifeTime, width, col)
	end
end
umsg.PoolString("slv_snd_new")
umsg.PoolString("slv_snd_pitch")
umsg.PoolString("slv_snd_vol")
umsg.PoolString("slv_snd_fade")
umsg.PoolString("slv_snd_sndlvl")
umsg.PoolString("slv_snd_stop")
local sndIdx = -32767
local tbSounds = {}
hook.Add("PlayerAuthed","sendsounds",function(pl,steamID,uniqueID)
	for idx, data in pairs(tbSounds) do
		if(data.ent:IsValid()) then
			umsg.Start("slv_snd_new",pl)
				umsg.String(data.snd)
				umsg.Short(idx)
				umsg.Short(data.ent:EntIndex())
			umsg.End()
			if(data.pitch) then
				umsg.Start("slv_snd_pitch",pl)
					umsg.Short(idx)
					umsg.Float(data.pitch)
					umsg.Float(data.delta)
				umsg.End()
			end
			if(data.vol) then
				umsg.Start("slv_snd_vol",pl)
					umsg.Short(idx)
					umsg.Float(data.vol)
				umsg.End()
			end
			if(data.lvl) then
				umsg.Start("slv_snd_sndlvl",pl)
					umsg.Short(idx)
					umsg.Float(data.lvl)
				umsg.End()
			end
		end
	end
end)
function util.CreateSound(snd,ent)	-- CreateSound is broken serverside in multiplayer (sound doesn't play if entity is out of range and gets close)
	local idx = sndIdx
	sndIdx = sndIdx +1
	if(sndIdx > 32767) then sndIdx = -32767 end
	umsg.Start("slv_snd_new")
		umsg.String(snd)
		umsg.Short(idx)
		umsg.Short(ent:EntIndex())
	umsg.End()
	tbSounds[idx] = {snd = snd,ent = ent}
	return {
		ChangePitch = function(pitch,delta)
			umsg.Start("slv_snd_pitch")
				umsg.Short(idx)
				umsg.Float(pitch)
				umsg.Float(delta || 0)
			umsg.End()
			tbSounds[idx].pitch = {pitch,delta || 0}
		end,
		ChangeVolume = function(vol)
			umsg.Start("slv_snd_vol")
				umsg.Short(idx)
				umsg.Float(vol)
			umsg.End()
			tbSounds[idx].vol = vol
		end,
		FadeOut = function(sec)
			tbSounds[idx] = nil
			umsg.Start("slv_snd_fade")
				umsg.Short(idx)
				umsg.Float(sec)
			umsg.End()
		end,
		SetSoundLevel = function(lvl)
			umsg.Start("slv_snd_sndlvl")
				umsg.Short(idx)
				umsg.Float(lvl)
			umsg.End()
			tbSounds[idx].lvl = lvl
		end,
		Stop = function()
			tbSounds[idx] = nil
			umsg.Start("slv_snd_stop")
				umsg.Short(idx)
			umsg.End()
		end
	}
end

--------------------
-- OBSOLETE!
-- USE util.DealBlastDamage INSTEAD!!!
--------------------
function util.BlastDmg(inflictor, attacker, pos, radius, dmg, TFilter, dmgType, bReduce)
	TFilter = TFilter && ((type(TFilter) == "function" || type(TFilter) == "table") && TFilter || {TFilter})
	dmgType = dmgType || DMG_GENERIC
	local tblEntsHit = {}
	for k, v in pairs(ents.FindInSphere(pos, radius)) do
		if (!TFilter || (type(TFilter) == "table" && !table.HasValue(TFilter, v)) || type(TFilter) != "table" && TFilter(v)) && !util.TraceLine({start = pos, endpos = v:GetPos() +v:OBBCenter(), mask = MASK_NPCWORLDSTATIC}).Hit && (!v:IsPlayer() || !v:IsPossessing()) then
			local posDmg = v:NearestPoint(pos)
			tblEntsHit[v] = pos:Distance(posDmg)
			local dmg = dmg
			if bReduce then dmg = math.Clamp(((radius -pos:Distance(posDmg)) +100) /radius *dmg, 1, dmg) end
			local dmgInfo = DamageInfo()
			dmgInfo:SetDamage(dmg)
			dmgInfo:SetAttacker(attacker)
			dmgInfo:SetInflictor(inflictor)
			dmgInfo:SetDamageType(dmgType)
			dmgInfo:SetDamagePosition(posDmg)
			v:TakeDamageInfo(dmgInfo)
			if (v:IsNPC() || v:IsPlayer()) && dmgType == DMG_ENERGYBEAM && v:Health() <= 0 then v:Dissolve(attacker, inflictor, 0) end
			
			if (v:IsNPC() && !v.bScripted) || v:IsPlayer() then
				local iBloodCol = v:GetBloodColor()
				if iBloodCol == BLOOD_COLOR_MECH then
					local effectdata = EffectData()
					effectdata:SetStart(posDmg)
					effectdata:SetOrigin(posDmg)
					effectdata:SetScale(1)
					util.Effect("ManhackSparks", effectdata)
				else
					local particle
					if iBloodCol == BLOOD_COLOR_RED then particle = "blood_impact_red_01"
					elseif iBloodCol == BLOOD_COLOR_YELLOW || iBloodCol == BLOOD_COLOR_ANTLION || iBloodCol == BLOOD_COLOR_ANTLION_WORKER then particle = "blood_impact_yellow_01"
					elseif iBloodCol == BLOOD_COLOR_GREEN || iBloodCol == BLOOD_COLOR_ZOMBIE then particle = "blood_impact_green_01"
					elseif iBloodCol == BLOOD_COLOR_BLUE then particle = "blood_impact_blue_01" end
					if particle then ParticleEffect(particle, posDmg, Angle(0,0,0), v) end
				end
			end
		end
	end
	return tblEntsHit
end

function util.DealBlastDamage(pos,radius,dmg,force,attacker,inflictor,bReduce,dmgType,TFilter,fcOnHit)
	TFilter = TFilter && ((type(TFilter) == "function" || type(TFilter) == "table") && TFilter || {TFilter})
	dmgType = dmgType || DMG_BLAST
	local tbEnts = {}
	for _, ent in ipairs(ents.FindInSphere(pos,radius)) do
		if (!TFilter || (type(TFilter) == "table" && !table.HasValue(TFilter, ent)) || type(TFilter) != "table" && TFilter(ent)) && !util.TraceLine({start = pos, endpos = ent:GetPos() +ent:OBBCenter(), mask = MASK_NPCWORLDSTATIC}).Hit && (!ent:IsPlayer() || !ent:IsPossessing()) then
			local posDmg = ent:NearestPoint(pos)
			tbEnts[ent] = pos:Distance(posDmg)
			local dmg,force = dmg,force
			if bReduce then
				local scale = ((radius -pos:Distance(posDmg)) +100) /radius
				dmg = math.Clamp(dmg *scale,1,dmg)
				force = force *scale
			end
			local dmgInfo = DamageInfo()
			dmgInfo:SetDamage(dmg)
			if force then dmgInfo:SetDamageForce((ent:GetPos() +ent:OBBCenter() -pos):GetNormal() *force) end
			if attacker then dmgInfo:SetAttacker(attacker) end
			if inflictor then dmgInfo:SetInflictor(inflictor) end
			dmgInfo:SetDamageType(dmgType)
			dmgInfo:SetDamagePosition(posDmg)
			ent:TakeDamageInfo(dmgInfo)
			if(!fcOnHit || !fcOnHit(ent,dmgInfo)) then
				if (ent:IsNPC() || ent:IsPlayer()) && dmgType == DMG_ENERGYBEAM && ent:Health() <= 0 then ent:Dissolve(attacker,inflictor, 0) end
			end
			
			if (ent:IsNPC() && !ent.bScripted) || ent:IsPlayer() then
				local iBloodCol = ent:GetBloodColor()
				if iBloodCol == BLOOD_COLOR_MECH then
					local effectdata = EffectData()
					effectdata:SetStart(posDmg)
					effectdata:SetOrigin(posDmg)
					effectdata:SetScale(1)
					util.Effect("ManhackSparks", effectdata)
				else
					local particle
					if iBloodCol == BLOOD_COLOR_RED then particle = "blood_impact_red_01"
					elseif iBloodCol == BLOOD_COLOR_YELLOW || iBloodCol == BLOOD_COLOR_ANTLION || iBloodCol == BLOOD_COLOR_ANTLION_WORKER then particle = "blood_impact_yellow_01"
					elseif iBloodCol == BLOOD_COLOR_GREEN || iBloodCol == BLOOD_COLOR_ZOMBIE then particle = "blood_impact_green_01"
					elseif iBloodCol == BLOOD_COLOR_BLUE then particle = "blood_impact_blue_01" end
					if particle then ParticleEffect(particle,posDmg,Angle(0,0,0),ent) end
				end
			end
		end
	end
	return tbEnts
end

function util.CreateExplosion(pos,dmg,radius,inflictor,attacker)
	radius = radius || 260
	dmg = dmg || 85
	local ang = Angle(0,0,0)
	local entParticle = ents.Create("info_particle_system")
	entParticle:SetKeyValue("start_active", "1")
	entParticle:SetKeyValue("effect_name", "dusty_explosion_rockets")//svl_explosion")
	entParticle:SetPos(pos)
	entParticle:SetAngles(ang)
	entParticle:Spawn()
	entParticle:Activate()
	timer.Simple(1, function() if IsValid(entParticle) then entParticle:Remove() end end)
	sound.Play("weapons/explode" .. math.random(7,9) .. ".wav", pos, 110, 100)
	util.BlastDamage(inflictor,attacker || inflictor, pos, radius, dmg)
	util.ScreenShake(pos, 5, dmg, math.Clamp(dmg /100, 0.1, 2), radius *2)
	
	local iDistMin = 26
	local tr
	for i = 1, 6 do
		local posEnd = pos
		if i == 1 then posEnd = posEnd +Vector(0,0,25)
		elseif i == 2 then posEnd = posEnd -Vector(0,0,25)
		elseif i == 3 then posEnd = posEnd +Vector(0,25,0)
		elseif i == 4 then posEnd = posEnd -Vector(0,25,0)
		elseif i == 5 then posEnd = posEnd +Vector(25,0,0)
		elseif i == 6 then posEnd = posEnd -Vector(25,0,0) end
		local tracedata = {
			start = pos,
			endpos = posEnd,
			filter = {inflictor,attacker}
		}
		local trace = util.TraceLine(tracedata)
		local iDist = pos:Distance(trace.HitPos)
		if trace.HitWorld && iDist < iDistMin then
			iDistMin = iDist
			tr = trace
		end
	end
	if tr then
		util.Decal("Scorch",tr.HitPos +tr.HitNormal,tr.HitPos -tr.HitNormal)  
	end
end

local iParticleTracers = 0
function util.ParticleEffectTracer(name, posStart, TCPoints, ang, ent, att, flRemoveDelay)
	iParticleTracers = iParticleTracers +1
	local iCheckpoint = 0
	local tblEnts = {}
	local function CreateCheckpoint(TPoint, att)
		iCheckpoint = iCheckpoint +1
		local _ent = ent
		local ent = ents.Create("obj_target")
		if type(TPoint) == "Vector" then ent:SetPos(TPoint)
		else ent:SetPos(TPoint:GetCenter()); ent:SetParent(TPoint) end
		ent:Spawn()
		ent:Activate()
		if att then ent:Fire("SetParentAttachment", att, 0) end
		table.insert(tblEnts, ent)
		
		local cName = "ParticleEffectTracer" .. iParticleTracers .. "_checkpoint" .. iCheckpoint
		ent:SetName(cName)
		if IsValid(_ent) then _ent:DeleteOnRemove(ent) end
		return ent, cName
	end

	local entParticle = ents.Create("info_particle_system")
	entParticle:SetKeyValue("start_active", "1")
	entParticle:SetKeyValue("effect_name", name)
	local cpoints
	if TCPoints then
		local sType = type(TCPoints)
		if sType == "Vector" || sType == "Entity" || sType == "Player" || sType == "NPC" then
			local ent, cName = CreateCheckpoint(TCPoints)
			cpoints = ent
			entParticle:SetKeyValue("cpoint1", cName)
		else
			cpoints = {}
			for k, v in pairs(TCPoints) do
				local TPoint, att
				if type(v) == "table" then
					TPoint = v.ent
					att = v.att
				else TPoint = v end
				local ent, cName = CreateCheckpoint(TPoint, att)
				table.insert(cpoints, ent)
				entParticle:SetKeyValue("cpoint" .. k, cName)
			end
		end
	end
	entParticle:SetAngles(ang)
	entParticle:SetPos(posStart)
	entParticle:Spawn()
	entParticle:Activate()
	if IsValid(ent) then
		entParticle:SetParent(ent)
		ent:DeleteOnRemove(entParticle)
		if att then entParticle:Fire("SetParentAttachment", att, 0) end
	end
	if flRemoveDelay != false then
		flRemoveDelay = flRemoveDelay || 1
		timer.Simple(flRemoveDelay, function()
			if IsValid(entParticle) then
				entParticle:Remove()
			end
			for k, v in pairs(tblEnts) do
				if IsValid(v) then v:Remove() end
			end
		end)
	end
	return entParticle,cpoints
end

function util.ParticleEffect(name, pos, ang, ent, att, flRemoveDelay)
	local entParticle = ents.Create("info_particle_system")
	entParticle:SetKeyValue("start_active", "1")
	entParticle:SetKeyValue("effect_name", name)
	entParticle:SetAngles(ang)
	entParticle:SetPos(pos)
	entParticle:Spawn()
	entParticle:Activate()
	if IsValid(ent) then
		entParticle:SetParent(ent)
		ent:DeleteOnRemove(entParticle)
		if att then entParticle:Fire("SetParentAttachment", att, 0) end
	end
	if flRemoveDelay != false then
		flRemoveDelay = flRemoveDelay || 1
		timer.Simple(flRemoveDelay, function()
			if IsValid(entParticle) then
				entParticle:Remove()
			end
		end)
	end
	return entParticle
end

function util.GetRandomWorldPos()
	if nodegraph.Exists() then
		local nodes = nodegraph.GetGroundNodes()
		if #nodes > 0 then
			local pos = table.Random(nodes).pos
			local tr = util.TraceLine({
				start = pos +Vector(0,0,20),
				endpos = pos -Vector(0,0,20),
				mask = MASK_SOLID
			})
			return tr.HitPos, tr.HitNormal
		end
	end
	local ents = {}
	for _, ent in ipairs(ents.GetAll()) do
		if ent:IsValid() && ent:GetSolid() == SOLID_NONE then
			table.insert(ents, ent)
		end
	end
	local ent = table.Random(ents)
	if !ent then return end
	local pos = ent:GetPos()
	local tr = util.TraceLine({
		start = pos +Vector(0,0,20),
		endpos = pos -Vector(0,0,20),
		mask = MASK_SOLID
	})
	return tr.HitPos, tr.HitNormal
end

local tblNPCClasses = {}
tblNPCClasses[CLASS_PLAYER_ALLY] = {"npc_gman", "monster_gman", "npc_alyx", "npc_barney", "npc_citizen", "npc_vortigaunt", "npc_monk", "npc_breen", "npc_dog", "npc_eli", "npc_fisherman", "monster_scientist", "monster_sitting_scientist", "npc_kleiner", "npc_magnusson", "npc_mossman", "player", "monster_barney", "npc_mmorpg_salesman", "npc_mmorpg_questman", "npc_mmorpg_civilian", "npc_libertyprime", "npc_dogmeat", "npc_dogskin", "npc_chicken", "npc_protectron", "npc_protectron_outcast", "npc_protectron_construction", "monster_otis", "monster_rosenberg", "monster_wheelchair"}
tblNPCClasses[CLASS_COMBINE] = {"npc_combine_s", "npc_cscanner", "npc_hunter", "npc_manhack", "npc_mortarsynth", "npc_rollermine", "npc_turret_floor", "npc_clawscanner", "npc_combine_camera", "npc_combinedropship", "npc_combinegunship", "npc_helicopter", "npc_turret_ceiling", "npc_turret_ground", "npc_combine_assassin", "npc_strider"}
tblNPCClasses[CLASS_HEADCRAB] = {"npc_headcrab", "npc_headcrab_black", "npc_headcrab_poison", "npc_headcrab_fast", "monster_babycrab", "monster_headcrab", "monster_bigmomma"}
tblNPCClasses[CLASS_MILITARY] = {"monster_human_grunt", "monster_hwgrunt", "monster_human_assassin", "monster_sentry", "monster_miniturret", "monster_miniturret_ceiling", "monster_sentry_decay"}
tblNPCClasses[CLASS_ZOMBIE] = {"monster_zombie_barney", "monster_zombie_soldier", "monster_zombie", "npc_fastzombie_torso", "npc_fastzombie",  "npc_poisonzombie", "npc_zombie", "npc_zombie_torso", "npc_zombine", "monster_gonome", "npc_zombine_torso"}
--tblNPCClasses[CLASS_RACEX] = {"monster_alien_babyvoltigore", "monster_alien_voltigore", "monster_geneworm", "monster_pitdrone", "monster_pitworm_up", "monster_shocktrooper", "monster_shockroach"}
--tblNPCClasses[CLASS_XENIAN] = {"monster_alien_controller", "monster_alien_grunt", "monster_alien_slave", "monster_alien_tor", "monster_nihilanth", "monster_babygarg", "monster_babycrab", "monster_bullchicken", "monster_gargantua", "monster_houndeye", "monster_ichthyosaur", "npc_icky", "monster_panthereye", "npc_devilsquid", "npc_frostsquid", "npc_stukabat", "monster_tentacle"}
--table.Add(tblNPCClasses[CLASS_HEADCRAB], tblNPCClasses[CLASS_XENIAN])
local tblNPCClasses_Hdcrb = table.Copy(tblNPCClasses[CLASS_HEADCRAB])
table.Add(tblNPCClasses[CLASS_HEADCRAB], tblNPCClasses[CLASS_ZOMBIE])
table.Add(tblNPCClasses[CLASS_ZOMBIE], tblNPCClasses_Hdcrb)
function util.SetNPCClassAllies(class, allies)
	tblNPCClasses[class] = allies || {}
end

function util.AddNPCClassAlly(class,ally)
	if(!tblNPCClasses[class]) then tblNPCClasses[class] = {ally}; return end
	table.insert(tblNPCClasses[class],ally);
end

function util.AddNPCClassAllies(class,allies)
	if(!tblNPCClasses[class]) then tblNPCClasses[class] = allies; return end
	table.Add(tblNPCClasses[class],allies)
end

function util.GetNPCClasses()
	local tbl = {}
	for k, v in pairs(tblNPCClasses) do table.insert(tbl, k) end
	return tbl
end

function util.GetNPCClassAllies(class)
	if !class then return tblNPCClasses end
	return tblNPCClasses[class] || {}
end