-- Generated from: gooey/lua/gooey/ui/controls/gimage.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/controls/gimage.lua
-- Timestamp:      2016-04-28 19:58:52
local PANEL = {}
CAC.Image = CAC.MakeConstructor (PANEL, CAC.VPanel)

function PANEL:ctor ()
	self:Init ()
end

function PANEL:Init ()
	self.Image = nil
	self:SetSize (16, 16)
	
	if self.SetMouseInputEnabled then
		self:SetMouseInputEnabled (false)
	end
	
	self.GetWidth  = self.GetWidth  or self.GetWide
	self.GetHeight = self.GetHeight or self.GetTall
end

function PANEL:GetImage ()
	return self.Image
end

function PANEL:GetImageHeight ()
	if not self.Image then return 0 end
	return CAC.ImageCache:LoadImage (self.Image):GetHeight ()
end

function PANEL:GetImageSize ()
	if not self.Image then return 0, 0 end
	return CAC.ImageCache:LoadImage (self.Image):GetSize ()
end

function PANEL:GetImageWidth ()
	if not self.Image then return 0 end
	return CAC.ImageCache:LoadImage (self.Image):GetWidth ()
end

function PANEL:Paint (renderContext)
	renderContext = renderContext or CAC.RenderContext
	
	if self.Image then
		local image = CAC.ImageCache:GetImage (self.Image)
		if self:IsEnabled () then
			image:Draw (renderContext, (self:GetWidth () - image:GetWidth ()) * 0.5, (self:GetHeight () - image:GetHeight ()) * 0.5)
		else
			image:Draw (renderContext, (self:GetWidth () - image:GetWidth ()) * 0.5, (self:GetHeight () - image:GetHeight ()) * 0.5, 0, 0, 0, 160)
			image:Draw (renderContext, (self:GetWidth () - image:GetWidth ()) * 0.5, (self:GetHeight () - image:GetHeight ()) * 0.5, nil, nil, nil, 32)
		end
	end
end

function PANEL:SetImage (image)
	self.Image = image
	return self
end

PANEL = table.Copy (PANEL)
PANEL.__index = nil
PANEL.__base = nil
CAC.Register ("GImage", PANEL, "GPanel")