local self = {}

--[[
	Events:
		SelectedTabChanged (lastSelectedTab, selectedTab)
			Fired when the selected tab has changed.
]]
local backgroundColor = Color (  0,   0,   0,   0)

function self:Init ()
	self.TabHeaders     = {}
	self.TabHeadersById = {}
	
	self.ViewContainer = self:Create ("CACViewContainer")
	
	-- Selection
	self.SelectedTab = nil
	self.SelectionBackgroundXInterpolator = CAC.SigmoidStepResponseInterpolator ()
end

function self:Paint (w, h)
	if self:GetSelectedTab () then
		surface.SetDrawColor (CAC.Colors.CornflowerBlue)
		surface.DrawRect (self.SelectionBackgroundXInterpolator:Run (), self:GetTabHeaderHeight () - 4, self:GetTabHeaderWidth (), 4)
	end
end

function self:PerformLayout (w, h)
	local y = 0
	
	-- Tab headers
	local x = 0
	local tabHeaderWidth  = self:GetTabHeaderWidth ()
	local tabHeaderHeight = self:GetTabHeaderHeight ()
	for _, tabHeader in ipairs (self.TabHeaders) do
		tabHeader:SetPos (x, y - 4)
		tabHeader:SetWidth (tabHeaderWidth)
		tabHeader:SetHeight (tabHeaderHeight + 4)
		x = x + tabHeader:GetWidth ()
	end
	y = y + tabHeaderHeight
	y = y + 4
	
	self.ViewContainer:SetPos (0, y)
	self.ViewContainer:SetSize (w, h - y)
end

-- Tab headers
function self:GetTabHeaderHeight ()
	return 40
end

function self:GetTabHeaderWidth ()
	return 128
end

-- Tabs
function self:AddTab (control, id, text)
	text = text or id
	
	self.ViewContainer:AddView (control, id)
	
	local tabHeader = self:Create ("CACTabHeader")
	self.TabHeaders [#self.TabHeaders + 1] = tabHeader
	self.TabHeadersById [id] = tabHeader
	
	tabHeader:SetTabControl (self)
	tabHeader:SetId (id)
	tabHeader:SetFont (CAC.Font ("Roboto", 24))
	tabHeader:SetText (text)
	
	-- Selection
	if not self:GetSelectedTab () then
		self:SetSelectedTab (id)
	end
	
	self:InvalidateLayout ()
end

function self:GetTab (id)
	return self.ViewContainer:GetViewById (id)
end

function self:IndexOf (id)
	for k, tabHeader in ipairs (self.TabHeaders) do
		if tabHeader:GetId () == id then
			return k
		end
	end
	
	return nil
end

-- Selection
function self:GetSelectedTab ()
	return self.SelectedTab
end

function self:SetSelectedTab (selectedTab)
	if self.SelectedTab == selectedTab then return self end
	
	local lastSelectedTab = self.SelectedTab
	self.SelectedTab = selectedTab
	
	if self:GetSelectedTab () then
		self.SelectionBackgroundXInterpolator:SetTargetValue (self.TabHeadersById [self.SelectedTab]:GetX ())
	end
	
	-- Update ViewContainer
	local lastIndex = self:IndexOf (lastSelectedTab)
	local index     = self:IndexOf (selectedTab)
	local direction = "Left"
	if lastIndex and index then
		direction = index > lastIndex and "Left" or "Right"
	end
	
	self.ViewContainer:SetActiveView (selectedTab, direction)
	
	-- Dispatch event
	self:DispatchEvent ("SelectedTabChanged", lastSelectedTab, self.SelectedTab)
	
	return self
end

CAC.Register ("CACTabControl", self, "CACPanel")