local self = {}
CAC.ObjectReceiver = CAC.MakeConstructor (self, CAC.ObjectNetworker)

--[[
	Events:
		FullUpdateReceived ()
			Fired when a full update has been received.
]]

function self:ctor (object)
	self:SetObject (object)
end

function self:IsReceiver ()
	return true
end

function self:IsSender ()
	return false
end

function self:HandleFullUpdate (inBuffer, object)
	self:DeserializeFullUpdate (inBuffer, object)
	
	self:DispatchEvent ("FullUpdateReceived")
	self:OnFullUpdateReceived (object)
end

function self:DeserializeFullUpdate (inBuffer, object)
	object:Deserialize (inBuffer)
end

function self:OnFullUpdateReceived (object)
end