local self = {}

function self:Init ()
	self.LuaScannerSettings = nil
	self.LuaScannerStatus   = nil
	
	self.Form = self:Create ("CACSettingsForm")
	
	self.Form:AddHeader ("Lua Scanner")
	
	self.LuaScanningCheckboxContainer = self:Create ("GContainer")
	self.LuaScanningCheckboxContainer:SetHeight (64)
	self.LuaScanningCheckboxContainer.PerformLayout = function (_, w, h)
		self.LuaScanningCheckbox   :SetWidth (w)
		self.LuaScanningDescription:SetPos (20, self.LuaScanningCheckbox:GetHeight ())
		self.LuaScanningDescription:SetSize (w - 20, h - self.LuaScanningCheckbox:GetHeight ())
	end
	
	self.LuaScanningCheckbox = self:Create ("CACCheckbox", self.LuaScanningCheckboxContainer)
		:SetHeight (18)
		:SetFont (CAC.Font ("Roboto", 18))
		:SetText ("Enable Lua scanner on startup")
	self.LuaScanningCheckbox:AddEventListener ("CheckStateChanged",
		function (_, checked)
			if not self.LuaScannerSettings then return end
			
			self.LuaScanningDescription:SetTextColor (checked and CAC.Colors.Black or CAC.Colors.LightGray)
			
			self.LuaScannerSettings:DispatchEvent ("SetLuaScanningEnabled", checked)
		end
	)
	self.LuaScanningDescription = self:Create ("CACLabel", self.LuaScanningCheckboxContainer)
	self.LuaScanningDescription:SetContentAlignment (7)
	self.LuaScanningDescription:SetWrap (true)
	self.LuaScanningDescription:SetHeight (28)
		:SetFont (CAC.Font ("Roboto", 14))
		:SetText ("Net receivers, console commands and hooks will be sent to a web server for analysis.\nEach report entry contains a file path and line range along with the relevant section of source code.\nComplete source files will NEVER be sent.")
	
	self.Form:AddIndentedControl (self.LuaScanningCheckboxContainer)
	
	self.AutomaticPatchingCheckbox = self:Create ("CACCheckbox", self)
		:SetFont (CAC.Font ("Roboto", 18))
		:SetText ("Run patches automatically")
	self.AutomaticPatchingCheckbox:AddEventListener ("CheckStateChanged",
		function (_, checked)
			if not self.LuaScannerSettings then return end
			
			self.LuaScannerSettings:DispatchEvent ("SetAutomaticPatchingEnabled", checked)
		end
	)
	self.Form:AddIndentedControl (self.AutomaticPatchingCheckbox)
	
	self.Form:AddHeader ("Scan Results")
	
	self.ScanStatusLabel = self:Create ("CACLabel")
		:SetHeight (24)
		:SetFont (CAC.Font ("Roboto", 18))
	self.ScanStartButton = self:Create ("CACButton")
		:SetHeight (24)
		:SetFont (CAC.Font ("Roboto", 16))
		:SetText ("Start scan")
	self.ScanStartButton:AddEventListener ("Click",
		function (_)
			if not self.LuaScannerStatus then return end
			
			self.LuaScannerStatus:DispatchEvent ("StartScan")
		end
	)
	
	self.ScanControlGridLayout = self.Form:AddGridLayout (3, 16)
		:SetColumnWidth (2, 96)
	self.Form:AddGridRow (self.ScanStatusLabel, self.ScanStartButton)
	
	self.LuaScanResultListBox = self:Create ("CACLuaScanResultListBox")
		:SetVisible (false)
	self.Form:AddIndentedControl (self.LuaScanResultListBox)
	
	self:SetLuaScannerSettings (CAC.Settings:GetSettingsGroup ("LuaScannerSettings"))
end

function self:Paint (w, h)
	if not self:GetLuaScannerStatus () then
		self:SetLuaScannerStatus (CAC.NetworkingClient:GetLuaScannerStatus ())
	end
end	

function self:PerformLayout (w, h)
	self.Form:SetPos (4, 4)
	self.Form:SetSize (w - 8, h - 8)
end

function self:Think ()
	if not self.LuaScannerStatus then return end
	
	local luaScannerState = self.LuaScannerStatus:GetLuaScannerState ()
	
	self.ScanStartButton:SetVisible (luaScannerState == CAC.LuaScannerState.Unstarted)
	
	if luaScannerState == CAC.LuaScannerState.Unstarted then
		self.ScanStatusLabel:SetText ("Scan unstarted.")
		self.ScanControlGridLayout:SetColumnWidthFraction (1, 0.15)
	elseif luaScannerState == CAC.LuaScannerState.WaitingForResults then
		self.ScanStatusLabel:SetText ("Waiting for scan results...")
		self.ScanControlGridLayout:SetColumnWidthFraction (1, 0.7)
	elseif luaScannerState == CAC.LuaScannerState.Unpatched or
	       luaScannerState == CAC.LuaScannerState.Patched then
		local lastScanTime = self.LuaScannerStatus:GetLastScanTime ()
		self.ScanStatusLabel:SetText ("Scan completed " .. CAC.FormatTimestampRelative (lastScanTime) .. " (" .. CAC.FormatTimestamp (lastScanTime) .. ").")
		self.ScanControlGridLayout:SetColumnWidthFraction (1, 0.7)
	end
