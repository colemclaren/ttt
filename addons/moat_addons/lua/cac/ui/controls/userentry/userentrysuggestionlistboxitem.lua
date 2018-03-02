local self = {}

function self:Init ()
	self.HoverInterpolationFilter = CAC.ExponentialDecayResponseFilter (10)
	
	self.Avatar = nil
	
	self.ActorReference = nil
	
	self.HighlightText = nil
	
	self:AddEventListener ("ListBoxItemChanged",
		function (_, lastListBoxItem, listBoxItem)
			if not listBoxItem then return end
			
			listBoxItem:SetHeight (56)
		end
	)
end

local backgroundColor
local smallTextColor       = Color (  0,   0,   0, 192)
local groupBackgroundColor = Color (255, 255, 255,  64)
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
	
	if not self.ActorReference then return end
	
	local x = 4
	local y = 4
	if self.ActorReference:IsUserReference () then
		x = x + 48 + 4
		surface.SetTextPos (x, y)
		surface.SetFont (CAC.Font ("Roboto", 18))
		CAC.DrawHighlightedText (self.ActorReference:GetDisplayName (), self.HighlightText, CAC.Colors.Black)
		
		surface.SetTextPos (x, y + 18)
		surface.SetFont (CAC.Font ("Roboto", 14))
		CAC.DrawHighlightedText (self.ActorReference:GetUserId (), self.HighlightText, smallTextColor)
	elseif self.ActorReference:IsGroupReference () then
		local groupSystemDisplayName = nil
		if self.ActorReference:GetGroupSystem () then
			groupSystemDisplayName = self.ActorReference:GetGroupSystem ():GetName ()
		else
			groupSystemDisplayName = self.ActorReference:GetGroupSystemId ()
		end
		
		local groupIcon = self.ActorReference:GetGroupIcon ("icon16/group_error.png")
		draw.RoundedBox (8, x, y, 48, 48, groupBackgroundColor)
		CAC.ImageCache:GetImage (groupIcon):Draw (CAC.RenderContext, x + 0.5 * (48 - 16), y + 0.5 * (48 - 16))
		
		x = x + 48 + 4
		surface.SetTextPos (x, y)
		surface.SetFont (CAC.Font ("Roboto", 18))
		CAC.DrawHighlightedText (self.ActorReference:GetGroupDisplayName (self.ActorReference:GetGroupId ()), self.HighlightText, CAC.Colors.Black)
		
		surface.SetTextPos (x, y + 18)
		surface.SetFont (CAC.Font ("Roboto", 14))
		CAC.DrawHighlightedText (groupSystemDisplayName, self.HighlightText, smallTextColor)
		surface.SetTextColor (smallTextColor)
		surface.DrawText (" group")
	end
end

function self:PerformLayout (w, h)
	self.TextLabel:SetVisible (false)
	
	if self.Avatar and self.Avatar:IsValid () then
		self.Avatar:SetPos (4, 4)
		self.Avatar:SetSize (48, 48)
	end
end

function self:OnRemoved ()
	self:SetActorReference (nil)
end

function self:GetHighlightText ()
	return self.HighlightText
end

function self:SetHighlightText (highlightText)
	self.HighlightText = highlightText
	
	return self
end

-- Data
function self:GetActorReference ()
	return self.ActorReference
end

function self:SetActorReference (actorReference)
	if self.ActorReference == actorReference then return self end
	
	if self.Avatar and self.Avatar:IsValid () then
		self.Avatar:Remove ()
		self.Avatar = nil
	end
	self.ActorReference = actorReference
	
	self:Update ()
	
	return self
end

function self:Update ()
	if not self.ActorReference then return end
	
	if self.ActorReference:IsUserReference () then
		self.Avatar = self:Create ("CACUserAvatar")
		self.Avatar:SetSteamId (self.ActorReference:GetUserId ())
	end
end

CAC.Register ("CACUserEntrySuggestionListBoxItem", self, "GListBoxItem")