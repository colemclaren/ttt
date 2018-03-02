local self = {}
CAC.LivePlayerSession = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		CheckAdded (Check check)
			Fired when a Check has been added.
		CheckStarted (Check check)
			Fired when a Check has started.
		CheckFinished (Check check)
			Fired when a Check has finished.
		CheckStatusChanged (Check check, status)
			Fired when a Check's status has changed.
		CheckTimeoutChanged (Check check, TimeoutEntry timeoutEntry)
			Fired when a Check's timeout has changed.
		TimeoutAdded (TimeoutEntry timeoutEntry)
			Fired when a timeout has been added.
		TimeoutDescriptionChanged (TimeoutEntry timeoutEntry, description)
			Fired when a timeout's description has been changed.
		TimeoutDurationChanged (TimeoutEntry timeoutEntry, duration)
			Fired when a timeout's duration has been changed.
		TimeoutRemoved (TimeoutEntry timeoutEntry)
			Fired when a timeout has been removed.
]]

local next  = next
local pairs = pairs

function self:ctor (livePlayerSessionManager, steamId, userId, ply, playerSession)
	self.LivePlayerSessionManager = livePlayerSessionManager
	
	-- Identity
	self.SteamId                       = steamId
	self.UserId                        = userId
	self.Player                        = ply
	
	self.PlayerInformation             = CAC.PlayerInformationManager:GetPlayerInformation (steamId, true, true)
	self.PlayerSession                 = playerSession
	
	if SERVER then
		-- Networking
		self.VNetSystem                    = CAC.VNetSystem (self, self.Player)
	
		-- Encryption keys
		self.DataEncryptionKey             = CAC.GenerateEncryptionKey (128)
		self.PathEncryptionKey             = CAC.GenerateEncryptionKey (128)
		
		-- Lua
		self.DynamicLuaInformation         = CAC.LuaInformation ()
		self.ForeignLuaInformation         = CAC.LuaInformation ()
		self.RejectedDynamicLuaInformation = CAC.LuaInformation ()
		
		-- Recover information from last instance
		if self.Player.CACDynamicLuaInformation then
			self.DynamicLuaInformation:Import (self.Player.CACDynamicLuaInformation)
			CAC.Logger:Message ("Imported existing dynamic lua information for " .. self.Player:Name () .. ".")
		end
		
		-- Setup information recovery for next instance
		self.Player.CACDynamicLuaInformation = self.DynamicLuaInformation
	end
	
	-- Checks
	self.Checks                        = {}
	
	-- Payloads
	self.SentPayloads                  = {}
	
	-- Timeouts
	self.NextTimeoutId                 = 1
	self.Timeouts                      = {}
	
	if SERVER then
		-- Replies
		self.NextReplyHandlerId            = math.random (0, 0x00100000) * 0x0100
		self.ReplyHandlers                 = {}
		
		if self.Player.CACReplyHandlers then
			for k, _ in pairs (self.Player.CACReplyHandlers) do
				self.ReplyHandlers [k] = function () return true end -- discard message, but assume there's more coming
			end
			CAC.Logger:Message ("Imported existing reply handlers for " .. self.Player:Name () .. ".")
		end
		
		self.Player.CACReplyHandlers = self.ReplyHandlers
	end
	
	-- Data
	self.Data                          = {}
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:StringN8 (self.SteamId)
	outBuffer:UInt32   (self.UserId )
	
	outBuffer:UInt32   (self.PlayerSession and self.PlayerSession:GetSessionId () or 0)
	
	-- Timeouts
	for timeoutEntry in self:GetTimeoutEnumerator () do
		outBuffer:UInt32 (timeoutEntry:GetId ())
		timeoutEntry:Serialize (outBuffer)
	end
	outBuffer:UInt32 (0)
	
	-- Checks
	for check in self:GetCheckEnumerator () do
		outBuffer:StringN8 (check:GetId ())
		check:Serialize (outBuffer)
	end
	outBuffer:StringN8 ("")
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self.SteamId = inBuffer:StringN8 ()
	self.UserId  = inBuffer:UInt32   ()
	
	local sessionId = inBuffer:UInt32 ()
	if sessionId ~= 0 then
		self.PlayerSession = self.PlayerInformation:CreateSession (sessionId)
	end
	
	-- Timeouts
	local timeoutId = inBuffer:UInt32 ()
	while timeoutId ~= 0 do
		local timeoutEntry = self:GetTimeout (timeoutId) or self:AddTimeout (nil, timeoutId)
		timeoutEntry:Deserialize (inBuffer)
		
		timeoutId = inBuffer:UInt32 ()
	end
	
	-- Checks
	local checkId = inBuffer:StringN8 ()
	while checkId ~= "" do
		local check = self:AddCheck (checkId)
		check:Deserialize (inBuffer)
		
		checkId = inBuffer:StringN8 ()
	end
	
	return self
