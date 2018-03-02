local self = {}

function self:Init ()
	self.DetectionResponseSettings = nil
	
	self.ResetWidget = self:Create ("CACResetWidget")
	self.ResetWidget:SetResetCommand ("Reset")
	
	-- Column headers
	self.ColumnHeaders = {}
	
	self:AddColumnHeader ("Detection")
	self:AddColumnHeader ("sv_allowcslua 0")
	self:AddColumnHeader ("sv_allowcslua 1")
	self:AddColumnHeader ("Actions")
	
	self.VerticalLayout = self:Create ("CACVerticalLayout")
	
	-- Rows
	self.Rows = {}
	self.RowsByDetectionType = {}
	
	for detectionInformation in CAC.Detections:GetEnumerator () do
		if not detectionInformation:IsDeprecated () then
			local detectionType = detectionInformation:GetDetectionType ()
			self:AddRow (detectionType)
		end
	end
end

function self:Paint (w, h)
end

function self:PerformLayout (w, h)
	local x = 0
	local y = 0
	
	local resetWidgetHeight = 24
	
	-- Rows
	y = 32 + 4 + 32 + 4
	self.VerticalLayout:SetPos (0, y)
	self.VerticalLayout:SetSize (w, h - y - resetWidgetHeight - 4)
	
	-- Column headers
	y = 0
	local availableWidth = w
	if self.VerticalLayout.VScroll:IsVisible () then
		availableWidth = availableWidth - self.VerticalLayout.VScroll:GetWidth () - 4
	end
	
	local columnHeaderWidth = (availableWidth - 4 * (3 - 1)) / 7
	
	-- Detections
	self.ColumnHeaders [1]:SetPos (x, y)
	x = x + columnHeaderWidth * 3
	self.ColumnHeaders [1]:SetSize (x - math.floor (self.ColumnHeaders [1]:GetX ()), 68)
	x = x + 4
	
	-- Actions
	self.ColumnHeaders [4]:SetPos (x, y)
	x = x + columnHeaderWidth * 4 + 4
	self.ColumnHeaders [4]:SetSize (x - math.floor (self.ColumnHeaders [4]:GetX ()), 32)
	x = x - columnHeaderWidth * 4 - 4
	y = y + 32
	y = y +  4
	
	-- Action headers
	for i = 2, 3 do
		self.ColumnHeaders [i]:SetPos (x, y)
		x = x + columnHeaderWidth * 2
		self.ColumnHeaders [i]:SetSize (x - math.floor (self.ColumnHeaders [i]:GetX ()), 32)
		
		x = x + 4
	end
	
	for i = 1, #self.ColumnHeaders do
		self.ColumnHeaders [i].Label:SetPos (8, 4)
		self.ColumnHeaders [i].Label:SetSize (self.ColumnHeaders [i]:GetWidth () - 16, self.ColumnHeaders [i]:GetHeight () - 8)
	end
	
	-- Reset widget
	self.ResetWidget:SetSize (w, resetWidgetHeight)
	self.ResetWidget:SetPos (0, h - self.ResetWidget:GetHeight ())
end

function self:OnRemoved ()
	self:SetDetectionResponseSettings (nil)
end

function self:GetDetectionResponseSettings ()
	return self.DetectionResponseSettings
end

function self:SetDetectionResponseSettings (detectionResponseSettings)
	if self.DetectionResponseSettings == detectionResponseSettings then return self end
	
	self:UnhookDetectionResponseSettings (self.DetectionResponseSettings)
	self.DetectionResponseSettings = detectionResponseSettings
	self:HookDetectionResponseSettings (self.DetectionResponseSettings)
	
	self.ResetWidget:SetTargetObject (self.DetectionResponseSettings)
	for _, row in ipairs (self.Rows) do
		row:SetDetectionResponseSettings (self.DetectionResponseSettings)
	end
	
	return self
end

-- Internal, do not call
function self:AddColumnHeader (text)
	local columnHeader = self:Create ("CACPanel")
	
	columnHeader:SetBackgroundColor (CAC.Colors.LightSteelBlue)
	columnHeader.Label = columnHeader:Create ("CACLabel")
	columnHeader.Label:SetText (text)
	columnHeader.Label:SetContentAlignment (4)
	
	self.ColumnHeaders [#self.ColumnHeaders + 1] = columnHeader
end

local transparentColor = Color (255, 255, 255, 0)
function self:AddRow (detectionType)
	if self.RowsByDetectionType [detectionType] then return self.RowsByDetectionType [detectionType] end
	
	local row = self:Create ("CACDetectionResponseRow")
	self.VerticalLayout:AddItem (row)
	
	self.Rows [#self.Rows + 1] = row
	self.RowsByDetectionType [detectionType] = row
	
	row:SetDetectionResponseSettings (self.DetectionResponseSettings)
	row:SetDetectionType (detectionType)
	
	return row
end

function self:HookDetectionResponseSettings (detectionResponseSettings)
	if not detectionResponseSettings then return end
	
	detectionResponseSettings:AddEventListener ("DetectionResponseChanged", "CAC.DetectionResponseSettingsView." .. self:GetHashCode (),
		function (_, detectionType, clientsideLuaDisallowedResponse, clientsideLuaAllowedResponse)
			if not self.RowsByDetectionType [detectionType] then return end
			
			self.RowsByDetectionType [detectionType]:Update ()
		end
	)
end

function self:UnhookDetectionResponseSettings (detectionResponseSettings)
	if not detectionResponseSettings then return end
	
	detectionResponseSettings:RemoveEventListener ("DetectionResponseChanged", "CAC.DetectionResponseSettingsView." .. self:GetHashCode ())
end

CAC.Register ("CACDetectionResponseSettingsView", self, "CACPanel")