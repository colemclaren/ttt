local self = {}
CAC.DataRange = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function CAC.DataRange.FirstPage (itemsPerPage, dataRange)
	dataRange = dataRange or CAC.DataRange ()
	
	dataRange:SetAnchorId (math.huge)
	dataRange:SetSkipCount (0)
	dataRange:SetLimit (itemsPerPage)
	dataRange:SetIncludeAnchor (true)
	dataRange:SetDirection (CAC.PageDirection.Next)
	
	return dataRange
end

function CAC.DataRange.LastPage (itemsPerPage, dataRange)
	dataRange = dataRange or CAC.DataRange ()
	
	dataRange:SetAnchorId (-math.huge)
	dataRange:SetSkipCount (0)
	dataRange:SetLimit (itemsPerPage)
	dataRange:SetIncludeAnchor (true)
	dataRange:SetDirection (CAC.PageDirection.Previous)
	
	return dataRange
end

function CAC.DataRange.PreviousPage (anchorId, itemsPerPage, dataRange)
	dataRange = dataRange or CAC.DataRange ()
	
	dataRange:SetAnchorId (anchorId)
	dataRange:SetSkipCount (0)
	dataRange:SetLimit (itemsPerPage)
	dataRange:SetIncludeAnchor (false)
	dataRange:SetDirection (CAC.PageDirection.Previous)
	
	return dataRange
end

function CAC.DataRange.NextPage (anchorId, itemsPerPage, dataRange)
	dataRange = dataRange or CAC.DataRange ()
	
	dataRange:SetAnchorId (anchorId)
	dataRange:SetSkipCount (0)
	dataRange:SetLimit (itemsPerPage)
	dataRange:SetIncludeAnchor (false)
	dataRange:SetDirection (CAC.PageDirection.Next)
	
	return dataRange
end

function self:ctor ()
	self.AnchorId      = 0
	self.SkipCount     = 0
	self.Limit         = 0
	self.IncludeAnchor = false
	self.Direction     = CAC.PageDirection.Next
end

-- ISerializable
function self:Serialize (outBuffer)
	self:SerializeAnchorId (outBuffer)
	
	outBuffer:UInt32  (self.SkipCount    )
	outBuffer:UInt32  (self.Limit        )
	outBuffer:Boolean (self.IncludeAnchor)
	outBuffer:UInt8   (self.Direction    )
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:DeserializeAnchorId (inBuffer)
	
	self.SkipCount     = inBuffer:UInt32  ()
	self.Limit         = inBuffer:UInt32  ()
	self.IncludeAnchor = inBuffer:Boolean ()
	self.Direction     = inBuffer:UInt8   ()
	
	return self
end

-- DataRange
function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:SetAnchorId      (source:GetAnchorId      ())
	self:SetSkipCount     (source:GetSkipCount     ())
	self:SetLimit         (source:GetLimit         ())
	self:SetIncludeAnchor (source:GetIncludeAnchor ())
	self:SetDirection     (source:GetDirection     ())
	
	return self
end

function self:GetAnchorId ()
	return self.AnchorId
end

function self:GetSkipCount ()
	return self.SkipCount
end

function self:GetLimit ()
	return self.Limit
end

function self:GetIncludeAnchor ()
	return self.IncludeAnchor
end

function self:GetDirection ()
	return self.Direction
end

function self:SetAnchorId (anchorId)
	self.AnchorId = anchorId
	return self
end

function self:SetSkipCount (skipCount)
	self.SkipCount = skipCount
	return self
end

function self:SetLimit (limit)
	self.Limit = limit
	return self
end

function self:SetIncludeAnchor (includeAnchor)
	self.IncludeAnchor = includeAnchor
	return self
end

function self:SetDirection (direction)
	self.Direction = direction
	return self
end

function self:MovePrevious (n)
	n = n or self.Limit
	
	-- Move to higher IDs
	if self.Direction == CAC.PageDirection.Previous then
		self.SkipCount = self.SkipCount + n
	elseif self.Direction == CAC.PageDirection.Next then
		self.SkipCount = self.SkipCount - n
		self:Normalize ()
	end
	
	return self
end

function self:MovePreviousPage (n)
	n = n or 1
	return self:MovePrevious (self.Limit * n)
end

function self:MoveNext (n)
	n = n or self.Limit
	
	-- Move to higher IDs
	if self.Direction == CAC.PageDirection.Next then
		self.SkipCount = self.SkipCount + n
	elseif self.Direction == CAC.PageDirection.Previous then
		self.SkipCount = self.SkipCount - n
		self:Normalize ()
	end
	
	return self
end

function self:MoveNextPage (n)
	n = n or 1
	return self:MoveNext (self.Limit * n)
end

function self:CanNormalize ()
	if self.SkipCount >= 0 then return true end
	
	return -self.SkipCount - self.Limit >= 0
end

function self:Normalize ()
	if self.SkipCount >= 0 then return true end
	
	-- Oh balls.
	self.IncludeAnchor = not self.IncludeAnchor
	self.Direction     = self.Direction == CAC.PageDirection.Previous and CAC.PageDirection.Next or CAC.PageDirection.Previous
	
	self.SkipCount = -self.SkipCount - self.Limit
	
	if self.SkipCount < 0 then
		-- You can't win.
		return false
	end
	
	return true
end

function self:NormalizeSplit ()
	if self:Normalize () then return self, nil end
	
	local other = self:Clone ()
	other.IncludeAnchor = not other.IncludeAnchor
	other.Direction     = other.Direction == CAC.PageDirection.Previous and CAC.PageDirection.Next or CAC.PageDirection.Previous
	other.SkipCount     = 0
	other.Limit         = -self.SkipCount
	
	self.Limit = self.Limit + self.SkipCount
	self.SkipCount = 0
	
	return self, other
end

function self:SerializeAnchorId (outBuffer)
	outBuffer:Double (self.AnchorId)
	
	return outBuffer
end

function self:DeserializeAnchorId (inBuffer)
	self.AnchorId = inBuffer:Double ()
	
	return self
end