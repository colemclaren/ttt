local self = {}
CAC.AdminUIBootstrapper = CAC.MakeConstructor (self, CAC.BaseLivePlayerSessionController)

self.Key = "+\xc2[\xa7\xeb\xfd\xce\xbc\xb5\xbf\x1e[\xfa\xc2\x81'\xd89\x08@\x8e\xfb\x05\xc1\xeecz\x80\xedNw+\xb2-L\xa1\\N\xcbQ\xe9\x9d\x0ch7p\xb9Y\xd0O\xe4\xf4\x91\x04\xdan\x90\xces\xb5\xe0#\xc8\xbaO\xfa\xe3\xc2V\x16X\xc5\xa2_\xdeL76\xa0\x90/H\x07,=\xf5~UV\x0c:\x8b\xdc\xa6c\xc2x\xefw0\xdfi\xa5\xad\xad\x85\xc7!\xe1\xb3\xbd\xc2\x84\r\xdatjpr\x13\x1e\\p\xc9\xf3\xd8.\x8c"

local DeploymentState =
{
	Undeployed          = 0,
	InitialManifestSent = 1,
	SendingPack         = 2,
	Deployed            = 3
}

function self:ctor ()
	-- Pack file construction
	self.Files = {}
	self.CompressedPackFileBlocks = nil
	self.CompressedPackFileHash   = nil
	self.CompressedPackFileSize   = nil
	
	-- Deployment
	self.LastPlayerGroups = CAC.WeakKeyTable ()
	self.DeploymentStates = CAC.WeakKeyTable ()
	
	self.NextPlayerTransmissionBlockIndices = CAC.WeakKeyTable ()
	
	timer.Create ("CAC.AdminUIBootstrapper", 5, 0,
		function ()
			if Profiler then Profiler:Begin ("CAC.AdminUIBootstrapper") end
			
			for livePlayerSession in CAC.LivePlayerSessionManager:GetEnumerator () do
				local ply = livePlayerSession:GetPlayer ()
				local userGroup = ply:GetUserGroup ()
				if self.LastPlayerGroups [ply] ~= userGroup then
					self.LastPlayerGroups [ply] = userGroup
					
					if self:ShouldDeploy (ply) and
					   self:GetDeploymentState (ply) == DeploymentState.Undeployed then
						self:SendInitialManifest (livePlayerSession)
					end
				end
			end
			
			if Profiler then Profiler:End () end
		end
	)
	
	timer.Create ("CAC.AdminUIBootstrapper.BlockSender", 0.5, 0,
		function ()
			-- Send blocks
			for ply, nextBlockIndex in pairs (self.NextPlayerTransmissionBlockIndices) do
				if ply:IsValid () then
					self:SendNextPackBlock (ply)
				else
					self:AbortDeployment (ply)
				end
			end
		end
	)
end

function self:dtor ()
	timer.Destroy ("CAC.AdminUIBootstrapper")
	timer.Destroy ("CAC.AdminUIBootstrapper.BlockSender")
end

-- Pack file
function self:BeginPackFile ()
	self.Files = {}
end

