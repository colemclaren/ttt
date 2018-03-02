local self = {}

function self:Init ()
	self.LuaWhitelistSettings = nil
	self.LuaWhitelistStatus   = nil
	
	self.Form = self:Create ("CACSettingsForm")
	
	self.Form:AddHeader ("Status")
	
	-- Counts
	self.Form:AddGridLayout (3, 16)
		:SetRowSpacing (4)
		:SetColumnWidthFraction (3, 0.5)
	
	self.FileCountLabel           = self:Create ("CACLabel"):SetFont (CAC.Font ("Roboto", 18))
	self.FunctionCountLabel       = self:Create ("CACLabel"):SetFont (CAC.Font ("Roboto", 18))
	self.UniqueFunctionCountLabel = self:Create ("CACLabel"):SetFont (CAC.Font ("Roboto", 18))
	
	self.FileCountLabel          :SetContentAlignment (6)
	self.FunctionCountLabel      :SetContentAlignment (6)
	self.UniqueFunctionCountLabel:SetContentAlignment (6)
	
	self.Form:AddGridRow (self:Create ("CACLabel"):SetFont (CAC.Font ("Roboto", 18)):SetText ("Files:"           ), self.FileCountLabel          )
	self.Form:AddGridRow (self:Create ("CACLabel"):SetFont (CAC.Font ("Roboto", 18)):SetText ("Functions:"       ), self.FunctionCountLabel      )
	self.Form:AddGridRow (self:Create ("CACLabel"):SetFont (CAC.Font ("Roboto", 18)):SetText ("Unique functions:"), self.UniqueFunctionCountLabel)
	
	self.Form:AddHeader ("Updates")
	
	-- Next startup update
	self.Form:AddGridLayout (4, 16)
		:SetColumnSpacing (4)
		:SetColumnWidth (1, 16)
		:SetColumnWidthFraction (2, 0.65)
		:SetColumnWidth (3, 96)
	
	self.NextUpdateImage = self:Create ("GImage")
	self.NextUpdateImage:SetHeight (24)
	
	self.NextUpdateLabel = self:Create ("CACLabel")
	self.NextUpdateLabel:SetHeight (24)
	self.NextUpdateLabel:SetFont (CAC.Font ("Roboto", 18))
	
	self.NextUpdateButton = self:Create ("CACButton")
	self.NextUpdateButton:SetHeight (24)
	self.NextUpdateButton:SetFont (CAC.Font ("Roboto", 16))
	self.NextUpdateButton:AddEventListener ("Click",
		function (_)
			if not self.LuaWhitelistSettings then return end
			
			self.LuaWhitelistSettings:DispatchEvent ("SetUpdateWhitelistNextStartup", not self.LuaWhitelistSettings:ShouldUpdateWhitelistNextStartup ())
		end
	)
	
	self.Form:AddGridRow (self.NextUpdateImage, self.NextUpdateLabel, self.NextUpdateButton)
	
	self.Form:AddHorizontalLine (16)
	
	-- Last update information
	self.LastUpdateTimeLabel     = self.Form:AddIndentedControl (self:Create ("CACLabel")):SetFont (CAC.Font ("Roboto", 18))
	self.LastUpdateDurationLabel = self.Form:AddIndentedControl (self:Create ("CACLabel")):SetFont (CAC.Font ("Roboto", 18))
	self.LastLiveUpdateTimeLabel = self.Form:AddIndentedControl (self:Create ("CACLabel")):SetFont (CAC.Font ("Roboto", 18))
	
	self.Form:AddHorizontalLine (16)
	
	-- Update trigger
	self.Form:AddGridLayout (1, 16)
	
	self.Form:AddGridRow (
		self:Create ("CACLabel")
			:SetFont (CAC.Font ("Roboto", 18))
			:SetText ("Update lua whitelist on map change:")
	)
	
	self.Form:AddGridLayout (1, 24)
	
	self.LuaWhitelistUpdateTriggerRadioButtons = {}
	for i = 0, #CAC.LuaWhitelistUpdateTrigger do
		local radioButton = self:Create ("CACRadioButton")
		self.LuaWhitelistUpdateTriggerRadioButtons [i] = radioButton
		
		radioButton:SetFont (CAC.Font ("Roboto", 18))
		radioButton:SetText (CAC.LuaWhitelistUpdateTrigger [i])
		radioButton:AddEventListener ("SelectedChanged",
			function (_, selected)
				if not selected then return end
				if not self.LuaWhitelistSettings then return end
				
				self.LuaWhitelistSettings:DispatchEvent ("SetWhitelistUpdateTrigger", i)
			end
		)
		
		self.Form:AddGridRow (radioButton)
	end
end

