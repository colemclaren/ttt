-- Generated from: gooey/lua/gooey/ui/history/historyitem.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/history/historyitem.lua
-- Timestamp:      2016-04-28 19:58:52
local self = {}
CAC.HistoryItem = CAC.MakeConstructor (self)

function self:ctor ()
	self.Description = "<action>"
	
	self.ChainedItem = nil
end

function self:ChainItem (historyItem)
	if not historyItem then return end
	
	if self.ChainedItem then
		self.ChainedItem:ChainItem (historyItem)
	else
		self.ChainedItem = historyItem
	end
end

function self:GetDescription ()
	return self.Description
end

function self:SetDescription (description)
	self.Description = description or "<action>"
end

function self:MoveForward ()
end

function self:MoveBack ()
end

-- Internal, do not call
function self:MoveForwardChain ()
	self:MoveForward ()
	if self.ChainedItem then
		self.ChainedItem:MoveForwardChain ()
	end
end

function self:MoveBackChain ()
	if self.ChainedItem then
		self.ChainedItem:MoveBackChain ()
	end
	self:MoveBack ()
end