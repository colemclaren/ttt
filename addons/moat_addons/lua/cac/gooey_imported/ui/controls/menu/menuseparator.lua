-- Generated from: gooey/lua/gooey/ui/controls/menu/menuseparator.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/menu/menuseparator.lua
-- Timestamp:      2016-04-28 19:58:53
local self = {}
CAC.MenuSeparator = CAC.MakeConstructor (self, CAC.BaseMenuItem)

function self:ctor ()
end

function self:dtor ()
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	-- BaseMenuItem
	self:SetId      (source:GetId     ())
	self:SetEnabled (source:IsEnabled ())
	self:SetVisible (source:IsVisible ())
	
	-- Events
	self:GetEventProvider ():Copy (source)
	
	return self
end

function self:GetText ()
	return "-"
end

function self:IsSeparator ()
	return true
end