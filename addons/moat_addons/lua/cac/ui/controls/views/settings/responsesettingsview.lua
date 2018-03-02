local self = {}

function self:Init ()
	self.ResponseSettings = nil
	
	self.Form = self:Create ("CACSettingsForm")
	
	-- Durations
	self.Form:AddHeader ("Countdown", "ResetCountdownSettings")
	self.Form:AddGridLayout (3, 16)
		:SetColumnWidthFraction (1, 0.20)
	
	self:AddDuration ("Countdown duration", "CountdownDuration")
	
	-- Bans
	self.Form:AddHeader ("Bans", "ResetBanSettings")
	self.Form:AddGridLayout (3, 16)
		:SetRowSpacing (0)
		:SetColumnWidthFraction (1, 0.20)
	self:AddDuration ("Ban duration", "BanDuration")
	self.Form:AddGridSpacing (2)
	
	self.Form:AddGridRow (nil,
		self:Create ("CACLabel")
			:SetFont (CAC.Font ("Roboto", 14))
			:SetHeight (32)
			:SetText ("eg. \"15.5 minutes\", \"2 hours 30 minutes\", \"20 ks\" or \"forever\"."),
		nil
	)
	self.Form:GetLastGridLayout ():GetControl (self.Form:GetLastGridLayout ():GetRowCount (), 2):SetWrap (true)
	self.Form:GetLastGridLayout ():GetControl (self.Form:GetLastGridLayout ():GetRowCount (), 2):SetContentAlignment (7)
	self.Form:AddGridSpacing (2)
	
	self.BanSystemComboBox = self:Create ("CACComboBox")
	self.BanSystemComboBox:SetFont (CAC.Font ("Roboto", 18))
	self.Form:AddGridRow (
		self:Create ("CACLabel")
			:SetFont (CAC.Font ("Roboto", 18))
			:SetText ("Ban system:"),
		self.BanSystemComboBox
	)
	
	self.BanSystemComboBox:AddItem ("Auto: Unknown", "Auto")
		:SetIcon ("icon16/accept.png")
		:SetEnabled (true)
	
	for banSystem in CAC.SystemRegistry:GetSystemEnumerator ("BanSystem") do
		self.BanSystemComboBox:AddItem (banSystem:GetName (), banSystem:GetId ())
			:SetIcon ("icon16/error.png")
			:SetEnabled (false)
	end
	
	self.BanSystemComboBox:AddEventListener ("SelectedItemChanged",
		function (_, _, selectedItem)
			if not selectedItem          then return end
			if not self.ResponseSettings then return end
			
			self.ResponseSettings:DispatchEvent ("SetBanSystem", selectedItem:GetId ())
		end
	)
	
	self:AddEventListener ("ResponseSettingsChanged",
		function (_, responseSettings)
			if not responseSettings then return end
			
			self.BanSystemComboBox:SetSelectedItem (responseSettings:GetBanSystem ())
		end
	)
	
	self:AddEventListener ("HookResponseSettings",
		function (_, responseSettings)
			responseSettings:AddEventListener ("BanSystemChanged", "CAC.ResponseSettingsView." .. self:GetHashCode (),
				function (_, banSystem)
					self.BanSystemComboBox:SetSelectedItem (banSystem)
				end
			)
		end
	)
	
	self:AddEventListener ("UnhookResponseSettings",
		function (_, responseSettings)
			responseSettings:RemoveEventListener ("BanSystemChanged", "CAC.ResponseSettingsView." .. self:GetHashCode ())
		end
	)
	
	-- Messages
	self.Form:AddHeader ("Messages", "ResetMessageSettings")
	
	local helpLabel1 = self:Create ("CACLabel")
	helpLabel1:SetTextColor (CAC.Colors.Firebrick)
	helpLabel1:SetFont (CAC.Font ("Roboto", 18))
	helpLabel1:SetText ("MESSAGE CUSTOMIZATION IS DONE AT YOUR OWN RISK.\nHELP WILL NOT BE PROVIDED FOR EDITING THESE MESSAGES.")
	helpLabel1:SizeToContents ()
	self.Form:AddIndentedControl (helpLabel1)
	self.Form:AddSpacing (8)
	
	local helpLabel2 = self:Create ("CACLabel")
	helpLabel2:SetFont (CAC.Font ("Roboto", 14))
	helpLabel2:SetHeight (70)
	helpLabel2:SetWrap (true)
	helpLabel2:SetText ("Special items are {identifier}, {identifier:formatter}, {condition?text if true:text if false}\n" ..
	                   "Available identifiers are {name}, {steamid}, {incidentid}, {response}, {responsed}, {countdownduration}, {countdowntimeremaining}, {banduration}, {approvername}, {approversteamid}, {detectionnames}, {fulldetectionnames}\n" ..
	                   "Available formatters are {:lowercase}, {:uppercase}, {:titlecase}\n" ..
					   "Available conditions are {ignore?:}, {kick?:}, {ban?:}, {permanentban?:}, {approved?:}"
	)
	self.Form:AddIndentedControl (helpLabel2)
	self.Form:AddSpacing (8)
	
	self.Form:AddGridLayout (3, 16)
		:SetColumnWidthFraction (1, 0.20)
	
	local previewHeader = self:Create ("CACLabel")
	previewHeader:SetFont (CAC.Font ("Roboto", 20))
	previewHeader:SetHeight (previewHeader:GetHeight () - 8)
	previewHeader:SetText ("Preview")
	
	self.Form:AddGridRow (nil, nil, previewHeader)
	self.Form:AddGridRow (nil, nil,
		self:Create ("CACPanel")
			:SetHeight (1)
			:SetBackgroundColor (CAC.Colors.CornflowerBlue)
	)
	
	self:AddMessage  ("Response notification", "ResponseNotification")
	self:AddMessage  ("Kick message",          "KickMessage",
		function (incidentMessageParameters)
			incidentMessageParameters:SetDetectionResponse (CAC.DetectionResponse.Kick)
		end
	)
	self:AddMessage  ("Ban message",           "BanMessage",
		function (incidentMessageParameters)
			incidentMessageParameters:SetDetectionResponse (CAC.DetectionResponse.Ban)
		end
	)
	self:AddMessage  ("Ban reason",            "BanReason",
		function (incidentMessageParameters)
			incidentMessageParameters:SetDetectionResponse (CAC.DetectionResponse.Ban)
		end
	)
