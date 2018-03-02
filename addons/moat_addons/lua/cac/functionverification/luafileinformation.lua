local self = {}
CAC.LuaFileInformation = CAC.MakeConstructor (self, CAC.LuaSourceInformation)

function self:ctor (path, pathId)
	self.Path            = path
	self.PathId          = pathId or "LUA"
	
	self.Timestamp       = 0
	self.Size            = 0
	
	self.UseWeakMatching = false
	
	self.LastUpdateTime  = 0
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt32    (self.Timestamp)
	outBuffer:UInt64    (self.Size     )
	
	outBuffer:Boolean   (self.UseWeakMatching)
	
	outBuffer:UInt32 (#self.Functions)
	for i = 1, #self.Functions do
		self.Functions [i]:Serialize (outBuffer)
	end
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self.Timestamp       = inBuffer:UInt32 ()
	self.Size            = inBuffer:UInt64 ()
	
	self.UseWeakMatching = inBuffer:Boolean ()
	
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
	
	self.Path           = source:GetPath           ()
	self.PathId         = source:GetPathId         ()
	self.Timestamp      = source:GetTimestamp      ()
	self.Size           = source:GetSize           ()
	self.LastUpdateTime = source:GetLastUpdateTime ()
	
	return self
end

-- LuaFileInformation
function self:GetLastUpdateTime ()
	return self.LastUpdateTime
end

function self:GetPath ()
	return self.Path
end

function self:GetPathId ()
	return self.PathId
end

function self:GetTimestamp ()
	return self.Timestamp
end

function self:GetSize ()
	return self.Size
end

function self:SetPath (path)
	self.Path = path
	self:SetSourceId (self.Path)
	return self
end

function self:ShouldUseWeakMatching ()
	return self.UseWeakMatching
end

function self:SetUseWeakMatching (useWeakMatching)
	if self.UseWeakMatching == useWeakMatching then return self end
	
	self.UseWeakMatching = useWeakMatching
	
	return self
end

function self:IsOutdated ()
	return file.Time (self.Path, self.PathId) ~= self.Timestamp or
	       file.Size (self.Path, self.PathId) ~= self.Size
end

function self:Update (updateType, logger)
	logger = logger or CAC.Logger
	
	self.LastUpdateTime = SysTime ()
	
	if not self:IsOutdated () then return end
	
	self.Timestamp = file.Time (self.Path, self.PathId) or 0
	self.Size      = file.Size (self.Path, self.PathId)
	
	if self.Size and
	   self.Size > 16 * 1024 * 1024 then
		logger:Message ("WARNING: Improbably large lua file " .. self.Path .. " (" .. CAC.FormatFileSize (self.Size) .. ")!")
	end
	
	local attemptCompileAnyway = false
	if self.Size == nil then
		attemptCompileAnyway = true
		self.Size = 0
		self:SetUseWeakMatching (true)
		
		logger:Message ("WARNING: Cannot get file information for " .. self.Path .. ", using weak verification!")
	else
		-- Check for C-style multiline comments
		local success, code = pcall (file.Read, self.Path, self.PathId)
		local useWeakMatching = false
		
		if not success then
			logger:Message ("WARNING: Failed to read file " .. self.Path .. "!")
		end
		
		if code then
			if isfunction (CompileString (code .. "*/", self.Path, false)) then
				-- Unterminated C-style multiline comment, which Garry's Mod accepts
				-- for some reason
				code = code .. "*/"
			end
			
			for comment in string.gmatch (code, "/%*.-%*/") do
				if string.find (comment, "\r\r", 1, true) or
				   string.find (comment, "\n\n", 1, true) or
				   string.find (comment, "\n\r", 1, true) then
					useWeakMatching = true
					break
				end
			end
			
			if useWeakMatching then
				logger:Message ("WARNING: Using weak verification for " .. self.Path .. " due to C-style multiline comments (/* */)!")
			end
		else
			useWeakMatching = true
			logger:Message ("WARNING: Using weak verification for " .. self.Path .. " since it can't be read to confirm absence of C-style multiline comments!")
		end
		
		if useWeakMatching then
			self:SetUseWeakMatching (true)
		end
	end
	
	if updateType == CAC.UpdateType.Overwrite then
		self:ClearFunctions ()
	end
	
	if attemptCompileAnyway or
	   self.Size > 0 then
		local code = CompileFile (self.Path)
		
		-- Linux (wtf?)
		if not code and string.lower (self.Path) ~= self.Path then
			code = CompileFile (string.lower (self.Path))
		end
		
		if not code then
			logger:Message ("Failed to compile " .. self.Path .. "!")
			return
		end
		
		self:AddDump (string.dump (code))
	end
end

-- LuaFileInformation
function self:GetLastUpdateTime ()
	return self.LastUpdateTime
end