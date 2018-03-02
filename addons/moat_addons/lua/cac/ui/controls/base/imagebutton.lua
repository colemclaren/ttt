local self = {}

--[[
	Events:
		IconChanged (icon)
			Fired when the icon has been changed.
]]

function self:Init ()
	self.NotificationControl = nil
	
	self.ClickAlphaFilter = CAC.ExponentialDecayResponseFilter (5)
	
	self.Icon = nil
	
	self:SetSize (24, 24)
end

function self:PaintContent (w, h)
	if self.NotificationControl and
	   self.NotificationControl:IsValid () then
		self.NotificationControl:SetAlpha (255 * self.ClickAlphaFilter:Evaluate ())
	end
	
	if self.Icon then
		local x = 0.5 * (w - 16)
		local y = 0.5 * (h - 16)
		local c = self:IsEnabled () and 255 or 64
		CAC.ImageCache:GetImage (self.Icon):Draw (CAC.RenderContext, x, y, c, c, c, c)
	end
end

function self:GetIcon ()
	return self.Icon
end

function self:SetIcon (icon)
	if self.Icon == icon then return self end
	
	self.Icon = icon
	
	self:DispatchEvent ("IconChanged", self.Icon)
	
	return self
end

function self:GetNotificationControl ()
	return self.NotificationControl
end

function self:SetNotificationControl (notificationControl)
	if self.NotificationControl == notificationControl then return self end
	
	self.NotificationControl = notificationControl
	
	return self
end

-- Event handlers
function self:OnClick (mouseCode, x, y)
	self.ClickAlphaFilter:Impulse (SysTime () + 0.5)
	
	if self.ToolTipController then
		self:GetToolTipController ():HideToolTip ()
	end
end

CAC.Register ("CACImageButton", self, "CACButton")