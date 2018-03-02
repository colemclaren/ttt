local self = {}

function self:Init ()
	self.UserWhitelistSettings = nil
	self.UserWhitelist         = nil
	self.UserBlacklist         = nil
	self.UserBlacklistStatus   = nil
	
	self.Form = self:Create ("CACSettingsForm")
	
	self.Form:AddHeader ("Whitelist")
	self.Form:AddGridLayout (1, 16)
	
	self.InputContainer = self:Create ("CACPanel")
	self.InputContainer:SetHeight (24)
	self.InputContainer:SetBackgroundColor (Color (0, 0, 0, 0))
	self.InputContainer.PerformLayout = function (_, w, h)
		self.UserWhitelistAddButton:SetSize (24, 24)
		self.UserWhitelistAddButton:SetPos (w - 24, 0)
		
		local x = w * 0.5 - 8
		self.UserWhitelistComboBox:SetPos (x, 0)
		self.UserWhitelistComboBox:SetSize (w - 24 - 6 - x, h)
		
		self.UserWhitelistUserEntry:SetPos (0, 0)
		self.UserWhitelistUserEntry:SetSize (x - 6, h)
	end
	
	self.UserWhitelistUserEntry = self:Create ("CACUserEntry",   self.InputContainer)
	self.UserWhitelistComboBox  = self:Create ("CACComboBox",    self.InputContainer)
	self.UserWhitelistAddButton = self:Create ("CACImageButton", self.InputContainer)
	
	self.UserWhitelistUserEntry:AddEventListener ("ActorReferenceChanged",
		function (_, actorReference)
			self.UserWhitelistAddButton:SetEnabled (actorReference ~= nil)
		end
	)
	self.UserWhitelistComboBox:SetFont (CAC.Font ("Roboto", 18))
	self.UserWhitelistComboBox:SetTextColor (CAC.Colors.Black)
	self.UserWhitelistComboBox:AddItem ("Suppress response",   CAC.WhitelistStatus.SuppressResponse  )
	self.UserWhitelistComboBox:AddItem ("Suppress detections", CAC.WhitelistStatus.SuppressDetections)
	self.UserWhitelistComboBox:AddItem ("Suppress checks",     CAC.WhitelistStatus.SuppressChecks    )
	
	self.UserWhitelistAddButton:SetIcon ("icon16/add.png")
	self.UserWhitelistAddButton:SetToolTipText ("Add entry")
	self.UserWhitelistAddButton:SetEnabled (false)
	self.UserWhitelistAddButton:AddEventListener ("Click",
		function (_)
			if not self.UserWhitelist then return end
			if not self.UserWhitelistUserEntry:GetActorReference () then return end
			
			local actorReference  = self.UserWhitelistUserEntry:GetActorReference ()
			local whitelistStatus = self.UserWhitelistComboBox:GetSelectedItem ():GetId ()
			local whitelistEntry  = CAC.WhitelistEntry (actorReference, whitelistStatus)
			
			self.UserWhitelist:DispatchEvent ("AddEntry", whitelistEntry)
			
			self.UserWhitelistUserEntry:SetText ("")
		end
	)
	
	self.UserWhitelistListBox = self:Create ("CACUserWhitelistListBox")
		:SetHeight (256)
	
	self.Form:AddGridRow (self.InputContainer)
	
	self.Form:AddGridRow (self.UserWhitelistListBox)
	
	self.Form:AddHeader ("Blacklist")
	
	-- Update information
	self.BlacklistVersionLabel             = self:Create ("CACLabel"):SetFont (CAC.Font ("Roboto", 18))
	self.BlacklistLastUpdateTimeLabel      = self:Create ("CACLabel"):SetFont (CAC.Font ("Roboto", 18))
	self.BlacklistLastUpdateCheckTimeLabel = self:Create ("CACLabel"):SetFont (CAC.Font ("Roboto", 18))
	
	self.UserBlacklistCheckbox = self:Create ("CACCheckbox")
		:SetHeight (18)
		:SetFont (CAC.Font ("Roboto", 18))
		:SetText ("Use user blacklist")
	self.UserBlacklistCheckbox:AddEventListener ("CheckStateChanged",
		function (_, checked)
			if not self.UserWhitelistSettings then return end
			
			self.UserWhitelistSettings:DispatchEvent ("SetBlacklistEnabled", checked)
		end
	)
	
	self.UserTrackingCheckboxContainer = self:Create ("GContainer")
	self.UserTrackingCheckboxContainer:SetHeight (76)
	self.UserTrackingCheckboxContainer.PerformLayout = function (_, w, h)
		self.UserTrackingCheckbox   :SetWidth (w)
		self.UserTrackingDescription:SetPos (20, self.UserTrackingCheckbox:GetHeight ())
		self.UserTrackingDescription:SetSize (w - 20, h - self.UserTrackingCheckbox:GetHeight ())
	end
	
	self.UserTrackingCheckbox = self:Create ("CACCheckbox", self.UserTrackingCheckboxContainer)
		:SetHeight (18)
		:SetFont (CAC.Font ("Roboto", 18))
		:SetText ("Track server file stealers")
	self.UserTrackingCheckbox:AddEventListener ("CheckStateChanged",
		function (_, checked)
			if not self.UserWhitelistSettings then return end
			
			self.UserTrackingDescription:SetTextColor (checked and CAC.Colors.Black or CAC.Colors.LightGray)
			
			self.UserWhitelistSettings:DispatchEvent ("SetUserTrackingEnabled", checked)
		end
	)
	self.UserTrackingDescription = self:Create ("CACLabel", self.UserTrackingCheckboxContainer)
	self.UserTrackingDescription:SetContentAlignment (7)
	self.UserTrackingDescription:SetWrap (true)
	self.UserTrackingDescription:SetFont (CAC.Font ("Roboto", 14))
		:SetText ("Your player list will be reported to a web server.\nEach report entry contains a Steam ID and a display name.\nIf a server file leak affects you, your player list will be compared against those of the other servers in the leak\nto determine which user is responsible.")
	
	self.UserBlacklistDescription1 = self:Create ("CACLabel")
		:SetHeight (36)
		:SetFont (CAC.Font ("Roboto", 18))
		:SetText ("This blacklist will be used for users who steal server files and post them publicly online.\nThis blacklist will NOT be used for cheaters - that is what the rest of the anticheat detection systems are for.")
	
	self.UserBlacklistDescription2 = self:Create ("CACLabel")
	self.UserBlacklistDescription2:SetWrap (true)
	self.UserBlacklistDescription2:SetHeight (28)
		:SetTextColor (CAC.Colors.Firebrick)
		:SetFont (CAC.Font ("Roboto", 14))
		:SetText ("If a user wishes to be removed from the list, they should send an email to cakenotfound@googlemail.com.\nAll polite, well-written requests will be granted.")
	
	self.UserBlacklistListBox = self:Create ("CACUserBlacklistListBox")
		:SetHeight (256)
	self.UserBlacklistListBox.ScrollableViewController:AddEventListener ("ContentHeightChanged",
		function (_, contentHeight)
			contentHeight = math.max (contentHeight, 256)
			self.UserBlacklistListBox:SetHeight (contentHeight)
		end
	)
	
	self.Form:AddIndentedControl (self.UserBlacklistCheckbox            , 16)
	self.Form:AddIndentedControl (self.UserTrackingCheckboxContainer    , 16)
	self.Form:AddHorizontalLine (16)
	self.Form:AddIndentedControl (self.UserBlacklistDescription1        , 16)
	self.Form:AddIndentedControl (self.UserBlacklistDescription2        , 16)
	self.Form:AddHorizontalLine (16)
	self.Form:AddIndentedControl (self.BlacklistVersionLabel            , 16)
	self.Form:AddIndentedControl (self.BlacklistLastUpdateTimeLabel     , 16)
	self.Form:AddIndentedControl (self.BlacklistLastUpdateCheckTimeLabel, 16)
	
	self.Form:AddGridLayout (1, 16)
	self.Form:AddGridRow (self.UserBlacklistListBox)
