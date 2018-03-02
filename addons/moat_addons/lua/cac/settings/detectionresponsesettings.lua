local self = {}
CAC.DetectionResponseSettings = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
			Fired when the settings have changed.
		DetectionResponseChanged (detectionType, DetectionResponse clientsideLuaDisallowedResponse, DetectionResponse clientsideLuaAllowedResponse)
			Fired when the detection response for a detection type has changed.
]]

CAC.DetectionResponseSettings.Networking =
{
	Events =
	{
		DetectionResponseChanged = { Handler = "SetDetectionResponse", Parameters = { "StringN8", "UInt8", "UInt8" } }
	},
	Commands =
	{
		SetDetectionResponse     = { Handler = "SetDetectionResponse", Parameters = { "StringN8", "UInt8", "UInt8" } },
		
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

CAC.DetectionResponseSettingsSender   = CAC.CreateObjectSenderFactory   (CAC.DetectionResponseSettings)
CAC.DetectionResponseSettingsReceiver = CAC.CreateObjectReceiverFactory (CAC.DetectionResponseSettings)

CAC.SerializerRegistry:RegisterSerializable ("DetectionResponseSettings", 1)

function self:ctor ()
	self.ClientsideLuaDisallowedResponses = {}
	self.ClientsideLuaAllowedResponses    = {}
	
	for detectionInformation in CAC.Detections:GetEnumerator () do
		local clientsideLuaDisallowedResponse, clientsideLuaAllowedResponse = detectionInformation:GetDefaultResponse ()
		self.ClientsideLuaDisallowedResponses [detectionInformation:GetDetectionType ()] = clientsideLuaDisallowedResponse
		self.ClientsideLuaAllowedResponses    [detectionInformation:GetDetectionType ()] = clientsideLuaAllowedResponse
	end
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	for detectionInformation in CAC.Detections:GetEnumerator () do
		local detectionType = detectionInformation:GetDetectionType ()
		local clientsideLuaDisallowedResponse, clientsideLuaAllowedResponse = self:GetDetectionResponse (detectionType)
		outBuffer:StringN8 (detectionType)
		outBuffer:UInt8 (clientsideLuaDisallowedResponse)
		outBuffer:UInt8 (clientsideLuaAllowedResponse)
	end
	
	outBuffer:StringN8 ("")
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	local detectionType = inBuffer:StringN8 ()
	while detectionType ~= "" do
		local clientsideLuaDisallowedResponse = inBuffer:UInt8 ()
		local clientsideLuaAllowedResponse    = inBuffer:UInt8 ()
		
		self:SetDetectionResponse (detectionType, clientsideLuaDisallowedResponse, clientsideLuaAllowedResponse)
		
		detectionType = inBuffer:StringN8 ()
	end
	
	return self
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	for detectionInformation in CAC.Detections:GetEnumerator () do
		local detectionType = detectionInformation:GetDetectionType ()
		self:SetDetectionResponse (detectionType, source:GetDetectionResponse (detectionType))
	end
	
	return self
end

-- Detections
function self:ClampDetectionResponses ()
	for detectionInformation in CAC.Detections:GetEnumerator () do
		local clientsideLuaDisallowedResponse,               clientsideLuaAllowedResponse               = self:GetDetectionResponse (detectionInformation:GetDetectionType ())
		local maximumAllowedClientsideLuaDisallowedResponse, maximumAllowedClientsideLuaAllowedResponse = detectionInformation:GetMaximumAllowedResponse ()
		
		clientsideLuaDisallowedResponse = math.min (clientsideLuaDisallowedResponse, maximumAllowedClientsideLuaDisallowedResponse)
		clientsideLuaAllowedResponse    = math.min (clientsideLuaAllowedResponse,    maximumAllowedClientsideLuaAllowedResponse   )
		
		self:SetDetectionResponse (detectionInformation:GetDetectionType (), clientsideLuaDisallowedResponse, clientsideLuaAllowedResponse)
	end
	
end

function self:GetDetectionResponse (detectionType)
	return self.ClientsideLuaDisallowedResponses [detectionType], self.ClientsideLuaAllowedResponses [detectionType]
end

function self:SetDetectionResponse (detectionType, clientsideLuaDisallowedResponse, clientsideLuaAllowedResponse)
	if self.ClientsideLuaDisallowedResponses [detectionType] == clientsideLuaDisallowedResponse and
	   self.ClientsideLuaAllowedResponses    [detectionType] == clientsideLuaAllowedResponse then
		return self
	end
	
	self.ClientsideLuaDisallowedResponses [detectionType] = clientsideLuaDisallowedResponse
	self.ClientsideLuaAllowedResponses    [detectionType] = clientsideLuaAllowedResponse
	
	self:DispatchEvent ("Changed")
	self:DispatchEvent ("DetectionResponseChanged", detectionType, self.ClientsideLuaDisallowedResponses [detectionType], self.ClientsideLuaAllowedResponses [detectionType])
	
	return self
end

function self:__call (...)
	return self:Clone (...)
end