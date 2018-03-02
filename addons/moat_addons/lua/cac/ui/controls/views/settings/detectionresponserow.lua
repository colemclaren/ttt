local self = {}

function self:Init ()
	self.HoverFilter = CAC.ExponentialDecayResponseFilter (10)
	
	self.DetectionResponseSettings = nil
	self.DetectionType             = nil
	
	self:SetHeight (32)
	
	self.NameContainer = self:Create ("CACPanel")
	
	self.NameLabel = self.NameContainer:Create ("CACLabel")
	self.NameLabel:SetFont (CAC.Font ("Roboto", 16))
	self.NameLabel:SetTextInset (8, 0)
	
	self.ClientsideLuaDisallowedResponseComboBox = self:Create ("CACComboBox")
	self.ClientsideLuaDisallowedResponseComboBox:SetTextColor (CAC.Colors.Black)
	self.ClientsideLuaDisallowedResponseComboBox:SetFont (CAC.Font ("Roboto", 16))
	
	self.ClientsideLuaAllowedResponseComboBox = self:Create ("CACComboBox")
	self.ClientsideLuaAllowedResponseComboBox:SetTextColor (CAC.Colors.Black)
	self.ClientsideLuaAllowedResponseComboBox:SetFont (CAC.Font ("Roboto", 16))
	
	self.ClientsideLuaDisallowedResponseComboBox:AddEventListener ("SelectedItemChanged",
		function (_)
			local detectionInformation = CAC.Detections:GetDetectionInformation (self.DetectionType)
			if detectionInformation then
				self.ClientsideLuaDisallowedResponseComboBox:SetToolTipText (detectionInformation:GetDescription ())
			end
			
			self:UpdateColors ()
			
			-- Send change request
			if not self.DetectionResponseSettings then return end
			
			local newClientsideLuaDisallowedResponse = CAC.DetectionResponse [self.ClientsideLuaDisallowedResponseComboBox:GetSelectedItem ():GetId ()]
			local clientsideLuaDisallowedResponse, _ = self.DetectionResponseSettings:GetDetectionResponse (self.DetectionType)
			
			if clientsideLuaDisallowedResponse ~= newClientsideLuaDisallowedResponse then
				self:SendDetectionResponseChangeRequest ()
			end
		end
	)
	
	self.ClientsideLuaAllowedResponseComboBox:AddEventListener ("SelectedItemChanged",
		function (_)
			local detectionInformation = CAC.Detections:GetDetectionInformation (self.DetectionType)
			if detectionInformation then
				self.ClientsideLuaAllowedResponseComboBox   :SetToolTipText (detectionInformation:GetDescription ())
			end
			
			self:UpdateColors ()
			
			-- Send change request
			if not self.DetectionResponseSettings then return end
			
			local newClientsideLuaAllowedResponse = CAC.DetectionResponse [self.ClientsideLuaAllowedResponseComboBox   :GetSelectedItem ():GetId ()]
			local _, clientsideLuaAllowedResponse = self.DetectionResponseSettings:GetDetectionResponse (self.DetectionType)
			
			if clientsideLuaAllowedResponse ~= newClientsideLuaAllowedResponse then
				self:SendDetectionResponseChangeRequest ()
			end
		end
	)
	
	self.ClientsideLuaDisallowedResponseBackgroundColor = CAC.Colors.Gainsboro
	self.ClientsideLuaAllowedResponseBackgroundColor    = CAC.Colors.Gainsboro
	
	for i = CAC.DetectionResponse.Ignore, #CAC.DetectionResponse do
		self.ClientsideLuaDisallowedResponseComboBox:AddItem (CAC.DetectionResponse [i])
		self.ClientsideLuaAllowedResponseComboBox   :AddItem (CAC.DetectionResponse [i])
	end
end

