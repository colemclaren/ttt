local self = {}
CAC.CheckInformation = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function self:ctor (checkId)
	self.Id          = checkId
	
	self.Constructor = nil
	
	self.Name        = nil
	self.Description = nil
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:StringN8  (self.Name        or "")
	outBuffer:StringN16 (self.Description or "")
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self.Name        = inBuffer:StringN8  ()
	self.Description = inBuffer:StringN16 ()
	
	if #self.Name        == 0 then self.Name        = nil end
	if #self.Description == 0 then self.Description = nil end
	
	return self
end

-- CheckInformation
function self:GetId ()
	return self.Id
end

function self:Create (...)
	return self.Constructor (self.Id, ...)
end

function self:GetConstructor ()
	return self.Constructor
end

function self:GetDescription ()
	return self.Description
end

function self:GetName ()
	return self.Name
end

function self:SetConstructor (constructor)
	self.Constructor = constructor
	return self
end

function self:SetDescription (description)
	self.Description = description
	return self
end

function self:SetName (name)
	self.Name = name
	return self
end