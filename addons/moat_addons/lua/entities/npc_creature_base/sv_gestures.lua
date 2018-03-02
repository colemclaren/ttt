util.AddNetworkString("slv_npc_gest")
function ENT:PlayGesture(anim,slot,fcCallOnEnd,bAnim)
	local ID = self:GetAnimationID(anim)
	if(ID == -1) then MsgN("WARNING: Attempting to play invalid gesture animation '" .. anim .. "'..."); return end
	slot = slot || 1
	local bGesture = !bAnim
	net.Start("slv_npc_gest")
		net.WriteEntity(self)
		net.WriteUInt(ID,9)
		net.WriteUInt(slot,4)
		net.WriteUInt(bGesture && 1 || 0,1)
	net.Broadcast()
	self.m_tGestures = self.m_tGestures || {}
	local data = self.Animations[anim]
	self.m_tGestures[slot] = {
		tm = CurTime(),
		anim = data,
		frame = 0,
		name = anim,
		fcCallOnEnd = fcCallOnEnd,
		gesture = bGesture
	}
	return self.m_tGestures[slot]
end

function ENT:PlayAnimation(anim,slot,fcCallOnEnd)
	self:PlayGesture(anim,slot,fcCallOnEnd,true)
end

util.AddNetworkString("slv_npc_gest_stop")
function ENT:StopGesture(slot)
	slot = slot || 1
	net.Start("slv_npc_gest_stop")
		net.WriteEntity(self)
		net.WriteUInt(slot,4)
	net.Broadcast()
	self.m_tGestures[slot] = nil
end

function ENT:PlayGestureActivity(act,slot,fcCallOnEnd)
	if(!self.AnimationActivities) then return end
	local seq = self.AnimationActivities[act]
	if(!seq) then return end
	local g = self:PlayGesture(table.Random(seq),slot,fcCallOnEnd)
	if(!g) then return end
	g.activity = act
end

function ENT:IsPlayingGestureActivity(act,slot)
	slot = slot || 1
	local g = self.m_tGestures[slot]
	if(!g) then return false end
	return g.activity
end

function ENT:MaintainAnimation(slot)
	local gest = self.m_tGestures[slot]
	local anim = gest.anim
	local tm = (CurTime() -gest.tm) *anim:GetFPS()
	local frames = anim:GetFrames()
	local numFrames = anim:GetFrameCount()
	local tmScale = tm /numFrames
	if(tmScale >= 1) then
		local frameCur = gest.frame
		for i = frameCur +1,numFrames do
			local events = anim:GetEvents(i)
			if(events) then
				for _,ev in ipairs(events) do
					self:Event(ev)
					MsgN("Handling animation event: ",ev)
				end
			end
		end
		self.m_tGestures[slot] = nil
		self:OnGestureEnded(gest.name)
		if(gest.fcCallOnEnd) then pcall(gest.fcCallOnEnd) end
	else
		local frameScale = numFrames *(tmScale -math.floor(tmScale))
		local frameID = math.floor(frameScale)
		frameID = frameID +1
		local frameCur = gest.frame
		for i = frameCur +1,frameID do
			local events = anim:GetEvents(i)
			if(events) then
				for _,ev in ipairs(events) do
					self:Event(ev)
				end
			end
		end
		gest.frame = frameID
	end
end

function ENT:MaintainAnimations()
	if(!self.m_tGestures) then return end
	for slot,gest in pairs(self.m_tGestures) do
		self:MaintainAnimation(slot)
	end
end