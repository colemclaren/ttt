local self = {}

function self:Init ()
	self.UserWhitelist = nil
	
	self:SetMenu (CAC.UserWhitelistListBoxMenu (self))
	
	self:SetComparator (
		function (a, b)
			local whitelistEntryA = a:GetControl ():GetWhitelistEntry ()
			local whitelistEntryB = b:GetControl ():GetWhitelistEntry ()
			local actorReferenceA = whitelistEntryA and whitelistEntryA:GetActorReference ()
			local actorReferenceB = whitelistEntryB and whitelistEntryB:GetActorReference ()
			
			if actorReferenceA == nil and actorReferenceB ~= nil then return false end
			if actorReferenceA ~= nil and actorReferenceB == nil then return true  end
			
			if actorReferenceA == nil and actorReferenceB == nil then return false end
			
			-- Group references first
			if     actorReferenceA:IsGroupReference () and not actorReferenceB:IsGroupReference () then return true  end
			if not actorReferenceA:IsGroupReference () and     actorReferenceB:IsGroupReference () then return false end
			
			return actorReferenceA:ToString () < actorReferenceB:ToString ()
		end
	)
end

-- Factories
self.ListBoxItemControlClassName = "CACUserWhitelistListBoxItem"

function self:Paint (w, h)
	local hoveredPanel = vgui.GetHoveredPanel ()
	local className = hoveredPanel and hoveredPanel:IsValid () and hoveredPanel.ClassName
	
	if not self.Items:IsEmpty () then return end
	
	surface.SetDrawColor (CAC.Colors.Gainsboro)
	surface.DrawRect (0, 0, w, h)
	
	surface.SetFont (CAC.Font ("Roboto", 20))
	local textWidth, textHeight = surface.GetTextSize ("No whitelisted users to display.")
	surface.SetTextPos (0.5 * (w - textWidth), 4)
	surface.SetTextColor (CAC.Colors.Firebrick)
	surface.DrawText ("No whitelisted users to display.")
end

function self:OnRemoved ()
	self:SetUserWhitelist (nil)
end

function self:GetUserWhitelist ()
	return self.UserWhitelist
end

function self:SetUserWhitelist (userWhitelist)
	if self.UserWhitelist == userWhitelist then return self end
	
	self:Clear ()
	self:UnhookUserWhitelist (self.UserWhitelist)
	self.UserWhitelist = userWhitelist
	self:HookUserWhitelist (self.UserWhitelist)
	
	if self.UserWhitelist then
		for whitelistEntry in self.UserWhitelist:GetEnumerator () do
			self:AddWhitelistEntry (whitelistEntry)
		end
	end
	
	return self
end

-- Internal, do not call
function self:AddWhitelistEntry (whitelistEntry)
	local listBoxItem = self:GetItemById (whitelistEntry:GetActorReference ():ToString ()) or self:AddItem (whitelistEntry:GetActorReference ():ToString ())
	listBoxItem:GetControl ():SetWhitelistEntry (whitelistEntry)
	
	self:Sort ()
end

function self:RemoveWhitelistEntry (whitelistEntry)
	if not self:GetItemById (whitelistEntry:GetActorReference ():ToString ()) then return end
	
	local listBoxItem = self:GetItemById (whitelistEntry:GetActorReference ():ToString ())
	self:RemoveItem (listBoxItem)
end

function self:HookUserWhitelist (userWhitelist)
	if not userWhitelist then return end
	
	userWhitelist:AddEventListener ("EntryAdded", "CAC.UserWhitelistListBox." .. self:GetHashCode (),
		function (_, whitelistEntry)
			self:AddWhitelistEntry (whitelistEntry)
		end
	)
	
	userWhitelist:AddEventListener ("EntryRemoved", "CAC.UserWhitelistListBox." .. self:GetHashCode (),
		function (_, whitelistEntry)
			self:RemoveWhitelistEntry (whitelistEntry)
		end
	)
end

function self:UnhookUserWhitelist (userWhitelist)
	if not userWhitelist then return end
	
	userWhitelist:RemoveEventListener ("EntryAdded",   "CAC.UserWhitelistListBox." .. self:GetHashCode ())
	userWhitelist:RemoveEventListener ("EntryRemoved", "CAC.UserWhitelistListBox." .. self:GetHashCode ())
end

CAC.Register ("CACUserWhitelistListBox", self, "CACListBox")