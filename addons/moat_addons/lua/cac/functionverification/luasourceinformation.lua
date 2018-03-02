local self = {}
CAC.LuaSourceInformation = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

local CAC_FunctionVerificationResult_Verified        = CAC.FunctionVerificationResult.Verified
local CAC_FunctionVerificationResult_ForeignHash     = CAC.FunctionVerificationResult.ForeignHash
local CAC_FunctionVerificationResult_ForeignLineSpan = CAC.FunctionVerificationResult.ForeignLineSpan

function CAC.DumpToFunctionInformationArray (dump)
	local inBuffer = CAC.StringInBuffer (dump)
	
	-- Header
	inBuffer:Bytes (4) -- Signature
	inBuffer:UInt8 ()  -- Flags
	
	inBuffer:Bytes (inBuffer:ULEB128 ()) -- Source
	
	-- Functions
	local functionInformationArray = {}
	local functionDataLength = inBuffer:ULEB128 ()
	while functionDataLength ~= 0 do
		local functionData = inBuffer:Bytes (functionDataLength)
		local functionInformation = CAC.LuaFunctionInformation.FromDump (functionData)
		functionInformationArray [#functionInformationArray + 1] = functionInformation
		
		functionDataLength = inBuffer:ULEB128 ()
	end
	
	return functionInformationArray
end

function self:ctor (sourceId)
	self.SourceId        = sourceId
	
	self.Functions       = {}
	self.FunctionsByHash = {} -- This is collision-heavy
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt32 (#self.Functions)
	for i = 1, #self.Functions do
		self.Functions [i]:Serialize (outBuffer)
	end
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	local functionCount = inBuffer:UInt32 ()
	for i = 1, functionCount do
		local functionInformation = CAC.LuaFunctionInformation ()
		functionInformation:SetSourceInformation (self)
		functionInformation:Deserialize (inBuffer)
		
		self.Functions [#self.Functions + 1] = functionInformation
		self.FunctionsByHash [functionInformation:GetHash ()] = functionInformation
	end
	
	return self
end

function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self.SourceId = source:GetSourceId ()
	
	self:ClearFunctions ()
	for functionInformation in source:GetFunctionEnumerator () do
		local functionInformation = functionInformation:Clone ()
		functionInformation:SetSourceInformation (self)
		
		self:AddFunction (functionInformation)
	end
	
	return self
end

function self:Import (sourceInformation)
	for functionInformation in sourceInformation:GetFunctionEnumerator () do
		local functionInformation = functionInformation:Clone ()
		functionInformation:SetSourceInformation (self)
		
		self:AddFunction (functionInformation)
	end
end

-- LuaSourceInformation
function self:AddCode (code)
	local f = CompileString (code, self:GetSourceId (), false)
	if isfunction (f) then
		self:AddDump (string.dump (f))
		return true
	else
		return false, f or ""
	end
end

function self:AddDump (dump)
	self:AddFunctions (CAC.DumpToFunctionInformationArray (dump))
end

function self:AddFunction (functionInformation, createCopy)
	createCopy = createCopy or false
	
	local hash = functionInformation:GetHash ()
	
	if self.FunctionsByHash [hash] then
		-- Avoid duplicates
		if self.FunctionsByHash [hash]:MatchesFunctionInformation (functionInformation) then return end
	end
	
	if createCopy then
		functionInformation = functionInformation:Clone ()
	end
	
	self.Functions [#self.Functions + 1] = functionInformation
	self.FunctionsByHash [hash] = functionInformation
	functionInformation:SetSourceInformation (self)
end

function self:AddFunctions (functionInformationArray, createCopy)
	for i = 1, #functionInformationArray do
		self:AddFunction (functionInformationArray [i], createCopy)
	end
end

function self:ClearFunctions ()
	self.Functions       = {}
	self.FunctionsByHash = {}
end

function self:FunctionExists (functionVerificationInformation)
	local functionVerificationResult = self:VerifyFunction (functionVerificationInformation)
	return functionVerificationResult == CAC_FunctionVerificationResult_Verified
end

function self:FunctionHashExists (functionVerificationInformation)
	local functionVerificationResult = self:VerifyFunctionHash (functionVerificationInformation)
	return functionVerificationResult == CAC_FunctionVerificationResult_Verified
end

function self:GetSourceId ()
	return self.SourceId
end

function self:GetFunctionByHash (hash)
	return self.FunctionsByHash (hash)
end

function self:GetFunctionCount ()
	return #self.Functions
end

function self:GetFunctionEnumerator ()
	return CAC.ArrayEnumerator (self.Functions)
end

function self:SetSourceId (sourceId)
	self.SourceId = sourceId
	return self
end

function self:VerifyFunction (functionVerificationInformation)
	if not self.FunctionsByHash [functionVerificationInformation:GetBytecodeHash ()] then
		return CAC_FunctionVerificationResult_ForeignHash
	end
	
	-- 2015-07-21 Killed line span checks because they are redundant.
	-- for functionInformation in self:GetFunctionEnumerator () do
	-- 	if functionInformation:MatchesFunctionVerificationInformation (functionVerificationInformation) then
	-- 		return CAC_FunctionVerificationResult_Verified
	-- 	end
	-- end
	-- 
	-- return CAC_FunctionVerificationResult_ForeignLineSpan
	
	return CAC_FunctionVerificationResult_Verified
end

function self:VerifyFunctionHash (functionVerificationInformation)
	local hash = functionVerificationInformation
	if type (functionVerificationInformation) ~= "number" then
		hash = functionVerificationInformation:GetBytecodeHash ()
	end
	
	return self.FunctionsByHash [hash] and CAC_FunctionVerificationResult_Verified or CAC_FunctionVerificationResult_ForeignHash
end
