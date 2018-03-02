local self = {}
CAC.Vermilion2GroupSystem = CAC.MakeConstructor (self, CAC.SimpleReadOnlyGroupSystem)

function self:ctor ()
end

-- IReadOnlyGroupSystem
function self:GetId ()
	return "Vermilion2GroupSystem"
end

function self:GetName ()
	return "Vermilion 2"
end

function self:IsAvailable ()
	return istable (Vermilion)
end

-- Groups
function self:GetGroupEnumerator ()
	local rankTable = Vermilion.Data.Ranks or Vermilion.Data.RankOverview
	for _, rankTable in ipairs (rankTable) do
		coroutine.yield (rankTable.Name)
	end
end
self.GetGroupEnumerator = CAC.YieldEnumeratorFactory (self.GetGroupEnumerator)

function self:GroupExists (groupId)
	for groupId2 in self:GetGroupEnumerator () do
		if groupId == groupId2 then return true end
	end
	
	return false
end

function self:GetBaseGroup (groupId)
	return nil
end

-- Group
function self:GetGroupColor (groupId)
	local rankTable = Vermilion.Data.Ranks or Vermilion.Data.RankOverview
	for _, rankTable in ipairs (rankTable) do
		if rankTable.Name == groupId then
			return rankTable.Colour
		end
	end
	
	return nil
end

function self:GetGroupDisplayName (groupId)
	return groupId
end

function self:GetGroupIcon (groupId)
	local rankTable = Vermilion.Data.Ranks or Vermilion.Data.RankOverview
	for _, rankTable in ipairs (rankTable) do
		if rankTable.Name == groupId then
			return "icon16/" .. rankTable.Icon .. ".png"
		end
	end
	
	return nil
end

-- Users
function self:GetUserGroup (userId)
	local ply = CAC.PlayerMonitor:GetUserEntity (userId)
	
	if SERVER then
		local user = Vermilion:GetUser (ply)
		if not user then return nil end
		
		local rankTable = user:GetRank ()
		if not rankTable then return nil end
		
		return rankTable.Name
	elseif CLIENT then
		if not Vermilion.Menu.Pages ["rank_assignment"] then return end
		local playerListView = Vermilion.Menu.Pages ["rank_assignment"].PlayerList
		if not playerListView            then return end
		if not playerListView:IsValid () then return end
		
		local entIndex = ply:EntIndex ()
		for _, listViewLine in pairs (playerListView:GetLines ()) do
			if listViewLine.EntityID == entIndex then
				return listViewLine:GetValue (2)
			end
		end
	end
	
	return nil
end

CAC.SystemRegistry:RegisterSystem ("GroupSystem", CAC.Vermilion2GroupSystem ())