local self = {}

function self:Init ()
	self.PlayerMonitor            = CAC.PlayerMonitor
	self.LivePlayerSessionManager = CAC.LivePlayerSessionManager
	
	self.PlayerUserIds = CAC.WeakKeyTable ()
	
	self:SetMenu (CAC.PlayerListBoxMenu (self))
	
	self.PlayerMonitor:AddPlayerExistenceListener ("CAC.PlayerListBox." .. self:GetHashCode (),
		function (_, ply, steamId, isLocalPlayer)
			if not ply or not ply:IsValid () then return end
			
			self.PlayerUserIds [ply] = ply:UserID ()
			
			self:AddPlayer (ply, steamId)
		end
	)
	
	self.PlayerMonitor:AddEventListener ("PlayerDisconnected", "CAC.PlayerListBox." .. self:GetHashCode (),
		function (_, ply, steamId)
			self:RemovePlayer (ply, steamId)
			
			self.PlayerUserIds [ply] = nil
		end
	)
	
	self.LivePlayerSessionManager:AddEventListener ("LivePlayerSessionCreated", "CAC.PlayerListBox." .. self:GetHashCode (),
		function (_, userId, ply, livePlayerSession)
			local listBoxItem = self:GetItemById (livePlayerSession:GetUserId ())
			if not listBoxItem then return end
			
			listBoxItem:GetControl ():SetPlayerInformation (livePlayerSession:GetPlayerInformation ())
			listBoxItem:GetControl ():SetPlayerSession     (livePlayerSession:GetPlayerSession     ())
			listBoxItem:GetControl ():SetLivePlayerSession (livePlayerSession                        )
		end
	)
	
	self.LivePlayerSessionManager:AddEventListener ("LivePlayerSessionDestroyed", "CAC.PlayerListBox." .. self:GetHashCode (),
		function (_, userId, ply, livePlayerSession)
			local listBoxItem = self:GetItemById (livePlayerSession:GetUserId ())
			if not listBoxItem then return end
			
			listBoxItem:GetControl ():SetLivePlayerSession (nil)
		end
	)
end

-- Factories
self.ListBoxItemControlClassName = "CACPlayerListBoxItem"

function self:OnRemoved ()
	self.PlayerMonitor:RemovePlayerExistenceListener ("CAC.PlayerListBox." .. self:GetHashCode ())
	self.PlayerMonitor:RemoveEventListener ("PlayerDisconnected", "CAC.PlayerListBox." .. self:GetHashCode ())
	
	self.LivePlayerSessionManager:RemoveEventListener ("LivePlayerSessionCreated",   "CAC.PlayerListBox." .. self:GetHashCode ())
	self.LivePlayerSessionManager:RemoveEventListener ("LivePlayerSessionDestroyed", "CAC.PlayerListBox." .. self:GetHashCode ())
end

-- Internal, do not call
function self:AddPlayer (ply, steamId)
	if self:GetItemById (self.PlayerUserIds [ply]) then return end
	
	local listBoxItem = self:AddItem (self.PlayerUserIds [ply], steamId)
	listBoxItem:GetControl ():SetPlayer (ply)
	
	local livePlayerSession = self.LivePlayerSessionManager:GetLivePlayerSession (ply:UserID ())
	if livePlayerSession then
		listBoxItem:GetControl ():SetPlayerInformation (livePlayerSession:GetPlayerInformation ())
		listBoxItem:GetControl ():SetPlayerSession     (livePlayerSession:GetPlayerSession     ())
		listBoxItem:GetControl ():SetLivePlayerSession (livePlayerSession                        )
	end
end

function self:RemovePlayer (ply, steamId)
	if not self:GetItemById (self.PlayerUserIds [ply]) then return end
	
	local listBoxItem = self:GetItemById (self.PlayerUserIds [ply])
	self:RemoveItem (listBoxItem)
end

CAC.Register ("CACPlayerListBox", self, "CACListBox")