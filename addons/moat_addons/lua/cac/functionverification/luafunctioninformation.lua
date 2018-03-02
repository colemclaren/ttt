local self = {}
CAC.LuaFunctionInformation = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function CAC.LuaFunctionInformation.FromDump (dump, functionInformation)
	functionInformation = functionInformation or CAC.LuaFunctionInformation ()
	
	local inBuffer = CAC.StringInBuffer (dump)
	
	inBuffer:UInt8   () -- Flags
	inBuffer:UInt8   () -- Fixed parameter count
	inBuffer:UInt8   () -- Frame size
	inBuffer:UInt8   () -- Upvalue count
	inBuffer:ULEB128 () -- Garbage collected constant count
	inBuffer:ULEB128 () -- Numeric constant count
	local instructionCount = inBuffer:ULEB128 () -- Instruction count
	
	inBuffer:ULEB128 () -- Debug data length
	
	functionInformation.StartLine = inBuffer:ULEB128 ()
	local lineCount = inBuffer:ULEB128 ()
	functionInformation.EndLine   = functionInformation.StartLine + lineCount
	functionInformation.Hash      = CAC.CalculateBytecodeHashFromBytecodeDump (inBuffer, instructionCount)
	
	return functionInformation
end

function CAC.LuaFunctionInformation.FromFunction (f, functionInformation)
	functionInformation = functionInformation or CAC.LuaFunctionInformation ()
	
	local debugInfo = debug.getinfo (f)
	functionInformation.StartLine = debugInfo.linedefined
	functionInformation.EndLine   = debugInfo.lastlinedefined
	functionInformation.Hash      = CAC.CalculateBytecodeHashFromFunction (f, jit.util.funcinfo (f).bytecodes)
	
	return functionInformation
end

function CAC.LuaFunctionInformation.FromFunctionVerificationInformation (functionVerificationInformation, functionInformation)
	functionInformation = functionInformation or CAC.LuaFunctionInformation ()
	
	functionInformation.Hash      = functionVerificationInformation:GetBytecodeHash ()
	functionInformation.StartLine = functionVerificationInformation:GetDefinitionStartLine ()
	functionInformation.EndLine   = functionVerificationInformation:GetDefinitionEndLine ()
	
	return functionInformation
end

function self:ctor ()
	self.SourceInformation = nil
	
	self.Hash              = 0
	self.StartLine         = 0
	self.EndLine           = 0
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt32 (self.Hash     )
	outBuffer:UInt32 (self.StartLine)
	outBuffer:UInt32 (self.EndLine  )
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self.Hash      = inBuffer:UInt32 ()
	self.StartLine = inBuffer:UInt32 ()
	self.EndLine   = inBuffer:UInt32 ()
	
	return self
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:SetSourceInformation (source:GetSourceInformation ())
	
	self.Hash      = source:GetHash      ()
	self.StartLine = source:GetStartLine ()
	self.EndLine   = source:GetEndLine   ()
	
	return self
end

-- LuaFunctionInformation
function self:GetSourceInformation ()
	return self.SourceInformation
end

function self:MatchesFunctionInformation (functionInformation)
	return self.Hash      == functionInformation:GetHash () and
	       self.StartLine == functionInformation:GetStartLine () and
		   self.EndLine   == functionInformation:GetEndLine ()
end

function self:MatchesFunctionVerificationInformation (functionVerificationInformation)
	return self.Hash      == functionVerificationInformation:GetBytecodeHash () and
	       self.StartLine == functionVerificationInformation:GetDefinitionStartLine () and
		   self.EndLine   == functionVerificationInformation:GetDefinitionEndLine ()
end

function self:SetSourceInformation (sourceInformation)
	self.SourceInformation = sourceInformation
end

function self:GetHash ()
	return self.Hash
end

function self:GetStartLine ()
	return self.StartLine
end

function self:GetEndLine ()
	return self.EndLine
end

function self:GetLineRange ()
	return self.StartLine, self.EndLine
end

function self:SetHash (hash)
	self.Hash = hash
	return self
end

function self:SetStartLine (startLine)
	self.StartLine = startLine
	return self
end

function self:SetEndLine (endLine)
	self.EndLine = endLine
	return self
end

function self:SetLineRange (startLine, endLine)
	self.StartLine = startLine
	self.EndLine   = endLine
	return self
end

function self:ToString ()
	return string.format ("function %08x, %3d-%3d", self.Hash, self.StartLine, self.EndLine)
end