-- This file is computer-generated.
local self = {}
CAC.LocationInformation = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
		CountryChanged (country)
		IPChanged (iP)
		PortChanged (port)
]]

CAC.LocationInformation.Networking =
{
	Events =
	{
		CountryChanged = { Handler = "SetCountry", Parameters = { "StringN8"  } },
		IPChanged      = { Handler = "SetIP",      Parameters = { "UInt32"    } },
		PortChanged    = { Handler = "SetPort",    Parameters = { "UInt16"    } },
	},
	Commands =
	{
	}
}

CAC.LocationInformationSender   = CAC.CreateObjectSenderFactory   (CAC.LocationInformation)
CAC.LocationInformationReceiver = CAC.CreateObjectReceiverFactory (CAC.LocationInformation)

function self:ctor ()
	self.Country = ""
	self.IP      = 0
	self.Port    = 0
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:StringN8  (self.Country)
	outBuffer:UInt32    (self.IP     )
	outBuffer:UInt16    (self.Port   )
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SetCountry (inBuffer:StringN8  ())
	self:SetIP      (inBuffer:UInt32    ())
	self:SetPort    (inBuffer:UInt16    ())
	
	return self
end

-- LocationInformation
function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:SetCountry (source.Country)
	self:SetIP      (source.IP     )
	self:SetPort    (source.Port   )
	
	return self
end

function self:GetCountry ()
	return self.Country
end

function self:GetIP ()
	return self.IP
end

function self:GetPort ()
	return self.Port
end

function self:SetCountry (country)
	if self.Country == country then return self end
	
	self.Country = country
	
	self:DispatchEvent ("CountryChanged", self.Country)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetIP (iP)
	if self.IP == iP then return self end
	
	self.IP = iP
	
	self:DispatchEvent ("IPChanged", self.IP)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetPort (port)
	if self.Port == port then return self end
	
	self.Port = port
	
	self:DispatchEvent ("PortChanged", self.Port)
	self:DispatchEvent ("Changed")
	
	return self
end

