function ENT:PlayGesture(anim,slot,fcCallOnEnd,bAnim)
	anim = string.lower(anim)
	slot = slot || 1
	local data = self.Animations[anim]
	if(!data) then return end
	local bGesture = !bAnim
	self.m_tGestures = self.m_tGestures || {}
	self.m_tGestures[slot] = {
		tm = CurTime(),
		anim = data,
		name = anim,
		fcCallOnEnd = fcCallOnEnd,
		gesture = bGesture
	}
end

net.Receive("slv_npc_gest",function(len)
	local npc = net.ReadEntity()
	if(!npc:IsValid()) then return end
	local ID = net.ReadUInt(9)
	local slot = net.ReadUInt(4)
	local bGesture = net.ReadUInt(1) == 1
	local name = npc:GetAnimationName(ID)
	npc:PlayGesture(name,slot,nil,!bGesture)
end)

net.Receive("slv_npc_gest_stop",function(len)
	local npc = net.ReadEntity()
	if(!npc:IsValid()) then return end
	local slot = net.ReadUInt(4)
	npc.m_tGestures[slot] = nil
end)

function ENT:MaintainAnimation(slot,numBones)
	//MsgN("Maintaining animation: ",slot,"\t",numBones)
	numBones = numBones || self:GetBoneCount()
	local posSelf = self:GetPos()
	local angSelf = self:GetAngles()
	local post = self.m_bonePositions
	local gest = self.m_tGestures[slot]
	local anim = gest.anim
	local tm = math.max(CurTime() -gest.tm,0) *anim:GetFPS()
	local frames = anim:GetFrames()
	local numFrames = anim:GetFrameCount()
	local tmScale = tm /numFrames
	if(tmScale >= 1) then
		self.m_tGestures[slot] = nil
		self:OnGestureEnded(gest.name)
		if(gest.fcCallOnEnd) then pcall(gest.fcCallOnEnd) end
	else
		local frameScale = numFrames *(tmScale -math.floor(tmScale))
		local frameID = math.floor(frameScale)
		frameScale = frameScale -frameID
		frameID = frameID +1
		local frame = frames[frameID]
		local frameNext
		if(frames[frameID +1]) then frameNext = frames[frameID +1]
		elseif(anim:HasFlag(ANIMATION_FLAG_LOOP)) then frameNext = frames[1]
		else frameNext = frame end
		local bones = anim:GetBones()
		local bonesFrame = frame:GetBonePositions()
		local bonesNext = frameNext:GetBonePositions()
		for i = 0,numBones -1 do
			local name = self:GetBoneName(i)
			local parent = self:GetBoneParent(i)
			local nameParent = anim:GetBoneName(parent)
			local boneID = anim:GetBoneID(name)
			if(boneID) then
				//print("Bone: ",i,name,i,parent)
				local boneFrame = bonesFrame[boneID]
				local bone = bones[boneID]
				local boneNext = bonesNext[boneID]
				local pos,ang
				if(gest.gesture) then pos,ang = unpack(post[i])
				else pos = Vector(0,0,0); ang = Angle(0,0,0) end
				pos = pos +LerpVector(frameScale,boneFrame.pos,boneNext.pos)
				ang = LerpAngle(frameScale,ang +boneFrame.ang,ang +boneNext.ang)
				if(!gest.gesture && bone.root) then
					pos:Rotate(angSelf)
					pos = pos +posSelf
					ang = ang +angSelf
				end
				self:SetBonePosition(i,pos,ang)
			end
		end
	end
end

function ENT:MaintainAnimations(numBones)
	if(!self.m_tGestures) then return end
	for slot,gest in pairs(self.m_tGestures) do
		self:MaintainAnimation(slot,numBones)
	end
end

function ENT:BuildBonePositions(numBones,numPhysBones)
	if(!self.m_tGestures) then return end
	self.m_bonePositions = {}
	for i = 0,numBones -1 do
		local pos,ang = self:GetBonePosition(i)
		self.m_bonePositions[i] = {pos,ang}
	end
	self:MaintainAnimations(numBones)
end