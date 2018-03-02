local self = {}

function self:Init ()
	self.TargetObject   = nil
	
	self.VerticalLayout = self:Create ("CACVerticalLayout")
	self.GridLayouts    = {}
	
	self.LastGridLayout = nil
end

function self:Paint (w, h)
end

function self:PerformLayout (w, h)
	self.VerticalLayout:SetPos (0, 0)
	self.VerticalLayout:SetSize (w, h)
	
	for _, gridLayout in ipairs (self.GridLayouts) do
		gridLayout:SetHeight (gridLayout:GetContentHeight ())
	end
end

function self:GetTargetObject ()
	return self.TargetObject
end

function self:SetTargetObject (targetObject)
	if self.TargetObject == targetObject then return self end
	
	self:UnhookTargetObject (self.TargetObject)
	self.TargetObject = targetObject
	self:HookTargetObject (self.TargetObject)
	
	self:DispatchEvent ("TargetObjectChanged", self.TargetObject)
	
	return self
end

-- Form elements
function self:AddControl (control)
	self.VerticalLayout:AddItem (control)
	self.LastGridLayout = nil
	
	return control
end

function self:AddIndentedControl (control, indent)
	indent = indent or 16
	
	if indent == 0 then
		return self:AddControl (control)
	end
	
	local container = self:Create ("GContainer")
	
	control:SetParent (container)
	control:SetPos (indent, 0)
	
	container:AddEventListener ("WidthChanged",
		function (_, w)
			control:SetWidth (w - indent)
		end
	)
	
	control:AddEventListener ("HeightChanged",
		function (_, h)
			container:SetHeight (h)
		end
	)
	
	self:AddControl (container)
	
	return control
end

function self:AddGridLayout (columnCount, indent)
	indent = indent or 0
	
	local gridLayout = self:Create ("CACGridLayout")
	gridLayout:SetColumnCount (columnCount)
	
	gridLayout:AddEventListener ("ContentHeightChanged",
		function ()
			self:InvalidateLayout ()
		end
	)
	
	if indent == 0 then
		self:AddControl (gridLayout)
	else
		self:AddIndentedControl (gridLayout, indent)
	end
	
	self.GridLayouts [#self.GridLayouts + 1] = gridLayout
	self.LastGridLayout = gridLayout
	
	return gridLayout
end

function self:AddGridRow (...)
	return self.LastGridLayout:AddRow (...)
end

function self:AddGridSpacing (spacing)
	self.LastGridLayout:AddSpacing (spacing)
end

function self:AddHorizontalLine (indent)
	indent = indent or 0
	
	-- Horizontal line
	local horizontalLine = self:Create ("CACPanel")
	horizontalLine:SetHeight (4)
	horizontalLine.Paint = function (self, w, h)
		surface.SetDrawColor (CAC.Colors.CornflowerBlue)
		surface.DrawLine (0, 0, w, 0)
	end
	
	self:AddIndentedControl (horizontalLine, indent)
	
	return horizontalLine
end

local backgroundColor = Color (0, 0, 0, 0)
function self:AddSpacing (spacing)
	local panel = self:Create ("GPanel")
	panel:SetHeight (spacing)
	panel:SetBackgroundColor (backgroundColor)
	
	self:AddControl (panel)
end

function self:AddHeader (text, resetCommand)
	-- Header label
	local label = self:Create ("CACLabel")
	label:SetTextInset (4, 0)
	label:SetText (text)
	label:SetFont (CAC.Font ("Roboto", 24))
	label:SizeToContents ()
	
	if self.VerticalLayout:GetItemCount () > 0 then
		self:AddSpacing (8)
	end
	
	if resetCommand then
		local resetWidget = self:Create ("CACResetWidget")
		resetWidget:SetTargetObject (self:GetTargetObject ())
		resetWidget:SetResetCommand (resetCommand)
		
		self:AddGridLayout (2)
		self:AddGridRow (label, resetWidget)
		
		CAC.BindCustomProperty (resetWidget, "SetTargetObject", self, "GetTargetObject", "TargetObjectChanged", "CAC.SettingsForm." .. self:GetHashCode () .. "." .. resetCommand)
	else
		self:AddControl (label)
	end
	
	self:AddHorizontalLine ()
end

function self:GetLastGridLayout ()
	return self.LastGridLayout
end

-- Internal, do not call
function self:HookTargetObject (targetObject)
	if not targetObject then return end
end

function self:UnhookTargetObject (targetObject)
	if not targetObject then return end
end

CAC.Register ("CACSettingsForm", self, "CACPanel")