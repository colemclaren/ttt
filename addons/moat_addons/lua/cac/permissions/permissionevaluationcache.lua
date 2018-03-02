local self = {}
CAC.Permissions.PermissionEvaluationCache = CAC.MakeConstructor (self)

-- Evaluated permissions are invalid if
--     - the player's user group changes
--     - the permissions change

function self:ctor (playerMonitor)
	self.EvaluatedPermissions        = CAC.WeakKeyTable ()
	self.InvalidEvaluatedPermissions = CAC.WeakKeyTable ()
	self.LastPlayerGroups            = CAC.WeakKeyTable ()
	self.PlayerActorReferences       = CAC.WeakKeyTable ()
end

function self:FreePlayerPermissions (ply)
	self.EvaluatedPermissions        [ply] = nil
	self.InvalidEvaluatedPermissions [ply] = nil
	self.LastPlayerGroups            [ply] = nil
	self.PlayerActorReferences       [ply] = nil
end

function self:GetPlayerAccess (ply, permissionId)
	return self:GetPlayerPermissions (ply):GetPermissionAccess (nil, permissionId)
end

function self:GetPlayerPermissions (ply)
	self:UpdatePlayerPermissions (ply)
	
	return self.EvaluatedPermissions [ply]
end

function self:UpdatePlayerPermissions (ply)
	if not self.PlayerActorReferences [ply] then
		self.PlayerActorReferences [ply] = CAC.UserReference.FromPlayer (ply)
	end
	
	local userGroup = ply:GetUserGroup ()
	if self.LastPlayerGroups [ply] ~= userGroup then
		self.LastPlayerGroups [ply] = userGroup
		self.InvalidEvaluatedPermissions [ply] = true
	end
	
	if self.InvalidEvaluatedPermissions [ply] then
		self.InvalidEvaluatedPermissions [ply] = nil
		
		self.EvaluatedPermisions [ply] = self.EvaluatedPermisions [ply] or CAC.Permissions.ActorPermissions ()
		self.EvaluatedPermisions [ply]:Copy (self.Permissions:Evaluate (self.PlayerActorReferences [ply]))
	end
end

CAC.Permissions.PermissionEvaluationCache = CAC.Permissions.PermissionEvaluationCache ()