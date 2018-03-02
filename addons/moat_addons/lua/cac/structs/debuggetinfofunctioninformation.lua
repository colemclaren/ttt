-- This file is computer-generated.
local self = {}
CAC.DebugGetInfoFunctionInformation = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function self:ctor ()
	self.CurrentLine         = nil
	self.Variadic            = nil
	self.LastLineDefined     = nil
	self.LineDefined         = nil
	self.NameWhat            = nil
	self.FixedParameterCount = nil
	self.UpvalueCount        = nil
	self.ShortSource         = nil
	self.Source              = nil
	self.What                = nil
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:Int32     (self.CurrentLine        )
	outBuffer:Boolean   (self.Variadic           )
	outBuffer:Int32     (self.LastLineDefined    )
	outBuffer:Int32     (self.LineDefined        )
	outBuffer:StringN8  (self.NameWhat           )
	outBuffer:UInt16    (self.FixedParameterCount)
	outBuffer:UInt16    (self.UpvalueCount       )
	outBuffer:StringN32 (self.ShortSource        )
	outBuffer:StringN32 (self.Source             )
	outBuffer:StringN8  (self.What               )
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self.CurrentLine         = inBuffer:Int32     ()
	self.Variadic            = inBuffer:Boolean   ()
	self.LastLineDefined     = inBuffer:Int32     ()
	self.LineDefined         = inBuffer:Int32     ()
	self.NameWhat            = inBuffer:StringN8  ()
	self.FixedParameterCount = inBuffer:UInt16    ()
	self.UpvalueCount        = inBuffer:UInt16    ()
	self.ShortSource         = inBuffer:StringN32 ()
	self.Source              = inBuffer:StringN32 ()
	self.What                = inBuffer:StringN8  ()
	
	return self
end

-- DebugGetInfoFunctionInformation
function self:GetCurrentLine ()
	return self.CurrentLine
end

function self:GetVariadic ()
	return self.Variadic
end

function self:GetLastLineDefined ()
	return self.LastLineDefined
end

function self:GetLineDefined ()
	return self.LineDefined
end

function self:GetNameWhat ()
	return self.NameWhat
end

function self:GetFixedParameterCount ()
	return self.FixedParameterCount
end

function self:GetUpvalueCount ()
	return self.UpvalueCount
end

function self:GetShortSource ()
	return self.ShortSource
end

function self:GetSource ()
	return self.Source
end

function self:GetWhat ()
	return self.What
end

function self:SetCurrentLine (currentLine)
	self.CurrentLine = currentLine
	return self
end

function self:SetVariadic (variadic)
	self.Variadic = variadic
	return self
end

function self:SetLastLineDefined (lastLineDefined)
	self.LastLineDefined = lastLineDefined
	return self
end

function self:SetLineDefined (lineDefined)
	self.LineDefined = lineDefined
	return self
end

function self:SetNameWhat (nameWhat)
	self.NameWhat = nameWhat
	return self
end

function self:SetFixedParameterCount (fixedParameterCount)
	self.FixedParameterCount = fixedParameterCount
	return self
end

function self:SetUpvalueCount (upvalueCount)
	self.UpvalueCount = upvalueCount
	return self
end

function self:SetShortSource (shortSource)
	self.ShortSource = shortSource
	return self
end

function self:SetSource (source)
	self.Source = source
	return self
end

function self:SetWhat (what)
	self.What = what
	return self
end