end

-- LivePlayerSession
function self:GetLivePlayerSessionManager ()
	return self.LivePlayerSessionManager
end

function self:GetPlayerInformation ()
	return self.PlayerInformation
end

function self:GetPlayerSession ()
	return self.PlayerSession
end

function self:GetLiveIncident ()
	return CAC.Incidents:GetLiveIncident (self:GetPlayerSession ():GetIncidentId ())
end

function self:IsValid ()
	if not self.Player then return false end
	if not self.Player:IsValid () then return false end
	if CAC.LivePlayerSessionManager:GetLivePlayerSession (self.Player) ~= self then return end
	return true
end

-- Identity
function self:GetSteamId ()
	return self.SteamId
end

function self:GetUserId ()
	return self.UserId
end

function self:GetPlayer ()
	if not self.Player then
		self.Player = self.LivePlayerSessionManager:GetPlayerFromUserId (self.UserId)
	end
	
	return self.Player
end

-- Encryption keys
function self:GetDataEncryptionKey ()
	return self.DataEncryptionKey
end

function self:GetPathEncryptionKey ()
	return self.PathEncryptionKey
end

-- Lua
function self:GetDynamicLuaInformation ()
	return self.DynamicLuaInformation
end

function self:GetForeignLuaInformation ()
	return self.ForeignLuaInformation
end

function self:GetRejectedDynamicLuaInformation ()
	return self.RejectedDynamicLuaInformation
end

function self:VerifyFunction (description, functionVerificationInformation, doNotSuppressDetection)
	-- Native functions are okay
	if functionVerificationInformation:GetNative () then
		return true, false
	end
	
	-- Normalize path
	functionVerificationInformation:SetPath (CAC.CodeGen.DecodePath (self, functionVerificationInformation:GetPath ()) or functionVerificationInformation:GetPath ())
	
	local lowercaseNormalizedPath = functionVerificationInformation:GetPath ()
	lowercaseNormalizedPath = CAC.LuaWhitelistController:NormalizePath (lowercaseNormalizedPath)
	lowercaseNormalizedPath = string.lower (lowercaseNormalizedPath)
	
	-- Check if we've already determined that the function is unwhitelisted
	-- and return now to prevent the autorefresh checks from kicking in.
	local functionExists = false
	functionExists = functionExists or self:GetRejectedDynamicLuaInformation ():FunctionExists (functionVerificationInformation, lowercaseNormalizedPath)
	functionExists = functionExists or self:GetForeignLuaInformation         ():FunctionExists (functionVerificationInformation, lowercaseNormalizedPath)
	if functionExists then
		if doNotSuppressDetection then
			-- Regenerate the reason
			local functionVerificationResult = CAC.LuaWhitelistController:VerifyFunction (functionVerificationInformation, self.DynamicLuaInformation, false, lowercaseNormalizedPath)
			
			-- Add the detection
			local reason = functionVerificationInformation:FormatVerificationResult (functionVerificationResult)
			self:GetPlayerSession ():AddDetectionReasonFiltered ("ClientsideLuaExecution", "Cannot verify " .. description .. ": " .. reason)
			
			return false, true
		end
		
		return false, false
	end
	
	-- Check the function against the whitelist
	local functionVerificationResult = CAC.LuaWhitelistController:VerifyFunction (functionVerificationInformation, self.DynamicLuaInformation, true, lowercaseNormalizedPath)
	if functionVerificationResult ~= CAC.FunctionVerificationResult.Verified then
		-- Add function to the foreign lua list
		local foreignLuaInformation = self:GetForeignLuaInformation ()
		local luaSourceInformation = foreignLuaInformation:AddSource (foreignLuaInformation:NormalizeSourceId (functionVerificationInformation:GetPath ()))
		luaSourceInformation:AddFunction (CAC.LuaFunctionInformation.FromFunctionVerificationInformation (functionVerificationInformation))
		
		-- Add the detection
		local reason = functionVerificationInformation:FormatVerificationResult (functionVerificationResult)
		self:GetPlayerSession ():AddDetectionReasonFiltered ("ClientsideLuaExecution", "Cannot verify " .. description .. ": " .. reason)
		
		return false, true
	end
	
	return true, false
