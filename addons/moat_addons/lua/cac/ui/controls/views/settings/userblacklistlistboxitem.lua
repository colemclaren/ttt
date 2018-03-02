local self = {}

function self:Init ()
	self.HoverInterpolationFilter = CAC.ExponentialDecayResponseFilter (10)
	
	self.BlacklistEntry = nil
	
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
	
	if not self:GetBlacklistEntry () then return end
	
	local text1 = self.BlacklistEntry:GetDisplayName ()
	local text2 = "(" .. self.BlacklistEntry:GetSteamId () .. ")"
	
	local x = 4
	local y = 0.5 * (h - 16)
	CAC.ImageCache:GetImage ("icon16/user_delete.png"):Draw (CAC.RenderContext, x, y)
	
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
	
	x = 0.5 * self:GetListBox ():GetWidth ()
	surface.SetFont (CAC.Font ("Roboto", 18))
	surface.SetTextPos (x, y)
	surface.SetTextColor (CAC.Colors.Black)
	surface.DrawText (self.BlacklistEntry:GetReason ())
end

function self:PerformLayout (w, h)
	self.TextLabel:SetVisible (false)
end

function self:OnRemoved ()
	self:SetBlacklistEntry (nil)
end

-- Data
function self:GetBlacklistEntry ()
	return self.BlacklistEntry
end

function self:SetBlacklistEntry (blacklistEntry)
	if self.BlacklistEntry == blacklistEntry then return self end
	
	self:UnhookBlacklistEntry (self.BlacklistEntry)
	self.BlacklistEntry = blacklistEntry
	self:HookBlacklistEntry (self.BlacklistEntry)
	
	self:Update ()
	
	return self
end

function self:Update ()
end

-- Internal, do not call
function self:HookBlacklistEntry (blacklistEntry)
	if not blacklistEntry then return end
end

function self:UnhookBlacklistEntry (blacklistEntry)
	if not blacklistEntry then return end
end

CAC.Register ("CACUserBlacklistListBoxItem", self, "GListBoxItem")