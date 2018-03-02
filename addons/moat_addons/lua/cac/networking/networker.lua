local self = {}
CAC.Networker = CAC.MakeConstructor (self)

function self:ctor (playerMonitor)
	self.PlayerMonitor = playerMonitor or CAC.PlayerMonitor
	
	self.NetworkingHosts = {}
	
	self.PlayerMonitor:AddEventListener ("PlayerDisconnected", "CAC.Networker." .. self:GetHashCode (),
		function (_, ply, userId)
			self:DestroyNetworkingHost (ply)
		end
	)
end

function self:dtor ()
	for ply, networkingHost in pairs (self.NetworkingHosts) do
		networkingHost:dtor ()
	end
	
	self.NetworkingHosts = {}
end

function self:CreateNetworkingHost (ply)
	if self.NetworkingHosts [ply] then
		return self.NetworkingHosts [ply]
	end
	
	self.NetworkingHosts [ply] = CAC.NetworkingHost (ply)
	-- self.NetworkingHosts [ply]:SetActorReference (CAC.UserReference.FromPlayer (ply))
	-- self.NetworkingHosts [ply]:SetPermissions (CAC.PermissionEvaluationCache:GetPlayerPermissions (ply))
	
	return self.NetworkingHosts [ply]
end

function self:GetNetworkingHost (ply)
	return self:CreateNetworkingHost (ply)
end

function self:HasNetworkingHost (ply)
	return self.NetworkingHosts [ply] ~= nil
end

-- Internal, do not call
function self:DestroyNetworkingHost (ply)
	if not self.NetworkingHosts [ply] then return end
	
	self.NetworkingHosts [ply]:dtor ()
	self.NetworkingHosts [ply] = nil
end