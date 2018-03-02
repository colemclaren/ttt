local self, info = CAC.Checks:RegisterCheck ("Timers", CAC.IncrementalReportingCheck)

info:SetName ("Timers")
info:SetDescription ("Reports the set of timers on the client and any future timers added.")

function self:ctor (livePlayerSession)
	self:SetPayloadId ("TimerReporter")
end

function self:OnStarted ()
	self:SetStatus ("Sending timer reporter...")
	self:SetStatus ("Waiting for timer report...")
	
	self:SendPayload ("TimerLibraryMonitor",
		function (inBuffer)
			self:ProcessReports (inBuffer)
			
			return true
		end
	)
end

function self:OnResponse (inBuffer)
	self:SetStatus ("Received timer report information!")
	
	local duration = self:ProcessReports (inBuffer)
	self:SetStatus ("Timer report serialization took " .. CAC.FormatDuration (duration) .. ".")
end

function self:OnTimedOut ()
	self:SetStatus ("Wait for timer report timed out.")
	
	self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "Timer report did not arrive on time.")
end

function self:OnFinished ()
end

function self:ProcessReportEntry (inBuffer)
	local timerId = inBuffer:UInt32 ()
	
	local functionVerificationInformation = CAC.FunctionVerificationInformation ()
	functionVerificationInformation:Deserialize (inBuffer)
	
	if CAC.IsDebug then
		CAC.Logger:Message ("\tReceived timer report " .. tostring (timerId) .. ": " .. functionVerificationInformation:ToString ())
	end
	
	local description = "timer " .. string.format ("%08d", timerId)
	if not self:GetLivePlayerSession ():VerifyFunction (description, functionVerificationInformation, true) then
		self:SetStatus ("Failed to verify " .. description)
	end
end