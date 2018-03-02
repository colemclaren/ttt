local self = {}
CAC.DetectorSettings = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
			Fired when the settings have changed.
		DetectorEnabledChanged (detectorName, enabled)
			Fired when a detector has been enabled or disabled.
]]

CAC.DetectorSettings.Networking =
{
	Events =
	{
		DetectorEnabledChanged = { Handler = "SetDetectorEnabled", Parameters = { "StringN8", "Boolean" } }
	},
	Commands =
	{
		SetDetectorEnabled     = { Handler = "SetDetectorEnabled", Parameters = { "StringN8", "Boolean" } },
		
		Reset =
		{
			Handler = function (sender, object)
				object:Copy (object.__ictor ())
			end
		}
	},
	CommandPermissionPredicate = function (sender, object, commandName)
		return CAC.Permissions.PlayerHasPermission (sender:GetPlayer (), "ChangeSettings")
	end
}

CAC.DetectorSettingsSender   = CAC.CreateObjectSenderFactory   (CAC.DetectorSettings)
CAC.DetectorSettingsReceiver = CAC.CreateObjectReceiverFactory (CAC.DetectorSettings)

CAC.SerializerRegistry:RegisterSerializable ("DetectorSettings", 1)

function self:ctor ()
	self.DetectorsEnabled = {}
	
	self.DetectorsEnabled ["AimbotDetector"          ] = false
	self.DetectorsEnabled ["AntiAimDetector"         ] = true
	self.DetectorsEnabled ["AutoBunnyHopDetector"    ] = true
	self.DetectorsEnabled ["SeedManipulationDetector"] = false
	self.DetectorsEnabled ["SpeedhackDetectorRunner" ] = true
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	for detectorName in self:GetDetectorEnumerator () do
		outBuffer:StringN8 (detectorName)
		outBuffer:Boolean  (self:IsDetectorEnabled (detectorName))
	end
	
	outBuffer:StringN8 ("")
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	local detectorName = inBuffer:StringN8 ()
	while detectorName ~= "" do
		local enabled = inBuffer:Boolean ()
		
		self:SetDetectorEnabled (detectorName, enabled)
		
		detectorName = inBuffer:StringN8 ()
	end
	
	return self
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	for detectorName in source:GetDetectorEnumerator () do
		self:SetDetectorEnabled (detectorName, source:IsDetectorEnabled (detectorName))
	end
	
	return self
end

-- Detectors
function self:GetDetectorEnumerator ()
	return CAC.KeyEnumerator (self.DetectorsEnabled)
end

function self:IsDetectorEnabled (detectorName)
	return self.DetectorsEnabled [detectorName] or false
end

function self:SetDetectorEnabled (detectorName, enabled)
	if detectorName == "AimbotDetector" or detectorName == "SeedManipulationDetector" then
		enabled = false
	end
	
	if self.DetectorsEnabled [detectorName] == enabled then return self end
	if self.DetectorsEnabled [detectorName] == nil     then return self end
	
	self.DetectorsEnabled [detectorName] = enabled
	
	self:DispatchEvent ("Changed")
	self:DispatchEvent ("DetectorEnabledChanged", detectorName, enabled)
	
	return self
end

function self:__call (...)
	return self:Clone (...)
end