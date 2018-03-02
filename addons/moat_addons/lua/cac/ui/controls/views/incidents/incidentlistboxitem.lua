local self = {}

function self:Init ()
	self.HoverInterpolationFilter = CAC.ExponentialDecayResponseFilter (10)
	
	-- Content
	self.Avatar                = self:Create ("CACUserAvatar")
	
	-- Player session
	self.PlayerSession         = nil
	
	-- Incident
	self.LiveIncident          = nil
	self.Incident              = nil
	
	-- Player data
	self.PlayerName            = nil
	self.PlayerNameColorFilter = CAC.ExponentialDecayResponseFilter (5)
	
	-- Detections
	self.DetectionList         = self:Create ("CACDetectionList")
	
	self:AddEventListener ("ListBoxItemChanged",
		function (_, lastListBoxItem, listBoxItem)
			if not listBoxItem then return end
			
			listBoxItem:SetHeight (56)
		end
	)
end

local backgroundColor
function self:Paint (w, h)
	if self.Incident then
		self:SetPlayerSession (self.Incident:GetPlayerSession ())
	end
	if self.LiveIncident then
		self.LiveIncident:SetReviewedByLocalAdmin (true)
	end
	
	if self:IsHoveredRecursive () then
		self.HoverInterpolationFilter:Impulse ()
	end
	
	-- Background
	if self:IsSelected () then
		local col = self:GetSkin ().combobox_selected
		surface.SetDrawColor (col)
		surface.DrawRect (0, 0, w, h)
	else
		local baseBackgroundColor = CAC.Colors.Gainsboro
		
		if self.Incident then
			if self.Incident:GetResponse () == CAC.DetectionResponse.Kick then
				baseBackgroundColor = CAC.Colors.Wheat
			elseif self.Incident:GetResponse () == CAC.DetectionResponse.Ban then
				baseBackgroundColor = CAC.Colors.DarkSalmon
			end
		end
		
		backgroundColor = CAC.Color.Lerp (1 - self.HoverInterpolationFilter:Evaluate (), CAC.Colors.LightSteelBlue, baseBackgroundColor, backgroundColor)
		surface.SetDrawColor (backgroundColor)
		surface.DrawRect (0, 0, w, h)
	end
	
	-- Update player data
	self:UpdatePlayerData ()
	
	-- Player name
	if self.PlayerName then
		surface.SetFont (CAC.Font ("Roboto", 20))
		
		local textColor = CAC.Colors.Orange
		local k = self.PlayerNameColorFilter:Evaluate ()
		surface.SetTextPos (self.Avatar:GetWide () + 8, 0)
		
		CAC.DrawHighlightedText (self.PlayerName, self.ListBox:GetSearchFilter (), textColor.r * k, textColor.g * k, textColor.b * k, textColor.a)
	end
	
	-- Countdown
	local liveIncident = self.LiveIncident
	local incident     = self.Incident
	
	local text         = nil
	local textColor    = nil
	
	if liveIncident and
	   not incident:GetResponseExecuted () then
		local responseCountdown = liveIncident:GetResponseCountdown ()
		if responseCountdown:IsRunning () and
		   SysTime () % 1 < 0.75 then
			local timeRemaining = responseCountdown:GetTimeRemaining ()
			timeRemaining = CAC.FormatTimeRemaining (timeRemaining)
			
			textColor = CAC.Colors.Red
			text = incident:GetResponse () == CAC.DetectionResponse.Kick and "Kick" or "Ban"
			text = text .. " in " .. timeRemaining
		end
	end
	
	if incident then
	   if incident:GetResponseExecuted () then
			textColor = CAC.Colors.Firebrick
			
			local response = incident:GetResponse ()
			if response == CAC.DetectionResponse.Kick then
				text = "Kicked"
			elseif response == CAC.DetectionResponse.Ban then
				text = "Banned"
			end
		elseif incident:GetResponseSuppressed () then
			textColor = CAC.Colors.Firebrick
			text = incident:GetResponse () == CAC.DetectionResponse.Kick and "Kick" or "Ban"
			text = text .. " aborted"
		end
	end
	
	if text then
		surface.SetFont (CAC.Font ("Roboto", 28))
		surface.SetTextColor (textColor)
		local textWidth, textHeight = surface.GetTextSize (text)
		surface.SetTextPos (0.5 * w - 0.5 * textWidth, 0.5 * (h - textHeight) - 4)
		surface.DrawText (text)
	end
	
	-- Timestamp
	if self.Incident then
		local timestamp = self.Incident:GetTimestamp ()
		
		surface.SetFont (CAC.Font ("Roboto", 16))
		surface.SetTextColor (CAC.Colors.Black)
		
		local y = 0
		local text = CAC.FormatTimestampRelative (timestamp)
		local textWidth, textHeight = surface.GetTextSize (text)
		surface.SetTextPos (w - 4 - textWidth, y)
		surface.DrawText (text)
		y = y + textHeight
		
		text = CAC.FormatDate (timestamp)
		textWidth, textHeight = surface.GetTextSize (text)
		surface.SetTextPos (w - 4 - textWidth, y)
		surface.DrawText (text)
		y = y + textHeight
		
		text = CAC.FormatTime (timestamp)
		textWidth, textHeight = surface.GetTextSize (text)
		surface.SetTextPos (w - 4 - textWidth, y)
		surface.DrawText (text)
		y = y + textHeight
	end
