if SERVER then
	include("prometheus/init.lua")
else
	include("prometheus/cl_init.lua")
end