end

function self:Paint (w, h)
end

function self:PerformLayout (w, h)
	self.Form:SetPos (0, 0)
	self.Form:SetSize (w, h)
end

function self:OnRemoved ()
	self:SetResponseSettings (nil)
end

function self:GetResponseSettings ()
	return self.ResponseSettings
end

function self:SetResponseSettings (responseSettings)
	if self.ResponseSettings == responseSettings then return self end
	
	self.Form:SetTargetObject (responseSettings)
	
	self:UnhookResponseSettings (self.ResponseSettings)
	self.ResponseSettings = responseSettings
	self:HookResponseSettings (self.ResponseSettings)
	
	if self.ResponseSettings then
		self.ResponseSettings:DispatchEvent ("RequestBanSystemStatus",
			function (sender, object, inBuffer)
				if not self            then return end
				if not self:IsValid () then return end
				
				local banSystemStatus = CAC.BanSystemStatus ()
				banSystemStatus:Deserialize (inBuffer)
				
				local bestSystem = CAC.SystemRegistry:GetSystem ("BanSystem", banSystemStatus:GetBestBanSystem ())
				self.BanSystemComboBox:GetItemById ("Auto")
					:SetText ("Auto: " .. (bestSystem and bestSystem:GetName () or "Unknown"))
				
				for comboBoxItem in self.BanSystemComboBox:GetItemEnumerator () do
					if comboBoxItem:GetId () ~= "Auto" then
						comboBoxItem:SetIcon (banSystemStatus:IsBanSystemAvailable (comboBoxItem:GetId ()) and "icon16/accept.png" or "icon16/error.png")
						comboBoxItem:SetEnabled (banSystemStatus:IsBanSystemAvailable (comboBoxItem:GetId ()))
					end
				end
			end
		)
	end
	
	self:DispatchEvent ("ResponseSettingsChanged", self.ResponseSettings)
	
	return self
