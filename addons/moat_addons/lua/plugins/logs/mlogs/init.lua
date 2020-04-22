mlogs = mlogs or {cfg = {}}
mlogs.Version = "0.0.1"
mlogs.Folder = "mlogs"
mlogs.Database = "moat_logs"
mlogs.ip = GetConVarString("ip") .. ":" .. GetConVarString("hostport")
mlogs.hostname_parse = function(hostname)
	return hostname:match("%[(.+)%]")
end

mlogs.cfg.Groups = mlogs.cfg.Groups or {}
mlogs.cfg.StaffGroups = mlogs.cfg.StaffGroups or {}

function mlogs.cfg:AddGroup(group, active, staff)
	self.Groups[group] = active
	self.StaffGroups[group] = staff
end

mlogs.cfg:AddGroup("owner", true, true)
mlogs.cfg:AddGroup("communitylead", true, true)
mlogs.cfg:AddGroup("headadmin", true, true)
mlogs.cfg:AddGroup("senioradmin", false, true)
mlogs.cfg:AddGroup("admin", false, true)
mlogs.cfg:AddGroup("moderator", false, true)
mlogs.cfg:AddGroup("trialstaff", false, true)
mlogs.cfg:AddGroup("techartist", false, true)
mlogs.cfg:AddGroup("audioengineer", false, true)
mlogs.cfg:AddGroup("softwareengineer", false, true)
mlogs.cfg:AddGroup("gamedesigner", false, true)
mlogs.cfg:AddGroup("creativedirector", false, true)

mlogs.IncludeSV = function(p) if (SERVER) then include(mlogs.Folder .. p) end end
mlogs.IncludeCL = function(p) if (SERVER) then AddCSLuaFile(mlogs.Folder .. p) else include(mlogs.Folder .. p) end end
mlogs.IncludeSH = function(p) mlogs.IncludeSV(p) mlogs.IncludeCL(p) end
mlogs.IncludeFolderCL = function(p) mlogs.IncludeFolder(p, true) end
mlogs.IncludeFolderSV = function(p) mlogs.IncludeFolder(p, false) end
function mlogs.IncludeFolder(p, cl)
	local tf = (cl == nil and mlogs.IncludeSH) or (cl == true and mlogs.IncludeCL) or (cl == false and mlogs.IncludeSV)
	p = "/" .. p .. "/"
	
	local files, folders = file.Find(mlogs.Folder .. p .. "*.lua", "LUA")
	-- file.Write('_mlogs_'..p:Trim('/')..'.txt', table.ToString(files, 'files', true))
	for _, f in ipairs(files) do i = tf
		if (f:StartWith("sh_")) then i = mlogs.IncludeSH end
		if (f:StartWith("cl_")) then i = mlogs.IncludeCL end
		if (f:StartWith("sv_")) then i = mlogs.IncludeSV end

		if (mlogs.Print) then mlogs:Print(" | " .. f) end
		i(p .. f)
	end
end