if(SERVER) then
	AddCSLuaFile("autorun/slvbase/meta_nodegraph.lua")
	AddCSLuaFile("includes/modules/a_star_pathfinding.lua")
	AddCSLuaFile("includes/modules/nodegraph.lua")
	
	AddCSLuaFile("autorun/slvbase/client/slvbase_cl_hooks.lua")
	AddCSLuaFile("autorun/slvbase/client/slvbase_cl_meta.lua")
	AddCSLuaFile("autorun/slvbase/client/slvbase_cl_umsg.lua")
	AddCSLuaFile("autorun/slvbase/client/slvbase_cl_util.lua")
	
	AddCSLuaFile("autorun/slvbase/shared/slvbase_sh_init.lua")
	AddCSLuaFile("autorun/slvbase/shared/slvbase_sh_hooks.lua")
	AddCSLuaFile("autorun/slvbase/shared/slvbase_sh_meta.lua")
	AddCSLuaFile("autorun/slvbase/shared/slvbase_sh_util.lua")
	
	include("server/slvbase_sv_conditions.lua")
	include("server/slvbase_sv_factions.lua")
	include("server/slvbase_sv_hooks.lua")
	include("server/slvbase_sv_init.lua")
	include("server/slvbase_sv_meta.lua")
	include("server/slvbase_sv_util.lua")
	
	include("server/slvbase_sv_nodegraph.lua")
end
include("meta_nodegraph.lua")
require("nodegraph")

include("shared/slvbase_sh_init.lua")
include("shared/slvbase_sh_hooks.lua")
include("shared/slvbase_sh_meta.lua")
include("shared/slvbase_sh_util.lua")

if(SERVER) then return end
include("client/slvbase_cl_hooks.lua")
include("client/slvbase_cl_meta.lua")
include("client/slvbase_cl_umsg.lua")
include("client/slvbase_cl_util.lua")