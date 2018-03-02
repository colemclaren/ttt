local self = {}
CAC.LuaInformation = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

local CAC_FunctionVerificationResult_Verified      = CAC.FunctionVerificationResult.Verified
local CAC_FunctionVerificationResult_ForeignSource = CAC.FunctionVerificationResult.ForeignSource

function self:ctor (logger)
	self.Logger                   = logger or CAC.Logger
	
	self.LuaSourceInformation     = CAC.LuaSourceInformation
	
	self.SourceList               = {}
	self.SourceListValid          = true
	self.SourceInformation        = {}
	
	self.FunctionCount            = 0
	self.UniqueFunctionHashCount  = 0
	self.FunctionsByHash          = {} -- This is collision-heavy
	self.FunctionInformationValid = true
end

-- ISerializable
function self:Serialize (outBuffer)
	local sourceList = self:GetSourceList ()
	outBuffer:UInt32 (#sourceList)
	for i = 1, #sourceList do
		local sourceInformation = self.SourceInformation [string.lower (sourceList [i])]
		outBuffer:StringN16 (sourceInformation:GetSourceId ())
		sourceInformation:Serialize (outBuffer)
	end
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	local sourceCount = inBuffer:UInt32 ()
	for i = 1, sourceCount do
		local sourceId          = inBuffer:StringN16 ()
		local sourceInformation = self:AddSource (sourceId)
		
		sourceInformation:Deserialize (inBuffer)
	end
	
	self:InvalidateSourceList ()
	self:InvalidateFunctionInformation ()
	
	return self
end

-- LuaInformation
function self:Import (luaInformation)
	for sourceInformation in luaInformation:GetSourceEnumerator () do
		if self.SourceInformation [string.lower (sourceInformation:GetSourceId ())] then
			self.SourceInformation [string.lower (sourceInformation:GetSourceId ())]:Import (sourceInformation)
		else
			local sourceInformation = sourceInformation:Clone ()
			self.SourceInformation [string.lower (sourceInformation:GetSourceId ())] = sourceInformation
		end
	end
	
	self:InvalidateSourceList ()
	self:InvalidateFunctionInformation ()
end

-- LuaInformation
function self:Clear ()
	self.SourceList               = {}
	self.SourceListValid          = true
	self.SourceInformation        = {}
	
	self.FunctionCount            = 0
	self.UniqueFunctionHashCount  = 0
	self.FunctionsByHash          = {} -- This is collision-heavy
	self.FunctionInformationValid = true
end

function self:AddCode (sourceId, code)
	if not code then return end
	
	local sourceInformation = self:AddSource (sourceId)
	sourceInformation:AddCode (code)
end

function self:AddDump (sourceId, dump)
	if not dump then return end
	
	local sourceInformation = self:AddSource (sourceId)
	sourceInformation:AddDump (dump)
end

function self:AddFunction (sourceId, functionInformation, createCopy)
	if not functionInformation then return end
	
	local sourceInformation = self:AddSource (sourceId)
	sourceInformation:AddFunction (functionInformation, createCopy)
end

function self:AddFunctions (sourceId, functionInformationArray, createCopy)
	if not functionInformationArray then return end
	
	local sourceInformation = self:AddSource (sourceId)
	sourceInformation:AddFunctions (functionInformationArray, createCopy)
end

function self:NormalizeSourceId (sourceId)
	sourceId = string.gsub (sourceId, "[\\/]+", "/")
	
	local folders = string.Split (sourceId, "/")
	if folders [1] == "gamemodes" then
		-- skip "gamemodes"
		sourceId = table.concat (folders, "/", 2)
	elseif folders [1] == "addons" then
		-- skip "addons", addon directory name, "lua"
		sourceId = table.concat (folders, "/", 4)
	elseif folders [1] == "workshop" then
		-- skip "workshop", "lua"
		sourceId = table.concat (folders, "/", 3)
	elseif folders [1] == "lua" then
		-- skip "lua"
		sourceId = table.concat (folders, "/", 2)
	end
	
	return sourceId
end

if Profiler then
	self.NormalizeSourceId = GCAD.Profiler:Wrap (self.NormalizeSourceId, "LuaInformation:NormalizeSourceId")
end

-- Sources
function self:AddSource (sourceId)
	if self.SourceInformation [string.lower (sourceId)] then
		return self.SourceInformation [string.lower (sourceId)]
	end
	
	local sourceInformation = self.LuaSourceInformation (sourceId)
	self.SourceInformation [string.lower (sourceId)] = sourceInformation
	self:InvalidateSourceList ()
	
	return sourceInformation
end

function self:ClearSources ()
	self.SourceInformation = {}
	
	self:InvalidateSourceList ()
	self:InvalidateFunctionInformation ()
end

function self:ContainsSource (sourceId)
	return self.SourceInformation [string.lower (sourceId)] ~= nil
end

function self:GetSourceCount ()
	return #self:GetSourceList ()
end

function self:GetSourceEnumerator ()
	return CAC.ValueEnumerator (self.SourceInformation)
end

function self:GetSourceInformation (sourceId)
	return self.SourceInformation [string.lower (sourceId)]
end

function self:GetSourceList ()
	if not self.SourceListValid then
		self.SourceList = {}
		self.SourceListValid = true
		
		for sourceInformation in self:GetSourceEnumerator () do
			self.SourceList [#self.SourceList + 1] = sourceInformation:GetSourceId ()
		end
		
		table.sort (self.SourceList)
	end
	
	return self.SourceList
end

function self:RemoveSource (sourceId)
	if not self.SourceInformation [string.lower (sourceId)] then return end
	
	self.SourceInformation [string.lower (sourceId)] = nil
	self:InvalidateSourceList ()
end

-- Functions
function self:ContainsFunction (hash)
	if not self.FunctionInformationValid then
		self:BuildFunctionInformation ()
	end
	
	return self.FunctionsByHash [hash] ~= nil
end

function self:FunctionExists (functionVerificationInformation, lowercaseNormalizedPath)
	local functionVerificationResult = self:VerifyFunction (functionVerificationInformation, lowercaseNormalizedPath)
	return functionVerificationResult == CAC_FunctionVerificationResult_Verified
end

function self:GetFunctionByHash (hash)
	if not self.FunctionInformationValid then
		self:BuildFunctionInformation ()
	end
	
	return self.FunctionsByHash [hash]
end

function self:GetFunctionCount ()
	if not self.FunctionInformationValid then
		self:BuildFunctionInformation ()
	end
	
	return self.FunctionCount
end

function self:GetUniqueFunctionHashCount ()
	if not self.FunctionInformationValid then
		self:BuildFunctionInformation ()
	end
	
	return self.UniqueFunctionHashCount
end

function self:VerifyFunction (functionVerificationInformation, lowercaseNormalizedPath)
	if not lowercaseNormalizedPath then
		lowercaseNormalizedPath = functionVerificationInformation:GetPath ()
		lowercaseNormalizedPath = self:NormalizeSourceId (lowercaseNormalizedPath)
		lowercaseNormalizedPath = string.lower (lowercaseNormalizedPath)
	end
	
	local sourceInformation = self.SourceInformation [lowercaseNormalizedPath]
	if not sourceInformation then
		return CAC_FunctionVerificationResult_ForeignSource
	end
	
	return sourceInformation:VerifyFunction (functionVerificationInformation)
end

-- Internal, do not call
function self:InvalidateSourceList ()
	self.SourceListValid = false
end

function self:BuildFunctionInformation ()
	if self.FunctionInformationValid then return end
	
	self.FunctionInformationValid = true
	
	self.FunctionCount           = 0
	self.UniqueFunctionHashCount = 0
	self.FunctionsByHash         = {}
	
	for sourceInformation in self:GetSourceEnumerator () do
		for functionInformation in sourceInformation:GetFunctionEnumerator () do
			self.FunctionCount = self.FunctionCount + 1
			
			local hash = functionInformation:GetHash ()
			
			if self.FunctionsByHash [hash] then
				-- 	self.Logger:Message ("Hash collision between " .. self.FunctionsByHash [hash]:GetSourceInformation ():GetSourceId () .. ", " .. self.FunctionsByHash [hash]:ToString () .. " and " .. functionInformation:GetSourceInformation ():GetSourceId () .. ", " .. functionInformation:ToString () .. ")!")
			else
				self.UniqueFunctionHashCount = self.UniqueFunctionHashCount + 1
			end
			
			self.FunctionsByHash [hash] = functionInformation
		end
	end
end

function self:InvalidateFunctionInformation ()
	self.FunctionInformationValid = false
end