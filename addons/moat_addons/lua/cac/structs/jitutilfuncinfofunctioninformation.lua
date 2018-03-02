-- This file is computer-generated.
local self = {}
CAC.JitUtilFuncInfoFunctionInformation = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function self:ctor ()
	self.Address                         = nil
	self.FFID                            = nil
	self.BytecodeCount                   = nil
	self.Children                        = nil
	self.CurrentLine                     = nil
	self.GarbageCollectableConstantCount = nil
	self.Variadic                        = nil
	self.LastLineDefined                 = nil
	self.LineDefined                     = nil
	self.Location                        = nil
	self.ConstantCount                   = nil
	self.FixedParameterCount             = nil
	self.Source                          = nil
	self.StackSize                       = nil
	self.UpvalueCount                    = nil
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:Boolean (self.Address ~= nil)
	if self.Address ~= nil then
		outBuffer:UInt32    (self.Address                        )
	end
	outBuffer:Boolean (self.FFID ~= nil)
	if self.FFID ~= nil then
		outBuffer:UInt16    (self.FFID                           )
	end
	outBuffer:Boolean (self.BytecodeCount ~= nil)
	if self.BytecodeCount ~= nil then
		outBuffer:UInt16    (self.BytecodeCount                  )
	end
	outBuffer:Boolean (self.Children ~= nil)
	if self.Children ~= nil then
		outBuffer:Boolean   (self.Children                       )
	end
	outBuffer:Boolean (self.CurrentLine ~= nil)
	if self.CurrentLine ~= nil then
		outBuffer:Int32     (self.CurrentLine                    )
	end
	outBuffer:Boolean (self.GarbageCollectableConstantCount ~= nil)
	if self.GarbageCollectableConstantCount ~= nil then
		outBuffer:UInt16    (self.GarbageCollectableConstantCount)
	end
	outBuffer:Boolean (self.Variadic ~= nil)
	if self.Variadic ~= nil then
		outBuffer:Boolean   (self.Variadic                       )
	end
	outBuffer:Boolean (self.LastLineDefined ~= nil)
	if self.LastLineDefined ~= nil then
		outBuffer:Int32     (self.LastLineDefined                )
	end
	outBuffer:Boolean (self.LineDefined ~= nil)
	if self.LineDefined ~= nil then
		outBuffer:Int32     (self.LineDefined                    )
	end
	outBuffer:Boolean (self.Location ~= nil)
	if self.Location ~= nil then
		outBuffer:StringN32 (self.Location                       )
	end
	outBuffer:Boolean (self.ConstantCount ~= nil)
	if self.ConstantCount ~= nil then
		outBuffer:UInt16    (self.ConstantCount                  )
	end
	outBuffer:Boolean (self.FixedParameterCount ~= nil)
	if self.FixedParameterCount ~= nil then
		outBuffer:UInt16    (self.FixedParameterCount            )
	end
	outBuffer:Boolean (self.Source ~= nil)
	if self.Source ~= nil then
		outBuffer:StringN32 (self.Source                         )
	end
	outBuffer:Boolean (self.StackSize ~= nil)
	if self.StackSize ~= nil then
		outBuffer:UInt16    (self.StackSize                      )
	end
	outBuffer:UInt16    (self.UpvalueCount                   )
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	if inBuffer:Boolean () then
		self.Address                         = inBuffer:UInt32    ()
	else
		self.Address = nil
	end
	if inBuffer:Boolean () then
		self.FFID                            = inBuffer:UInt16    ()
	else
		self.FFID = nil
	end
	if inBuffer:Boolean () then
		self.BytecodeCount                   = inBuffer:UInt16    ()
	else
		self.BytecodeCount = nil
	end
	if inBuffer:Boolean () then
		self.Children                        = inBuffer:Boolean   ()
	else
		self.Children = nil
	end
	if inBuffer:Boolean () then
		self.CurrentLine                     = inBuffer:Int32     ()
	else
		self.CurrentLine = nil
	end
	if inBuffer:Boolean () then
		self.GarbageCollectableConstantCount = inBuffer:UInt16    ()
	else
		self.GarbageCollectableConstantCount = nil
	end
	if inBuffer:Boolean () then
		self.Variadic                        = inBuffer:Boolean   ()
	else
		self.Variadic = nil
	end
	if inBuffer:Boolean () then
		self.LastLineDefined                 = inBuffer:Int32     ()
	else
		self.LastLineDefined = nil
	end
	if inBuffer:Boolean () then
		self.LineDefined                     = inBuffer:Int32     ()
	else
		self.LineDefined = nil
	end
	if inBuffer:Boolean () then
		self.Location                        = inBuffer:StringN32 ()
	else
		self.Location = nil
	end
	if inBuffer:Boolean () then
		self.ConstantCount                   = inBuffer:UInt16    ()
	else
		self.ConstantCount = nil
	end
	if inBuffer:Boolean () then
		self.FixedParameterCount             = inBuffer:UInt16    ()
	else
		self.FixedParameterCount = nil
	end
	if inBuffer:Boolean () then
		self.Source                          = inBuffer:StringN32 ()
	else
		self.Source = nil
	end
	if inBuffer:Boolean () then
		self.StackSize                       = inBuffer:UInt16    ()
	else
		self.StackSize = nil
	end
	self.UpvalueCount                    = inBuffer:UInt16    ()
	
	return self
end

-- JitUtilFuncInfoFunctionInformation
function self:GetAddress ()
	return self.Address
end

function self:GetFFID ()
	return self.FFID
end

function self:GetBytecodeCount ()
	return self.BytecodeCount
end

function self:GetChildren ()
	return self.Children
end

function self:GetCurrentLine ()
	return self.CurrentLine
end

function self:GetGarbageCollectableConstantCount ()
	return self.GarbageCollectableConstantCount
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

function self:GetLocation ()
	return self.Location
end

function self:GetConstantCount ()
	return self.ConstantCount
end

function self:GetFixedParameterCount ()
	return self.FixedParameterCount
end

function self:GetSource ()
	return self.Source
end

function self:GetStackSize ()
	return self.StackSize
end

function self:GetUpvalueCount ()
	return self.UpvalueCount
end

function self:SetAddress (address)
	self.Address = address
	return self
end

function self:SetFFID (fFID)
	self.FFID = fFID
	return self
end

function self:SetBytecodeCount (bytecodeCount)
	self.BytecodeCount = bytecodeCount
	return self
end

function self:SetChildren (children)
	self.Children = children
	return self
end

function self:SetCurrentLine (currentLine)
	self.CurrentLine = currentLine
	return self
end

function self:SetGarbageCollectableConstantCount (garbageCollectableConstantCount)
	self.GarbageCollectableConstantCount = garbageCollectableConstantCount
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

function self:SetLocation (location)
	self.Location = location
	return self
end

function self:SetConstantCount (constantCount)
	self.ConstantCount = constantCount
	return self
end

function self:SetFixedParameterCount (fixedParameterCount)
	self.FixedParameterCount = fixedParameterCount
	return self
end

function self:SetSource (source)
	self.Source = source
	return self
end

function self:SetStackSize (stackSize)
	self.StackSize = stackSize
	return self
end

function self:SetUpvalueCount (upvalueCount)
	self.UpvalueCount = upvalueCount
	return self
end

