-- This file is computer-generated.
local self = {}
CAC.GameInformation = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
		VersionChanged (version)
		BranchChanged (branch)
]]

CAC.GameInformation.Networking =
{
	Events =
	{
		VersionChanged = { Handler = "SetVersion", Parameters = { "UInt32"    } },
		BranchChanged  = { Handler = "SetBranch",  Parameters = { "StringN8"  } },
	},
	Commands =
	{
	}
}

CAC.GameInformationSender   = CAC.CreateObjectSenderFactory   (CAC.GameInformation)
CAC.GameInformationReceiver = CAC.CreateObjectReceiverFactory (CAC.GameInformation)

function self:ctor ()
	self.Version = 0
	self.Branch  = ""
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt32    (self.Version)
	outBuffer:StringN8  (self.Branch )
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SetVersion (inBuffer:UInt32    ())
	self:SetBranch  (inBuffer:StringN8  ())
	
	return self
end

-- GameInformation
function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:SetVersion (source.Version)
	self:SetBranch  (source.Branch )
	
	return self
end

function self:GetVersion ()
	return self.Version
end

function self:GetBranch ()
	return self.Branch
end

function self:SetVersion (version)
	if self.Version == version then return self end
	
	self.Version = version
	
	self:DispatchEvent ("VersionChanged", self.Version)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetBranch (branch)
	if self.Branch == branch then return self end
	
	self.Branch = branch
	
	self:DispatchEvent ("BranchChanged", self.Branch)
	self:DispatchEvent ("Changed")
	
	return self
end