end

function self:Paint (w, h)
end

function self:PerformLayout (w, h)
	self.Form:SetPos (0, 0)
	self.Form:SetSize (w, h)
end

function self:Think ()
	self:UpdateBlacklistStatusLabels ()
end

function self:OnRemoved ()
	self:SetUserWhitelistSettings (nil)
end

function self:GetUserWhitelistSettings ()
	return self.UserWhitelistSettings
end

function self:GetUserWhitelist ()
	return self.UserWhitelist
end

function self:GetUserBlacklist ()
	return self.UserBlacklist
end

function self:GetUserBlacklistStatus ()
	return self.UserBlacklistStatus
end

function self:SetUserWhitelistSettings (userWhitelistSettings)
	if self.UserWhitelistSettings == userWhitelistSettings then return self end
	
	self.Form:SetTargetObject (userWhitelistSettings)
	
	self:UnhookUserWhitelistSettings (self.UserWhitelistSettings)
	self.UserWhitelistSettings = userWhitelistSettings
	self:HookUserWhitelistSettings (self.UserWhitelistSettings)
	
	self:SetUserWhitelist (self.UserWhitelistSettings and self.UserWhitelistSettings:GetUserWhitelist ())
	self:SetUserBlacklist (self.UserWhitelistSettings and self.UserWhitelistSettings:GetUserBlacklist ())
	self:SetUserBlacklistStatus (self.UserWhitelistSettings and self.UserWhitelistSettings:DispatchEvent ("GetUserBlacklistStatus"))
	
	if self.UserWhitelistSettings then
		self.UserWhitelistSettings:DispatchEvent ("RequestUserBlacklist")
		
		self:Update ()
	end
	
	self:DispatchEvent ("UserWhitelistSettingsChanged", self.UserWhitelistSettings)
	
	return self
