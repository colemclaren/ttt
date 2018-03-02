local self = {}
CAC.Detection = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
			Fired when this Detection's data has changed.
]]

function self:ctor ()
	self.ChangedEventPending     = false
	self.ChangedEventsSuppressed = false
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	CAC.Error ("Detection:Serialize : Not implemented (" .. self:GetDetectionType () .. ").")
end

function self:Deserialize (inBuffer)
	CAC.Error ("Detection:Deserialize : Not implemented (" .. self:GetDetectionType () .. ").")
end

-- Detection
function self:GetInformation ()
	return CAC.Detections:GetDetectionInformation (self:GetDetectionType ())
end

function self:GetDescription ()
	CAC.Error ("Detection:GetDescription : Not implemented (" .. self:GetDetectionType () .. ").")
end

-- Internal, do not call
function self:DispatchChanged ()
	self.ChangedEventPending = true
	
	if self.ChangedEventsSuppressed then return end
	
	self.ChangedEventPending = false
	self:DispatchEvent ("Changed")
end

function self:SuppressChangedEvent (suppressChangedEvent)
	self.ChangedEventsSuppressed = suppressChangedEvent
	
	if not self.ChangedEventsSuppressed and
	   self.ChangedEventPending then
		self:DispatchChanged ()
	end
end