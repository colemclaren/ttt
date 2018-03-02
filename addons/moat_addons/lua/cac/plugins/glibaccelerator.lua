local self = CAC.Plugins:CreatePlugin ("GLibAccelerator")

local sv_allowcslua = GetConVar ("sv_allowcslua")

function self:ctor ()
	self.GLibTables = CAC.WeakKeyTable ()
end

-- Plugin
function self:CanEnable ()
	return istable (GLib) or (istable (LibK) and istable (LibK.GLib))
end

function self:OnEnable ()
	self:ProcessTables ()
	
	timer.Create ("CAC.Plugins.GLibAccelerator", 1, 0,
		function ()	
			self:ProcessTables ()
		end
	)
	
	self:Hook ("PlayerConnected",
		function (ply, livePlayerSession)
			livePlayerSession:SendPayload ("GLibAccelerator")
		end
	)
end

function self:OnDisable ()
	for glib, _ in pairs (self.GLibTables) do
		self:UnprocessGLibTable (glib)
	end
	
	timer.Destroy ("CAC.Plugins.GLibAccelerator")
end

-- Internal, do not call
function self:ProcessTables ()
	if istable (GLib) then
		self:ProcessGLibTable (GLib)
	end
	
	if istable (LibK) and istable (LibK.GLib) then
		self:ProcessGLibTable (LibK.GLib)
	end
end

function self:ProcessGLibTable (glib)
	if not glib then return end
	if self.GLibTables [glib] then return end
	
	local backupTable = {}
	self.GLibTables [glib] = backupTable
	
	backupTable.GLib_Loader_PackFileManager_MergedPackFileSystem_Write = glib.Loader.PackFileManager.MergedPackFileSystem.Write
	backupTable.GLib_Loader_StreamPack                                 = glib.Loader.StreamPack
	
	glib.Loader.PackFileManager.MergedPackFileSystem.Write = function (packFileSystem, path, data)
		local normalizedPath = packFileSystem:NormalizePath (path)
		self:WhitelistCode (glib, path, data)
		
		return backupTable.GLib_Loader_PackFileManager_MergedPackFileSystem_Write (packFileSystem, path, data)
	end
	
	glib.Loader.StreamPack = function (...)
		if not sv_allowcslua:GetBool () then
			RunConsoleCommand ("sv_allowcslua", "1")
			
			for _, ply in ipairs (player.GetAll ()) do
				if CAC.Permissions.PlayerHasPermission (ply, "ViewMenu") then
					CAC.Logger:Message ("sv_allowcslua set to 1 due to deployment of custom GLib Lua pack.")
					ply:ChatPrint ("!cake Anti-Cheat: sv_allowcslua set to 1 due to deployment of custom GLib Lua pack.")
				end
			end
		end
		
		return backupTable.GLib_Loader_StreamPack (...)
	end
	
	CAC.Logger:Message ("Whitelisting dynamic GLib lua files...")
	local function ProcessDirectory (path, directoryTable)
		if #path > 0 then path = path .. "/" end
		
		for name, data in pairs (directoryTable) do
			local childPath = path .. name
			if isstring (data) then
				self:WhitelistCode (glib, childPath, data)
			else
				ProcessDirectory (childPath, data)
			end
		end
	end
	
	ProcessDirectory ("", glib.Loader.PackFileManager.MergedPackFileSystem.Root)
	
	CAC.Logger:Message ("Whitelisting dynamic GLib lua files complete.")
end

function self:UnprocessGLibTable (glib)
	if not glib then return end
	if not self.GLibTables [glib] then return end
	
	local backupTable = self.GLibTables [glib]
	self.GLibTables [glib] = nil
	
	glib.Loader.PackFileManager.MergedPackFileSystem.Write = backupTable.GLib_Loader_PackFileManager_MergedPackFileSystem_Write
	glib.Loader.StreamPack                                 = backupTable.GLib_Loader_StreamPack
end

function self:WhitelistCode (glib, path, data)
	local compiled = glib.Loader.CompileString (data, path, false)
	
	if isfunction (compiled) then
		CAC.LuaWhitelistController:GetDynamicLuaInformation ():AddDump (path, string.dump (compiled))
		
		if CAC.IsDebug then
			CAC.Logger:Message ("Whitelisted dynamic GLib lua file " .. path .. ".")
		end
	else
		CAC.Logger:Message ("Failed to compile dynamic GLib lua file " .. path .. " (" .. compiled .. ")")
	end
end