end

if Profiler then
	self.VerifyFunction = Profiler:Wrap (self.VerifyFunction, "LivePlayerSession:VerifyFunction")
end

-- Code execution
function self:ExecuteCode (code, path, replyId)
	path    = path    or CAC.CodeGen.GeneratePath (self, code)
	replyId = replyId or 0
	
	if Profiler then Profiler:Begin ("util.Compress") end
	local compressedCode = util.Compress (code)
	if Profiler then Profiler:End () end
	
	local outBuffer = CAC.StringOutBuffer ()
	outBuffer:StringN16 (compressedCode)
	outBuffer:StringN16 (path)
	outBuffer:UInt32 (replyId)
	
	if CAC.IsDebug then
		CAC.Logger:Message ("Sent payload (" .. CAC.CodeGen.DecodePath (self, path) .. ", " .. CAC.FormatFileSize (outBuffer:GetSize ()) .. ") to " .. self:GetPlayer ():Nick () .. " (" .. self:GetPlayer ():SteamID () .. ") via ExecutionChannel.")
	end
	
	self:SendMessage (CAC.Identifiers.ExecutionChannelName, outBuffer)
end

if Profiler then
	self.ExecuteCode = Profiler:Wrap (self.ExecuteCode, "LivePlayerSession:ExecuteCode")
end

-- Checks
function self:AddCheck (checkId)
	if self.Checks [checkId] then return self.Checks [checkId] end
	
	self.Checks [checkId] = CAC.Checks:CreateCheck (checkId, self)
	
	if not self.Checks [checkId] then
		CAC.Error ("LivePlayerSession:AddCheck : Check " .. checkId .. " not found!")
		return
	end
	
	self:HookCheck (self.Checks [checkId])
	
	self:DispatchEvent ("CheckAdded", self.Checks [checkId])
	
	return self.Checks [checkId]
end

function self:StartCheck (checkId)
	local check = self:AddCheck (checkId)
	if not check then return nil end
	
	check:Start ()
	return check
end

function self:GetCheck (checkId)
	return self.Checks [checkId]
end

function self:GetCheckEnumerator ()
	return CAC.ValueEnumerator (self.Checks)
end

-- Payloads
function self:AddSentPayload (payloadId)
	self.SentPayloads [payloadId] = true
end

function self:ClearSentPayloads ()
	self.SentPayloads = {}
end

function self:IsPayloadSent (payloadId)
	return self.SentPayloads [payloadId] ~= nil
end

function self:RemoveSentPayload (payloadId)
	self.SentPayloads [payloadId] = nil
end

function self:SendPayload (payloadId, replyId)
	local payloadInformation = CAC.Payloads:GetPayload (payloadId)
	
	if not payloadInformation then
		CAC.Error ("LivePlayerSession:SendPayload : Payload " .. payloadId .. " not found!")
		return
	end
	
	-- Verify conditions
	if not payloadInformation:IsRepeatable () and
	   self:IsPayloadSent (payloadId) then
		error ("CAC.LivePlayerSession:SendPayload : Payload " .. payloadId .. " does not support retransmission!")
		return
	end
	
	-- Reply ID
	if isfunction (replyId) then
		replyId = self:CreateReplyHandler (replyId)
	end
	
	-- Check for reply ID
	if payloadInformation:HasReply () and
	   not replyId then
		error ("CAC.LivePlayerSession:SendPayload : Payload " .. payloadId .. " has a reply, but no reply ID was provided!")
		return
	end
	
	-- Dependencies
	for dependencyPayloadId in payloadInformation:GetDependencyEnumerator () do
		if not self:IsPayloadSent (dependencyPayloadId) then
			self:SendPayload (dependencyPayloadId)
		end
	end
	
	local code = payloadInformation:GenerateProcessedCode (self)
	self:AddSentPayload (payloadId)
	self:ExecuteCode (
		code,
		CAC.CodeGen.GeneratePath (self, code, payloadId),
		replyId
	)
