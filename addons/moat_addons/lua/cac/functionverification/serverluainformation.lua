local self = {}
CAC.ServerLuaInformation = CAC.MakeConstructor (self, CAC.LuaInformation)

--[[
	Events:
		LastLiveUpdateTimeChanged (lastLiveUpdateTime)
			Fired when this ServerLuaInformation's last live update time has changed.
]]

local CAC_FunctionVerificationResult_Verified      = CAC.FunctionVerificationResult.Verified
local CAC_FunctionVerificationResult_ForeignSource = CAC.FunctionVerificationResult.ForeignSource

function self:ctor (logger)
	self.LuaSourceInformation     = function (sourceId)
		return CAC.LuaFileInformation (sourceId, self.PathId)
	end
	
	self.PathId                   = SERVER and "LUA" or "LCL"
	
	self.LastCreationCheckTimes   = {}
	
	CAC.EventProvider (self)
end

-- Functions
function self:FunctionExists (functionVerificationInformation, lowercaseNormalizedPath)
	local functionVerificationResult = self:VerifyFunction (functionVerificationInformation, lowercaseNormalizedPath)
	return functionVerificationResult == CAC_FunctionVerificationResult_Verified
end

function self:GetPathId ()
	return self.PathId
end

function self:UpdateFile (path, updateType)
	if not self.SourceInformation [string.lower (path)] then return end
	
	self.SourceInformation [string.lower (path)]:Update (updateType, self.Logger)
end

function self:UpdateIncremental ()
	local function EnumerateFolder (folder, pathId, callback, recursive)
		if not callback then return end
		
		if #folder > 0 then folder = folder .. "/" end
		local files, folders = file.Find (folder .. "*", pathId)
		
		if not files and not folders then
			self.Logger:Message ("WARNING: Could not add " .. folder .. " to lua information.")
			return
		end
		
		for _, fileName in pairs (files) do
			callback (folder .. fileName, pathId)
		end
		if recursive then
			for _, childFolder in pairs (folders) do
				if childFolder ~= "." and childFolder ~= ".." then
					EnumerateFolder (folder .. childFolder, pathId, callback, recursive)
				end
			end
		end
	end
	
	-- Generate list of lua files
	self.Logger:Message ("Scanning lua files for changes...")
	local fileSet   = {}
	local fileCount = 0
	
	EnumerateFolder ("", self.PathId,
		function (path)
			if string.lower (string.sub (path, -4)) ~= ".lua" then return end
			-- if string.find (path, "^entities/gmod_wire_expression2/core/") then return end
			
			fileSet [path] = true
			fileCount = fileCount + 1
		end,
		true
	)
	
	self.Logger:Message (string.format ("%4d lua file%s found.", fileCount, fileCount == 1 and "" or "s"))
	
	-- Generate changelist
	local newFiles      = {}
	local deletedFiles  = {}
	local modifiedFiles = {}
	
	-- Check for new and modified files
	for path, _ in pairs (fileSet) do
		local fileInformation = self:GetSourceInformation (path)
		if not fileInformation then
			newFiles [#newFiles + 1] = path
		elseif fileInformation:IsOutdated () then
			modifiedFiles [#modifiedFiles + 1] = path
		end
	end
	
	-- Check for deleted files
	for fileInformation in self:GetSourceEnumerator () do
		if not fileSet [fileInformation:GetPath ()] then
			deletedFiles [#deletedFiles + 1] = fileInformation:GetPath ()
		end
	end
	
	if #newFiles      ~= 0 or
	   #deletedFiles  ~= 0 or
	   #modifiedFiles ~= 0 then
		-- Print list of new / deleted / modified files
		table.sort (newFiles     )
		table.sort (deletedFiles )
		table.sort (modifiedFiles)
		for i = 1, #newFiles do
			self.Logger:Message ("+ " .. newFiles [i])
		end
		for i = 1, #deletedFiles do
			self.Logger:Message ("- " .. deletedFiles [i])
		end
		for i = 1, #modifiedFiles do
			self.Logger:Message ("* " .. modifiedFiles [i])
		end
		
		self.Logger:Message (string.format ("%4d lua file%s added.",    #newFiles,      #newFiles      == 1 and "" or "s"))
		self.Logger:Message (string.format ("%4d lua file%s deleted.",  #deletedFiles,  #deletedFiles  == 1 and "" or "s"))
		self.Logger:Message (string.format ("%4d lua file%s modified.", #modifiedFiles, #modifiedFiles == 1 and "" or "s"))
		
		-- New files
		local lastOutputTime = SysTime ()
		for i = 1, #newFiles do
			self:AddSource (newFiles [i])
			self:UpdateFile (newFiles [i], CAC.UpdateType.Overwrite)
			
			if SysTime () - lastOutputTime > 1 then
				lastOutputTime = SysTime ()
				self.Logger:Message (string.format ("%4d / %4d new file%s processed.", i, #newFiles, #newFiles == 1 and "" or "s"))
			end
		end
		lastOutputTime = SysTime ()
		self.Logger:Message (string.format ("%4d / %4d new file%s processed.", #newFiles, #newFiles, #newFiles == 1 and "" or "s"))
		
		-- Deleted files
		for i = 1, #deletedFiles do
			self:RemoveSource (deletedFiles [i])
			
			if SysTime () - lastOutputTime > 1 then
				lastOutputTime = SysTime ()
				self.Logger:Message (string.format ("%4d / %4d deleted file%s processed.", i, #deletedFiles, #deletedFiles == 1 and "" or "s"))
			end
		end
		lastOutputTime = SysTime ()
		self.Logger:Message (string.format ("%4d / %4d deleted file%s processed.", #deletedFiles, #deletedFiles, #deletedFiles == 1 and "" or "s"))
		
		-- Modified files
		for i = 1, #modifiedFiles do
			self:UpdateFile (modifiedFiles [i], CAC.UpdateType.Overwrite)
			
			if SysTime () - lastOutputTime > 1 then
				lastOutputTime = SysTime ()
				self.Logger:Message (string.format ("%4d / %4d modified file%s processed.", i, #modifiedFiles, #modifiedFiles == 1 and "" or "s"))
			end
		end
		lastOutputTime = SysTime ()
		self.Logger:Message (string.format ("%4d / %4d modified file%s processed.", #modifiedFiles, #modifiedFiles, #modifiedFiles == 1 and "" or "s"))
		
		self:InvalidateFunctionInformation ()
		self:BuildFunctionInformation ()
		
		self.Logger:Message ("Saving new lua information...")
	else
		self.Logger:Message ("No lua file changes detected.")
	end
	
	self.Logger:Message (
		"Ready (" .. string.format (
			"%4d lua file%s, %5d function%s, %5d unique hash%s",
			fileCount, fileCount == 1 and "" or "s",
			self:GetFunctionCount (), self:GetFunctionCount () == 1 and "" or "s",
			self:GetUniqueFunctionHashCount (), self:GetUniqueFunctionHashCount () == 1 and "" or "es"
		) .. ")."
	)
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
	
	if sourceInformation:ShouldUseWeakMatching () then
		return sourceInformation:VerifyFunctionHash (functionVerificationInformation)
	else
		return sourceInformation:VerifyFunction (functionVerificationInformation)
	end
end
