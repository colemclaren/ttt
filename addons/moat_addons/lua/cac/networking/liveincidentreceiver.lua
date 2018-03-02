local self = {}
CAC.LiveIncidentReceiver = CAC.MakeConstructor (self, CAC.ObjectReceiver)

function self:ctor (object)
end

function self:HandlePlayerChanged (inBuffer, liveIncident)
	if inBuffer:Boolean () then
		local userId = inBuffer:UInt32 ()
		liveIncident:SetPlayer (CAC.LivePlayerSessionManager:GetPlayerFromUserId (userId))
	else
		inBuffer:UInt32 ()
		liveIncident:SetPlayer (nil)
	end
end

function self:HandleResponseCountdownChanged (inBuffer, liveIncident)
	liveIncident:GetResponseCountdown ():Deserialize (inBuffer)
end

function self:HandleReviewedByAdminChanged (inBuffer, liveIncident)
	liveIncident:SetReviewedByAdmin (inBuffer:Boolean ())
end

function self:HookObject (object)
	if not object then return end
	
	object:AddEventListener ("AbortResponse", "CAC.LiveIncidentReceiver." .. self:GetHashCode (),
		function (_)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8 ("AbortResponse")
			
			self:DispatchEvent ("DispatchPacket", outBuffer)
		end
	)
end

function self:UnhookObject (object)
	if not object then return end
end

function self:__call (...)
	return self.__ictor (...)
end

CAC.LiveIncidentReceiver = CAC.LiveIncidentReceiver ()