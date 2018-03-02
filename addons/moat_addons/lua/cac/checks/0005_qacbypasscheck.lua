local self, info = CAC.Checks:RegisterCheck ("QACBypassCheck", CAC.SingleResponseCheck)

info:SetName ("QAC Bypass Check")
info:SetDescription ("Checks if a QAC bypass attempt has been made.")

function self:ctor (livePlayerSession)
	self:SetPayloadId ("QACBypassCheck")
end

function self:OnStarted ()
	self:SetStatus ("Sending QAC bypass check...")
	self:SetStatus ("Waiting for QAC bypass check...")
end

function self:OnResponse (inBuffer)
	self:SetStatus ("Received QAC bypass check status!")
	
	if CAC.Plugins:GetPlugin ("QACCompatibility") and
	   CAC.Plugins:GetPlugin ("QACCompatibility"):IsQACPresent () then
		return
	end
	
	local qacBypassPresent = inBuffer:StringN8 ()
	if qacBypassPresent ~= "false" then
		self:SetStatus ("QAC bypass detected, rekking player...")
		self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "QAC bypass detected (expected \"false\" for presence, got \"" .. CAC.String.EscapeNonprintable (qacBypassPresent) .. "\" instead)!")
	end
end

function self:OnTimedOut ()
	self:SetStatus ("Wait for QAC bypass check timed out.")
	
	self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "QAC bypass check reply did not arrive on time.")
end

function self:OnFinished ()
end