local meta = FindMetaTable("Angle")
function meta:Normalize()
	return Angle(math.NormalizeAngle(self.p), math.NormalizeAngle(self.y), math.NormalizeAngle(self.r))
end

function meta:Clamp()
	while self.p < 0 do self.p = self.p +360 end
	while self.y < 0 do self.y = self.y +360 end
	while self.r < 0 do self.r = self.r +360 end
	
	while self.p > 360 do self.p = self.p -360 end
	while self.y > 360 do self.y = self.y -360 end
	while self.r > 360 do self.r = self.r -360 end
end

meta = FindMetaTable("Vector")
function meta:DistanceSqr(vec)
	return (self -vec):LengthSqr()
end

function meta:ClampToDir(dirTgt,flTolerance)
	self.x = math.Clamp(self.x,dirTgt.x -flTolerance,dirTgt.x +flTolerance)
	self.y = math.Clamp(self.y,dirTgt.y -flTolerance,dirTgt.y +flTolerance)
	self.z = math.Clamp(self.z,dirTgt.z -flTolerance,dirTgt.z +flTolerance)
end

meta = FindMetaTable("NPC")
function meta:GetHeadPos()
	local iBone
	local tblBones = {"Bip01 Head", "ValveBiped.Bip01_Head1", "ValveBiped.Bip01_Spine4"}
	for k, v in pairs(tblBones) do
		local _iBone = self:LookupBone(v)
		if _iBone then iBone = _iBone; break end
	end
	if !iBone then return self:GetCenter() end
	local pos, ang = self:GetBonePosition(iBone)
	return pos
end

meta = FindMetaTable("Entity")
function meta:FollowBone(ent,boneID)
	local idx = self:EntIndex()
	local hk = "followbone" .. idx
	if(!ent) then
		hook.Remove("Think",hk)
		return
	end
	local bonepos,boneang = ent:GetBonePosition(boneID)
	if(!bonepos) then
		hook.Remove("Think",hk)
		MsgN("Warning: Invalid bone '" .. boneID .. "' on entity " .. tostring(ent) .. " (FollowBone)")
		return
	end
	local pos = self:GetPos()
	local ang = self:GetAngles()
	local posOffset = (pos -bonepos)
	local angOffset = (ang -ent:GetAngles())
	hook.Add("Think",hk,function()
		if(!ent:IsValid() || !self:IsValid()) then hook.Remove("Think",hk)
		else
			local bonepos,boneang = ent:GetBonePosition(boneID)
			if(bonepos) then
				boneang = ent:GetAngles()
				bonepos = bonepos +posOffset
				boneang = boneang +angOffset
				self:SetPos(bonepos)
				self:SetAngles(boneang)
			end
		end
	end)
end

function meta:GetCenter()
	return self:GetPos() +self:OBBCenter()
end

function meta:GetLocalVelocity()
	local vel = self:GetVelocity()
	local dirVel = vel:GetNormal()
	local len = vel:Length()
	local dir = self:GetForward()
	local ang = dir:Angle()
	local angVel = dirVel:Angle()
	return (angVel -ang):Forward() *len
end

function meta:FindInCone(deg,dist,filter)
	local pos = self.GetShootPos && self:GetShootPos() || (self:GetPos() +self:OBBCenter())
	local dir = self.GetAimVector && self:GetAimVector() || self:GetForward()
	local ang = dir:Angle()
	local tbEnts = {}
	for _, ent in ipairs(ents.FindInSphere(pos,dist)) do
		if(ent:IsValid() && !filter || filter(ent)) then
			local posTgt = ent:NearestPoint(pos)
			local ang = ang -(posTgt -pos):Angle()
			while(ang.p < 0) do ang.p = ang.p +360 end
			while(ang.y < 0) do ang.y = ang.y +360 end
			while(ang.p > 360) do ang.p = ang.p -360 end
			while(ang.y > 360) do ang.y = ang.y -360 end
			if(ang.p <= deg || ang.p >= 360 -deg) && (ang.y <= deg || ang.y >= 360 -deg) then
				table.insert(tbEnts,ent)
			end
		end
	end
	return tbEnts
end

-- OBSOLETE: Use util.GetConstrictedDirection instead
function meta:GetConstrictedDirection(posStart, iLimitPitch, iLimitYaw, posEnd)
	posStart = posStart || self:GetPos()
	iLimitPitch = iLimitPitch || 45
	iLimitYaw = iLimitYaw || 45
	local angSelf = self:GetAngles()
	local ang = angSelf -(posEnd -posStart):Angle()
	while ang.p > 0 do ang.p = ang.p -360 end
	while ang.p < -360 do ang.p = ang.p +360 end
	while ang.y > 0 do ang.y = ang.y -360 end
	while ang.y < -360 do ang.y = ang.y +360 end
	local angEnd = (posEnd -posStart):Angle()
	if ang.p > -360 +iLimitPitch && ang.p < -90 then
		angEnd.p = angEnd.p +(ang.p -iLimitPitch)
	elseif ang.p < -iLimitPitch && ang.p >= -90 then
		angEnd.p = angEnd.p +(ang.p +iLimitPitch)
	end
	if ang.y < -iLimitYaw then
		if ang.y > -180 then
			angEnd.y = angEnd.y +(ang.y +iLimitYaw)
		elseif ang.y > -360 +iLimitYaw then
			angEnd.y = angEnd.y +(ang.y -iLimitYaw)
		end
	end
	return angEnd:Forward()
