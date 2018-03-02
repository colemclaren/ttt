local self = {}
CAC.LiveIncident = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		PlayerChanged (Player ply)
			Fired when this LiveIncident's player has been updated.
		ResponseCountdownChanged (Countdown countdown)
			Fired when the response countdown has changed.
		ResponseExecuted ()
			Fired when the incident response has been carried out.
		ReviewedByAdminChanged (reviewedByAdmin)
			Fired when this LiveIncident has been reviewed by an admin.
		ReviewedByLocalAdminChanged (reviewedByLocalAdmin)
			Fired when this LiveIncident has been reviewed by the local admin.
]]

function self:ctor ()
	self.Id                   = nil
	
	self.Player               = nil
	
	self.ResponseCountdown    = CAC.Countdown ()
	
	self.ReviewedByAdmin      = false
	self.ReviewedByLocalAdmin = false
	
	CAC.EventProvider (self)
	
	self:HookCountdown (self.ResponseCountdown)
end

function self:dtor ()
	self:UnhookCountdown (self.ResponseCountdown)
end

-- ISerializable
function self:Serialize (outBuffer)
	if self.Player and self.Player:IsValid () then
		outBuffer:Boolean (true)
		outBuffer:UInt32 (self.Player:UserID ())
	else
		outBuffer:Boolean (false)
		outBuffer:UInt32 (0)
	end
	
	self.ResponseCountdown:Serialize (outBuffer)
	outBuffer:Boolean (self.ReviewedByAdmin)
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	if inBuffer:Boolean () then
		local userId = inBuffer:UInt32 ()
		self.Player = CAC.LivePlayerSessionManager:GetPlayerFromUserId (userId)
	else
		inBuffer:UInt32 ()
	end
	
	self.ResponseCountdown:Deserialize (inBuffer)
	self:SetReviewedByAdmin (inBuffer:Boolean ())
	
	return self
end

-- LiveIncident
function self:GetId ()
	return self.Id
end

function self:GetQualifiedIncidentId ()
	return self:GetIncident ():GetQualifiedIncidentId ()
end

function self:GetIncident ()
	return CAC.Incidents:GetIncident (self:GetId ())
end

function self:GetPlayerSession ()
	return self:GetIncident ():GetPlayerSession ()
end

function self:GetLivePlayerSession ()
	return CAC.LivePlayerSessionManager:GetLivePlayerSession (self.Player)
end

function self:GetPlayer ()
	return self.Player
end

function self:GetResponseCountdown ()
	return self.ResponseCountdown
end

function self:IsActive ()
	return self.ResponseCountdown:IsRunning () and
	       self.ResponseCountdown:GetTimeRemaining () > 0
end

function self:IsReviewedByAdmin ()
	return self.ReviewedByAdmin
end

function self:IsReviewedByLocalAdmin ()
	return self.ReviewedByLocalAdmin
end

function self:SetId (id)
	self.Id = id
end

function self:SetPlayer (ply)
	if self.Player == ply then return self end
	
	self.Player = ply
	
	self:DispatchEvent ("PlayerChanged", self.Player)
	
	return self
end

function self:SetReviewedByAdmin (reviewedByAdmin)
	if self.ReviewedByAdmin == reviewedByAdmin then return true end
	
	self.ReviewedByAdmin = reviewedByAdmin
	
	self:DispatchEvent ("ReviewedByAdminChanged", self.ReviewedByAdmin)
	
	return self
end

function self:SetReviewedByLocalAdmin (reviewedByAdmin)
	if self.ReviewedByLocalAdmin == reviewedByLocalAdmin then return true end
	
	self.ReviewedByLocalAdmin = reviewedByLocalAdmin
	
	self:DispatchEvent ("ReviewedByLocalAdminChanged", self.ReviewedByLocalAdmin)
	
	return self
end

-- Responses
function self:AbortResponse (steamIdOrPlayer, name)
	if not self:CanAbortResponse () then return end
	
	local steamId
	
	if isstring (steamIdOrPlayer) then
		steamId = steamIdOrPlayer
		name    = CAC.PlayerMonitor:GetUserName (steamId)
	else
		name    = steamIdOrPlayer:GetName ()
		steamId = steamIdOrPlayer:SteamID ()
	end
	
	self:GetIncident ():Suppress (steamId, name)
	
	self.ResponseCountdown:Stop ()
end