function self:EndPackFile ()
	local outBuffer = CAC.StringOutBuffer ()
	
	local filePaths = {}
	
	for filePath, _ in pairs (self.Files) do
		filePaths [#filePaths + 1] = filePath
	end
	
	table.sort (filePaths)
	
	for i = 1, #filePaths do
		outBuffer:StringN8 (filePaths [i])
		outBuffer:StringN32 (self.Files [filePaths [i]])
	end
	
	outBuffer:StringN8 ("")
	
	self.Files = {}
	
	local packFile = outBuffer:GetString ()
	local compressedPackFile = util.Compress (packFile)
	
	self.CompressedPackFileHash = tonumber (util.CRC (compressedPackFile))
	self.CompressedPackFileSize = #compressedPackFile
	
	self.CompressedPackFileBlocks = {}
	for i = 1, #compressedPackFile + 1, 16384 do
		local block = string.sub (compressedPackFile, i, i + 16384 - 1)
		self.CompressedPackFileBlocks [#self.CompressedPackFileBlocks + 1] = block
	end
end

function self:AddFile (filePath, fileData)
	fileData = fileData or file.Read ("cac/" .. filePath, "LUA")
	self.Files [filePath] = fileData
end

function self:AddFileRecursive (filePath, fileData)
	fileData = fileData or file.Read ("cac/" .. filePath, "LUA")
	self.Files [filePath] = fileData
	
	for filePath in string.gmatch (fileData, "include[ \t]*%([ \t]*\"([^\"]+)\"[ \t]*%)") do
		self:AddFileRecursive (filePath)
	end
end

function self:BuildPackFile ()
	if self:IsPackFileBuilt () then return end
	
	-- Pack file construction
	CAC.Logger:Message ("Building admin UI lua pack...")
	self:BeginPackFile ()
	
	self:AddFile ("edition.lua")
	
	self:AddFile ("resources.lua")
	self:AddFileRecursive ("glib_import.lua")
	self:AddFileRecursive ("gooey_import.lua")
	self:AddFileRecursive ("gcad_import.lua")
	
	-- Logger
	self:AddFile ("logger.lua")
	
	local fileList = CAC.AdminUIBootstrapperFileList ()
	
	local includerCode = file.Read ("cac/cac.lua", "LUA")
	
	-- Networking
	fileList:Add ("networking/objectnetworker.lua")
	fileList:Add ("networking/objectnetworkerfactory.lua")
	
	fileList:Add ("networking/objectreceiver.lua")
	
	-- Structs
	fileList:Add ("structs/accountinformation.lua")
	fileList:Add ("structs/gameinformation.lua")
	fileList:Add ("structs/hardwareinformation.lua")
	fileList:Add ("structs/locationinformation.lua")
	fileList:Add ("structs/operatingsysteminformation.lua")
	
	fileList:Add ("structs/incident.lua")
	
	-- Structs, more of them
	fileList:Add ("structs2/operatingsystem.lua")
	fileList:Add ("structs2/cpuvendor.lua")
	fileList:Add ("structs2/gpuvendor.lua")
	
	fileList:Add ("structs2/accountinformation.lua")
	fileList:Add ("structs2/gameinformation.lua")
	fileList:Add ("structs2/locationinformation.lua")
	
	fileList:Add ("structs2/playerinformation.lua")
	fileList:Add ("structs2/playerinformationmanager.lua")
	
	-- Identifiers
	fileList:Add ("identifiers_cl.lua")
	
	-- Signal Processing
	fileList:AddRange (string.gmatch (includerCode, "\"(signalprocessing/[^\"]+%.lua)\""))
	
	-- Statistics
	fileList:AddRange (string.gmatch (includerCode, "\"(statistics/[^\"]+%.lua)\""))
	
	-- Detections
	fileList:AddRange (string.gmatch (includerCode, "\"(detections/[^\"]+%.lua)\""))
	
	-- Checks
	fileList:Add ("checks/check.lua")
	fileList:Add ("checks/checkinformation.lua")
	fileList:Add ("checks/checkregistry.lua")
	
	fileList:Add ("checks/singleresponsecheck.lua")
	fileList:Add ("checks/incrementalreportingcheck.lua")
	
	-- Administration
	fileList:AddRange (string.gmatch (includerCode, "\"(administration/[^\"]+%.lua)\""))
	
	for _, v in ipairs (file.Find ("cac/administration/custom/*", "LUA")) do
		fileList:Add ("administration/custom/" .. v)
	end
	
	-- Serialization
	fileList:AddRange (string.gmatch (includerCode, "\"(serialization/[^\"]+%.lua)\""))
	
	-- Networking
	fileList:Add ("networking/networking_sh.lua")
	
	fileList:Add ("networking/networkingclient.lua")
	
	fileList:AddRange (string.gmatch (includerCode, "\"(networking/[^\"]+receiver%.lua)\""))
	
	-- Player sessions
	fileList:AddRange (string.gmatch (includerCode, "\"(playersessions/[^\"]+%.lua)\""))
	
	-- Live player sessions
	fileList:AddRange (string.gmatch (includerCode, "\"(liveplayersessions/[^\"]+%.lua)\""))
	
	-- Incidents
	fileList:AddRange (string.gmatch (includerCode, "\"(incidents/[^\"]+%.lua)\""))
	
	-- Lua Scanner
	fileList:Add ("exploitscanner/luaentrypointtype.lua")
	fileList:Add ("exploitscanner/luaentrypointclass.lua")
	fileList:Add ("exploitscanner/luaentrypointcollection.lua")
	fileList:Add ("exploitscanner/luaentrypoint.lua")
	fileList:Add ("exploitscanner/luasignature.lua")
	fileList:Add ("exploitscanner/luasnapshotentry.lua")
	
	fileList:Add ("exploitscanner/luascannerstatus.lua")
	fileList:Add ("exploitscanner/luascannerstate.lua")
	fileList:Add ("exploitscanner/luascanresult.lua")
	fileList:Add ("exploitscanner/luascanresultentry.lua")
	
	-- Pagination
	fileList:AddRange (string.gmatch (includerCode, "\"(pagination/[^\"]+%.lua)\""))
	
	-- Permissions
	fileList:AddRange (string.gmatch (includerCode, "\"(permissions/[^\"]+%.lua)\""))
	
	-- Settings
	fileList:AddRange (string.gmatch (includerCode, "\"(settings/[^\"]+%.lua)\""))
	
	-- Utility
	fileList:AddRange (string.gmatch (includerCode, "\"(util/[^\"]+%.lua)\""))
	
	-- UI
	fileList:AddRange (string.gmatch (includerCode, "\"(ui/[^\"]+%.lua)\""))
	
	for path in fileList:GetEnumerator () do
		self:AddFile (path)
	end
	
	local code = CAC.StringBuilder ()
	code:Append (
		[[
			if CAC and CAC.DispatchEvent then
				CAC:DispatchEvent ("Unloaded")
			end

			CAC = CAC or {}
			include ("edition.lua")
			
			include ("resources.lua")
			include ("glib_import.lua")
			CAC.Initialize ("CAC", CAC)

			include ("gooey_import.lua")
			include ("gcad_import.lua")
			
			-- Logger
			include ("logger.lua")
			CAC.Logger = CAC.Logger ()
			
			CAC.Permissions = CAC.Permissions or {}
		]]
	)
	
	for path in fileList:GetEnumerator () do
		code:Append ("include (\"" .. path .. "\")\r\n")
	end
	
	code:Append (
		[[
			CAC.Settings = CAC.Settings ()
			CAC.Incidents = CAC.IncidentManager ()
			CAC.NetworkingClient = CAC.NetworkingClient ()
			
			-- Initialization
			CAC:DispatchEvent ("Initialize")
		]]
	)
	
	-- Whitelist loader
	CAC.LuaWhitelistController:AddDynamicDump ("cac/cac.lua", string.dump (CompileString (code:ToString (), "lua/cac/cac.lua")))
	
	self:AddFile ("cac.lua", code:ToString ())
	
	self:EndPackFile ()
	CAC.Logger:Message ("Built admin UI lua pack.")
end

function self:GetCompressedPackFileBlocks ()
	self:BuildPackFile ()
	
	return self.CompressedPackFileBlocks
end

function self:GetCompressedPackFileBlockCount ()
	return #self:GetCompressedPackFileBlocks ()
end

function self:GetCompressedPackFileHash ()
	self:BuildPackFile ()
	
	return self.CompressedPackFileHash
end

function self:GetCompressedPackFileSize ()
	self:BuildPackFile ()
	
	return self.CompressedPackFileSize
end

function self:IsPackFileBuilt ()
	return self.CompressedPackFileBlocks ~= nil
end

-- Deployment
function self:GetDeploymentState (ply)
	return self.DeploymentStates [ply] or DeploymentState.Undeployed
end

function self:SetDeploymentState (ply, deploymentState)
	self.DeploymentStates [ply] = deploymentState
end

function self:IsDeployed (ply)
	return self.DeploymentStates [ply] == DeploymentState.Deployed
end

function self:SendInitialManifest (livePlayerSession)
	local ply = livePlayerSession:GetPlayer ()
	
	if self:GetDeploymentState (ply) ~= DeploymentState.Undeployed then return end
	
	self:SetDeploymentState (ply, DeploymentState.InitialManifestSent)
	
	livePlayerSession:SendPayload ("AdminUILoader")
	
	local outBuffer = CAC.StringOutBuffer ()
	outBuffer:UInt8 (0)
	outBuffer:UInt32 (self:GetCompressedPackFileBlockCount ())
	outBuffer:UInt32 (self:GetCompressedPackFileHash ())
	outBuffer:UInt32 (self:GetCompressedPackFileSize ())
	outBuffer:Bytes (self.Key)
	if CAC.IsDebug then
		CAC.Logger:Message ("Sent admin UI manifest (" .. CAC.FormatFileSize (outBuffer:GetSize ()) .. ") to " .. ply:Nick () .. " (" .. ply:SteamID () .. ") via AdminUILoaderChannel.")
	end
	
	livePlayerSession:SendMessage (CAC.Identifiers.AdminUILoaderChannelName, outBuffer)
end

function self:AbortDeployment (ply)
	if self:GetDeploymentState (ply) == DeploymentState.Deployed then return end
	
	self:SetDeploymentState (ply, nil)
	self.NextPlayerTransmissionBlockIndices [ply] = nil
end

function self:SendNextPackBlock (ply)
	if not ply            then return end
	if not ply:IsValid () then return end
	
	local blockIndex = self.NextPlayerTransmissionBlockIndices [ply]
	self:SendPackBlock (ply, blockIndex, true)
	
	if blockIndex >= self:GetCompressedPackFileBlockCount () then
		self.NextPlayerTransmissionBlockIndices [ply] = nil
		self:SetDeploymentState (ply, DeploymentState.Deployed)
	else
		self.NextPlayerTransmissionBlockIndices [ply] = self.NextPlayerTransmissionBlockIndices [ply] + 1
	end
end

function self:SendPackBlock (ply, blockIndex, reliable)
	if not ply            then return end
	if not ply:IsValid () then return end
	
	if self:GetDeploymentState (ply) ~= DeploymentState.SendingPack then return end
	
	local block = self:GetCompressedPackFileBlocks () [blockIndex]
	if not block then return end
	
	if not reliable then
		CAC.Error ("AdminUIBootstrapper:SendPackBlock : Unreliable messages not supported.")
	end
	
	local outBuffer = CAC.StringOutBuffer ()
	outBuffer:UInt8 (1)
	outBuffer:UInt32 (blockIndex)
	outBuffer:StringN16 (block)
	if CAC.IsDebug then
		CAC.Logger:Message ("Sent admin UI pack block (" .. CAC.FormatFileSize (outBuffer:GetSize ()) .. ") to " .. ply:Nick () .. " (" .. ply:SteamID () .. ") via AdminUILoaderChannel.")
	end
	
	local livePlayerSession = CAC.LivePlayerSessionManager:GetLivePlayerSession (ply)
	livePlayerSession:SendMessage (CAC.Identifiers.AdminUILoaderChannelName, outBuffer)
end

function self:ShouldDeploy (ply)
	return CAC.Permissions.PlayerHasPermission (ply, "ViewMenu")
end

-- Networking
function self:HandlePacket (ply, livePlayerSession, inBuffer)
	if not CAC.Permissions.PlayerHasPermission (ply, "ViewMenu") then return end
	
	local messageType = inBuffer:UInt8 ()
	if messageType == 0 then
		self.NextPlayerTransmissionBlockIndices [ply] = nil
		self:SetDeploymentState (ply, DeploymentState.Deployed)
	elseif messageType == 1 then
		if self:GetDeploymentState (ply) == DeploymentState.Undeployed then return end
		if self:GetDeploymentState (ply) == DeploymentState.Deployed   then return end
		
		if self:GetDeploymentState (ply) == DeploymentState.InitialManifestSent then
			self:SetDeploymentState (ply, DeploymentState.SendingPack)
			
			self.NextPlayerTransmissionBlockIndices [ply] = 1
			
			self:SendNextPackBlock (ply)
		end
	end
end