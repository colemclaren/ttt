local self = {}

--[[
	Events:
		ContentHeightChanged (contentHeight)
			Fired when the content height has changed.
]]

function self:Init ()
	self.Columns                = {}
	self.ColumnSizingMethods    = {}
	self.ColumnSizingParameters = {}
	self.ColumnWidths           = {}
	self.ColumnXs               = {}
	
	self.ColumnLayoutValid      = true
	self.ContentLayoutValid     = true
	
	self.RowCount      = 0
	
	-- Layout
	self.ColumnSpacing = 16
	self.RowSpacing    = 8
	
	self.ContentHeight = 0
	
	self:AddEventListener ("WidthChanged",
		function ()
			self:InvalidateColumnLayout ()
		end
	)
end

function self:Paint (w, h)
end

function self:PerformLayout (w, h)
	if not self.ColumnLayoutValid then
		self:LayoutColumns (w, h)
	end
	
	if not self.ContentLayoutValid then
		self:LayoutContent (w, h)
	end
end

function self:LayoutColumns (w, h)
	if self.ColumnLayoutValid then return end
	
	self.ColumnLayoutValid = true
	
	local remainingWidth = w
	local expandToFitColumnCount = 0
	for i = 1, #self.Columns do
		local sizingMethod = self.ColumnSizingMethods [i]
		if sizingMethod == CAC.SizingMethod.Fixed then
			self.ColumnWidths [i] = math.min (remainingWidth - self.ColumnSpacing, self.ColumnSizingParameters [i])
		elseif sizingMethod == CAC.SizingMethod.Percentage then
			self.ColumnWidths [i] = math.min (remainingWidth - self.ColumnSpacing, math.floor (self.ColumnSizingParameters [i] / 100 * w + 0.5))
		else
			expandToFitColumnCount = expandToFitColumnCount + 1
		end
		
		if sizingMethod ~= CAC.SizingMethod.ExpandToFit then
			remainingWidth = remainingWidth - self.ColumnWidths [i] - self.ColumnSpacing
		end
	end
	
	-- Distribute remaining width among panels which expand to fit
	local dividedWidth = (remainingWidth - expandToFitColumnCount * self.ColumnSpacing) / expandToFitColumnCount
	for i = 1, #self.Columns do
		if self.ColumnSizingMethods [i] == CAC.SizingMethod.ExpandToFit then
			self.ColumnWidths [i] = dividedWidth
		end
	end
	
	-- Position columns
	local x = 0
	for i = 1, #self.Columns do
		self.ColumnXs [i] = x
		
		x = x + self.ColumnWidths [i]
		x = x + self.ColumnSpacing
	end
end

function self:LayoutContent ()
	if self.ContentLayoutValid then return end
	
	self.ContentLayoutValid = true
	
	if self.RowCount == 0 then	
		self:SetContentHeight (0)
		return
	end
	
	local y = 0
	for i = 1, self.RowCount do
		local h = 0
		for j = 1, #self.Columns do
			if self.Columns [j] [i] then
				self.Columns [j] [i]:SetWidth (self.ColumnWidths [j])
				
				h = math.max (h, self.Columns [j] [i]:GetHeight ())
			end
		end
		
		for j = 1, #self.Columns do
			if self.Columns [j] [i] then
				self.Columns [j] [i]:SetPos (self.ColumnXs [j], y)
			end
		end
		
		y = y + h
		y = y + self.RowSpacing
	end
	
	self:SetContentHeight (y - self.RowSpacing)
end

-- Columns
function self:AddColumn (sizingMethod, sizingParameter)
	sizingMethod = sizingMethod or CAC.SizingMethod.ExpandToFit
	
	local columnIndex = #self.Columns + 1
	self.Columns                [columnIndex] = {}
	self.ColumnSizingMethods    [columnIndex] = sizingMethod
	self.ColumnSizingParameters [columnIndex] = sizingParameter
	self.ColumnWidths           [columnIndex] = 0
	self.ColumnXs               [columnIndex] = 0
	
	self:InvalidateColumnLayout ()
