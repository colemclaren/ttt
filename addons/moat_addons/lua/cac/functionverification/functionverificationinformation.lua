local self = {}
CAC.FunctionVerificationInformation = CAC.MakeConstructor (self, CAC.FunctionVerificationInformation)

function CAC.FunctionVerificationInformation.FromFunction (f, functionVerificationInformation)
	functionVerificationInformation = functionVerificationInformation or CAC.FunctionVerificationInformation ()
	
	local jitUtilFuncInfoFunctionInformation = CAC.JitUtilFuncInfoFunctionInformation.FromFunction (f)
	
	functionVerificationInformation:SetNative              (jitUtilFuncInfoFunctionInformation:GetAddress () ~= nil)
	functionVerificationInformation:SetAddress             (tonumber (string.format ("%p", f)))
	
	if not functionVerificationInformation:GetNative () then
		local path = string.gsub (jitUtilFuncInfoFunctionInformation:GetSource (), "^@", "")
		path = string.gsub (path, "[\\/]+", "/")
		
		functionVerificationInformation:SetPath                (path)
		functionVerificationInformation:SetDefinitionStartLine (jitUtilFuncInfoFunctionInformation:GetLineDefined ())
		functionVerificationInformation:SetDefinitionEndLine   (jitUtilFuncInfoFunctionInformation:GetLastLineDefined ())
		
		local bytecodeHash = CAC.CalculateBytecodeHashFromFunction (f, jitUtilFuncInfoFunctionInformation:GetBytecodeCount ())
		functionVerificationInformation:SetBytecodeHash        (bytecodeHash)
	end
	
	return functionVerificationInformation
end

function self:ctor ()
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:Boolean   (self.Native             )
	outBuffer:UInt32    (self.Address            )
	
	if not self.Native then
		outBuffer:StringN32 (self.Path               )
		outBuffer:Int32     (self.DefinitionStartLine)
		outBuffer:Int32     (self.DefinitionEndLine  )
		outBuffer:UInt32    (self.BytecodeHash       )
	end
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self.Native              = inBuffer:Boolean   ()
	self.Address             = inBuffer:UInt32    ()
	
	if not self.Native then
		self.Path                = inBuffer:StringN32 ()
		self.DefinitionStartLine = inBuffer:Int32     ()
		self.DefinitionEndLine   = inBuffer:Int32     ()
		self.BytecodeHash        = inBuffer:UInt32    ()
	else
		self.Path                = nil
		self.DefinitionStartLine = nil
		self.DefinitionEndLine   = nil
		self.BytecodeHash        = nil
	end
	
	return self
end

-- FunctionVerificationInformation
function self:FormatVerificationResult (functionVerificationResult)
	if functionVerificationResult == CAC.FunctionVerificationResult.Verified then
		return "Found lua function match for " .. self:ToString ()
	elseif functionVerificationResult == CAC.FunctionVerificationResult.ForeignSource then
		return "Foreign lua source: " .. self:ToString ()
	elseif functionVerificationResult == CAC.FunctionVerificationResult.ForeignHash then
		return "Foreign lua function hash: " .. self:ToString ()
	elseif functionVerificationResult == CAC.FunctionVerificationResult.ForeignLineSpan then
		return "Foreign lua function line span: " .. self:ToString ()
	end
	
	return "Foreign lua function: " .. self:ToString ()
end

function self:ToString ()
	if self.Native then return string.format ("Native [C]: %08x", self.Address) end
	return string.format ("%s: %08x, %08x, lines %4d-%4d", CAC.String.EscapeNonprintable (self.Path), self.BytecodeHash, self.Address, self.DefinitionStartLine, self.DefinitionEndLine)
end

if Profiler then
	self.ToString = Profiler:Wrap (self.ToString, "FunctionVerificationInformation:ToString")
end
