local self = {}

function self:Init ()
	self.HoverInterpolationFilter = CAC.ExponentialDecayResponseFilter (5)
	self.FocusInterpolationFilter = CAC.ExponentialDecayResponseFilter (5)
	
	-- Content
	self.TextEntry = self:Create ("CACTextEntry")
	
	self:SetHeight (28)
	
	self.TextEntry:AddEventListener ("TextChanged",
		function (_, text)
			return self:DispatchEvent ("TextChanged", text)
		end
	)
	
	self:AddEventListener ("MouseDown",
		function (_, mouseCode, x, y)
			self.TextEntry:Focus ()
			
			local dx, dy = self.TextEntry:GetPos ()
			x, y = x - dx, y - dy
			self.TextEntry:DispatchEvent ("MouseDown", mouseCode, x, y)
		end
	)
end

local frameColor
function self:Paint (w, h)
	if self:ContainsFocus () then
		self.FocusInterpolationFilter:Impulse ()
	end
	if self:IsHoveredRecursive () then
		self.HoverInterpolationFilter:Impulse ()
	end
	
	frameColor = CAC.Color.Lerp (1 - self.HoverInterpolationFilter:Evaluate (), CAC.Colors.LightSteelBlue, CAC.Colors.Gainsboro, frameColor)
	frameColor = CAC.Color.Lerp (1 - self.FocusInterpolationFilter:Evaluate (), CAC.Colors.Orange,         frameColor,           frameColor)
	surface.SetDrawColor (frameColor)
	surface.DrawRect (0, 0, w, h)
	
	surface.SetDrawColor (self.TextEntry:GetBackgroundColor ())
	surface.DrawRect (4, 4, w - 8, h - 8)
	
	local image = CAC.ImageCache:GetImage ("icon16/magnifier.png")
	image:Draw (CAC.RenderContext, w - 24, 6)
end

function self:PerformLayout (w, h)
	self.TextEntry:SetPos (4, 4)
	self.TextEntry:SetSize (w - 30, h - 8)
end

-- Help Text
function self:GetHelpText ()
	return self.TextEntry:GetHelpText ()
end

function self:SetHelpText (helpText)
	self.TextEntry:SetHelpText (helpText)
	return self
end

-- Text
function self:GetText ()
	return self.TextEntry:GetText ()
end

function self:SetText (text)
	self.TextEntry:SetText (text)
	return self
end

CAC.Register ("CACSearchTextEntry", self, "CACPanel")