end

function self:GetColumnCount ()
	return #self.Columns
end

function self:SetColumnSizingMethod (columnIndex, sizingMethod, sizingParameter)
	if self.ColumnSizingMethods    [columnIndex] == sizingMethod and
	   self.ColumnSizingParameters [columnIndex] == sizingParameter then
		return self
	end
	
	self.ColumnSizingMethods    [columnIndex] = sizingMethod
	self.ColumnSizingParameters [columnIndex] = sizingParameter
	
	self:InvalidateColumnLayout ()
	
	return self
end

function self:SetColumnWidth (columnIndex, width)
	return self:SetColumnSizingMethod (columnIndex, CAC.SizingMethod.Fixed, width)
end

function self:SetColumnWidthFraction (columnIndex, widthFraction)
	return self:SetColumnSizingMethod (columnIndex, CAC.SizingMethod.Percentage, widthFraction * 100)
end

function self:SetColumnCount (columnCount)
	if #self.Columns == columnCount then return self end
	
	for i = #self.Columns + 1, columnCount do
		self:AddColumn ()
	end
	
	for i = #self.Columns, columnCount + 1, -1 do
		for _, control in pairs (self.Columns [i]) do
			control:Remove ()
		end
		
		self.Columns                [i] = nil
		self.ColumnSizingMethods    [i] = nil
		self.ColumnSizingParameters [i] = nil
		self.ColumnWidths           [i] = nil
		self.ColumnXs               [i] = nil
	end
	
	self:InvalidateColumnLayout ()
	
	return self
end

-- Rows
function self:AddRow (...)
	local controls = {...}
	
	self.RowCount = self.RowCount + 1
	
	for i = 1, #self.Columns do
		self.Columns [i] [self.RowCount] = controls [i]
		
		if controls [i] then
			controls [i]:SetParent (self)
			
			controls [i]:AddEventListener ("HeightChanged",
				function (_, height)
					self:InvalidateContentLayout ()
				end
			)
		end
	end
	
	self:InvalidateContentLayout ()
	
	return controls
end

local backgroundColor = Color (0, 0, 0, 0)
function self:AddSpacing (height)
	return self:AddRow (
		self:Create ("CACPanel")
			:SetBackgroundColor (backgroundColor)
			:SetHeight (height)
	)
end

function self:GetControl (row, column)
	return self.Columns [column] [row]
end

function self:GetRowCount ()
	return self.RowCount
end

-- Layout
function self:GetContentHeight ()
	if not self.ContentLayoutValid then
		self:PerformLayout (self:GetSize ())
	end
	
	return self.ContentHeight
end

function self:GetColumnSpacing ()
	return self.ColumnSpacing
end

function self:GetRowSpacing ()
	return self.RowSpacing
end

function self:SetColumnSpacing (columnSpacing)
	if self.ColumnSpacing == columnSpacing then return self end
	
	self.ColumnSpacing = columnSpacing
	
	self:InvalidateColumnLayout ()
	
	return self
end

function self:SetRowSpacing (rowSpacing)
	if self.RowSpacing == rowSpacing then return self end
	
	self.RowSpacing = rowSpacing
	
	self:InvalidateContentLayout ()
	
	return self
end

-- Internal, do not call
function self:SetContentHeight (contentHeight)
	if self.ContentHeight == contentHeight then return self end
	
	self.ContentHeight = contentHeight
	
	self:DispatchEvent ("ContentHeightChanged", self.ContentHeight)
	
	return self
end

function self:InvalidateColumnLayout ()
	self.ColumnLayoutValid  = false
	self.ContentLayoutValid = false
	
	self:InvalidateLayout ()
end

function self:InvalidateContentLayout ()
	self.ContentLayoutValid = false
	
	self:InvalidateLayout ()
end

CAC.Register ("CACGridLayout", self, "CACPanel")