local self = {}
CAC.ReasonArrayDetection = CAC.MakeConstructor (self, CAC.Detection)

--[[
	Events:
		Changed ()
			Fired when this Detection's data has changed.
		ReasonAdded (reason)
			Fired when a reason has been added.
		ReasonsCleared ()
			Fired when the reasons have been cleared.
]]

function self:ctor ()
	self.Reasons = {}
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt32 (self:GetReasonCount ())
	
	for reason in self:GetReasonEnumerator () do
		outBuffer:StringN32 (reason)
	end
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SuppressChangedEvent (true)
	
	self:ClearReasons ()
	
	local reasonCount = inBuffer:UInt32 ()
	for i = 1, reasonCount do
		self:AddReason (inBuffer:StringN32 ())
	end
	
	self:SuppressChangedEvent (false)
	
	return self
end

-- Detection
function self:GetDescription ()
	local lines = {}
	
	lines [#lines + 1] = self:GetInformation ():GetName () .. ":"
	
	for i = 1, #self.Reasons do
		lines [#lines + 1] = "        " .. self.Reasons [i]
	end
	
	return table.concat (lines, "\n")
end

-- ReasonArrayDetection
function self:AddReason (reason)
	if #self.Reasons >= 20 then return end -- NOPE
	
	self.Reasons [#self.Reasons + 1] = reason
	
	self:DispatchChanged ()
	self:DispatchEvent ("ReasonAdded", reason)
end

function self:ClearReasons ()
	if self:GetReasonCount () == 0 then return end
	
	self.Reasons = {}
	
	self:DispatchChanged ()
	self:DispatchEvent ("ReasonsCleared")
end

function self:GetReason (index)
	return self.Reasons [index]
end

function self:GetReasonCount ()
	return #self.Reasons
end

function self:GetReasonEnumerator ()
	return CAC.ArrayEnumerator (self.Reasons)
end

function self:GetReasonString ()
	return table.concat (self.Reasons, "\n")
end