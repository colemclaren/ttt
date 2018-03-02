CAC.SerializerRegistry:RegisterSerializer ("ReasonArrayDetection", 2,
	function (self, outBuffer)
		return self:Serialize (outBuffer)
	end
)

CAC.SerializerRegistry:RegisterDeserializer ("ReasonArrayDetection", 2,
	function (self, inBuffer)
		return self:Deserialize (inBuffer)
	end
)