function self:CanAbortResponse ()
	local incident = self:GetIncident ()
	
	if incident:GetResponseExecuted   () then return false end
	if incident:GetResponseSuppressed () then return false end
	if incident:GetResponse () == CAC.DetectionResponse.Ignore then return false end
	
	return true
end

function self:ExecuteResponse ()
	if self:GetIncident ():GetResponseExecuted () then return end
	
	local detectionResponse = self:GetIncident ():GetResponse ()
	
	local incidentMessageParameters = CAC.IncidentMessageParameters.FromLiveIncident (self)
	
	if detectionResponse == CAC.DetectionResponse.Ignore then
		return
	elseif detectionResponse == CAC.DetectionResponse.Kick then
		if self.Player and self.Player:IsValid () then
			self:GetIncident ():SetResponseExecuted (true)
			
			local kickMessage = CAC.FormatMessage (CAC.Settings:GetSettingsGroup ("ResponseSettings"):GetKickMessage (), incidentMessageParameters)
			self.Player:Kick (kickMessage)
			
			self:GetIncident ():GetPlayerSession ():GetLog ():AppendLine ("")
			self:GetIncident ():GetPlayerSession ():GetLog ():AppendLine ("Kicked by anticheat.")
			self:GetIncident ():GetPlayerSession ():GetLog ():Save ()
		end
	elseif detectionResponse == CAC.DetectionResponse.Ban then
		self:GetIncident ():SetResponseExecuted (true)
		
		local kickMessage = CAC.FormatMessage (CAC.Settings:GetSettingsGroup ("ResponseSettings"):GetBanMessage (), incidentMessageParameters)
		
		local banDuration = CAC.Settings:GetSettingsGroup ("ResponseSettings"):GetBanDuration ()
		local banReason   = CAC.FormatMessage (CAC.Settings:GetSettingsGroup ("ResponseSettings"):GetBanReason (), incidentMessageParameters)
		
		local banSystem   = CAC.SystemRegistry:GetSystem ("BanSystem", CAC.Settings:GetSettingsGroup ("ResponseSettings"):GetBanSystem ()) or CAC.SystemRegistry:GetBestSystem ("BanSystem")
		
		-- Kick the player
		if banSystem:CanBanOfflineUsers () and
		   self.Player and self.Player:IsValid () then
			self.Player:Kick (kickMessage)
		end
		
		-- Ban the player
		xpcall (banSystem.Ban,
			function (message)
				ErrorNoHalt (tostring (message) .. "\n" .. debug.traceback () .. "\n")
			end,
			banSystem, self:GetIncident ():GetPlayerSteamId (), banDuration, banReason, nil
		)
		
		-- Kick the player
		if not banSystem:CanBanOfflineUsers () and
		   self.Player and self.Player:IsValid () then
			CAC.CallDelayed (
				function ()
					if not self.Player then return end
					if not self.Player:IsValid () then return end
					
					self.Player:Kick (kickMessage)
				end
			)
		end
		
		self:GetIncident ():GetPlayerSession ():GetLog ():AppendLine ("")
		self:GetIncident ():GetPlayerSession ():GetLog ():AppendLine ("Banned by anticheat.")
		self:GetIncident ():GetPlayerSession ():GetLog ():Save ()
	end
	
	self:DispatchEvent ("ResponseExecuted")
end

function self:StartResponse (detectionResponse)
	local incident = self:GetIncident ()
	
	local currentResponse = incident:GetResponse ()
	if currentResponse == detectionResponse and
	   not incident:GetResponseSuppressed () then
		return
	end
	
	-- Unsuppress response
	self:GetIncident ():Unsuppress ()
	
	if detectionResponse == CAC.DetectionResponse.Ignore then
		self.ResponseCountdown:Stop ()
	else
		self.ResponseCountdown:SetDuration (CAC.Settings:GetSettingsGroup ("ResponseSettings"):GetCountdownDuration ())
		self.ResponseCountdown:Start ()
	end
	incident:SetResponse (detectionResponse)
end

-- Internal, do not call
function self:HookCountdown (countdown)
	if not countdown then return end
	
	countdown:AddEventListener ("Changed", "CAC.LiveIncident." .. self:GetHashCode (),
		function (_)
			self:DispatchEvent ("ResponseCountdownChanged", countdown)
		end
	)
end

function self:UnhookCountdown (countdown)
	if not countdown then return end
	
	countdown:RemoveEventListener ("Changed", "CAC.LiveIncident." .. self:GetHashCode ())
end