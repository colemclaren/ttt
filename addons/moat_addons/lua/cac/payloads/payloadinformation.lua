local self = {}
CAC.PayloadInformation = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function self:ctor (payloadId)
	self.Id              = payloadId
	self.Path            = nil
	
	self.Name            = nil
	self.Description     = nil
	
	self.Repeatable      = false
	self.Reply           = false
	
	self.Dependencies    = CAC.Containers.OrderedSet ()
	
	self.UnprocessedCode = nil
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:StringN16 (self.Path        or "")
	outBuffer:StringN8  (self.Name        or "")
	outBuffer:StringN16 (self.Description or "")
	
	outBuffer:Boolean   (self.Repeatable)
	outBuffer:Boolean   (self.Reply     )
	
	outBuffer:UInt8 (self.Dependencies:GetCount ())
	for dependency in self.Dependencies:GetEnumerator () do
		outBuffer:StringN8 (dependency)
	end
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	local path = inBuffer:StringN16 ()
	if self.Path == "" then path = nil end
	self:SetPath (path)
	
	self.Name        = inBuffer:StringN8  ()
	self.Description = inBuffer:StringN16 ()
	
	self.Repeatable  = inBuffer:Boolean   ()
	self.Reply       = inBuffer:Boolean   ()
	
	if self.Name        == "" then self.Name        = nil end
	if self.Description == "" then self.Description = nil end
	
	self.Dependencies:Clear ()
	local dependencyCount = inBuffer:UInt8 ()
	for i = 1, dependencyCount do
		self.Dependencies:Add (inBuffer:StringN8 ())
	end
	
	return self
end

-- PayloadInformation
-- Identity
function self:GetId ()
	return self.Id
end

function self:SetId (payloadId)
	self.Id = payloadId
end

-- Code
function self:GetLuaPath ()
	return "cac/payloads/" .. self.Path
end

function self:GetPath ()
	return self.Path
end

function self:SetPath (path)
	if self.Path == path then return self end
	
	self.Path = path
	
	if self.Path then
		self.UnprocessedCode = file.Read (self:GetLuaPath (), SERVER and "LUA" or "LCL")
	else
		self.UnprocessedCode = nil
	end
	
	return self
end

function self:GetUnprocessedCode ()
	return self.UnprocessedCode
end

function self:GenerateProcessedCode (livePlayerSession)
	if Profiler then Profiler:Begin ("PayloadInformation:GenerateProcessedCode : " .. self:GetName ()) end
	local code = CAC.CodeGen.FinalizeCode (self:GetUnprocessedCode (), livePlayerSession)
	if Profiler then Profiler:End () end
	
	return code
end

-- Metadata
function self:GetName ()
	return self.Name
end

function self:GetDescription ()
	return self.Description
end

function self:HasReply ()
	return self.Reply
end

function self:IsRepeatable ()
	return self.Repeatable
end

function self:SetName (name)
	self.Name = name
	return self
end

function self:SetDescription (description)
	self.Description = description
	return self
end

function self:SetHasReply (hasReply)
	self.Reply = hasReply
	return self
end

function self:SetRepeatable (repeatable)
	self.Repeatable = repeatable
	return self
end

-- Dependencies
function self:AddDependency (payloadId)
	self.Dependencies:Add (payloadId)
end

function self:ClearDependencies ()
	self.Dependencies:Clear ()
end

function self:GetDependencyEnumerator ()
	return self.Dependencies:GetEnumerator ()
end

function self:RemoveDependency (payloadId)
	self.Dependencies:Remove (payloadId)
end