local color1
local color2
local color3
function self:Paint (w, h)
	if self:IsHoveredRecursive () or
	   self.ClientsideLuaDisallowedResponseComboBox:IsMenuOpen () or
	   self.ClientsideLuaAllowedResponseComboBox   :IsMenuOpen () then
		self.HoverFilter:Impulse ()
	end
	
	local highlightColor2 = CAC.Colors.LightSteelBlue
	local highlightColor3 = CAC.Colors.LightSteelBlue
	
	local clientsideLuaDisallowedResponse = CAC.DetectionResponse [self.ClientsideLuaDisallowedResponseComboBox:GetSelectedItem ():GetId ()]
	local clientsideLuaAllowedResponse    = CAC.DetectionResponse [self.ClientsideLuaAllowedResponseComboBox   :GetSelectedItem ():GetId ()]
	
	if     clientsideLuaDisallowedResponse == CAC.DetectionResponse.Kick then highlightColor2 = CAC.Colors.Orange
	elseif clientsideLuaDisallowedResponse == CAC.DetectionResponse.Ban  then highlightColor2 = CAC.Colors.Tomato end
	if     clientsideLuaAllowedResponse    == CAC.DetectionResponse.Kick then highlightColor3 = CAC.Colors.Orange
	elseif clientsideLuaAllowedResponse    == CAC.DetectionResponse.Ban  then highlightColor3 = CAC.Colors.Tomato end
	
	color1 = CAC.Color.Lerp (1 - 0.5 * self.HoverFilter:Evaluate (), CAC.Colors.LightSteelBlue, CAC.Colors.Gainsboro,                                color1)
	color2 = CAC.Color.Lerp (1 - 0.5 * self.HoverFilter:Evaluate (), highlightColor2,           self.ClientsideLuaDisallowedResponseBackgroundColor, color2)
	color3 = CAC.Color.Lerp (1 - 0.5 * self.HoverFilter:Evaluate (), highlightColor3,           self.ClientsideLuaAllowedResponseBackgroundColor,    color3)
	
	self.NameContainer                          :SetBackgroundColor (color1)
	self.ClientsideLuaDisallowedResponseComboBox:SetBackgroundColor (color2)
	self.ClientsideLuaAllowedResponseComboBox   :SetBackgroundColor (color3)
end

function self:PerformLayout (w, h)
	local cellWidth = (w - 4 * (3 - 1)) / 7
	
	local x = 0
	self.NameContainer:SetPos (0, 0)
	x = x + cellWidth * 3
	self.NameContainer:SetSize (x - math.floor (self.NameContainer:GetX ()), h)
	x = x + 4
	
	self.ClientsideLuaDisallowedResponseComboBox:SetPos (x, 0)
	x = x + cellWidth * 2
	self.ClientsideLuaDisallowedResponseComboBox:SetSize (x - math.floor (self.ClientsideLuaDisallowedResponseComboBox:GetX ()), h)
	x = x + 4
	
	self.ClientsideLuaAllowedResponseComboBox:SetPos (x, 0)
	x = x + cellWidth * 2
	self.ClientsideLuaAllowedResponseComboBox:SetSize (x - math.floor (self.ClientsideLuaAllowedResponseComboBox:GetX ()), h)
	x = x + 4
	
	self.NameLabel:SetPos (0, 0)
	self.NameLabel:SetSize (self.NameContainer:GetSize ())
end

function self:GetDetectionResponseSettings ()
	return self.DetectionResponseSettings
end

function self:SetDetectionResponseSettings (detectionResponseSettings)
	if self.DetectionResponseSettings == detectionResponseSettings then return self end
	
	self.DetectionResponseSettings = detectionResponseSettings
	
	self:Update ()
	
	return self
end

function self:GetDetectionType ()
	return self.DetectionType
end

function self:SetDetectionType (detectionType)
	if self.DetectionType == detectionType then return self end
	
	self.DetectionType = detectionType
	
	self:Update ()
	
	return self
end

-- Internal, do not call
function self:GetResponseColor (detectionResponse)
	if detectionResponse == CAC.DetectionResponse.Ignore then
		return CAC.Colors.Gainsboro
	elseif detectionResponse == CAC.DetectionResponse.Kick then
		return CAC.Colors.Wheat
	elseif detectionResponse == CAC.DetectionResponse.Ban then
		return CAC.Colors.DarkSalmon
	end
