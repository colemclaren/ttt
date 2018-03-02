-- Generated from: gooey/lua/gooey/ui/history/ihistorystack.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/history/ihistorystack.lua
-- Timestamp:      2016-04-28 19:58:52
local self = {}
CAC.IHistoryStack = CAC.MakeConstructor (self)

--[[
	Events:
		ItemPushed (HistoryItem historyItem)
			Fired when a HistoryItem has been added to this HistoryStack.
		MovedForward (HistoryItem historyItem)
			Fired when the state has been moved forward.
		MovedBack (HistoryItem historyItem)
			Fired when the state has been moved back.
		StackChanged ()
			Fired when a HistoryItem has been added or the state has been moved forward or back.
		StackCleared ()
			Fired when this UndoRedoStack has been cleared.
]]

function self:ctor ()
	CAC.EventProvider (self)
end

function self:CanMoveForward ()
	CAC.Error ("IHistoryStack:CanMoveForward : Not implemented.")
end

function self:CanMoveBack ()
	CAC.Error ("IHistoryStack:CanMoveBack : Not implemented.")
end

function self:Clear ()
	CAC.Error ("IHistoryStack:Clear : Not implemented.")
end

function self:GetNextDescription ()
	CAC.Error ("IHistoryStack:GetNextDescription : Not implemented.")
end

function self:GetNextItem ()
	CAC.Error ("IHistoryStack:GetNextItem : Not implemented.")
end

function self:GetNextStack ()
	CAC.Error ("IHistoryStack:GetNextStack : Not implemented.")
end

function self:GetPreviousDescription ()
	CAC.Error ("IHistoryStack:GetPreviousDescription : Not implemented.")
end

function self:GetPreviousItem ()
	CAC.Error ("IHistoryStack:GetPreviousItem : Not implemented.")
end

function self:GetPreviousStack ()
	CAC.Error ("IHistoryStack:GetPreviousStack : Not implemented.")
end

function self:Push (historyItem)
	CAC.Error ("IHistoryStack:Push : Not implemented.")
end

function self:MoveForward (count)
	CAC.Error ("IHistoryStack:MoveForward : Not implemented.")
end

function self:MoveBack (count)
	CAC.Error ("IHistoryStack:MoveBack : Not implemented.")
end