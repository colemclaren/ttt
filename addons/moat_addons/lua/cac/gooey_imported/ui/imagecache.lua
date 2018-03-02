-- Generated from: gooey/lua/gooey/ui/imagecache.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/imagecache.lua
-- Timestamp:      2016-04-28 19:58:52
local self = {}
CAC.ImageCache = CAC.MakeConstructor (self)

function self:ctor ()
	self.Images = {}
	
	self.LoadDuration  = 0.005
	self.LastLoadFrame = 0
	self.LoadStartTime = 0
	
	self.FallbackImage    = self:LoadImage ("icon16/cross.png")
	self.PlaceholderImage = self:LoadImage ("icon16/hourglass.png")
end

function self:GetFallbackImage ()
	return self.FallbackImage
end

function self:GetPlaceholderImage ()
	return self.PlaceholderImage
end

function self:GetImage (image)
	image = string.lower (image)
	if self.Images [image] then
		return self.Images [image]
	end
	if self.LastLoadFrame ~= CurTime () then
		self.LastLoadFrame = CurTime ()
		self.LoadStartTime = SysTime ()
	end
	if SysTime () - self.LoadStartTime > self.LoadDuration then
		return self:GetPlaceholderImage ()
	end
	
	local imageCacheEntry = CAC.ImageCacheEntry (self, image)
	self.Images [image] = imageCacheEntry
	return imageCacheEntry
end

function self:LoadImage (image)
	image = string.lower (image)
	if self.Images [image] then
		return self.Images [image]
	end
	
	local imageCacheEntry = CAC.ImageCacheEntry (self, image)
	self.Images [image] = imageCacheEntry
	return imageCacheEntry
end

CAC.ImageCache = CAC.ImageCache ()