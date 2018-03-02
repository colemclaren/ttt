local self, info = CAC.Checks:RegisterCheck ("ConVarBlacklist", CAC.IncrementalReportingCheck)

info:SetName ("Console Variable Blacklist")
info:SetDescription ("Checks for sets of blacklisted console variables.")

-- This check does absolutely nothing.

-- This is because malicious server owners can create "cheat" convars on clients
-- to get them banned from other servers.

function self:ctor (livePlayerSession)
	self:SetPayloadId ("BlacklistedConVarReporter")
end

function self:OnStarted ()
	self:SetStatus ("Sending blacklisted convar reporter...")
	self:SetStatus ("Waiting for blacklisted convar report...")
	
	self:SendPayload ("BlacklistedConVarMonitor",
		function (inBuffer)
			self:ProcessReports (inBuffer)
			
			return true
		end
	)
end

function self:OnResponse (inBuffer)
	self:SetStatus ("Received blacklist convar report!")
	
	local duration = self:ProcessReports (inBuffer)
end

function self:OnTimedOut ()
	self:SetStatus ("Wait for blacklisted convar report timed out.")
	
	self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "Blacklisted convar report did not arrive on time.")
end

function self:OnFinished ()
end

function self:ProcessReportEntry (inBuffer)
	local conVarName   = inBuffer:StringN8 ()
	local conVarString = inBuffer:StringN8 ()
	
	self:AppendLogLine ("\tFound suspicious convar: " .. conVarName .. " = " .. CAC.String.EscapeNonprintable (conVarString))
end