CAC.SerializerRegistry:RegisterSerializer ("ReasonArrayDetection", 1,
	function (self, outBuffer)
		outBuffer:UInt32 (self:GetReasonCount ())
		
		for reason in self:GetReasonEnumerator () do
			outBuffer:StringN16 (reason)
		end
	end
)

CAC.SerializerRegistry:RegisterDeserializer ("ReasonArrayDetection", 1,
	function (self, inBuffer)
		self:SuppressChangedEvent (true)
		
		self:ClearReasons ()
		
		local reasonCount = inBuffer:UInt32 ()
		for i = 1, reasonCount do
			self:AddReason (inBuffer:StringN16 ())
		end
		
		self:SuppressChangedEvent (false)
	end
)