-- This file is computer-generated.
local self = {}
CAC.AccountInformation = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
		SteamIdChanged (steamId)
		CommunityIdChanged (communityId)
		DisplayNameChanged (displayName)
]]

CAC.AccountInformation.Networking =
{
	Events =
	{
		SteamIdChanged     = { Handler = "SetSteamId",     Parameters = { "StringN8"  } },
		CommunityIdChanged = { Handler = "SetCommunityId", Parameters = { "StringN8"  } },
		DisplayNameChanged = { Handler = "SetDisplayName", Parameters = { "StringN16" } },
	},
	Commands =
	{
	}
}

CAC.AccountInformationSender   = CAC.CreateObjectSenderFactory   (CAC.AccountInformation)
CAC.AccountInformationReceiver = CAC.CreateObjectReceiverFactory (CAC.AccountInformation)

function self:ctor ()
	self.SteamId     = ""
	self.CommunityId = ""
	self.DisplayName = ""
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:StringN8  (self.SteamId    )
	outBuffer:StringN8  (self.CommunityId)
	outBuffer:StringN16 (self.DisplayName)
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SetSteamId     (inBuffer:StringN8  ())
	self:SetCommunityId (inBuffer:StringN8  ())
	self:SetDisplayName (inBuffer:StringN16 ())
	
	return self
end

-- AccountInformation
function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:SetSteamId     (source.SteamId    )
	self:SetCommunityId (source.CommunityId)
	self:SetDisplayName (source.DisplayName)
	
	return self
end

function self:GetSteamId ()
	return self.SteamId
end

function self:GetCommunityId ()
	return self.CommunityId
end

function self:GetDisplayName ()
	return self.DisplayName
end

function self:SetSteamId (steamId)
	if self.SteamId == steamId then return self end
	
	self.SteamId = steamId
	
	self:DispatchEvent ("SteamIdChanged", self.SteamId)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetCommunityId (communityId)
	if self.CommunityId == communityId then return self end
	
	self.CommunityId = communityId
	
	self:DispatchEvent ("CommunityIdChanged", self.CommunityId)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetDisplayName (displayName)
	if self.DisplayName == displayName then return self end
	
	self.DisplayName = displayName
	
	self:DispatchEvent ("DisplayNameChanged", self.DisplayName)
	self:DispatchEvent ("Changed")
	
	return self
end