end

function self:SetUserWhitelist (userWhitelist)
	if self.UserWhitelist == userWhitelist then return self end
	
	self:UnhookUserWhitelist (self.UserWhitelist)
	self.UserWhitelist = userWhitelist
	self:HookUserWhitelist (self.UserWhitelist)
	
	self.UserWhitelistListBox:SetUserWhitelist (userWhitelist)
	
	self:DispatchEvent ("UserWhitelistChanged", self.UserWhitelist)
	
	return self
end

function self:SetUserBlacklist (userBlacklist)
	if self.UserBlacklist == userBlacklist then return self end
	
	self:UnhookUserBlacklist (self.UserBlacklist)
	self.UserBlacklist = userBlacklist
	self:HookUserBlacklist (self.UserBlacklist)
	
	self.UserBlacklistListBox:SetUserBlacklist (userBlacklist)
	
	self:DispatchEvent ("UserBlacklistChanged", self.UserBlacklist)
	
	return self
end

function self:SetUserBlacklistStatus (userBlacklistStatus)
	if self.UserBlacklistStatus == userBlacklistStatus then return self end
	
	self:UnhookUserBlacklistStatus (self.UserBlacklistStatus)
	self.UserBlacklistStatus = userBlacklistStatus
	self:HookUserBlacklistStatus (self.UserBlacklistStatus)
	
	if self.UserBlacklistStatus then
		self:UpdateBlacklistStatusLabels ()
	end
	
	self:DispatchEvent ("UserBlacklistStatusChanged", self.UserBlacklistStatus)
	
	return self
end

-- Internal, do not call
function self:Update ()
	self.BlacklistVersionLabel  :SetText ("Blacklist version: " .. self.UserBlacklist:GetVersion ())
	self.UserBlacklistCheckbox  :SetChecked (self.UserWhitelistSettings:IsBlacklistEnabled    ())
	self.UserTrackingCheckbox   :SetChecked (self.UserWhitelistSettings:IsUserTrackingEnabled ())
	self.UserTrackingDescription:SetTextColor (self.UserWhitelistSettings:IsUserTrackingEnabled () and CAC.Colors.Black or CAC.Colors.LightGray)
end