end

-- Timeouts
function self:AddTimeout (callback, timeoutId)
	timeoutId = timeoutId or self:AllocateTimeoutId ()
	
	local timeoutEntry = CAC.TimeoutEntry (timeoutId)
	timeoutEntry:SetCallback (callback)
	
	self.Timeouts [timeoutId] = timeoutEntry
	
	self:DispatchEvent ("TimeoutAdded", timeoutEntry)
	
	return timeoutEntry
end

function self:AllocateTimeoutId ()
	local timeoutId = self.NextTimeoutId
	
	self.NextTimeoutId = (self.NextTimeoutId + 1) % 4294967296
	
	return timeoutId
end

function self:CreditTimeout (t)
	if not next (self.Timeouts) then return end
	
	for _, timeoutEntry in pairs (self.Timeouts) do
		timeoutEntry:Credit (t)
		
		if timeoutEntry:HasTimedOut () then
			timeoutEntry:GetCallback () ()
			self:RemoveTimeout (timeoutEntry)
		end
	end
end

function self:GetTimeout (timeoutId)
	return self.Timeouts [timeoutId]
end

function self:GetTimeoutEnumerator ()
	return CAC.ValueEnumerator (self.Timeouts)
end

function self:RemoveTimeout (timeoutId)
	if not timeoutId then return end
	if istable (timeoutId) then
		timeoutId = timeoutId:GetId ()
	end
	
	if not self.Timeouts [timeoutId] then return end
	
	local timeoutEntry = self.Timeouts [timeoutId]
	self.Timeouts [timeoutId] = nil
	
	self:DispatchEvent ("TimeoutRemoved", timeoutEntry)
end

-- Networking
function self:AddMessageHandler (channelName, handler)
	self.VNetSystem:AddReceiver (channelName, handler)
end

function self:HandleMessage (bitCount)
	self.VNetSystem:HandleMessage (bitCount)
end

function self:SendMessage (channelName, outBuffer)
	self.VNetSystem:Send (channelName, outBuffer)
end

function self:HandleReceivedData (inBuffer)
	local replyHandlerId = inBuffer:UInt32 ()
	if replyHandlerId < 0 then replyHandlerId = replyHandlerId + 4294967296 end
	
	local data = inBuffer:StringN16 ()
	
	if not self.ReplyHandlers [replyHandlerId] then
		-- get rekt
		data = string.sub (data, 1, 64)
		data = CAC.Decrypt (data, self.DataEncryptionKey)
		
		self:GetPlayerSession ():AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Received anticheat data reply with unsolicited ID " .. string.format ("%d (0x%08x)", replyHandlerId, replyHandlerId) .. ", [" .. string.format ("%04x", #data) .. "] " .. "\"" .. CAC.String.EscapeNonprintable (data) .. "\".")
	else
		if Profiler then Profiler:Begin ("CAC.Decrypt") end
		data = CAC.Decrypt (data, self.DataEncryptionKey)
		if Profiler then Profiler:End ("CAC.Decrypt") end
		
		local inBuffer = CAC.StringInBuffer (data)
		
		if CAC.IsDebug then
			CAC.Logger:Message ("Received data (" .. CAC.FormatFileSize (inBuffer:GetSize ()) .. ") for " .. debug.getinfo (self.ReplyHandlers [replyHandlerId]).source)
		end
		
		if Profiler then Profiler:Begin (debug.getinfo (self.ReplyHandlers [replyHandlerId]).source) end
		local moreData = self.ReplyHandlers [replyHandlerId] (inBuffer)
		if not moreData then
			self:DestroyReplyHandler (replyHandlerId)
		end
		if Profiler then Profiler:End () end
	end
end

