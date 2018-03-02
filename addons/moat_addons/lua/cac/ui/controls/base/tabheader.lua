local self = {}

local backgroundColor = Color (0, 0, 0, 0)

function self:Init ()
	self.TabControl = nil
	
	self.Id = nil
	
	self:SetBackgroundColor (backgroundColor)
end

-- TabControl
function self:GetTabControl ()
	return self.TabControl
end

function self:SetTabControl (tabControl)
	self.TabControl = tabControl
end

-- Identity
function self:GetId ()
	return self.Id
end

function self:SetId (id)
	self.Id = id
	return self
end

function self:GetIndex ()
	return self.TabControl:IndexOf (self.Id)
end

-- Event handlers
function self:OnClick ()
	self.TabControl:SetSelectedTab (self.Id)
end

CAC.Register ("CACTabHeader", self, "CACButton")