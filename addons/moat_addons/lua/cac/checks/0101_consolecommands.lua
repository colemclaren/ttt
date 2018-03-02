local self, info = CAC.Checks:RegisterCheck ("ConsoleCommands", CAC.IncrementalReportingCheck)

info:SetName ("Console Commands")
info:SetDescription ("Reports the console commands on the client and any future commands added.")

function self:ctor (livePlayerSession)
	self:SetPayloadId ("ConCommandReporter")
end

function self:OnStarted ()
	self:SetStatus ("Sending console command reporter...")
	self:SetStatus ("Waiting for console command report...")
	
	self:SendPayload ("ConCommandLibraryMonitor",
		function (inBuffer)
			self:ProcessReports (inBuffer)
			
			return true
		end
	)
end

function self:OnResponse (inBuffer)
	self:SetStatus ("Received console command report information!")
	
	local duration = self:ProcessReports (inBuffer)
	self:SetStatus ("Console command report serialization took " .. CAC.FormatDuration (duration) .. ".")
end

function self:OnTimedOut ()
	self:SetStatus ("Wait for console command report timed out.")
	
	self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "Console command report did not arrive on time.")
end

function self:OnFinished ()
end

function self:ProcessReportEntry (inBuffer)
	local conCommandName = inBuffer:StringN8 ()
	
	local functionVerificationInformation = CAC.FunctionVerificationInformation ()
	functionVerificationInformation:Deserialize (inBuffer)
	
	if CAC.IsDebug then
		CAC.Logger:Message ("\tReceived concommand report " .. conCommandName .. ": " .. functionVerificationInformation:ToString ())
	end
	
	local description = "console command \"" .. CAC.String.EscapeNonprintable (conCommandName) .. "\""
	if not self:GetLivePlayerSession ():VerifyFunction (description, functionVerificationInformation, true) then
		self:SetStatus ("Failed to verify " .. description)
	end
end