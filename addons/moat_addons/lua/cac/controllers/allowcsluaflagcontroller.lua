local self = {}
CAC.AllowCsLuaFlagController = CAC.MakeConstructor (self)

-- This controller:
--     Adds the sv_allowcslua flags to all connected players' PlayerSessions when sv_allowcslua is 1
--     Adds the sv_cheats     flags to all connected players' PlayerSessions when sv_cheats     is 1

function self:ctor (conVarMonitor, livePlayerSessionManager)
	self.ConVarMonitor            = conVarMonitor            or CAC.ConVarMonitor
	self.LivePlayerSessionManager = livePlayerSessionManager or CAC.LivePlayerSessionManager
	
	self.ConVarMonitor:AddEventListener ("ConVarChanged", "CAC.AllowCsLuaFlagController." .. self:GetHashCode (),
		function (_, conVarName, bool)
			if conVarName ~= "sv_allowcslua" and
			   conVarName ~= "sv_cheats" then
				return
			end
			
			if bool then
				for _, ply in ipairs (player.GetAll ()) do
					local livePlayerSession = CAC.LivePlayerSessionController:EnsureSessionCreated (ply)
					
					livePlayerSession:GetPlayerSession ():AddFlag (conVarName)
				end
			end
		end
	)
	
	for livePlayerSession in self.LivePlayerSessionManager:GetEnumerator () do
		self:OnLivePlayerSessionCreated (livePlayerSession)
	end
	
	self.LivePlayerSessionManager:AddEventListener ("LivePlayerSessionCreated", "CAC.AllowCsLuaFlagController." .. self:GetHashCode (),
		function (_, userId, ply, livePlayerSession)
			self:OnLivePlayerSessionCreated (livePlayerSession)
		end
	)
end

function self:dtor ()
	self.ConVarMonitor           :RemoveEventListener ("ConVarChanged",            "CAC.AllowCsLuaFlagController." .. self:GetHashCode ())
	self.LivePlayerSessionManager:RemoveEventListener ("LivePlayerSessionCreated", "CAC.AllowCsLuaFlagController." .. self:GetHashCode ())
end

function self:OnLivePlayerSessionCreated (livePlayerSession)
	if self.ConVarMonitor:GetBooleanValue ("sv_allowcslua") then
		livePlayerSession:GetPlayerSession ():AddFlag ("sv_allowcslua")
	end
	if self.ConVarMonitor:GetBooleanValue ("sv_cheats") then
		livePlayerSession:GetPlayerSession ():AddFlag ("sv_cheats")
	end
end
