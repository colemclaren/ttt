local self = {}
CAC.BaseLivePlayerSessionController = CAC.MakeConstructor (self)

function self:ctor (livePlayerSessionManager)
	self.LivePlayerSessionManager = nil
	
	self:SetLivePlayerSessionManager (livePlayerSessionManager or CAC.LivePlayerSessionManager)
end

function self:dtor ()
	self:SetLivePlayerSessionManager (nil)
end

function self:GetLivePlayerSessionManager ()
	return self.LivePlayerSessionManager
end

function self:SetLivePlayerSessionManager (livePlayerSessionManager)
	if self.LivePlayerSessionManager == livePlayerSessionManager then return self end
	
	if self.LivePlayerSessionManager then
		self:UnhookLivePlayerSessionManager (self.LivePlayerSessionManager)
		
		for livePlayerSession in self.LivePlayerSessionManager:GetEnumerator () do
			self:UnhookLivePlayerSession (livePlayerSession)
			self:UnhookPlayerSession (livePlayerSession:GetPlayerSession ())
		end
	end
	
	self.LivePlayerSessionManager = livePlayerSessionManager
	
	if self.LivePlayerSessionManager then
		self:HookLivePlayerSessionManager (self.LivePlayerSessionManager)
		
		for livePlayerSession in self.LivePlayerSessionManager:GetEnumerator () do
			self:HookLivePlayerSession (livePlayerSession)
			self:HookPlayerSession (livePlayerSession:GetPlayerSession ())
		end
	end
	
	return self
end

function self:OnLivePlayerSessionCreated (userId, ply, livePlayerSession)
end

function self:OnLivePlayerSessionDestroyed (userId, ply, livePlayerSession)
end

-- Internal, do not call
function self:HookLivePlayerSessionManager (livePlayerSessionManager)
	if not livePlayerSessionManager then return end
	
	livePlayerSessionManager:AddEventListener ("LivePlayerSessionCreated", "CAC.BaseLivePlayerSessionController." .. self:GetHashCode (),
		function (_, userId, ply, livePlayerSession)
			self:OnLivePlayerSessionCreated (userId, ply, livePlayerSession)
			
			self:HookLivePlayerSession (livePlayerSession)
			self:HookPlayerSession (livePlayerSession:GetPlayerSession ())
		end
	)
	
	livePlayerSessionManager:AddEventListener ("LivePlayerSessionDestroyed", "CAC.BaseLivePlayerSessionController." .. self:GetHashCode (),
		function (_, userId, ply, livePlayerSession)
			self:OnLivePlayerSessionDestroyed (userId, ply, livePlayerSession)
			
			self:UnhookLivePlayerSession (livePlayerSession)
			self:UnhookPlayerSession (livePlayerSession:GetPlayerSession ())
		end
	)
end

function self:UnhookLivePlayerSessionManager (livePlayerSessionManager)
	if not livePlayerSessionManager then return end
	
	livePlayerSessionManager:RemoveEventListener ("LivePlayerSessionCreated",   "CAC.BaseLivePlayerSessionController." .. self:GetHashCode ())
	livePlayerSessionManager:RemoveEventListener ("LivePlayerSessionDestroyed", "CAC.BaseLivePlayerSessionController." .. self:GetHashCode ())
end

function self:HookLivePlayerSession (livePlayerSession)
	if not livePlayerSession then return end
end

function self:UnhookLivePlayerSession (livePlayerSession)
	if not livePlayerSession then return end
end

function self:HookPlayerSession (playerSession)
	if not playerSession then return end
end

function self:UnhookPlayerSession (playerSession)
	if not playerSession then return end
end