function self:HandleFunctionReport (inBuffer)
	local functionReportType = inBuffer:UInt8 ()
	local functionName       = inBuffer:StringN8 ()
	functionName = CAC.InverseIdentifiers [functionName] or functionName

	if CAC.IsDebug then
		CAC.Logger:Message ("\tReceived report of " .. functionName)
	end
	
	local passed1        = true
	local passed2        = false
	local detectionAdded = false
	
	if functionReportType == 0 then
		-- Stack trace
		local stackFrameCount = inBuffer:UInt8 ()
		
		local stackFrames = {}
		for i = 1, stackFrameCount do
			stackFrames [i - 1] = CAC.FunctionVerificationInformation ()
			stackFrames [i - 1]:Deserialize (inBuffer)
			
			if CAC.IsDebug then
				CAC.Logger:Message ("\t\t" .. stackFrames [i - 1]:ToString ())
			end
		end
		
		for i = stackFrameCount - 1, 0, -1 do
			local stackFramePassed1, stackFrameDetectionAdded = self:VerifyFunction (functionName .. " call stack entry", stackFrames [i])
			
			local stackFramePassed2 = true
			stackFramePassed2 = stackFramePassed2 and not stackFrames [i]:GetNative ()
			stackFramePassed2 = stackFramePassed2 and not string.find (stackFrames [i]:GetPath (), "lua/includes/modules/.*%.lua$")
			stackFramePassed2 = stackFramePassed2 and not string.find (stackFrames [i]:GetPath (), "lua/includes/extensions/client/vehicle%.lua$")
			
			passed1        = passed1        and stackFramePassed1
			passed2        = passed2        or  stackFramePassed2
			detectionAdded = detectionAdded or  stackFrameDetectionAdded
		end
		
		if detectionAdded then
			for i = 0, stackFrameCount - 1 do
				self:GetPlayerSession ():GetLog ():AppendLine ("\t" .. string.format ("%2d", i) .. "    " .. stackFrames [i]:ToString ())
			end
		end
	elseif functionReportType == 1 then
		-- Function
		local functionVerificationInformation = CAC.FunctionVerificationInformation ()
		functionVerificationInformation:Deserialize (inBuffer)
		
		if not self:VerifyFunction (functionName, functionVerificationInformation) then
			passed1 = false
		end
	else
		self:GetPlayerSession ():AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Malformed function report received (" .. string.format ("%d (0x%02x)", functionReportType, functionReportType) .. ", \"" .. CAC.String.EscapeNonprintable (functionName) .. "\").")
		return
	end
	
	-- Read additional data
	local additionalData = {}
	local additionalDataCount = inBuffer:UInt8 ()
	
	for i = 1, additionalDataCount do
		additionalData [#additionalData + 1] = inBuffer:StringN32 ()
	end
	
	-- Update dynamic lua information if necessary
	local dynamicLuaInformation = passed1 and passed2 and self:GetDynamicLuaInformation () or self:GetRejectedDynamicLuaInformation ()
	
	if functionReportType == 0 then
		-- Stack trace report
		if functionName == "RunString" or
		   functionName == "RunStringEx" or
		   functionName == "CompileString" then
			local sourceId = additionalData [1]
			local code     = additionalData [2]
			sourceId = dynamicLuaInformation:NormalizeSourceId (sourceId)
			dynamicLuaInformation:AddCode (sourceId, code)
			if not passed2 then
				self:GetPlayerSession ():AddDetectionReasonFiltered ("ClientsideLuaExecution", "Unverifiable " .. functionName .. " call stack (" .. CAC.String.EscapeNonprintable (sourceId) .. ": " .. CAC.String.EscapeNonprintable (string.sub (code, 1, 512)) .. ")")
			end
		elseif functionName == "coroutine.create" or
		       functionName == "coroutine.wrap" then
			if not passed2 then
				self:GetPlayerSession ():AddDetectionReasonFiltered ("ClientsideLuaExecution", "Unverifiable " .. functionName .. " call stack")
			end
		end
	end
end

-- Replies
function self:CancelReplyHandler (replyHandlerId)
	self:DestroyReplyHandler (replyHandlerId)
end

function self:CreateReplyHandler (callback)
	local replyHandlerId = self.NextReplyHandlerId
	self.NextReplyHandlerId = (self.NextReplyHandlerId + 1) % 4294967296
	
	-- Avoid overwriting an existing reply handler
	while self.ReplyHandlers [replyHandlerId] do
		replyHandlerId = self.NextReplyHandlerId
		self.NextReplyHandlerId = (self.NextReplyHandlerId + 1) % 4294967296
	end
	
	self.ReplyHandlers [replyHandlerId] = callback
	
	return replyHandlerId
end

function self:DestroyReplyHandler (replyHandlerId)
	self.ReplyHandlers [replyHandlerId] = nil
end

-- Data
function self:GetData ()
	return self.Data
end

-- Modules
function self:IsClientDllAddress (address)
	if address <  self:GetData ().ClientDllImageBase then return false end
	if address >= self:GetData ().ClientDllImageBase + self:GetData ().ClientDllImageSize then return false end
	
	return true
end

function self:IsClientDllAddressRangeCertain ()
	return self:GetData ().ClientDllImageBaseCertain
end

function self:GetFormattedClientDllAddressRange ()
	return string.format ("0x%08x-0x%08x", self:GetData ().ClientDllImageBase, self:GetData ().ClientDllImageBase + self:GetData ().ClientDllImageSize)
end

function self:IsLuaSharedDllAddress (address)
	if address <  self:GetData ().LuaSharedDllImageBase then return false end
	if address >= self:GetData ().LuaSharedDllImageBase + self:GetData ().LuaSharedDllImageSize then return false end
	
	return true
end

function self:IsLuaSharedDllAddressRangeCertain ()
	return self:GetData ().LuaSharedDllImageBaseCertain
end

function self:GetFormattedLuaSharedDllAddressRange ()
	return string.format ("0x%08x-0x%08x", self:GetData ().LuaSharedDllImageBase, self:GetData ().LuaSharedDllImageBase + self:GetData ().LuaSharedDllImageSize)
end

-- Internal, do not call
function self:HookCheck (check)
	if not check then return end
	
	check:AddEventListener ("Started", "CAC.LivePlayerSession." .. self:GetHashCode (),
		function (_)
			self:DispatchEvent ("CheckStarted", check)
		end
	)
	check:AddEventListener ("Finished", "CAC.LivePlayerSession." .. self:GetHashCode (),
		function (_)
			self:DispatchEvent ("CheckFinished", check)
			
			-- Start next checks
			if CAC.Settings:GetSettingsGroup ("UserWhitelistSettings"):GetUserWhitelist ():GetUserWhitelistStatus (self:GetSteamId ()) >= CAC.WhitelistStatus.SuppressChecks then
				return
			end
			
			for nextCheckId in CAC.Checks:GetNextCheckEnumerator (check:GetId ()) do
				self:StartCheck (nextCheckId)
			end
		end
	)
	check:AddEventListener ("StatusChanged", "CAC.LivePlayerSession." .. self:GetHashCode (),
		function (_, status)
			self:DispatchEvent ("CheckStatusChanged", check, status)
		end
	)
	check:AddEventListener ("TimeoutChanged", "CAC.LivePlayerSession." .. self:GetHashCode (),
		function (_, timeoutEntry)
			self:DispatchEvent ("CheckTimeoutChanged", check, timeoutEntry)
		end
	)
end

function self:UnhookCheck (check)
	if not check then return end
	
	check:RemoveEventListener ("Started",        "CAC.LivePlayerSession." .. self:GetHashCode ())
	check:RemoveEventListener ("Finished",       "CAC.LivePlayerSession." .. self:GetHashCode ())
	check:RemoveEventListener ("StatusChanged",  "CAC.LivePlayerSession." .. self:GetHashCode ())
	check:RemoveEventListener ("TimeoutChanged", "CAC.LivePlayerSession." .. self:GetHashCode ())
end

function self:HookTimeoutEntry (timeoutEntry)
	if not timeoutEntry then return end
	
	timeoutEntry:AddEventListener ("DescriptionChanged", "CAC.LivePlayerSession." .. self:GetHashCode (),
		function (_, description)
			self:DispatchEvent ("TimeoutDescriptionChanged", timeoutEntry, description)
		end
	)
	timeoutEntry:AddEventListener ("DurationChanged", "CAC.LivePlayerSession." .. self:GetHashCode (),
		function (_, duration)
			self:DispatchEvent ("TimeoutDurationChanged", timeoutEntry, duration)
		end
	)
end

function self:UnhookTimeoutEntry (timeoutEntry)
	if not timeoutEntry then return end
	
	timeoutEntry:RemoveEventListener ("DescriptionChanged", "CAC.LivePlayerSession." .. self:GetHashCode ())
	timeoutEntry:RemoveEventListener ("DurationChanged",    "CAC.LivePlayerSession." .. self:GetHashCode ())
end