local self = {}
CAC.ObjectSender = CAC.MakeConstructor (self, CAC.ObjectNetworker)

function self:ctor (ply, object)
	self.Player = nil
	
	self:SetPlayer (ply)
	self:SetObject (object)
end

function self:GetPlayer ()
	return self.Player
end

function self:SetPlayer (ply)
	if self.Player == ply then return self end
	
	self.Player = ply
	
	for childId, childNetworker in self:GetChildNetworkerEnumerator () do
		childNetworker:SetPlayer (ply)
	end
	
	return self
end

function self:IsReceiver ()
	return false
end

function self:IsSender ()
	return true
end

function self:SendFullUpdate ()
	local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
	outBuffer:StringN8  ("FullUpdate")
	self:SerializeFullUpdate (outBuffer, self:GetObject ())
	self:DispatchEvent  ("DispatchPacket", outBuffer)
end

function self:SerializeFullUpdate (outBuffer, object)
	object:Serialize (outBuffer)
	
	return outBuffer
end

-- Children
function self:CreateChildObjectNetworker (objectNetworkerFactory)
	local objectNetworker = objectNetworkerFactory (self:GetPlayer ())
	objectNetworker:SetPlayer (self:GetPlayer ())
	return objectNetworker
end