SHR = SHR or {
	Config = {},
	Version = "1.0.0"
}

SHR.IncludeSV = SERVER and include or function() end
SHR.IncludeCL = SERVER and AddCSLuaFile or include
SHR.IncludeSH = function(p) SHR.IncludeSV(p) SHR.IncludeCL(p) end

SHR.IncludeSH "shr/config.lua"
if (not SHR.Config.Enabled) then return end

SHR.IncludeSV "shr/sv.lua"
SHR.IncludeCL "shr/cl.lua"