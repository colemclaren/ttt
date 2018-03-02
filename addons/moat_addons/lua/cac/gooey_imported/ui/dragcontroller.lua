-- Generated from: gooey/lua/gooey/ui/dragcontroller.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/dragcontroller.lua
-- Timestamp:      2016-04-28 19:58:52
local self = {}
CAC.DragController = CAC.MakeConstructor (self)

--[[
	Events:
		DragEnded ()
			Fired when the dragging has ended.
		PositionCorrectionChanged (deltaX, deltaY)
			Fired when the control's position needs to be changed.
]]

function self:ctor (control)
	self.Control = nil
	
	CAC.EventProvider (self)
	
	self.ExpectingDrag = false
	self.Dragging = false
	self.MouseDownX = 0
	self.MouseDownY = 0
	
	self.MouseDown = function (_, mouseCode, x, y)
		if mouseCode == MOUSE_LEFT then
			self.Control:MouseCapture (true)
			
			self.ExpectingDrag = true
			self.MouseDownX = x
			self.MouseDownY = y
		end
	end
	self.MouseMove = function (_, mouseCode, x, y)
		if self.Dragging then
			self:DispatchEvent ("PositionCorrectionChanged", x - self.MouseDownX, y - self.MouseDownY)
		elseif self.ExpectingDrag then
			self:BeginDrag ()
		end
	end
	self.MouseUp = function (_, mouseCode, x, y)
		if mouseCode == MOUSE_LEFT then
			self.Control:MouseCapture (false)
			
			self.ExpectingDrag = false
			self:EndDrag ()
		end
	end
	
	self:SetControl (control)
end

function self:BeginDrag ()
	if self.Dragging then return end
	
	if not self.ExpectingDrag then
		self.ExpectingDrag = true
		self.MouseDownX, self.MouseDownY = self.Control:CursorPos ()
	end
	
	self.ExpectingDrag = false
	self.Dragging = true
end

function self:EndDrag ()
	if not self.Dragging then return end
	
	self.Dragging = false
	self.ExpectingDrag = false
	
	self:DispatchEvent ("DragEnded")
end

function self:SetControl (control)
	if self.Control == control then return end
	
	self:EndDrag ()
	
	if self.Control then
		self.Control:RemoveEventListener ("MouseDown", "CAC.DragController." .. self:GetHashCode ())
		self.Control:RemoveEventListener ("MouseMove", "CAC.DragController." .. self:GetHashCode ())
		self.Control:RemoveEventListener ("MouseUp",   "CAC.DragController." .. self:GetHashCode ())
	end
	
	self.Control = control
	
	if self.Control then
		self.Control:AddEventListener ("MouseDown", "CAC.DragController." .. self:GetHashCode (), self.MouseDown)
		self.Control:AddEventListener ("MouseMove", "CAC.DragController." .. self:GetHashCode (), self.MouseMove)
		self.Control:AddEventListener ("MouseUp",   "CAC.DragController." .. self:GetHashCode (), self.MouseUp)
	end
end

-- Event handlers
self.MouseDown = CAC.NullCallback
self.MouseMove = CAC.NullCallback
self.MouseUp   = CAC.NullCallback