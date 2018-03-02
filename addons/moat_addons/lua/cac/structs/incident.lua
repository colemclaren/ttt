-- This file is computer-generated.
local self = {}
CAC.Incident = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
		IdChanged (id)
		TimestampChanged (timestamp)
		PlayerSteamIdChanged (playerSteamId)
		PlayerNameChanged (playerName)
		SessionIdChanged (sessionId)
		ResponseChanged (response)
		ResponseExecutedChanged (responseExecuted)
		ResponseSuppressedChanged (responseSuppressed)
		ResponseSuppressorSteamIdChanged (responseSuppressorSteamId)
		ResponseSuppressorNameChanged (responseSuppressorName)
		ResponseApprovedChanged (responseApproved)
		ResponseApproverSteamIdChanged (responseApproverSteamId)
		ResponseApproverNameChanged (responseApproverName)
]]

CAC.Incident.Networking =
{
	Events =
	{
		IdChanged                        = { Handler = "SetId",                        Parameters = { "UInt64"    } },
		TimestampChanged                 = { Handler = "SetTimestamp",                 Parameters = { "UInt32"    } },
		PlayerSteamIdChanged             = { Handler = "SetPlayerSteamId",             Parameters = { "StringN8"  } },
		PlayerNameChanged                = { Handler = "SetPlayerName",                Parameters = { "StringN8"  } },
		SessionIdChanged                 = { Handler = "SetSessionId",                 Parameters = { "UInt32"    } },
		ResponseChanged                  = { Handler = "SetResponse",                  Parameters = { "UInt8"     } },
		ResponseExecutedChanged          = { Handler = "SetResponseExecuted",          Parameters = { "Boolean"   } },
		ResponseSuppressedChanged        = { Handler = "SetResponseSuppressed",        Parameters = { "Boolean"   } },
		ResponseSuppressorSteamIdChanged = { Handler = "SetResponseSuppressorSteamId", Parameters = { "StringN8"  } },
		ResponseSuppressorNameChanged    = { Handler = "SetResponseSuppressorName",    Parameters = { "StringN8"  } },
		ResponseApprovedChanged          = { Handler = "SetResponseApproved",          Parameters = { "Boolean"   } },
		ResponseApproverSteamIdChanged   = { Handler = "SetResponseApproverSteamId",   Parameters = { "StringN8"  } },
		ResponseApproverNameChanged      = { Handler = "SetResponseApproverName",      Parameters = { "StringN8"  } },
	},
	Commands =
	{
	}
}

CAC.IncidentSender   = CAC.CreateObjectSenderFactory   (CAC.Incident)
CAC.IncidentReceiver = CAC.CreateObjectReceiverFactory (CAC.Incident)

function self:ctor ()
	self.Id                        = nil
	self.Timestamp                 = os.time ()
	self.PlayerSteamId             = ""
	self.PlayerName                = ""
	self.SessionId                 = 0
	self.Response                  = CAC.DetectionResponse.Ignore
	self.ResponseExecuted          = false
	self.ResponseSuppressed        = false
	self.ResponseSuppressorSteamId = ""
	self.ResponseSuppressorName    = ""
	self.ResponseApproved          = false
	self.ResponseApproverSteamId   = ""
	self.ResponseApproverName      = ""
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt64    (self.Id                       )
	outBuffer:UInt32    (self.Timestamp                )
	outBuffer:StringN8  (self.PlayerSteamId            )
	outBuffer:StringN8  (self.PlayerName               )
	outBuffer:UInt32    (self.SessionId                )
	outBuffer:UInt8     (self.Response                 )
	outBuffer:Boolean   (self.ResponseExecuted         )
	outBuffer:Boolean   (self.ResponseSuppressed       )
	outBuffer:StringN8  (self.ResponseSuppressorSteamId)
	outBuffer:StringN8  (self.ResponseSuppressorName   )
	outBuffer:Boolean   (self.ResponseApproved         )
	outBuffer:StringN8  (self.ResponseApproverSteamId  )
	outBuffer:StringN8  (self.ResponseApproverName     )
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SetId                        (inBuffer:UInt64    ())
	self:SetTimestamp                 (inBuffer:UInt32    ())
	self:SetPlayerSteamId             (inBuffer:StringN8  ())
	self:SetPlayerName                (inBuffer:StringN8  ())
	self:SetSessionId                 (inBuffer:UInt32    ())
	self:SetResponse                  (inBuffer:UInt8     ())
	self:SetResponseExecuted          (inBuffer:Boolean   ())
	self:SetResponseSuppressed        (inBuffer:Boolean   ())
	self:SetResponseSuppressorSteamId (inBuffer:StringN8  ())
	self:SetResponseSuppressorName    (inBuffer:StringN8  ())
	self:SetResponseApproved          (inBuffer:Boolean   ())
	self:SetResponseApproverSteamId   (inBuffer:StringN8  ())
	self:SetResponseApproverName      (inBuffer:StringN8  ())
	
	return self
end

