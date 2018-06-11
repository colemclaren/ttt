mlogs = mlogs or {}
mlogs.cfg = mlogs.cfg or {}

mlogs.Version = "1.0.0"
mlogs.Folder = "mlogs"
mlogs.Database = "moat_logs"
mlogs.ip = GetConVarString("ip") .. ":" .. GetConVarString("hostport")
mlogs.hostname_parse = function(hostname)
	return hostname:match("%[(.+)%]")
end

mlogs.IncludeSV = function(p) if (SERVER) then include(mlogs.Folder .. p) end end
mlogs.IncludeCL = function(p) if (SERVER) then AddCSLuaFile(mlogs.Folder .. p) else include(mlogs.Folder .. p) end end
mlogs.IncludeSH = function(p) mlogs.IncludeSV(p) mlogs.IncludeCL(p) end
mlogs.IncludeFolderCL = function(p) mlogs.IncludeFolder(p, true) end
mlogs.IncludeFolderSV = function(p) mlogs.IncludeFolder(p, false) end
function mlogs.IncludeFolder(p, cl)
	local tf = (cl == nil and mlogs.IncludeSH) or (cl == true and mlogs.IncludeCL) or (cl == false and mlogs.IncludeSV)
	p = "/" .. p .. "/"

	for _, f in ipairs(file.Find(mlogs.Folder .. p .. "*.lua", "LUA")) do i = tf
		if (f:StartWith("sh_")) then i = mlogs.IncludeSH end
		if (f:StartWith("cl_")) then i = mlogs.IncludeCL end
		if (f:StartWith("sv_")) then i = mlogs.IncludeSV end

		if (mlogs.Print) then mlogs:Print(" | " .. f) end
		i(p .. f)
	end
end

mlogs.IncludeSH "/util/hooks/sh_hook.lua"
mlogs.IncludeSH "/util/net/sh_net.lua"
mlogs.IncludeSH "/util/msg.lua"

mlogs:PrintH "mlogs loading core files"

mlogs:Print "parsing util files"
mlogs.IncludeFolder "util"

mlogs.IncludeSH "/config.lua"

if (SERVER) then
	mlogs:Print "parsing server files"
	mlogs.IncludeFolderSV "server"
end

mlogs:Print "parsing client files"
mlogs.IncludeFolderCL "client"

mlogs:Print "parsing shared files"
mlogs.IncludeFolder "shared"

mlogs:PrintH "mlogs loaded core files"

mlogs:hook("mlogs.init", function(s)
	mlogs:PrintH "mlogs loading event files"
	s.loadevents()
	mlogs:PrintH "mlogs loaded event files"
end)