end

function meta:GetAttPos(att)
	if type(att) == "string" then
		att = self:LookupAttachment(att)
	end
	if !att || att <= 0 then return end
	return self:GetAttachment(att).Pos
end

function meta:GetAttAng(att)
	if type(att) == "string" then
		att = self:LookupAttachment(att)
	end
	if !att || att <= 0 then return end
	return self:GetAttachment(att).Ang
end

function meta:GetPredictedPos(flDelay)
	flDelay = flDelay || 1
	return self:GetPos() +self:GetVelocity() *flDelay
end

function meta:Distance(TArg)
	local pos
	if type(TArg) == "Vector" then pos = TArg
	else pos = TArg:GetPos() end
	return self:GetPos():Distance(pos)
end

function meta:OBBDistance(ent)
	local posTarget = ent:NearestPoint(self:GetPos() +ent:OBBCenter())
	local posSelf = self:NearestPoint(ent:GetPos() +self:OBBCenter())
	posTarget.z = ent:GetPos().z
	posSelf.z = self:GetPos().z
	return posSelf:Distance(posTarget)
end

function meta:PosInViewCone(pos, fDeg)
	fDeg = fDeg || 45
	local ang
	if self:IsPlayer() then ang = self:GetAimVector():Angle() end
	ang = self:GetAngleToPos(pos,ang)
	return (ang.p <= fDeg || ang.p >= 360 -fDeg) && (ang.y <= fDeg || ang.y >= 360 -fDeg)
end

function meta:EntInViewCone(ent, fDeg)
	return self:PosInViewCone(ent:GetPos(), fDeg)
end

local tblEntsNoCollide = {}
local tblEntsNoCollideByClass = {}
hook.Add("OnEntityCreated", "HLR_Collisions_EntCheckForClass", function(entA)
	timer.Simple(0, function()
		if IsValid(entA) then
			local sClass = entA.ClassName || entA:GetClass()
			for entB, tbl in pairs(tblEntsNoCollideByClass) do
				if IsValid(entB) then
					if tbl[sClass] then
						entB:NoCollide(entA)
					end
				else tblEntsNoCollideByClass[entB] = nil end
			end
		end
	end)
end)

if SERVER then
	hook.Add("PlayerInitialSpawn", "SLV_UpdateCollisions", function(ply)
		if !IsValid(ply) then return end
		timer.Simple(0.5, function() -- Let the entities initialize clientside
			if !IsValid(ply) then return end
			for entA, dat in pairs(tblEntsNoCollide) do
				if !IsValid(entA) then tblEntsNoCollide[entA] = nil
				else
					for entB, _ in pairs(dat) do if(!entB:IsValid()) then tblEntsNoCollide[entA][entB] = nil end end
				end
			end
			for ent, dat in pairs(tblEntsNoCollideByClass) do
				if !IsValid(ent) then tblEntsNoCollide[ent] = nil end
			end
			
			umsg.Start("SLV_UpdateCollisions", ply)
				umsg.Short(table.Count(tblEntsNoCollide))
				for entA, dat in pairs(tblEntsNoCollide) do
					umsg.Entity(entA)
					umsg.Short(table.Count(dat))
					for entB, _ in pairs(dat) do
						umsg.Entity(entB)
					end
				end
				umsg.Short(table.Count(tblEntsNoCollideByClass))
				for ent, dat in pairs(tblEntsNoCollideByClass) do
					umsg.Entity(ent)
					umsg.Short(table.Count(dat))
					for class, _ in pairs(dat) do
						umsg.String(class)
					end
				end
			umsg.End()
		end)
	end)
end

function meta:NoCollide(ent)
	tblEntsNoCollide[self] = tblEntsNoCollide[self] || {}
	if type(ent) != "string" then
		if tblEntsNoCollide[self][ent] then return end
		tblEntsNoCollide[self][ent] = true
		
		if CLIENT then return end
		local rp = RecipientFilter()
		rp:AddAllPlayers()
		
		umsg.Start("HLR_EntsCollide", rp)
			umsg.Entity(self)
			umsg.Entity(ent)
			umsg.Bool(false)
		umsg.End()
		return
	end
	if tblEntsNoCollideByClass[self] && tblEntsNoCollideByClass[self][ent] then return end
	for _, ent in pairs(ents.FindByClass(ent)) do
		tblEntsNoCollide[self][ent] = true
	end
	for ent, _ in pairs(tblEntsNoCollide[self]) do if !IsValid(ent) then tblEntsNoCollide[self][ent] = nil end end
	if table.Count(tblEntsNoCollide[self]) == 0 then tblEntsNoCollide[self] = nil end
	tblEntsNoCollideByClass[self] = tblEntsNoCollideByClass[self] || {}
	tblEntsNoCollideByClass[self][ent] = true
	
	if CLIENT then return end
	umsg.Start("HLR_EntsCollideClass")
		umsg.Entity(self)
		umsg.String(ent)
		umsg.Bool(false)
	umsg.End()
