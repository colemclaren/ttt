-- Generated from: gooey/lua/gooey/ui/keyboard/keyboardmap.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/keyboard/keyboardmap.lua
-- Timestamp:      2016-04-28 19:58:52
local self = {}
CAC.KeyboardMap = CAC.MakeConstructor (self)

function self:ctor ()
	self.Keys = {}
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	for key, handlers in pairs (source.Keys) do
		for _, handler in ipairs (handlers) do
			self:Register (key, handler)
		end
	end
	
	return self
end

local lastEscapeFrame = nil
function self:Execute (control, key, ctrl, shift, alt)
	if not self.Keys [key] then return false end
	
	local handled
	for _, handler in ipairs (self.Keys [key]) do
		if type (handler) == "string" then
			handled = control:DispatchAction (handler)
		else
			handled = handler (control, key, ctrl, shift, alt)
		end
		
		if handled == nil then handled = true end
		if handled then break end
	end
	
	if handled and key == KEY_ESCAPE then
		if lastEscapeFrame ~= FrameNumber () then
			lastEscapeFrame = FrameNumber ()
			if gui.IsGameUIVisible () then
				gui.HideGameUI ()
			else
				gui.ActivateGameUI ()
			end
		end
	end
	
	return handled or false
end

function self:Register (key, handler)
	if type (key) == "table" then
		for _, v in ipairs (key) do
			self:Register (v, handler)
		end
		return
	end
	
	self.Keys [key] = self.Keys [key] or {}
	self.Keys [key] [#self.Keys [key] + 1] = handler
end

function self:Unregister (key, handler)
	if not handler then
		CAC.Error ("KeyboardMap:Unregister : No handler specified.")
	end
	
	if not self.Keys [key] then return end
	
	for i = 1, #self.Keys [key] do
		if self.Keys [key] [i] == handler then
			table.remove (self.Keys [key], i)
			break
		end
	end
end

function self:UnregisterAll (key)
	if not key then
		self.Keys = {}
	else
		self.Keys [key] = nil
	end
end

function self:__call ()
	return self:Clone ()
end