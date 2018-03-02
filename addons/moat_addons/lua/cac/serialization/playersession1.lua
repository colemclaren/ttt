CAC.SerializerRegistry:RegisterSerializer ("PlayerSession", 1,
	function (self, outBuffer)
		outBuffer:UInt32  (self:GetStartTime ())
		outBuffer:UInt32  (self:GetEndTime   ())
		outBuffer:Boolean (self:IsFinished   ())
		
		outBuffer:Boolean (self:HasIncident  ())
		outBuffer:UInt32  (self:GetIncidentId () or 0)
		
		self:GetAccountInformation         ():Serialize (outBuffer)
		self:GetGameInformation            ():Serialize (outBuffer)
		self:GetOperatingSystemInformation ():Serialize (outBuffer)
		self:GetLocationInformation        ():Serialize (outBuffer)
		self:GetHardwareInformation        ():Serialize (outBuffer)
		
		-- Flags
		for flag in self:GetFlagEnumerator () do
			outBuffer:StringN8 (flag)
		end
		outBuffer:StringN8 ("")
		
		-- Detections
		local reasonArrayDetectionSerializer = CAC.SerializerRegistry:GetSerializer ("ReasonArrayDetection", 1)
		for detection in self:GetDetectionEnumerator () do
			outBuffer:StringN8 (detection:GetDetectionType ())
			
			if detection:Is (CAC.ReasonArrayDetection) then
				reasonArrayDetectionSerializer (detection, outBuffer)
			else
				detection:Serialize (outBuffer)
			end
		end
		outBuffer:StringN8 ("")
		
		return outBuffer
	end
)

CAC.SerializerRegistry:RegisterDeserializer ("PlayerSession", 1,
	function (self, inBuffer)
		self:SetStartTime (inBuffer:UInt32 ())
		self:SetEndTime   (inBuffer:UInt32 ())
		self:SetFinished  (inBuffer:Boolean ())
		
		if inBuffer:Boolean () then
			self:SetIncidentId (inBuffer:UInt32 ())
		else
			inBuffer:UInt32 ()
			self:SetIncidentId (nil)
		end
		
		self:GetAccountInformation         ():Deserialize (inBuffer)
		self:GetGameInformation            ():Deserialize (inBuffer)
		self:GetOperatingSystemInformation ():Deserialize (inBuffer)
		self:GetLocationInformation        ():Deserialize (inBuffer)
		self:GetHardwareInformation        ():Deserialize (inBuffer)
		
		-- Flags
		local flag = inBuffer:StringN8 ()
		while flag ~= "" do
			self:AddFlag (flag)
			flag = inBuffer:StringN8 ()
		end
		
		-- Detections
		local reasonArrayDetectionDeserializer = CAC.SerializerRegistry:GetDeserializer ("ReasonArrayDetection", 1)
		local detectionType = inBuffer:StringN8 ()
		while detectionType ~= "" do
			local detection = self:AddDetection (detectionType)
			if detection:Is (CAC.ReasonArrayDetection) then
				reasonArrayDetectionDeserializer (detection, inBuffer)
			else
				detection:Deserialize (inBuffer)
			end
			
			detectionType = inBuffer:StringN8 ()
		end
		
		return self
	end
)