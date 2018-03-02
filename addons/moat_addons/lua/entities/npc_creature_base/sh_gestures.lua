function ENT:GetAnimationID(anim)
	if(!self.AnimationIDs) then return -1 end
	anim = string.lower(anim)
	return self.AnimationIDs[anim] || -1
end

function ENT:IsGesturePlaying(anim)
	local g = self.m_tGestures
	if(!g) then return end
	for slot,data in pairs(g) do
		if(data.name == anim) then return true end
	end
	return false
end

function ENT:GetGesture(ID)
	if(!self.m_tGestures) then return end
	ID = ID || 1
	return self.m_tGestures[ID]
end

function ENT:GetGestureName()
	local g = self:GetGesture(ID)
	return g && g.name
end

function ENT:GetAnimationName(ID)
	if(!self.AnimationNames) then return "INVALID" end
	return self.AnimationNames[ID] || "INVALID"
end

function ENT:OnGestureEnded(name)
end