end

-- Internal, do not call
function self:AddDuration (text, propertyName)
	local getterName = "Get" .. propertyName
	local setterName = "Set" .. propertyName
	local eventName  = propertyName .. "Changed"
	
	local label = self:Create ("CACLabel")
	label:SetFont (CAC.Font ("Roboto", 18))
	label:SetText (text .. ":")
	
	local textEntry = self:Create ("CACTextEntry")
	textEntry:SetFont (CAC.Font ("Roboto", 18))
	
	local previewLabel = self:Create ("CACLabel")
	previewLabel:SetFont (CAC.Font ("Roboto", 18))
	
	local function UpdatePreview (hasFocus)
		if hasFocus == nil then hasFocus = textEntry:HasFocus () end
		
		local duration, valid = CAC.DurationParser.Parse (textEntry:GetText ())
		local color = valid and CAC.Colors.Green or CAC.Colors.Red
		
		previewLabel:SetTextColor (color)
		
		if valid and not hasFocus then
			previewLabel:SetText ("")
			return
		end
		
		previewLabel:SetText ((valid and "OK: " or "??? ") .. CAC.FormatDurationVerbose (duration))
	end
	
	textEntry:AddEventListener ("TextChanged",
		function (_, text)
			local duration, valid = CAC.DurationParser.Parse (text)
			local color = valid and CAC.Colors.Green or CAC.Colors.Red
			
			textEntry:SetTextColor (color)
			
			UpdatePreview ()
		end
	)
	
	textEntry:AddEventListener ("GotFocus",
		function (_)
			UpdatePreview ()
		end
	)
	
	textEntry:AddEventListener ("LostFocus",
		function (_)
			if input.IsKeyDown (KEY_ESCAPE) then
				textEntry:SetText (CAC.FormatDurationVerbose (self.ResponseSettings [getterName] (self.ResponseSettings)))
			end
			
			local duration, valid = CAC.DurationParser.Parse (textEntry:GetText ())
			if not valid then return end
			
			UpdatePreview (false)
			self.ResponseSettings:DispatchEvent (setterName, duration)
		end
	)
	
	label       :SetHeight (textEntry:GetHeight ())
	previewLabel:SetHeight (textEntry:GetHeight ())
	
	self.Form:AddGridRow (label, textEntry, previewLabel)
	
	UpdatePreview ()
	
	-- Event listeners
	self:AddEventListener ("ResponseSettingsChanged",
		function (_, responseSettings)
			if not responseSettings then return end
			
			textEntry:SetText (CAC.FormatDurationVerbose (responseSettings [getterName] (responseSettings)))
		end
	)
	
	self:AddEventListener ("HookResponseSettings",
		function (_, responseSettings)
			responseSettings:AddEventListener (eventName, "CAC.ResponseSettingsView." .. self:GetHashCode (),
				function (_)
					textEntry:SetText (CAC.FormatDurationVerbose (responseSettings [getterName] (responseSettings)))
				end
			)
		end
	)
	
	self:AddEventListener ("UnhookResponseSettings",
		function (_, responseSettings)
			responseSettings:RemoveEventListener (eventName, "CAC.ResponseSettingsView." .. self:GetHashCode ())
		end
	)
end

