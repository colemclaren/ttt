local self = {}

function self:Init ()
	self.HoverInterpolationFilter = CAC.ExponentialDecayResponseFilter (10)
	
	self.ScriptId   = nil
	self.ScriptName = nil
	
	-- Content
	self.TitleLabel = self:Create ("GUrlLabel")
	self.TitleLabel:SetFont (CAC.Font ("Roboto", 28))
	self.TitleLabel:SetTextColor (CAC.Colors.Black)
	
	self.UrlLabel = self:Create ("GUrlLabel")
	self.UrlLabel:SetFont (CAC.Font ("Roboto", 20))
	self.UrlCopyButton = self:Create ("CACCopyButton")
	self.UrlCopyButton:SetToolTipText ("Copy script url")
	self.UrlCopyLabel  = self:Create ("GLabel")
	self.UrlCopyLabel:SetFont (CAC.Font ("Roboto", 20))
	self.UrlCopyLabel:SetTextColor (CAC.Colors.Firebrick)
	self.UrlCopyLabel:SetText ("Script url copied to clipboard!")
	
	self.UrlCopyButton:SetNotificationControl (self.UrlCopyLabel)
	
	self.UrlImage = self:Create ("CACUrlImage")
	self.UrlImage:SetCursor ("hand")
	self.UrlImage:AddEventListener ("Click",
		function (_, ...)
			self.UrlLabel:OnClick (...)
		end
	)
	
	self:AddEventListener ("ListBoxItemChanged",
		function (_, lastListBoxItem, listBoxItem)
			if not listBoxItem then return end
			
			listBoxItem:SetHeight (168)
		end
	)
end

local backgroundColor
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
end

function self:PerformLayout (w, h)
	self.TextLabel:SetVisible (false)
	
	local x = 8
	local y = 4
	
	self.TitleLabel:SizeToContents ()
	self.TitleLabel:SetPos (x, y)
	y = y + self.TitleLabel:GetHeight () - 4
	
	self.UrlLabel:SizeToContents ()
	self.UrlLabel:SetPos (x, y + 0.5 * (self.UrlCopyButton:GetHeight () - self.UrlLabel:GetHeight ()))
	x = x + self.UrlLabel:GetWidth () + 4
	self.UrlCopyButton:SetPos (x, y)
	x = x + self.UrlCopyButton:GetWidth () + 4
	self.UrlCopyLabel:SizeToContents ()
	self.UrlCopyLabel:SetPos (x, y + 0.5 * (self.UrlCopyButton:GetHeight () - self.UrlCopyLabel:GetHeight ()))
	y = y + self.UrlCopyButton:GetHeight () + 4
	
	x = 8
	self.UrlImage:SetPos (x, y)
	self.UrlImage:SetSize (0.4 * 920, 0.4 * 260)
end

-- Data
function self:GetScriptId ()
	return self.ScriptId
end

function self:GetScriptName ()
	return self.ScriptName
end

function self:GetScriptUrl ()
	return "https://scriptfodder.net/scripts/view/" .. self.ScriptId .. "/"
end

function self:SetScriptId (scriptId)
	if self.ScriptId == scriptId then return self end
	
	self.ScriptId = scriptId
	
	self.TitleLabel:SetUrl (self:GetScriptUrl ())
	self.UrlLabel:SetText (self:GetScriptUrl ())
	self.UrlCopyButton:SetText (self:GetScriptUrl ())
	self.UrlImage:SetUrl ("https://cdn.scriptfodder.net/uploads/script_banners/" .. self.ScriptId .. ".png")
	
	return self
end

function self:SetScriptName (scriptName)
	if self.ScriptName == scriptName then return self end
	
	self.ScriptName = scriptName
	
	self.TextLabel:SetText (scriptName)
	self.TitleLabel:SetText (scriptName)
	
	return self
end

-- Item filtering
function self:PassesSearchFilter (searchFilter)
	return string.find (self.ScriptName or "", searchFilter) ~= nil
end

CAC.Register ("CACScriptListBoxItem", self, "GListBoxItem")