-- Incident
function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:SetId                        (source.Id                       )
	self:SetTimestamp                 (source.Timestamp                )
	self:SetPlayerSteamId             (source.PlayerSteamId            )
	self:SetPlayerName                (source.PlayerName               )
	self:SetSessionId                 (source.SessionId                )
	self:SetResponse                  (source.Response                 )
	self:SetResponseExecuted          (source.ResponseExecuted         )
	self:SetResponseSuppressed        (source.ResponseSuppressed       )
	self:SetResponseSuppressorSteamId (source.ResponseSuppressorSteamId)
	self:SetResponseSuppressorName    (source.ResponseSuppressorName   )
	self:SetResponseApproved          (source.ResponseApproved         )
	self:SetResponseApproverSteamId   (source.ResponseApproverSteamId  )
	self:SetResponseApproverName      (source.ResponseApproverName     )
	
	return self
end

function self:GetId ()
	return self.Id
end

function self:GetTimestamp ()
	return self.Timestamp
end

function self:GetPlayerSteamId ()
	return self.PlayerSteamId
end

function self:GetPlayerName ()
	return self.PlayerName
end

function self:GetSessionId ()
	return self.SessionId
end

function self:GetResponse ()
	return self.Response
end

function self:GetResponseExecuted ()
	return self.ResponseExecuted
end

function self:GetResponseSuppressed ()
	return self.ResponseSuppressed
end

function self:GetResponseSuppressorSteamId ()
	return self.ResponseSuppressorSteamId
end

function self:GetResponseSuppressorName ()
	return self.ResponseSuppressorName
end

function self:GetResponseApproved ()
	return self.ResponseApproved
end

function self:GetResponseApproverSteamId ()
	return self.ResponseApproverSteamId
end

function self:GetResponseApproverName ()
	return self.ResponseApproverName
end

function self:SetId (id)
	if self.Id == id then return self end
	
	self.Id = id
	
	self:DispatchEvent ("IdChanged", self.Id)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetTimestamp (timestamp)
	if self.Timestamp == timestamp then return self end
	
	self.Timestamp = timestamp
	
	self:DispatchEvent ("TimestampChanged", self.Timestamp)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetPlayerSteamId (playerSteamId)
	if self.PlayerSteamId == playerSteamId then return self end
	
	self.PlayerSteamId = playerSteamId
	
	self:DispatchEvent ("PlayerSteamIdChanged", self.PlayerSteamId)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetPlayerName (playerName)
	if self.PlayerName == playerName then return self end
	
	self.PlayerName = playerName
	
	self:DispatchEvent ("PlayerNameChanged", self.PlayerName)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetSessionId (sessionId)
	if self.SessionId == sessionId then return self end
	
	self.SessionId = sessionId
	
	self:DispatchEvent ("SessionIdChanged", self.SessionId)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetResponse (response)
	if self.Response == response then return self end
	
	self.Response = response
	
	self:DispatchEvent ("ResponseChanged", self.Response)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetResponseExecuted (responseExecuted)
	if self.ResponseExecuted == responseExecuted then return self end
	
	self.ResponseExecuted = responseExecuted
	
	self:DispatchEvent ("ResponseExecutedChanged", self.ResponseExecuted)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetResponseSuppressed (responseSuppressed)
	if self.ResponseSuppressed == responseSuppressed then return self end
	
	self.ResponseSuppressed = responseSuppressed
	
	self:DispatchEvent ("ResponseSuppressedChanged", self.ResponseSuppressed)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetResponseSuppressorSteamId (responseSuppressorSteamId)
	if self.ResponseSuppressorSteamId == responseSuppressorSteamId then return self end
	
	self.ResponseSuppressorSteamId = responseSuppressorSteamId
	
	self:DispatchEvent ("ResponseSuppressorSteamIdChanged", self.ResponseSuppressorSteamId)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetResponseSuppressorName (responseSuppressorName)
	if self.ResponseSuppressorName == responseSuppressorName then return self end
	
	self.ResponseSuppressorName = responseSuppressorName
	
	self:DispatchEvent ("ResponseSuppressorNameChanged", self.ResponseSuppressorName)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetResponseApproved (responseApproved)
	if self.ResponseApproved == responseApproved then return self end
	
	self.ResponseApproved = responseApproved
	
	self:DispatchEvent ("ResponseApprovedChanged", self.ResponseApproved)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetResponseApproverSteamId (responseApproverSteamId)
	if self.ResponseApproverSteamId == responseApproverSteamId then return self end
	
	self.ResponseApproverSteamId = responseApproverSteamId
	
	self:DispatchEvent ("ResponseApproverSteamIdChanged", self.ResponseApproverSteamId)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetResponseApproverName (responseApproverName)
	if self.ResponseApproverName == responseApproverName then return self end
	
	self.ResponseApproverName = responseApproverName
	
	self:DispatchEvent ("ResponseApproverNameChanged", self.ResponseApproverName)
	self:DispatchEvent ("Changed")
	
	return self
end