end

function meta:Collide(ent)
	if type(ent) == "string" then
		if tblEntsNoCollide[self] then
			for _ent, _ in pairs(tblEntsNoCollide[self]) do
				if IsValid(_ent) && _ent:GetClass() == ent then
					tblEntsNoCollide[self][_ent] = nil
				end
			end
			for ent, _ in pairs(tblEntsNoCollide[self]) do if !IsValid(ent) then tblEntsNoCollide[self][ent] = nil end end
			if table.Count(tblEntsNoCollide[self]) == 0 then tblEntsNoCollide[self] = nil end
		end
		if tblEntsNoCollideByClass[self] then
			tblEntsNoCollideByClass[self][ent] = nil
			if table.Count(tblEntsNoCollideByClass[self]) == 0 then tblEntsNoCollideByClass[self] = nil end
		end
		if CLIENT then return end
		umsg.Start("HLR_EntsCollideClass")
			umsg.Entity(self)
			umsg.String(ent)
			umsg.Bool(true)
		umsg.End()
		return
	end
	if tblEntsNoCollide[self] then for ent, _ in pairs(tblEntsNoCollide[self]) do if !IsValid(ent) then tblEntsNoCollide[self][ent] = nil end end end
	if tblEntsNoCollide[self] && tblEntsNoCollide[self][ent] then
		tblEntsNoCollide[self][ent] = nil
		if SERVER then
			umsg.Start("HLR_EntsCollide")
				umsg.Entity(self)
				umsg.Entity(ent)
				umsg.Bool(true)
			umsg.End()
		end
		if table.Count(tblEntsNoCollide[self]) == 0 then tblEntsNoCollide[self] = nil end
	elseif tblEntsNoCollide[ent] && tblEntsNoCollide[ent][self] then
		tblEntsNoCollide[ent][self] = nil
		if SERVER then
			umsg.Start("HLR_EntsCollide")
				umsg.Entity(self)
				umsg.Entity(ent)
				umsg.Bool(true)
			umsg.End()
		end
		if table.Count(tblEntsNoCollide[ent]) == 0 then tblEntsNoCollide[ent] = nil end
	end
end

function meta:CanCollide(ent)
	if(type(ent) != "string" && ((self.ShouldCollide && self:ShouldCollide(ent) == false) || (ent.ShouldCollide && ent:ShouldCollide(self) == false))) then return false end
	return (!tblEntsNoCollide[self] || !tblEntsNoCollide[self][ent]) && (!tblEntsNoCollide[ent] || !tblEntsNoCollide[ent][self])
end

function meta:IsPhysicsEntity()
	return !self:IsNPC() && !self:IsPlayer() && !self:IsWorld() && IsValid(self:GetPhysicsObject())
end

function meta:GetAngleToPos(pos, _ang, bDontClamp)
	local _pos
	if self:IsPlayer() then
		_pos = self:GetShootPos()
		if !_ang then
			_ang = self:GetAimVector():Angle()
		end
	else
		_ang = _ang || self:GetAngles()
		_pos = self:GetPos()
	end
	local ang = _ang -(pos -_pos):Angle()
	if !bDontClamp then ang:Clamp() end
	return ang
end

meta = FindMetaTable("Player")
function meta:GetHeadPos()
	local pos = self:GetPos()
	if !self:Crouching() then
		pos.z = pos.z +self:OBBMaxs().z -15
	else
		pos.z = pos.z +self:OBBMaxs().z -20
	end
	return pos
end

function math.ClampAngle(deg,min,max)
	min = math.NormalizeAngle(min)
	max = math.NormalizeAngle(max)
	deg = math.NormalizeAngle(deg)
	local diffMin = math.AngleDifference(deg,min)
	local diffMax = math.AngleDifference(deg,max)
	if(diffMax > 0 || diffMin < 0) then
		if(math.abs(diffMax) <= math.abs(diffMin)) then deg = max
		else deg = min end
	end
	return deg
end

meta = FindMetaTable("Angle")
function meta:Unify(lower)
	local upper = lower +360
	while(self.p < lower) do self.p = self.p +360 end
	while(self.y < lower) do self.y = self.y +360 end
	while(self.r < lower) do self.r = self.r +360 end
	while(self.p > upper) do self.p = self.p -360 end
	while(self.y > upper) do self.y = self.y -360 end
	while(self.r > upper) do self.r = self.r -360 end
end

function meta:Difference(angTgt)
	return Angle(math.AngleDifference(self.p,angTgt.p),math.AngleDifference(self.y,angTgt.y),math.AngleDifference(self.r,angTgt.r))
end