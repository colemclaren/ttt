local self = {}

function self:Init ()
	self.HoverInterpolationFilter = CAC.ExponentialDecayResponseFilter (10)
	
	-- Content
	self.Avatar                = self:Create ("AvatarImage")
	
	-- Player data
	self.Player                = nil
	
	self.PlayerInformation     = nil
	self.PlayerSession         = nil
	self.LivePlayerSession     = nil
	
	self.PlayerName            = nil
	self.PlayerNameColorFilter = CAC.ExponentialDecayResponseFilter (5)
	
	-- Checks
	self.Checks                = {}
	self.ChecksById            = {}
	
	-- Detections
	self.DetectionList         = self:Create ("CACDetectionList")
	
	self:PerformLayout (self:GetSize ())
	
	self:AddEventListener ("ListBoxItemChanged",
		function (_, lastListBoxItem, listBoxItem)
			if not listBoxItem then return end
			
			listBoxItem:SetHeight (56)
		end
	)
end

local backgroundColor
function self:Paint (w, h)
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
		-- if self.PlayerSession and
		--    self.PlayerSession:GetDetectionEnumerator () () then
		-- 	baseBackgroundColor = CAC.Colors.Orange
		-- end
		backgroundColor = CAC.Color.Lerp (1 - self.HoverInterpolationFilter:Evaluate (), CAC.Colors.LightSteelBlue, baseBackgroundColor, backgroundColor)
		surface.SetDrawColor (backgroundColor)
		surface.DrawRect (0, 0, w, h)
	end
	
	-- Update player data
	self:UpdatePlayerData ()
	
	-- Text
	if self.PlayerName then
		surface.SetFont (CAC.Font ("Roboto", 20))
		
		local textColor = CAC.Colors.Orange
		local k = self.PlayerNameColorFilter:Evaluate ()
		surface.SetTextPos (self.Avatar:GetWide () + 8, 0)
		
		CAC.DrawHighlightedText (self.PlayerName, self.ListBox:GetSearchFilter (), textColor.r * k, textColor.g * k, textColor.b * k, textColor.a)
	end
	
	-- Countdown
	local liveIncident = self.LivePlayerSession and self.LivePlayerSession:GetLiveIncident ()
	local incident     = liveIncident and liveIncident:GetIncident ()
	
	local text         = nil
	local textColor    = nil
	
	if liveIncident then
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
	
	-- Checks
	local x = 0.65 * w
	local y = 2
	for i = 1, #self.Checks do
		self.Checks [i]:SetPos (x, y)
		self.Checks [i]:SetWidth (w - x)
		y = y + self.Checks [i]:GetHeight ()
	end
end

function self:Think ()
	local i = 1
	while i <= #self.Checks do
		if self.Checks [i]:ShouldRemove () then
			self.ChecksById [self.Checks [i]:GetCheck ():GetId ()] = nil
			self.Checks [i]:Remove ()
			table.remove (self.Checks, i)
			
			self:InvalidateLayout ()
		else
			i = i + 1
		end
	end
end

-- Player
function self:GetPlayer ()
	return self.Player
end

function self:GetPlayerInformation ()
	return self.PlayerInformation
end

function self:GetPlayerSession ()
	return self.PlayerSession
end

function self:GetLivePlayerSession ()
	return self.LivePlayerSession
end

function self:SetPlayer (ply)
	if self.Player == ply then return self end
	
	self.Player = ply
	self.Avatar:SetPlayer (self.Player, 48)
	
	self:UpdatePlayerData ()
	
	return self
end

function self:SetPlayerInformation (playerInformation)
	if self.PlayerInformation == playerInformation then return self end
	
	self.PlayerInformation = playerInformation
	
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

function self:SetLivePlayerSession (livePlayerSession)
	if self.LivePlayerSession == livePlayerSession then return self end
	
	self:UnhookLivePlayerSession (self.LivePlayerSession)
	self:ClearCheckItems ()
	
	self.LivePlayerSession = livePlayerSession
	
	if self.LivePlayerSession then
		self:HookLivePlayerSession (self.LivePlayerSession)
		for check in self.LivePlayerSession:GetCheckEnumerator () do
			if check:IsStarted () and not check:IsFinished () then
				self:CreateCheckItem (check)
			end
		end
	end
	
	return self
end

function self:UpdatePlayerData ()
	if self.Player and self.Player:IsValid () then
		if self.PlayerName ~= self.Player:Name () then
			if self.PlayerName then
				self.PlayerNameColorFilter:Impulse (SysTime () + 1)
			end
			self.PlayerName = self.Player:Name ()
		end
	end
end

-- Item filtering
function self:PassesSearchFilter (searchFilter)
	return CAC.UTF8.MatchTransliteration (self.Player:Name (), searchFilter)
end

-- Internal, do not call
function self:OnRemoved ()
	self:SetPlayerInformation (nil)
	self:SetPlayerSession     (nil)
	self:SetLivePlayerSession (nil)
end

function self:ClearCheckItems ()
	if #self.Checks == 0 then return end
	
	for i = 1, #self.Checks do
		self.Checks [i]:Remove ()
	end
	
	self.Checks     = {}
	self.ChecksById = {}
end

function self:CreateCheckItem (check)
	local checkId = check:GetId ()
	if self.ChecksById [checkId] then
		return self.ChecksById [checkId]
	end
	
	local checkItem = self:Create ("CACCheckItem")
	checkItem:SetCheck (check)
	
	self.Checks [#self.Checks + 1] = checkItem
	self.ChecksById [checkId] = checkItem
	
	self:InvalidateLayout ()
	
	return checkItem
end

function self:HookPlayerSession (playerSession)
	if not playerSession then return end
end

function self:UnhookPlayerSession (playerSession)
	if not playerSession then return end
end

function self:HookLivePlayerSession (livePlayerSession)
	if not livePlayerSession then return end
	
	livePlayerSession:AddEventListener ("CheckStarted", "CAC.PlayerListBoxItem." .. self:GetHashCode (),
		function (_, check)
			self:CreateCheckItem (check)
		end
	)
end

function self:UnhookLivePlayerSession (livePlayerSession)
	if not livePlayerSession then return end
	
	livePlayerSession:RemoveEventListener ("CheckStarted", "CAC.PlayerListBoxItem." .. self:GetHashCode ())
end

CAC.Register ("CACPlayerListBoxItem", self, "GListBoxItem")