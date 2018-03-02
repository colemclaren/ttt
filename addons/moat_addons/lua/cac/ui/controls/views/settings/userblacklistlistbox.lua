local self = {}

function self:Init ()
	self.UserBlacklist = nil
	
	self:SetMenu (CAC.UserBlacklistListBoxMenu (self))
end

-- Factories
self.ListBoxItemControlClassName = "CACUserBlacklistListBoxItem"

function self:Paint (w, h)
	if not self.Items:IsEmpty () then return end
	
	surface.SetDrawColor (CAC.Colors.Gainsboro)
	surface.DrawRect (0, 0, w, h)
	
	surface.SetFont (CAC.Font ("Roboto", 20))
	local textWidth, textHeight = surface.GetTextSize ("No blacklisted users to display.")
	surface.SetTextPos (0.5 * (w - textWidth), 4)
	surface.SetTextColor (CAC.Colors.Firebrick)
	surface.DrawText ("No blacklisted users to display.")
end

function self:OnRemoved ()
	self:SetUserBlacklist (nil)
end

function self:GetUserBlacklist ()
	return self.UserBlacklist
end

function self:SetUserBlacklist (userBlacklist)
	if self.UserBlacklist == userBlacklist then return self end
	
	self:Clear ()
	self:UnhookUserBlacklist (self.UserBlacklist)
	self.UserBlacklist = userBlacklist
	self:HookUserBlacklist (self.UserBlacklist)
	
	if self.UserBlacklist then
		for blacklistEntry in self.UserBlacklist:GetEnumerator () do
			self:AddBlacklistEntry (blacklistEntry)
		end
	end
	
	return self
end

-- Internal, do not call
function self:AddBlacklistEntry (blacklistEntry)
	local listBoxItem = self:GetItemById (blacklistEntry:GetSteamId ()) or self:AddItem (blacklistEntry:GetSteamId ())
	listBoxItem:GetControl ():SetBlacklistEntry (blacklistEntry)
end

function self:RemoveBlacklistEntry (blacklistEntry)
	if not self:GetItemById (blacklistEntry:GetSteamId ()) then return end
	
	local listBoxItem = self:GetItemById (blacklistEntry:GetSteamId ())
	self:RemoveItem (listBoxItem)
end

function self:HookUserBlacklist (userBlacklist)
	if not userBlacklist then return end
	
	userBlacklist:AddEventListener ("EntryAdded", "CAC.UserBlacklistListBox." .. self:GetHashCode (),
		function (_, blacklistEntry)
			self:AddBlacklistEntry (blacklistEntry)
		end
	)
	
	userBlacklist:AddEventListener ("EntryRemoved", "CAC.UserBlacklistListBox." .. self:GetHashCode (),
		function (_, blacklistEntry)
			self:RemoveBlacklistEntry (blacklistEntry)
		end
	)
end

function self:UnhookUserBlacklist (userBlacklist)
	if not userBlacklist then return end
	
	userBlacklist:RemoveEventListener ("EntryAdded",   "CAC.UserBlacklistListBox." .. self:GetHashCode ())
	userBlacklist:RemoveEventListener ("EntryRemoved", "CAC.UserBlacklistListBox." .. self:GetHashCode ())
end

CAC.Register ("CACUserBlacklistListBox", self, "CACListBox")