function self:UpdateBlacklistStatusLabels ()
	local blacklistLastUpdateTime = self.UserBlacklistStatus:GetLastUpdateTime ()
	if blacklistLastUpdateTime == 0 then
		self.BlacklistLastUpdateTimeLabel:SetText ("The blacklist has never been updated.")
	else
		self.BlacklistLastUpdateTimeLabel:SetText ("The last blacklist update was " .. CAC.FormatTimestampRelative (blacklistLastUpdateTime) .. " (" .. CAC.FormatTimestamp (blacklistLastUpdateTime) .. ").")
	end
	
	local blacklistLastUpdateCheckTime = self.UserBlacklistStatus:GetLastUpdateCheckTime ()
	if blacklistLastUpdateCheckTime == 0 then
		self.BlacklistLastUpdateCheckTimeLabel:SetText ("The blacklist has never been checked for updates.")
	else
		self.BlacklistLastUpdateCheckTimeLabel:SetText ("The last blacklist update check was " .. CAC.FormatTimestampRelative (blacklistLastUpdateCheckTime) .. " (" .. CAC.FormatTimestamp (blacklistLastUpdateCheckTime) .. ").")
	end
end

function self:HookUserWhitelistSettings (userWhitelistSettings)
	if not userWhitelistSettings then return end
	
	self:DispatchEvent ("HookUserWhitelistSettings", userWhitelistSettings)
	
	userWhitelistSettings:AddEventListener ("BlacklistEnabledChanged", "CAC.UserWhitelistSettingsView." .. self:GetHashCode (),
		function (_)
			self:Update ()
		end
	)
	userWhitelistSettings:AddEventListener ("UserTrackingEnabledChanged", "CAC.UserWhitelistSettingsView." .. self:GetHashCode (),
		function (_)
			self:Update ()
		end
	)
end

function self:UnhookUserWhitelistSettings (userWhitelistSettings)
	if not userWhitelistSettings then return end
	
	self:DispatchEvent ("UnhookUserWhitelistSettings", userWhitelistSettings)
	
	userWhitelistSettings:RemoveEventListener ("BlacklistEnabledChanged",    "CAC.UserWhitelistSettingsView." .. self:GetHashCode ())
	userWhitelistSettings:RemoveEventListener ("UserTrackingEnabledChanged", "CAC.UserWhitelistSettingsView." .. self:GetHashCode ())
end

function self:HookUserWhitelist (userWhitelist)
	if not userWhitelist then return end
	
	self:DispatchEvent ("HookUserWhitelist", userWhitelist)
end

function self:UnhookUserWhitelist (userWhitelist)
	if not userWhitelist then return end
	
	self:DispatchEvent ("UnhookUserWhitelist", userWhitelist)
end

function self:HookUserBlacklist (userBlacklist)
	if not userBlacklist then return end
	
	self:DispatchEvent ("HookUserBlacklist", userBlacklist)
	
	userBlacklist:AddEventListener ("Changed", "CAC.UserWhitelistSettingsView." .. self:GetHashCode (),
		function (_)
			self:Update ()
		end
	)
end

function self:UnhookUserBlacklist (userBlacklist)
	if not userBlacklist then return end
	
	self:DispatchEvent ("UnhookUserBlacklist", userBlacklist)
	
	userBlacklist:RemoveEventListener ("Changed", "CAC.UserWhitelistSettingsView." .. self:GetHashCode ())
end

function self:HookUserBlacklistStatus (userBlacklistStatus)
	if not userBlacklistStatus then return end
	
	self:DispatchEvent ("HookUserBlacklistStatus", userBlacklistStatus)
	
	userBlacklistStatus:AddEventListener ("Changed", "CAC.UserWhitelistSettingsView." .. self:GetHashCode (),
		function (_)
			self:UpdateBlacklistStatusLabels ()
		end
	)
end

function self:UnhookUserBlacklistStatus (userBlacklistStatus)
	if not userBlacklistStatus then return end
	
	self:DispatchEvent ("UnhookUserBlacklistStatus", userBlacklistStatus)
	
	userBlacklistStatus:RemoveEventListener ("Changed", "CAC.UserWhitelistSettingsView." .. self:GetHashCode ())
end

CAC.Register ("CACUserWhitelistSettingsView", self, "CACPanel")