function self:AddMessage (text, propertyName, incidentMessageParameterModifier)
	local getterName = "Get" .. propertyName
	local setterName = "Set" .. propertyName
	local eventName  = propertyName .. "Changed"
	
	local label = self:Create ("CACLabel")
	label:SetFont (CAC.Font ("Roboto", 18))
	label:SetContentAlignment (7)
	label:SetText (text .. ":")
	
	local textEntry = self:Create ("CACTextEntry")
	textEntry:SetMultiline (true)
	textEntry:SetHeight (128)
	textEntry:SetWrap (true)
	textEntry:SetVerticalScrollbarEnabled (true)
	textEntry:SetFont (CAC.Font ("Roboto", 16))
	
	local previewLabel = self:Create ("CACLabel")
	previewLabel:SetWrap (true)
	previewLabel:SetFont (CAC.Font ("Roboto", 16))
	previewLabel:SetContentAlignment (7)
	
	local function UpdatePreview ()
		local incidentMessageParameters = CAC.IncidentMessageParameters.CreateExample ()
		if incidentMessageParameterModifier then
			incidentMessageParameterModifier (incidentMessageParameters)
		end
		previewLabel:SetText (CAC.FormatMessage (textEntry:GetText (), incidentMessageParameters))
	end
	
	textEntry:AddEventListener ("TextChanged",
		function (_, text)
			UpdatePreview ()
		end
	)
	
	textEntry:AddEventListener ("LostFocus",
		function (_)
			if input.IsKeyDown (KEY_ESCAPE) then
				textEntry:SetText (self.ResponseSettings [getterName] (self.ResponseSettings))
			end
			
			self.ResponseSettings:DispatchEvent (setterName, textEntry:GetText ())
		end
	)
	
	label       :SetHeight (textEntry:GetHeight ())
	previewLabel:SetHeight (textEntry:GetHeight ())
	
	self.Form:AddGridRow (label, textEntry, previewLabel)
	
	UpdatePreview ()
	
	-- Event listeners
	self:AddEventListener ("ResponseSettingsChanged",
		function (_, responseSettings)
			if not responseSettings then return end
			
			textEntry:SetText (responseSettings [getterName] (responseSettings))
		end
	)
	
	self:AddEventListener ("UpdateMessagePreviews",
		function (_)
			UpdatePreview ()
		end
	)
	
	self:AddEventListener ("HookResponseSettings",
		function (_, responseSettings)
			CAC.BindCustomProperty (textEntry, "SetText", responseSettings, getterName, eventName, "CAC.ResponseSettingsView." .. self:GetHashCode ())
		end
	)
	
	self:AddEventListener ("UnhookResponseSettings",
		function (_, responseSettings)
			CAC.UnbindCustomProperty (textEntry, "SetText", responseSettings, getterName, eventName, "CAC.ResponseSettingsView." .. self:GetHashCode ())
		end
	)
end

function self:HookResponseSettings (responseSettings)
	if not responseSettings then return end
	
	self:DispatchEvent ("HookResponseSettings", responseSettings)
	
	responseSettings:AddEventListener ("CountdownDurationChanged", "CAC.ResponseSettingsView." .. self:GetHashCode () .. ".UpdateMessagePreviews",
		function (_)
			self:DispatchEvent ("UpdateMessagePreviews")
		end
	)
	
	responseSettings:AddEventListener ("BanDurationChanged", "CAC.ResponseSettingsView." .. self:GetHashCode () .. ".UpdateMessagePreviews",
		function (_)
			self:DispatchEvent ("UpdateMessagePreviews")
		end
	)
end

function self:UnhookResponseSettings (responseSettings)
	if not responseSettings then return end
	
	self:DispatchEvent ("UnhookResponseSettings", responseSettings)
	
	responseSettings:RemoveEventListener ("CountdownDurationChanged", "CAC.ResponseSettingsView." .. self:GetHashCode () .. ".UpdateMessagePreviews")
	responseSettings:RemoveEventListener ("BanDurationChanged",       "CAC.ResponseSettingsView." .. self:GetHashCode () .. ".UpdateMessagePreviews")
end

CAC.Register ("CACResponseSettingsView", self, "CACPanel")