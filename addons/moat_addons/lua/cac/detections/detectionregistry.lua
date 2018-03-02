local self = {}
CAC.DetectionRegistry = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function self:ctor (logger)
	self.Logger = logger or CAC.Logger
	
	self.DetectionInformation       = {}
	self.DetectionInformationByType = {}
end

-- ISerializable
function self:Serialize (outBuffer)
	for _, detectionInformation in ipairs (self.DetectionInformation) do
		outBuffer:StringN8 (detectionInformation:GetDetectionType ())
		detectionInformation:Serialize (outBuffer)
	end
	
	outBuffer:StringN8 ("")
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	local detectionType = inBuffer:StringN8 ()
	while detectionType ~= "" do
		local detectionInformation = self:RegisterDetection (detectionType)
		detectionInformation:Deserialize (inBuffer)
		
		detectionType = inBuffer:StringN8 ()
	end
	
	return self
end

-- DetectionRegistry
function self:CreateDetection (detectionType, ...)
	if not self.DetectionInformationByType [detectionType] then
		CAC.Error ("CAC.DetectionRegistry:CreateDetection : Detection " .. detectionType .. " does not exist!")
		return nil
	end
	
	return self.DetectionInformationByType [detectionType]:Create (...)
end

function self:GetEnumerator ()
	return CAC.ArrayEnumerator (self.DetectionInformation)
end

function self:GetDetectionInformation (detectionType)
	return self.DetectionInformationByType [detectionType]
end

function self:RegisterDetection (detectionType, baseClass)
	local detectionInformation = CAC.DetectionInformation (detectionType)
	self.DetectionInformation [#self.DetectionInformation + 1] = detectionInformation
	self.DetectionInformationByType [detectionType] = detectionInformation
	
	local detection = {}
	detection.GetDetectionType = function (self)
		return detectionType
	end
	
	detectionInformation:SetConstructor (CAC.MakeConstructor (detection, baseClass or CAC.Detection))
	
	return detection, detectionInformation
end

CAC.Detections = CAC.DetectionRegistry ()