end

function self:PerformLayout (w, h)
	self.TextLabel:SetVisible (false)
	
	self.Avatar:SetPos (4, 4)
	self.Avatar:SetSize (48, 48)
	
	-- Detections
	local x = self.Avatar:GetWide () + 8
	local y = 20
	self.DetectionList:SetPos (x, y)
	self.DetectionList:SetSize (w * 0.5, h - y)
end

function self:OnRemoved ()
	self:SetIncident (nil)
	self:SetLiveIncident (nil)
	self:SetPlayerSession (nil)
end

-- Data
function self:GetIncident ()
	return self.Incident
end

function self:GetLiveIncident ()
	return self.LiveIncident
end

function self:GetPlayerSession ()
	return self.PlayerSession
end

function self:SetIncident (incident)
	if self.Incident == incident then return self end
	
	self:UnhookIncident (self.Incident)
	self:UnhookLiveIncident (self.LiveIncident)
	
	self.LiveIncident = nil
	self.Incident     = incident
	
	if self.Incident then
		self.LiveIncident = CAC.Incidents:GetLiveIncident (self.Incident:GetId ())
	end
	
	self:UpdatePlayerData (false)
	
	self:HookIncident (self.Incident)
	self:HookLiveIncident (self.LiveIncident)
	
	if self.Incident then
		self:SetPlayerSession (self.Incident:GetPlayerSession ())
		self.Avatar:SetSteamId (self.Incident:GetPlayerSteamId ())
	end
	
	return self
end

function self:SetLiveIncident (liveIncident)
	if self.LiveIncident == liveIncident then return self end
	
	self:UnhookIncident (self.Incident)
	self:UnhookLiveIncident (self.LiveIncident)
	
	self.LiveIncident = liveIncident
	self.Incident     = self.LiveIncident:GetIncident ()
	
	self:UpdatePlayerData (false)
	
	self:HookIncident (self.Incident)
	self:HookLiveIncident (self.LiveIncident)
	
	if self.Incident then
		self:SetPlayerSession (self.Incident:GetPlayerSession ())
		self.Avatar:SetSteamId (self.Incident:GetPlayerSteamId ())
	end
	
	return self
end

function self:SetPlayerSession (playerSession)
	if self.PlayerSession == playerSession then return self end
	
	self:UnhookPlayerSession (self.PlayerSession)
	
	self.PlayerSession = playerSession
	self.DetectionList:SetPlayerSession (self.PlayerSession)
	
	self:HookPlayerSession (self.PlayerSession)
	
	return self
end

function self:UpdatePlayerData (flashName)
	if flashName == nil then flashName = true end
	
	if not self.Incident then return end
	
	local playerName = self.Incident:GetPlayerName ()
	
	if self.Incident:GetPlayerSession () then
		playerName = self.Incident:GetPlayerSession ():GetAccountInformation ():GetDisplayName ()
	end
	
	if self.PlayerName ~= playerName then
		if self.PlayerName and flashName then
			self.PlayerNameColorFilter:Impulse (SysTime () + 1)
		end
		self.PlayerName = playerName
	end
end

-- Item filtering
function self:PassesSearchFilter (searchFilter)
	if not self:GetIncident () then return true end
	
	if string.find (self:GetIncident ():GetQualifiedIncidentId (), searchFilter, 1, true) then return true end
	return CAC.UTF8.MatchTransliteration (self.PlayerName or "", searchFilter)
end

-- Internal, do not call
function self:HookPlayerSession (playerSession)
	if not playerSession then return end
end

function self:UnhookPlayerSession (playerSession)
	if not playerSession then return end
end

function self:HookIncident (incident)
	if not incident then return end
	
	incident:AddEventListener ("PlayerSteamIdChanged", "CAC.IncidentListBoxItem." .. self:GetHashCode (),
		function (_, steamId)
			self.Avatar:SetSteamId (steamId)
		end
	)
	
	incident:AddEventListener ("TimestampChanged", "CAC.IncidentListBoxItem." .. self:GetHashCode (),
		function (_)
			self:GetListBox ():Sort ()
		end
	)
end

function self:UnhookIncident (incident)
	if not incident then return end
	
	incident:RemoveEventListener ("PlayerSteamIdChanged", "CAC.IncidentListBoxItem." .. self:GetHashCode ())
	incident:RemoveEventListener ("TimestampChanged",     "CAC.IncidentListBoxItem." .. self:GetHashCode ())
end

function self:HookLiveIncident (liveIncident)
	if not liveIncident then return end
	
	liveIncident:AddEventListener ("PlayerChanged", "CAC.IncidentListBoxItem." .. self:GetHashCode (),
		function (_, ply)
			if ply and ply:IsValid () then
				self.Avatar:SetPlayer (ply, 48)
			end
		end
	)
end

function self:UnhookLiveIncident (liveIncident)
	if not liveIncident then return end
	
	liveIncident:RemoveEventListener ("PlayerChanged", "CAC.IncidentListBoxItem." .. self:GetHashCode ())
end

CAC.Register ("CACIncidentListBoxItem", self, "GListBoxItem")