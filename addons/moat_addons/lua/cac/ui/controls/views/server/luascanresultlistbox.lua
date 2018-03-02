local self = {}

function self:Init ()
	self.LuaScanResult = nil
	
	self:SetMenu (CAC.LuaScanResultListBoxMenu (self))
	
	self.TypeHeaders = {}
	
	self:SetComparator (
		function (a, b)
			local controlA = a:GetControl ()
			local controlB = b:GetControl ()
			local luaScanResultEntryA = controlA:GetLuaScanResultEntry ()
			local luaScanResultEntryB = controlB:GetLuaScanResultEntry ()
			
			if controlA:GetType () ~= controlB:GetType () then
				return controlA:GetType () < controlB:GetType ()
			end
			
			if controlA:IsHeader () then return true  end
			if controlB:IsHeader () then return false end
			
			return luaScanResultEntryA:GetId () < luaScanResultEntryB:GetId ()
		end
	)
end

-- Factories
self.ListBoxItemControlClassName = "CACLuaScanResultListBoxItem"

function self:Paint (w, h)
	local hoveredPanel = vgui.GetHoveredPanel ()
	local className = hoveredPanel and hoveredPanel:IsValid () and hoveredPanel.ClassName
	
	if not self.Items:IsEmpty () then return end
	
	surface.SetDrawColor (CAC.Colors.Gainsboro)
	surface.DrawRect (0, 0, w, h)
	
	surface.SetFont (CAC.Font ("Roboto", 20))
	local textWidth, textHeight = surface.GetTextSize ("No known exploits or backdoors found.")
	surface.SetTextPos (0.5 * (w - textWidth), 4)
	surface.SetTextColor (CAC.Colors.Green)
	surface.DrawText ("No known exploits or backdoors found.")
end

function self:OnRemoved ()
	self:SetLuaScanResult (nil)
end

function self:GetLuaScanResult ()
	return self.LuaScanResult
end

function self:SetLuaScanResult (luaScanResult)
	if self.LuaScanResult == luaScanResult then return self end
	
	self:Clear ()
	self.TypeHeaders = {}
	
	self:UnhookLuaScanResult (self.LuaScanResult)
	self.LuaScanResult = luaScanResult
	self:HookLuaScanResult (self.LuaScanResult)
	
	if self.LuaScanResult then
		for luaScanResultEntry in self.LuaScanResult:GetEnumerator () do
			self:AddLuaScanResultEntry (luaScanResultEntry)
		end
	end
	
	return self
end

-- Internal, do not call
function self:AddLuaScanResultEntry (luaScanResultEntry)
	local listBoxItem = self:GetItemById (luaScanResultEntry:GetId ()) or self:AddItem (luaScanResultEntry:GetId ())
	listBoxItem:GetControl ():SetLuaScanResultEntry (luaScanResultEntry)
	listBoxItem:SetToolTipText (luaScanResultEntry:GetLuaSignature ():GetComment ())
	
	self:AddTypeHeader (luaScanResultEntry:GetType ())
	
	self:Sort ()
end

function self:AddTypeHeader (type)
	if self.TypeHeaders [type] then return end
	
	local listBoxItem = self:AddItem ("TypeHeader." .. type)
	listBoxItem:GetControl ():SetType (type)
	listBoxItem:GetControl ():SetHeader (true)
	self.TypeHeaders [type] = listBoxItem
	
	self:Sort ()
end

function self:RemoveLuaScanResultEntry (luaScanResultEntry)
	if not self:GetItemById (luaScanResultEntry:GetId ()) then return end
	
	local listBoxItem = self:GetItemById (luaScanResultEntry:GetId ())
	self:RemoveItem (listBoxItem)
end

function self:HookLuaScanResult (luaScanResult)
	if not luaScanResult then return end
end

function self:UnhookLuaScanResult (luaScanResult)
	if not luaScanResult then return end
end

CAC.Register ("CACLuaScanResultListBox", self, "CACListBox")