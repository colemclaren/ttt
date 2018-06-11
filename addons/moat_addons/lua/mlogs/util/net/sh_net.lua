mlogs.net = mlogs.net or {}
mlogs.net.active = mlogs.net.active or false

mlogs:hook("mlogs.init", function(s)
	s.net.active = true
end)

mlogs.IncludeCL "/util/net/cl_net.lua"
mlogs.IncludeSV "/util/net/sv_net.lua"