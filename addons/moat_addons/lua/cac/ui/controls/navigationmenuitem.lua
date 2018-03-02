local self = {}

local backgroundColor = Color (0, 0, 0, 0)

function self:Init ()
	self.NavigationMenu = nil
	
	self.Id = nil
	
	self:SetHeight (60)
	
	self:SetBackgroundColor (backgroundColor)
end

-- NavigationMenu
function self:GetNavigationMenu ()
	return self.NavigationMenu
end

function self:SetNavigationMenu (navigationMenu)
	self.NavigationMenu = navigationMenu
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
	return self.NavigationMenu:IndexOf (self)
end

-- Event handlers
function self:OnClick ()
	self.NavigationMenu:SetSelectedItem (self)
end

CAC.Register ("CACNavigationMenuItem", self, "CACButton")