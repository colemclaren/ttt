local self = CAC.Plugins:CreatePlugin ("ARCLoadAccelerator")

function self:ctor ()
	self.LastClientChunkDownload = nil
end

-- Plugin
function self:CanEnable ()
	return istable (ARCLoad)
end

function self:OnEnable ()
	self:ProcessCode ()
	
	timer.Create ("CAC.Plugins.ARCLoadAccelerator", 1, 0,
		function ()
			self:ProcessCode ()
		end
	)
end

function self:OnDisable ()
	timer.Destroy ("CAC.Plugins.ARCLoadAccelerator")
end

-- Internal, do not call
function self:ProcessCode ()
	if not ARCLoad.ClientChunkDownload then return end
	if self.LastClientChunkDownload == ARCLoad.ClientChunkDownload then return end
	
	self.LastClientChunkDownload = ARCLoad.ClientChunkDownload
	local code = table.concat (ARCLoad.ClientChunkDownload)
	
	if self:WhitelistCode (code, "Virtual clientside lua.") then
		self:Hook ("PlayerConnected",
			function (ply, livePlayerSession)
				livePlayerSession:SendPayload ("ARCLoadAccelerator")
			end
		)
	end
end

function self:WhitelistCode (code, path)
	local compiled = CompileString (code, path, false)
	
	if isfunction (compiled) then
		CAC.LuaWhitelistController:GetDynamicLuaInformation ():AddDump (path, string.dump (compiled))
		
		if CAC.IsDebug then
			CAC.Logger:Message ("Whitelisted dynamic ARCLoad lua.")
		end
		return true
	else
		CAC.Logger:Message ("Failed to compile dynamic ARCLoad lua (" .. compiled .. ")")
		return false
	end
end