end

function self:SendDetectionResponseChangeRequest ()
	if not self.DetectionResponseSettings then return end
	if not self.DetectionType             then return end
	
	local newClientsideLuaDisallowedResponse = CAC.DetectionResponse [self.ClientsideLuaDisallowedResponseComboBox:GetSelectedItem ():GetId ()]
	local newClientsideLuaAllowedResponse    = CAC.DetectionResponse [self.ClientsideLuaAllowedResponseComboBox   :GetSelectedItem ():GetId ()]
	
	local clientsideLuaDisallowedResponse, clientsideLuaAllowedResponse = self.DetectionResponseSettings:GetDetectionResponse (self.DetectionType)
	if clientsideLuaDisallowedResponse == newClientsideLuaDisallowedResponse and
	   clientsideLuaAllowedResponse    == newClientsideLuaAllowedResponse then
		return
	end
	
	self.DetectionResponseSettings:DispatchEvent ("SetDetectionResponse", self.DetectionType, newClientsideLuaDisallowedResponse, newClientsideLuaAllowedResponse)
	
	timer.Simple (0.5,
		function ()
			if not self            then return end
			if not self:IsValid () then return end
			
			self:Update ()
		end
	)
end

function self:Update ()
	if not self.DetectionType             then return end
	
	local detectionInformation = CAC.Detections:GetDetectionInformation (self.DetectionType)
	self.NameLabel:SetText (detectionInformation:GetName ())
	
	self                                        :SetToolTipText (detectionInformation:GetDescription ())
	self.NameContainer                          :SetToolTipText (detectionInformation:GetDescription ())
	self.NameLabel                              :SetToolTipText (detectionInformation:GetDescription ())
	self.ClientsideLuaDisallowedResponseComboBox:SetToolTipText (detectionInformation:GetDescription ())
	self.ClientsideLuaAllowedResponseComboBox   :SetToolTipText (detectionInformation:GetDescription ())
	
	-- Allowable responses
	local clientsideLuaDisallowedMaximumAllowedResponse, clientsideLuaAllowedMaximumAllowedResponse = detectionInformation:GetMaximumAllowedResponse ()
	
	for i = CAC.DetectionResponse.Ignore, #CAC.DetectionResponse do
		self.ClientsideLuaDisallowedResponseComboBox:GetItemById (CAC.DetectionResponse [i]):SetVisible (i <= clientsideLuaDisallowedMaximumAllowedResponse)
		self.ClientsideLuaAllowedResponseComboBox   :GetItemById (CAC.DetectionResponse [i]):SetVisible (i <= clientsideLuaAllowedMaximumAllowedResponse   )
	end
	
	-- Setting response
	if not self.DetectionResponseSettings then return end
	
	local clientsideLuaDisallowedResponse, clientsideLuaAllowedResponse = self.DetectionResponseSettings:GetDetectionResponse (self.DetectionType)
	self.ClientsideLuaDisallowedResponseComboBox:SetSelectedItem (CAC.DetectionResponse [clientsideLuaDisallowedResponse])
	self.ClientsideLuaAllowedResponseComboBox   :SetSelectedItem (CAC.DetectionResponse [clientsideLuaAllowedResponse   ])
end

function self:UpdateColors ()
	if self.ClientsideLuaDisallowedResponseComboBox:GetSelectedItem () then
		self.ClientsideLuaDisallowedResponseBackgroundColor = self:GetResponseColor (CAC.DetectionResponse [self.ClientsideLuaDisallowedResponseComboBox:GetSelectedItem ():GetId ()])
	end
	if self.ClientsideLuaAllowedResponseComboBox   :GetSelectedItem () then
		self.ClientsideLuaAllowedResponseBackgroundColor    = self:GetResponseColor (CAC.DetectionResponse [self.ClientsideLuaAllowedResponseComboBox   :GetSelectedItem ():GetId ()])
	end
end

CAC.Register ("CACDetectionResponseRow", self, "CACPanel")