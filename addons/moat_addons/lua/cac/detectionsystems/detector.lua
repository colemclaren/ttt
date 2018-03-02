local self = {}
CAC.Detector = CAC.MakeConstructor (self, CAC.Detector)

function self:ctor (playerMonitor)
	self.PlayerMonitor = playerMonitor or CAC.PlayerMonitor
	
	self.PlayerStates = CAC.WeakKeyTable ()
	
	self.PlayerMonitor:AddPlayerExistenceListener ("CAC." .. self:GetName (),
		function (_, ply, userId, isLocalPlayer)
			self:CreatePlayerState (ply)
		end
	)
	
	self.PlayerMonitor:AddEventListener ("PlayerDisconnected", "CAC." .. self:GetName (),
		function (_, ply, userId)
			self:DestroyPlayerState (ply)
		end
	)
end

function self:dtor ()
	self.PlayerMonitor:RemovePlayerExistenceListener ("CAC." .. self:GetName ())
	self.PlayerMonitor:RemoveEventListener ("PlayerDisconnected", "CAC." .. self:GetName ())
end

function self:Reset ()
	for ply, playerState in pairs (self.PlayerStates) do
		if ply:IsValid () then
			self:InitializePlayerState (ply, playerState)
		end
	end
end

-- Internal, do not call
function self:GetName ()
	CAC.Error ("Detector:GetName : Not implemented.")
end

function self:CreatePlayerState (ply)
	self.PlayerStates [ply] = {}
	self:InitializePlayerState (ply, self.PlayerStates [ply])
end

function self:DestroyPlayerState (ply)
	self.PlayerStates [ply] = nil
end

function self:GetPlayerState (ply)
	return self.PlayerStates [ply]
end

function self:InitializePlayerState (ply, playerState)
	CAC.Error ("Detector:InitializePlayerState : Not implemented.")
end

function self:PlayerStateExists (ply)
	return self.PlayerStates [ply] ~= nil
end