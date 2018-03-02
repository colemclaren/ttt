local self = {}

local detectors =
{
	-- { Name = "AimbotDetector",           Text = "Enable aimbot detector (not recommended)"            },
	{ Name = "AntiAimDetector",          Text = "Enable anti-aim detector"                            },
	{ Name = "AutoBunnyHopDetector",     Text = "Enable auto bunny hop detector"                      },
	-- { Name = "SeedManipulationDetector", Text = "Enable seed manipulation detector (not recommended)" },
	{ Name = "SpeedhackDetectorRunner",  Text = "Enable speedhack detector"                           }
}

function self:Init ()
	self.DetectorSettings = nil
	
	self.Form = self:Create ("CACSettingsForm")
	
	self.DetectorCheckboxes = {}
	
	self.Form:AddHeader ("Detection Systems")
	
	for _, detectorInfo in ipairs (detectors) do
		local checkbox = self:Create ("CACCheckbox")
			:SetHeight (18)
			:SetFont (CAC.Font ("Roboto", 18))
			:SetText (detectorInfo.Text)
		self.DetectorCheckboxes [detectorInfo.Name] = checkbox
		self.Form:AddIndentedControl (checkbox)
		
		checkbox:AddEventListener ("CheckStateChanged",
			function (_, checked)
				if not self.DetectorSettings then return end
				if self.DetectorSettings:IsDetectorEnabled (detectorInfo.Name) == checked then return end
				
				self.DetectorSettings:DispatchEvent ("SetDetectorEnabled", detectorInfo.Name, checked)
			end
		)
	end
end

function self:Paint (w, h)
end

function self:PerformLayout (w, h)
	self.Form:SetPos (0, 0)
	self.Form:SetSize (w, h)
end

function self:OnRemoved ()
	self:SetDetectorSettings (nil)
end

function self:GetDetectorSettings ()
	return self.DetectorSettings
end

function self:SetDetectorSettings (detectorSettings)
	if self.DetectorSettings == detectorSettings then return self end
	
	self.Form:SetTargetObject (detectorSettings)
	
	self:UnhookDetectorSettings (self.DetectorSettings)
	self.DetectorSettings = detectorSettings
	self:HookDetectorSettings (self.DetectorSettings)
	
	if self.DetectorSettings then
		self:Update ()
	end
	
	self:DispatchEvent ("DetectorSettingsChanged", self.DetectorSettings)
	
	return self
end

-- Internal, do not call
function self:Update ()
	for _, detectorInfo in ipairs (detectors) do
		local enabled = self.DetectorSettings:IsDetectorEnabled (detectorInfo.Name)
		self.DetectorCheckboxes [detectorInfo.Name]:SetChecked (enabled)
	end
end

function self:HookDetectorSettings (detectorSettings)
	if not detectorSettings then return end
	
	self:DispatchEvent ("HookDetectorSettings", detectorSettings)
	
	detectorSettings:AddEventListener ("Changed", "CAC.DetectorSettingsView." .. self:GetHashCode () .. ".UpdateMessagePreviews",
		function (_)
			self:Update ()
		end
	)
end

function self:UnhookDetectorSettings (detectorSettings)
	if not detectorSettings then return end
	
	self:DispatchEvent ("UnhookDetectorSettings", detectorSettings)
	
	detectorSettings:RemoveEventListener ("Changed", "CAC.DetectorSettingsView." .. self:GetHashCode () .. ".UpdateMessagePreviews")
end

CAC.Register ("CACDetectorSettingsView", self, "CACPanel")