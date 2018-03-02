-- Generated from: gooey/lua/gooey/ui/history/historycontroller.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/history/historycontroller.lua
-- Timestamp:      2016-04-28 19:58:52
local self = {}
CAC.HistoryController = CAC.MakeConstructor (self, CAC.ButtonController)

--[[
	Events:
		CanMoveForwardChanged (canMoveForward)
			Fired when the move forward command has been enabled or disabled.
		CanMoveBackChanged (canMoveBack)
			Fired when the move back command has been enabled or disabled.
]]

function self:ctor (historyStack)
	self.HistoryStack = nil
	
	self:RegisterAction ("Move Forward", "CanMoveForwardChanged")
	self:RegisterAction ("Move Back",    "CanMoveBackChanged")
	
	-- Event handlers
	self.StackChanged = function ()
		self:UpdateButtonState ()
	end
	
	self:SetHistoryStack (historyStack)
end

function self:AddMoveForwardAction (action)
	self:AddAction ("Move Forward", action)
end

function self:AddMoveForwardButton (button)
	self:AddButton ("Move Forward", button)
	
	button:AddEventListener ("Click",
		function ()
			if not self.HistoryStack then return end
			self.HistoryStack:MoveForward ()
		end
	)
end

function self:AddMoveBackAction (action)
	self:AddAction ("Move Back", action)
end

function self:AddMoveBackButton (button)
	self:AddButton ("Move Back", button)
	
	button:AddEventListener ("Click",
		function ()
			if not self.HistoryStack then return end
			self.HistoryStack:MoveBack ()
		end
	)
end

function self:CanMoveForward ()
	return self:CanPerformAction ("Move Forward")
end

function self:CanMoveBack ()
	return self:CanPerformAction ("Move Back")
end

function self:GetHistoryStack ()
	return self.HistoryStack
end

function self:SetHistoryStack (historyStack)
	if self.HistoryStack then
		self.HistoryStack:RemoveEventListener ("StackChanged", "CAC.HistoryController." .. self:GetHashCode ())
	end
	
	self.HistoryStack = historyStack
	
	if self.HistoryStack then
		self.HistoryStack:AddEventListener ("StackChanged", "CAC.HistoryController." .. self:GetHashCode (), self.StackChanged)
	end
	
	self:UpdateButtonState ()
end

-- Internal, do not call
function self:UpdateButtonState ()
	self:UpdateMoveForwardState ()
	self:UpdateMoveBackState ()
end

function self:UpdateMoveForwardState ()
	self:UpdateActionState ("Move Forward", self.HistoryStack and self.HistoryStack:CanMoveForward () or false)
end

function self:UpdateMoveBackState ()
	self:UpdateActionState ("Move Back",    self.HistoryStack and self.HistoryStack:CanMoveBack    () or false)
end

-- Event handlers
self.StackChanged = CAC.NullCallback