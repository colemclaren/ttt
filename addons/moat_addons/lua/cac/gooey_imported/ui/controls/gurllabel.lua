-- Generated from: gooey/lua/gooey/ui/controls/gurllabel.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/gurllabel.lua
-- Timestamp:      2016-04-28 19:58:52
local self = {}

--[[
	Events:
		UrlChanged (url)
			Fired when this UrlLabel's URL has changed.
]]

local textColor = Color (0, 50, 255)
function self:Init ()
	self.Url = nil
	
	self:SetMouseInputEnabled (true)
	
	self:SetCursor ("hand")
	self:SetTextColor (textColor)
end

function self:GetUrl ()
	return self.Url
end

function self:SetUrl (url)
	if self.Url == url then return self end
	
	self.Url = url
	
	self:DispatchEvent ("UrlChanged", self.Url)
	
	return self
end

-- Event handlers
CAC.CreateMouseEvents (self)

function self:OnClick (mouseCode, x, y)
	gui.OpenURL (string.gsub (self.Url or self:GetText (), "^https://", "http://"))
end

CAC.Register ("GUrlLabel", self, "DLabel")