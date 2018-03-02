local self = {}
CAC.SerializerRegistry = CAC.MakeConstructor (self)

function self:ctor ()
	self.Serializers   = {}
	self.Deserializers = {}
end

function self:SerializerExists (className, version)
	if not self.Serializers [className] then return false end
	
	return self.Serializers [className] [version] ~= nil
end

function self:DeserializerExists (className, version)
	if not self.Deserializers [className] then return false end
	
	return self.Deserializers [className] [version] ~= nil
end

function self:GetLatestSerializerVersion (className)
	if not self.Serializers [className] then return nil end
	
	return table.maxn (self.Serializers [className])
end

function self:GetLatestDeserializerVersion (className)
	if not self.Deserializers [className] then return nil end
	
	return table.maxn (self.Deserializers [className])
end

function self:GetSerializer (className, version)
	if not self.Serializers [className] then return nil end
	
	return self.Serializers [className] [version]
end

function self:GetDeserializer (className, version)
	if not self.Deserializers [className] then return nil end
	
	return self.Deserializers [className] [version]
end

function self:Serialize (className, version, object, outBuffer)
	if not version then version = self:GetLatestSerializerVersion (className) end
	
	return self:GetSerializer (className, version) (object, outBuffer)
end

function self:Deserialize (className, version, object, inBuffer)
	if not version then version = self:GetLatestDeserializerVersion (className) end
	
	return self:GetDeserializer (className, version) (object, inBuffer)
end

function self:RegisterSerializable (className, version)
	self:RegisterSerializer (className, version,
		function (self, outBuffer)
			return self:Serialize (outBuffer)
		end
	)
	
	self:RegisterDeserializer (className, version,
		function (self, inBuffer)
			return self:Deserialize (inBuffer)
		end
	)
end

function self:RegisterSerializer (className, version, serializer)
	self.Serializers [className] = self.Serializers [className] or {}
	self.Serializers [className] [version] = serializer
end

function self:RegisterDeserializer (className, version, deserializer)
	self.Deserializers [className] = self.Deserializers [className] or {}
	self.Deserializers [className] [version] = deserializer
end

function self:UnregisterSerializer (className, version)
	if not self.Serializers [className] then return end
	self.Serializers [className] [version] = nil
end

function self:UnregisterDeserializer (className, version)
	if not self.Deserializers [className] then return end
	self.Deserializers [className] [version] = nil
end

CAC.SerializerRegistry = CAC.SerializerRegistry ()