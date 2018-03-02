local self, info = CAC.Checks:RegisterCheck ("ConVarMonitor", CAC.IncrementalReportingCheck)

info:SetName ("Console Variable Monitor")
info:SetDescription ("Checks for forced console variables.")

function self:ctor (livePlayerSession)
	self:SetPayloadId ("ConVarReporter")
end

function self:OnStarted ()
	self:SetStatus ("Sending convar reporter...")
	self:SetStatus ("Waiting for convar report...")
	
	self:SendPayload ("ConVarMonitor",
		function (inBuffer)
			self:ProcessReports (inBuffer)
			
			return true
		end
	)
end

function self:OnResponse (inBuffer)
	self:SetStatus ("Received convar report information!")
	
	local conVarNames = {}
	local duration = self:ProcessReports (inBuffer, conVarNames)
	
	-- Check that the convars reported are as expected
	local conVarNameSet = {}
	CAC.InvertTable (conVarNames, conVarNameSet)
	
	for conVarName in CAC.RestrictedConVars:GetEnumerator () do
		if not conVarNameSet [conVarName] then
			self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Convar report is missing convar \"" .. CAC.String.EscapeNonprintable (conVarName) .. "\".")
		end
	end
	
	for conVarName, _ in pairs (conVarNameSet) do
		if not CAC.RestrictedConVars:ContainsConVar (conVarName) then
			self:AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Convar report contains unexpected convar \"" .. CAC.String.EscapeNonprintable (conVarName) .. "\".")
		end
	end
	
	self:SetStatus ("Convar report serialization took " .. CAC.FormatDuration (duration) .. ".")
end

function self:OnTimedOut ()
	self:SetStatus ("Wait for convar report timed out.")
	
	self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "Convar report did not arrive on time.")
end

function self:OnFinished ()
end

function self:ProcessReportEntry (inBuffer)
	local conVarName   = inBuffer:StringN8  ()
	local conVarName2  = inBuffer:StringN8  ()
	local booleanValue = inBuffer:Boolean   ()
	local integerValue = inBuffer:Int64     ()
	local floatValue   = inBuffer:Float     ()
	local stringValue  = inBuffer:StringN16 ()
	
	if not CAC.RestrictedConVars:ContainsConVar (conVarName) then return conVarName end
	
	if conVarName2 == "" then
		self:AddDetectionReasonFiltered ("ConVarManipulation", "Cannot find " .. conVarName .. " convar on client!")
		return conVarName
	end
	
	-- Replicated convars need to match the value on the server
	-- Cheat convars need to match the default value
	if CAC.RestrictedConVars:IsReplicatedConVar (conVarName) then
		local typeName = CAC.RestrictedConVars:GetConVarType (conVarName)
		if typeName == "Boolean" then
			if not CAC.ConVarMonitor:ValidateBooleanValue (conVarName, booleanValue) then
				self:AddDetectionReasonFiltered ("ConVarManipulation", conVarName .. " mismatch (" .. (booleanValue and "1" or "0") .. " on client, " .. CAC.ConVarMonitor:GetStringValue (conVarName) .. " on server)")
			end
		elseif typeName == "Integer" then
			if not CAC.ConVarMonitor:ValidateIntegerValue (conVarName, integerValue) then
				self:AddDetectionReasonFiltered ("ConVarManipulation", conVarName .. " mismatch (" .. tostring (integerValue) .. " on client, " .. CAC.ConVarMonitor:GetStringValue (conVarName) .. " on server)")
			end
		elseif typeName == "Float" then
			if not CAC.ConVarMonitor:ValidateFloatValue (conVarName, floatValue) then
				self:AddDetectionReasonFiltered ("ConVarManipulation", conVarName .. " mismatch (" .. tostring (floatValue) .. " on client, " .. CAC.ConVarMonitor:GetStringValue (conVarName) .. " on server)")
			end
		elseif typeName == "String" then
			if not CAC.ConVarMonitor:ValidateStringValue (conVarName, stringValue) then
				self:AddDetectionReasonFiltered ("ConVarManipulation", conVarName .. " mismatch (\"" .. CAC.String.EscapeNonprintable (stringValue) .. "\" on client, " .. CAC.ConVarMonitor:GetStringValue (conVarName) .. " on server)")
			end
		end
	elseif CAC.RestrictedConVars:IsCheatConVar (conVarName) then
		if not CAC.ConVarMonitor:ValidateBooleanValue ("sv_cheats", true) and
		   not game.SinglePlayer () then
			local typeName = CAC.RestrictedConVars:GetConVarType (conVarName)
			if typeName == "Boolean" then
				if booleanValue ~= CAC.RestrictedConVars:GetDefaultConVarValue (conVarName) then
					self:AddDetectionReasonFiltered ("ConVarManipulation", conVarName .. " mismatch (" .. (booleanValue and "1" or "0") .. ", but " .. tostring (CAC.RestrictedConVars:GetDefaultConVarValue (conVarName)) .. " expected)")
				end
			elseif typeName == "Integer" then
				if integerValue ~= CAC.RestrictedConVars:GetDefaultConVarValue (conVarName) then
					self:AddDetectionReasonFiltered ("ConVarManipulation", conVarName .. " mismatch (" .. tostring (integerValue) .. ", but " .. tostring (CAC.RestrictedConVars:GetDefaultConVarValue (conVarName)) .. " expected)")
				end
			elseif typeName == "Float" then
				if floatValue ~= CAC.RestrictedConVars:GetDefaultConVarValue (conVarName) then
					self:AddDetectionReasonFiltered ("ConVarManipulation", conVarName .. " mismatch (" .. tostring (floatValue) .. ", but " .. tostring (CAC.RestrictedConVars:GetDefaultConVarValue (conVarName)) .. " expected)")
				end
			elseif typeName == "String" then
				if stringValue ~= CAC.RestrictedConVars:GetDefaultConVarValue (conVarName) then
					self:AddDetectionReasonFiltered ("ConVarManipulation", conVarName .. " mismatch (\"" .. CAC.String.EscapeNonprintable (stringValue) .. "\", but \"" .. CAC.String.EscapeNonprintable (CAC.RestrictedConVars:GetDefaultConVarValue (conVarName)) .. "\" expected)")
				end
			end
		end
	end
	
	return conVarName
end