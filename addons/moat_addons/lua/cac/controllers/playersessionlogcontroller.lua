local self = {}
CAC.PlayerSessionLogController = CAC.MakeConstructor (self, CAC.BaseLivePlayerSessionController)

function self:ctor (livePlayerSessionManager)
end

-- Internal, do not call
function self:HookLivePlayerSession (livePlayerSession)
	if not livePlayerSession then return end
	
	livePlayerSession:AddEventListener ("CheckStatusChanged", "CAC.PlayerSessionLogController." .. self:GetHashCode (),
		function (_, check, status)
			check:AppendLogLine (status)
		end
	)
end

function self:UnhookLivePlayerSession (livePlayerSession)
	if not livePlayerSession then return end
	
	livePlayerSession:RemoveEventListener ("CheckStatusChanged", "CAC.PlayerSessionLogController." .. self:GetHashCode ())
end

function self:HookPlayerSession (playerSession)
	if not playerSession then return end
	
	playerSession:AddEventListener ("DetectionReasonAdded", "CAC.PlayerSessionLogController." .. self:GetHashCode (),
		function (_, detection, reason)
			playerSession:GetLog ():AppendLine ("!!! DETECTION !!!: " .. detection:GetInformation ():GetName () .. ": " .. reason)
		end
	)
end

function self:UnhookPlayerSession (playerSession)
	if not playerSession then return end
	
	playerSession:RemoveEventListener ("DetectionReasonAdded", "CAC.PlayerSessionLogController." .. self:GetHashCode ())
end