function self:Paint (w, h)
end

function self:PerformLayout (w, h)
	self.Form:SetPos (0, 0)
	self.Form:SetSize (w, h)
end

function self:Think ()
	self:UpdateLastUpdateTimeLabels ()
end

function self:OnRemoved ()
	self:SetLuaWhitelistSettings (nil)
end

function self:GetLuaWhitelistSettings ()
	return self.LuaWhitelistSettings
end

function self:GetLuaWhitelistStatus ()
	return self.LuaWhitelistStatus
end

function self:SetLuaWhitelistSettings (luaWhitelistSettings)
	if self.LuaWhitelistSettings == luaWhitelistSettings then return self end
	
	self.Form:SetTargetObject (luaWhitelistSettings)
	
	self:UnhookLuaWhitelistSettings (self.LuaWhitelistSettings)
	self.LuaWhitelistSettings = luaWhitelistSettings
	self:HookLuaWhitelistSettings (self.LuaWhitelistSettings)
	
	self:SetLuaWhitelistStatus (self.LuaWhitelistSettings and self.LuaWhitelistSettings:DispatchEvent ("GetLuaWhitelistStatus"))
	
	if self.LuaWhitelistSettings then
		self:UpdateNextStartupUpdateControls ()
		self:UpdateWhitelistUpdateTriggerRadioButtons ()
	end
	
	self:DispatchEvent ("LuaWhitelistSettingsChanged", self.LuaWhitelistSettings)
	
	return self
end

function self:SetLuaWhitelistStatus (luaWhitelistStatus)
	if self.LuaWhitelistStatus == luaWhitelistStatus then return self end
	
	self:UnhookLuaWhitelistStatus (self.LuaWhitelistStatus)
	self.LuaWhitelistStatus = luaWhitelistStatus
	self:HookLuaWhitelistStatus (self.LuaWhitelistStatus)
	
	if self.LuaWhitelistStatus then
		self:UpdateLastUpdateTimeLabels ()
		self:UpdateLastUpdateDurationLabel ()
		self:UpdateWhitelistCountLabels ()
	end
	
	self:DispatchEvent ("LuaWhitelistStatusChanged", self.LuaWhitelistStatus)
	
	return self
end

-- Internal, do not call
function self:UpdateWhitelistUpdateTriggerRadioButtons ()
	local radioButton = self.LuaWhitelistUpdateTriggerRadioButtons [self.LuaWhitelistSettings:GetWhitelistUpdateTrigger ()]
	
	if radioButton then
		radioButton:SetSelected (true)
	else
		for i = 0, #self.LuaWhitelistUpdateTriggerRadioButtons do
			self.LuaWhitelistUpdateTriggerRadioButtons:SetSelected (false)
		end
	end
end

function self:UpdateLastUpdateTimeLabels ()
	self.LastUpdateTimeLabel:SetText ("The last update was " .. CAC.FormatTimestampRelative (self.LuaWhitelistStatus:GetLastUpdateTime ()) .. " (" .. CAC.FormatTimestamp (self.LuaWhitelistStatus:GetLastUpdateTime ()) .. ").")
	
	if self.LuaWhitelistStatus:IsUpdateNeeded () then
		self.LastLiveUpdateTimeLabel:SetText ("The last live update was " .. CAC.FormatTimestampRelative (self.LuaWhitelistStatus:GetLastLiveUpdateTime ()) .. " (" .. CAC.FormatTimestamp (self.LuaWhitelistStatus:GetLastLiveUpdateTime ()) .. ").")
	else
		self.LastLiveUpdateTimeLabel:SetText ("No live updates have occurred this map.")
	end
end

function self:UpdateLastUpdateDurationLabel ()
	self.LastUpdateDurationLabel:SetText ("The last update took " .. CAC.FormatBanDuration (self.LuaWhitelistStatus:GetLastUpdateDuration ()) .. ".")
end

local function FormatNumber (n)
	local str = tostring (n)
	str = string.reverse (str)
	str = string.gsub (str, "[0-9][0-9][0-9]", "%1,")
	str = string.reverse (str)
	return str
end

function self:UpdateWhitelistCountLabels ()
	self.FileCountLabel          :SetText (FormatNumber (self.LuaWhitelistStatus:GetFileCount               ()))
	self.FunctionCountLabel      :SetText (FormatNumber (self.LuaWhitelistStatus:GetFunctionCount           ()))
	self.UniqueFunctionCountLabel:SetText (FormatNumber (self.LuaWhitelistStatus:GetUniqueFunctionHashCount ()))
end

