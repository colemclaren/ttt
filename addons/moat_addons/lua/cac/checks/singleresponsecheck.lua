local self = {}
CAC.SingleResponseCheck = CAC.MakeConstructor (self, CAC.Check)

function self:ctor (checkId, livePlayerSession)
	self.PayloadId = nil
end

-- Check
function self:Start ()
	if self:IsStarted () then return end
	
	self.Started = true
	
	self:DispatchEvent ("Started")
	
	self:DispatchCall ("OnStarted")
	if self:IsFinished () then return end
	
	self:SendPayload (self:GetPayloadId (),
		function (inBuffer)
			if self:DispatchCall ("OnResponse", inBuffer) ~= true then
				self:Finish ()
			end
		end,
		function ()
			if self:DispatchCall ("OnTimedOut") ~= true then
				self:Finish ()
			end
		end
	)
end

-- SingleResponseCheck
function self:GetPayloadId ()
	return self.PayloadId
end

function self:SetPayloadId (payloadId)
	self.PayloadId = payloadId
	return self
end

function self:OnStarted ()
end

function self:OnTimedOut ()
end

function self:OnResponse (inBuffer)
end