end

function self:OnRemoved ()
	self:SetLuaScannerSettings (nil)
	self:SetLuaScannerStatus   (nil)
end

function self:GetLuaScannerSettings ()
	return self.LuaScannerSettings
end

function self:GetLuaScannerStatus ()
	return self.LuaScannerStatus
end

function self:SetLuaScannerSettings (luaScannerSettings)
	if self.LuaScannerSettings == luaScannerSettings then return self end
	
	self.Form:SetTargetObject (luaScannerSettings)
	
	self:UnhookLuaScannerSettings (self.LuaScannerSettings)
	self.LuaScannerSettings = luaScannerSettings
	self:HookLuaScannerSettings (self.LuaScannerSettings)
	
	if self.LuaScannerSettings then
		self:UpdateLuaScannerSettings ()
	end
	
	self:DispatchEvent ("LuaScannerSettingsChanged", self.LuaScannerSettings)
	
	return self
end

function self:SetLuaScannerStatus (luaScannerStatus)
	if self.LuaScannerStatus == luaScannerStatus then return self end
	
	self:UnhookLuaScannerStatus (self.LuaScannerStatus)
	self.LuaScannerStatus = luaScannerStatus
	self:HookLuaScannerStatus (self.LuaScannerStatus)
	
	if self.LuaScannerStatus then
		self:UpdateLuaScannerStatus ()
	end
	
	self:DispatchEvent ("LuaScannerStatusChanged", self.LuaScannerStatus)
	
	return self
end

-- Internal, do not call
function self:UpdateLuaScannerSettings ()
	self.LuaScanningCheckbox      :SetChecked   (self.LuaScannerSettings:IsLuaScanningEnabled ())
	self.LuaScanningDescription   :SetTextColor (self.LuaScannerSettings:IsLuaScanningEnabled () and CAC.Colors.Black or CAC.Colors.LightGray)
	self.AutomaticPatchingCheckbox:SetChecked   (self.LuaScannerSettings:IsAutomaticPatchingEnabled ())
end

function self:UpdateLuaScannerStatus ()
	if not self.LuaScannerStatus then return end
	
	local luaScanResult = self.LuaScannerStatus:GetLuaScanResult ()
	self.LuaScanResultListBox:SetLuaScanResult (luaScanResult)
	self.LuaScanResultListBox:SetVisible (luaScanResult ~= nil)
	
	local _, y0 = self.LuaScanResultListBox:LocalToScreen (0, 0)
	local _, y1 = self:LocalToScreen (0, self:GetHeight ())
	
	local contentHeight = self.LuaScanResultListBox.ScrollableViewController:GetContentHeight ()
	contentHeight = math.max (contentHeight, y1 - y0 - 4)
	self.LuaScanResultListBox:SetHeight (contentHeight)
end

function self:HookLuaScannerSettings (luaScannerSettings)
	if not luaScannerSettings then return end
	
	self:DispatchEvent ("HookLuaScannerSettings", luaScannerSettings)
	
	luaScannerSettings:AddEventListener ("LuaScannerEnabledChanged", "CAC.ServerView." .. self:GetHashCode (),
		function (_)
			self:UpdateLuaScannerSettings ()
		end
	)
	luaScannerSettings:AddEventListener ("AutomaticPatchingEnabledChanged", "CAC.ServerView." .. self:GetHashCode (),
		function (_)
			self:UpdateLuaScannerSettings ()
		end
	)
end

function self:UnhookLuaScannerSettings (luaScannerSettings)
	if not luaScannerSettings then return end
	
	self:DispatchEvent ("UnhookLuaScannerSettings", luaScannerSettings)
	
	luaScannerSettings:RemoveEventListener ("LuaScannerEnabledChanged",        "CAC.ServerView." .. self:GetHashCode ())
	luaScannerSettings:RemoveEventListener ("AutomaticPatchingEnabledChanged", "CAC.ServerView." .. self:GetHashCode ())
end

function self:HookLuaScannerStatus (luaScannerStatus)
	if not luaScannerStatus then return end
	
	self:DispatchEvent ("HookLuaScannerStatus", luaScannerStatus)
	
	luaScannerStatus:AddEventListener ("LuaScannerStateChanged", "CAC.ServerView." .. self:GetHashCode (),
		function (_)
			self:UpdateLuaScannerStatus ()
		end
	)
	luaScannerStatus:AddEventListener ("LuaScanResultChanged", "CAC.ServerView." .. self:GetHashCode (),
		function (_)
			self:UpdateLuaScannerStatus ()
		end
	)
end

function self:UnhookLuaScannerStatus (luaScannerStatus)
	if not luaScannerStatus then return end
	
	self:DispatchEvent ("UnhookLuaScannerStatus", luaScannerStatus)
	
	luaScannerStatus:RemoveEventListener ("LuaScannerStateChanged", "CAC.ServerView." .. self:GetHashCode ())
	luaScannerStatus:RemoveEventListener ("LuaScanResultChanged",   "CAC.ServerView." .. self:GetHashCode ())
end

CAC.Register ("CACServerView", self, "CACPanel")