function self:UpdateNextStartupUpdateControls ()
	local updateWhitelistNextStartup = self.LuaWhitelistSettings:ShouldUpdateWhitelistNextStartup ()
	local whitelistUpdateNeeded      = self.LuaWhitelistStatus:IsUpdateNeeded ()
	
	updateWhitelistNextStartup = updateWhitelistNextStartup or self.LuaWhitelistSettings:GetWhitelistUpdateTrigger () == CAC.LuaWhitelistUpdateTrigger.Always
	
	self.NextUpdateButton:SetVisible (self.LuaWhitelistSettings:GetWhitelistUpdateTrigger () ~= CAC.LuaWhitelistUpdateTrigger.Always)
	
	local image         = "icon16/information.png"
	local infoText      = nil
	local infoTextColor = whitelistUpdateNeeded and CAC.Colors.Red or CAC.Colors.Green
	local buttonText    = nil
	
	if updateWhitelistNextStartup then
		buttonText = "Cancel"
		
		if whitelistUpdateNeeded then
			infoText      = "The lua whitelist is outdated and will be updated on the next map change."
		else
			infoText      = "The lua whitelist is up to date and will be updated on the next map change."
		end
	else
		if whitelistUpdateNeeded then
			image         = "icon16/error.png"
			infoText      = "The lua whitelist is outdated."
			buttonText    = "Update"
		else
			infoText      = "The lua whitelist is up to date."
			buttonText    = "Force Update"
		end
	end
	
	self.NextUpdateImage :SetImage (image)
	self.NextUpdateLabel :SetText (infoText)
	self.NextUpdateLabel :SetTextColor (infoTextColor)
	self.NextUpdateButton:SetText (buttonText)
end

function self:HookLuaWhitelistSettings (luaWhitelistSettings)
	if not luaWhitelistSettings then return end
	
	self:DispatchEvent ("HookLuaWhitelistSettings", luaWhitelistSettings)
	
	luaWhitelistSettings:AddEventListener ("WhitelistUpdateTriggerChanged", "CAC.LuaWhitelistSettingsView." .. self:GetHashCode (),
		function (_)
			self:UpdateNextStartupUpdateControls ()
			self:UpdateWhitelistUpdateTriggerRadioButtons ()
		end
	)
	
	luaWhitelistSettings:AddEventListener ("UpdateWhitelistNextStartupChanged", "CAC.LuaWhitelistSettingsView." .. self:GetHashCode (),
		function (_)
			self:UpdateNextStartupUpdateControls ()
		end
	)
end

function self:UnhookLuaWhitelistSettings (luaWhitelistSettings)
	if not luaWhitelistSettings then return end
	
	self:DispatchEvent ("UnhookLuaWhitelistSettings", luaWhitelistSettings)
	
	luaWhitelistSettings:RemoveEventListener ("WhitelistUpdateTriggerChanged",     "CAC.LuaWhitelistSettingsView." .. self:GetHashCode ())
	luaWhitelistSettings:RemoveEventListener ("UpdateWhitelistNextStartupChanged", "CAC.LuaWhitelistSettingsView." .. self:GetHashCode ())
end

local luaWhitelistStatusEvents =
{
	LastUpdateTimeChanged          = self.UpdateLastUpdateTimeLabels,
	LastUpdateDurationChanged      = self.UpdateLastUpdateDurationLabel,
	LastLiveUpdateTimeChanged      = function (self)
		self:UpdateLastUpdateTimeLabels ()
		self:UpdateNextStartupUpdateControls ()
	end,
	FileCountChanged               = self.UpdateWhitelistCountLabels,
	FunctionCountChanged           = self.UpdateWhitelistCountLabels,
	UniqueFunctionHashCountChanged = self.UpdateWhitelistCountLabels,
}

function self:HookLuaWhitelistStatus (luaWhitelistStatus)
	if not luaWhitelistStatus then return end
	
	self:DispatchEvent ("HookLuaWhitelistStatus", luaWhitelistStatus)
	
	for eventName, handler in pairs (luaWhitelistStatusEvents) do
		luaWhitelistStatus:AddEventListener (eventName, "CAC.LuaWhitelistSettingsView." .. self:GetHashCode (),
			function (_, ...)
				handler (self, ...)
			end
		)
	end
end

function self:UnhookLuaWhitelistStatus (luaWhitelistStatus)
	if not luaWhitelistStatus then return end
	
	self:DispatchEvent ("UnhookLuaWhitelistStatus", luaWhitelistStatus)
	
	for eventName, _ in pairs (luaWhitelistStatusEvents) do
		luaWhitelistStatus:RemoveEventListener (eventName, "CAC.LuaWhitelistSettingsView." .. self:GetHashCode ())
	end
end

CAC.Register ("CACLuaWhitelistSettingsView", self, "CACPanel")