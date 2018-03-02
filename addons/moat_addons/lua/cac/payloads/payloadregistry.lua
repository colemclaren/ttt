local self = {}
CAC.PayloadRegistry = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function self:ctor ()
	self.Payloads = {}
end

-- ISerializable
function self:Serialize (outBuffer)
	for payloadId, payloadInformation in pairs (self.Payloads) do
		outBuffer:StringN8 (payloadId)
		payloadInformation:Serialize (outBuffer)
	end
	
	outBuffer:StringN8 ("")
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	local payloadId = inBuffer:StringN8 ()
	while payloadId ~= "" do
		local payloadInformation = self:RegisterPayload (payloadId)
		payloadInformation:Deserialize (inBuffer)
		
		payloadId = inBuffer:StringN8 ()
	end
	
	return self
end

-- PayloadRegistry
function self:GetPayload (payloadId)
	return self.Payloads [payloadId]
end

function self:RegisterPayload (payloadId, filePath)
	local payloadInformation = self.Payloads [payloadId]
	
	if not payloadInformation then
		payloadInformation = CAC.PayloadInformation (payloadId)
		self.Payloads [payloadId] = payloadInformation
	end
	
	payloadInformation:SetPath (filePath)
	
	return payloadInformation
end

CAC.Payloads = CAC.PayloadRegistry ()