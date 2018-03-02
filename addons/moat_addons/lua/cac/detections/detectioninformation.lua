local self = {}
CAC.DetectionInformation = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function self:ctor (detectionType)
	self.DetectionType       = detectionType
	
	self.Constructor         = nil
	
	-- Metadata
	self.Name                = nil
	self.KickName            = nil
	self.Description         = nil
	
	self.Deprecated          = false
	
	-- Responses
	self.ClientsideLuaDisallowedDefaultResponse            = CAC.DetectionResponse.Ignore
	self.ClientsideLuaDisallowedRecommendedResponse        = CAC.DetectionResponse.Ignore
	self.ClientsideLuaDisallowedMaximumAllowedResponse     = CAC.DetectionResponse.Ban
	self.ClientsideLuaDisallowedMaximumRecommendedResponse = CAC.DetectionResponse.Ban
	
	self.ClientsideLuaAllowedDefaultResponse               = CAC.DetectionResponse.Ignore
	self.ClientsideLuaAllowedRecommendedResponse           = CAC.DetectionResponse.Ignore
	self.ClientsideLuaAllowedMaximumAllowedResponse        = CAC.DetectionResponse.Ban
	self.ClientsideLuaAllowedMaximumRecommendedResponse    = CAC.DetectionResponse.Ban
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:StringN8  (self.Name        or "")
	outBuffer:StringN8  (self.KickName    or "")
	outBuffer:StringN16 (self.Description or "")
	
	outBuffer:Boolean   (self.Deprecated)
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self.Name        = inBuffer:StringN8  ()
	self.KickName    = inBuffer:StringN8  ()
	self.Description = inBuffer:StringN16 ()
	
	self.Deprecated  = inBuffer:Boolean   ()
	
	if #self.Name        == 0 then self.Name        = nil end
	if #self.KickName    == 0 then self.KickName    = nil end
	if #self.Description == 0 then self.Description = nil end
	
	return self
end

-- DetectionInformation
function self:GetDetectionType ()
	return self.DetectionType
end

function self:Create (...)
	return self.Constructor (...)
end

function self:GetConstructor ()
	return self.Constructor
end

function self:SetConstructor (constructor)
	self.Constructor = constructor
	return self
end

-- Metadata
function self:GetDescription ()
	return self.Description
end

function self:GetName ()
	return self.Name
end

function self:GetKickName ()
	return self.KickName or self:GetName ()
end

function self:SetDescription (description)
	self.Description = description
	return self
end

function self:SetName (name)
	self.Name = name
	return self
end

function self:SetKickName (kickName)
	self.KickName = kickName
	return self
end

function self:IsDeprecated ()
	return self.Deprecated
end

function self:SetDeprecated (deprecated)
	self.Deprecated = deprecated
	return self
end

-- Responses
function self:GetDefaultResponse ()
	return self.ClientsideLuaDisallowedDefaultResponse, self.ClientsideLuaAllowedDefaultResponse
end

function self:GetRecommendedResponse ()
	return self.ClientsideLuaDisallowedRecommendedResponse, self.ClientsideLuaAllowedRecommendedResponse
end

function self:GetMaximumAllowedResponse ()
	return self.ClientsideLuaDisallowedMaximumAllowedResponse, self.ClientsideLuaAllowedMaximumAllowedResponse
end

function self:GetMaximumRecommendedResponse ()
	return self.ClientsideLuaDisallowedMaximumRecommendedResponse, self.ClientsideLuaAllowedMaximumRecommendedResponse
end

function self:SetDefaultResponse (clientsideLuaDisallowedDefaultResponse, clientsideLuaAllowedDefaultResponse)
	clientsideLuaAllowedDefaultResponse = clientsideLuaAllowedDefaultResponse or clientsideLuaDisallowedDefaultResponse
	
	self.ClientsideLuaDisallowedDefaultResponse = clientsideLuaDisallowedDefaultResponse
	self.ClientsideLuaAllowedDefaultResponse    = clientsideLuaAllowedDefaultResponse
	
	return self
end

function self:SetRecommendedResponse (clientsideLuaDisallowedRecommendedResponse, clientsideLuaAllowedRecommendedResponse)
	clientsideLuaAllowedRecommendedResponse = clientsideLuaAllowedRecommendedResponse or clientsideLuaDisallowedRecommendedResponse
	
	self.ClientsideLuaDisallowedRecommendedResponse = clientsideLuaDisallowedRecommendedResponse
	self.ClientsideLuaAllowedRecommendedResponse    = clientsideLuaAllowedRecommendedResponse
	
	return self
end

function self:SetMaximumAllowedResponse (clientsideLuaDisallowedMaximumAllowedResponse, clientsideLuaAllowedMaximumAllowedResponse)
	clientsideLuaAllowedMaximumAllowedResponse = clientsideLuaAllowedMaximumAllowedResponse or clientsideLuaDisallowedMaximumAllowedResponse
	
	self.ClientsideLuaDisallowedMaximumAllowedResponse = clientsideLuaDisallowedMaximumAllowedResponse
	self.ClientsideLuaAllowedMaximumAllowedResponse    = clientsideLuaAllowedMaximumAllowedResponse
	
	return self
end

function self:SetMaximumRecommendedResponse (clientsideLuaDisallowedMaximumRecommendedResponse, clientsideLuaAllowedMaximumRecommendedResponse)
	clientsideLuaAllowedMaximumRecommendedResponse = clientsideLuaAllowedMaximumRecommendedResponse or clientsideLuaDisallowedMaximumRecommendedResponse
	
	self.ClientsideLuaDisallowedMaximumRecommendedResponse = clientsideLuaDisallowedMaximumRecommendedResponse
	self.ClientsideLuaAllowedMaximumRecommendedResponse    = clientsideLuaAllowedMaximumRecommendedResponse
	
	return self
end