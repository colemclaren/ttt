-- This file is computer-generated.
local self = {}
CAC.OperatingSystemInformation = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
		OperatingSystemChanged (operatingSystem)
		VersionMajorChanged (versionMajor)
		VersionMinorChanged (versionMinor)
		BuildNumberChanged (buildNumber)
]]

CAC.OperatingSystemInformation.Networking =
{
	Events =
	{
		OperatingSystemChanged = { Handler = "SetOperatingSystem", Parameters = { "UInt8"     } },
		VersionMajorChanged    = { Handler = "SetVersionMajor",    Parameters = { "UInt16"    } },
		VersionMinorChanged    = { Handler = "SetVersionMinor",    Parameters = { "UInt16"    } },
		BuildNumberChanged     = { Handler = "SetBuildNumber",     Parameters = { "UInt16"    } },
	},
	Commands =
	{
	}
}

CAC.OperatingSystemInformationSender   = CAC.CreateObjectSenderFactory   (CAC.OperatingSystemInformation)
CAC.OperatingSystemInformationReceiver = CAC.CreateObjectReceiverFactory (CAC.OperatingSystemInformation)

function self:ctor ()
	self.OperatingSystem = CAC.OperatingSystem.Indeterminate
	self.VersionMajor    = 0
	self.VersionMinor    = 0
	self.BuildNumber     = 0
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt8     (self.OperatingSystem)
	outBuffer:UInt16    (self.VersionMajor   )
	outBuffer:UInt16    (self.VersionMinor   )
	outBuffer:UInt16    (self.BuildNumber    )
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SetOperatingSystem (inBuffer:UInt8     ())
	self:SetVersionMajor    (inBuffer:UInt16    ())
	self:SetVersionMinor    (inBuffer:UInt16    ())
	self:SetBuildNumber     (inBuffer:UInt16    ())
	
	return self
end

-- OperatingSystemInformation
function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:SetOperatingSystem (source.OperatingSystem)
	self:SetVersionMajor    (source.VersionMajor   )
	self:SetVersionMinor    (source.VersionMinor   )
	self:SetBuildNumber     (source.BuildNumber    )
	
	return self
end

function self:GetOperatingSystem ()
	return self.OperatingSystem
end

function self:GetVersionMajor ()
	return self.VersionMajor
end

function self:GetVersionMinor ()
	return self.VersionMinor
end

function self:GetBuildNumber ()
	return self.BuildNumber
end

function self:SetOperatingSystem (operatingSystem)
	if self.OperatingSystem == operatingSystem then return self end
	
	self.OperatingSystem = operatingSystem
	
	self:DispatchEvent ("OperatingSystemChanged", self.OperatingSystem)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetVersionMajor (versionMajor)
	if self.VersionMajor == versionMajor then return self end
	
	self.VersionMajor = versionMajor
	
	self:DispatchEvent ("VersionMajorChanged", self.VersionMajor)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetVersionMinor (versionMinor)
	if self.VersionMinor == versionMinor then return self end
	
	self.VersionMinor = versionMinor
	
	self:DispatchEvent ("VersionMinorChanged", self.VersionMinor)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetBuildNumber (buildNumber)
	if self.BuildNumber == buildNumber then return self end
	
	self.BuildNumber = buildNumber
	
	self:DispatchEvent ("BuildNumberChanged", self.BuildNumber)
	self:DispatchEvent ("Changed")
	
	return self
end

