local self = {}

local comboBoxBackgroundColor = Color (255, 255, 255, 0)
function self:Init ()
	self.HoverInterpolationFilter = CAC.ExponentialDecayResponseFilter (10)
	
	self.ComboBox = self:Create ("CACComboBox")
	self.ComboBox:SetFont (CAC.Font ("Roboto", 18))
	self.ComboBox:SetTextColor (CAC.Colors.Black)
	self.ComboBox:SetBackgroundColor (comboBoxBackgroundColor)
	self.ComboBox:AddItem ("Suppress response",   CAC.WhitelistStatus.SuppressResponse  )
	self.ComboBox:AddItem ("Suppress detections", CAC.WhitelistStatus.SuppressDetections)
	self.ComboBox:AddItem ("Suppress checks",     CAC.WhitelistStatus.SuppressChecks    )
	self.ComboBox:AddEventListener ("SelectedItemChanged",
		function (_)
			self.WhitelistEntry:DispatchEvent ("SetWhitelistStatus", self.ComboBox:GetSelectedItem ():GetId ())
		end
	)
	
	self.StatusLabel = self:Create ("CACLabel")
	self.StatusLabel:SetFont (CAC.Font ("Roboto", 18))
	self.StatusLabel:SetTextColor (CAC.Colors.Black)
	self.StatusLabel:SetTextInset (8, 0)
	
	self.RemoveButton = self:Create ("CACImageButton")
	self.RemoveButton:SetIcon ("icon16/cross.png")
	self.RemoveButton:SetToolTipText ("Remove entry")
	self.RemoveButton:AddEventListener ("Click",
		function ()
			self:GetListBox ():GetUserWhitelist ():DispatchEvent ("RemoveEntry", self:GetWhitelistEntry ())
		end
	)
	
	self.WhitelistEntry = nil
	
	self:AddEventListener ("ListBoxItemChanged",
		function (_, lastListBoxItem, listBoxItem)
			if not listBoxItem then return end
			
			listBoxItem:SetHeight (32)
		end
	)
end

local backgroundColor
local smallTextColor = Color (0, 0, 0, 192)
function self:Paint (w, h)
	if self:IsHoveredRecursive () then
		self.HoverInterpolationFilter:Impulse ()
	end
	
	-- Background
	if self:IsSelected () then
		local col = self:GetSkin ().combobox_selected
		surface.SetDrawColor (col)
		surface.DrawRect (0, 0, w, h)
	else
		local baseBackgroundColor = CAC.Colors.Gainsboro
		
		backgroundColor = CAC.Color.Lerp (1 - self.HoverInterpolationFilter:Evaluate (), CAC.Colors.LightSteelBlue, baseBackgroundColor, backgroundColor)
		surface.SetDrawColor (backgroundColor)
		surface.DrawRect (0, 0, w, h)
	end
	
	if not self:GetWhitelistEntry () then return end
	
	local icon
	local text1
	local text2
	
	if self.WhitelistEntry:GetActorReference ():IsUserReference () then
		icon = "icon16/user.png"
		text1 = self.WhitelistEntry:GetActorReference ():GetDisplayName ()
		text2 = self.WhitelistEntry:GetActorReference ():GetUserId ()
	elseif self.WhitelistEntry:GetActorReference ():IsGroupReference () then
		icon = "icon16/group.png"
		text1 = self.WhitelistEntry:GetActorReference ():GetGroupDisplayName (self.WhitelistEntry:GetActorReference ():GetGroupId ())
		if self.WhitelistEntry:GetActorReference ():GetGroupSystem () then
			text2 = self.WhitelistEntry:GetActorReference ():GetGroupSystem ():GetName () .. " group"
		else
			text2 = self.WhitelistEntry:GetActorReference ():GetGroupSystemId () .. " group"
		end
	end
	text2 = "(" .. text2 .. ")"
	
	local x = 4
	local y = 0.5 * (h - 16)
	CAC.ImageCache:GetImage (icon):Draw (CAC.RenderContext, x, y)
	
	x = x + 16 + 4
	surface.SetFont (CAC.Font ("Roboto", 18))
	local textWidth, textHeight = surface.GetTextSize (text1)
	y = 0.5 * (h - textHeight)
	surface.SetTextPos (x, y)
	surface.SetTextColor (CAC.Colors.Black)
	surface.DrawText (text1)
	
	x = x + 4 + textWidth + 4
	x = math.max (x, 0.25 * self:GetListBox ():GetWidth ())
	surface.SetFont (CAC.Font ("Roboto", 14))
	local textWidth, textHeight = surface.GetTextSize (text2)
	surface.SetTextPos (x, 0.5 * (h - textHeight))
	surface.SetTextColor (smallTextColor)
	surface.DrawText (text2)
end

function self:PerformLayout (w, h)
	self.TextLabel:SetVisible (false)
	
	self.RemoveButton:SetPos (w - 4 - self.RemoveButton:GetWidth (), 0.5 * (h - self.RemoveButton:GetHeight ()))
	
	local x = 0.5 * self:GetListBox ():GetWidth () - 8
	self.ComboBox:SetPos (x, 0)
	self.ComboBox:SetSize (0.75 * self:GetListBox ():GetWidth () - x, h)
	
	self.StatusLabel:SetPos  (self.ComboBox:GetPos  ())
	self.StatusLabel:SetSize (self.ComboBox:GetSize ())
end

function self:Think ()
	self.ComboBox    :SetVisible (self:IsHoveredRecursive () or self.ComboBox:IsMenuOpen ())
	self.RemoveButton:SetVisible (self:IsHoveredRecursive () or self.ComboBox:IsMenuOpen ())
	self.StatusLabel :SetVisible (not self.ComboBox:IsVisible ())
end

function self:OnRemoved ()
	self:SetWhitelistEntry (nil)
end

-- Data
function self:GetWhitelistEntry ()
	return self.WhitelistEntry
end

function self:SetWhitelistEntry (whitelistEntry)
	if self.WhitelistEntry == whitelistEntry then return self end
	
	self:UnhookWhitelistEntry (self.WhitelistEntry)
	self.WhitelistEntry = whitelistEntry
	self:HookWhitelistEntry (self.WhitelistEntry)
	
	self:Update ()
	
	return self
end

function self:Update ()
	if not self.WhitelistEntry then return end
	
	self.ComboBox:SetSelectedItem (self.WhitelistEntry:GetWhitelistStatus ())
	self.StatusLabel:SetText (self.ComboBox:GetText ())
end

-- Internal, do not call
function self:HookWhitelistEntry (whitelistEntry)
	if not whitelistEntry then return end
	
	whitelistEntry:AddEventListener ("WhitelistStatusChanged", "CAC.UserWhitelistListBoxItem." .. self:GetHashCode (),
		function (_, whitelistStatus)
			self:Update ()
		end
	)
end

function self:UnhookWhitelistEntry (whitelistEntry)
	if not whitelistEntry then return end
	
	whitelistEntry:RemoveEventListener ("WhitelistStatusChanged", "CAC.UserWhitelistListBoxItem." .. self:GetHashCode ())
end

CAC.Register ("CACUserWhitelistListBoxItem", self, "GListBoxItem")