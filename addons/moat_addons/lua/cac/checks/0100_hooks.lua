local self, info = CAC.Checks:RegisterCheck ("Hooks", CAC.IncrementalReportingCheck)

info:SetName ("Hook Reporting")
info:SetDescription ("Reports the set of hooks on the client and any future hooks added.")

function self:ctor (livePlayerSession)
	self:SetPayloadId ("HookReporter")
end

function self:OnStarted ()
	self:SetStatus ("Sending hook reporter...")
	self:SetStatus ("Waiting for hook report...")
	
	self:SendPayload ("HookLibraryMonitor",
		function (inBuffer)
			self:ProcessReports (inBuffer)
			
			return true
		end
	)
end

function self:OnResponse (inBuffer)
	self:SetStatus ("Received hook report information!")
	
	local duration = self:ProcessReports (inBuffer)
	self:SetStatus ("Hook report serialization took " .. CAC.FormatDuration (duration) .. ".")
	
	self:SendPayload ("GamemodeHookReporter")
end

function self:OnTimedOut ()
	self:SetStatus ("Wait for hook report timed out.")
	
	self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "Hook report did not arrive on time.")
end

function self:OnFinished ()
end

function self:ProcessReportEntry (inBuffer)
	local eventName = inBuffer:StringN8 ()
	local hookName  = inBuffer:StringN8 ()
	
	local functionVerificationInformation = CAC.FunctionVerificationInformation ()
	functionVerificationInformation:Deserialize (inBuffer)
	
	if CAC.IsDebug then
		CAC.Logger:Message ("\tReceived hook report " .. eventName .. "." .. hookName .. ": " .. functionVerificationInformation:ToString ())
	end
	
	local description = "hook \"" .. CAC.String.EscapeNonprintable (eventName) .. "\".\"" .. CAC.String.EscapeNonprintable (hookName) .. "\""
	if not self:GetLivePlayerSession ():VerifyFunction (description, functionVerificationInformation, true) then
		self:SetStatus ("Failed to verify " .. description)
	end
end