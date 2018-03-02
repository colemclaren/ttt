CAC.SerializerRegistry:RegisterSerializer ("Settings", 1,
	function (self, outBuffer)
		return self:GetDetectionResponseSettings ():Serialize (outBuffer)
	end
)

CAC.SerializerRegistry:RegisterDeserializer ("Settings", 1,
	function (self, inBuffer)
		return self:GetDetectionResponseSettings ():Deserialize (inBuffer)
	end
)