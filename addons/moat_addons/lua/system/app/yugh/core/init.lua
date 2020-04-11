AddCSLuaFile()

TOTAL_INCLUDES = {}
if (not _include) then _include = include end
function include(str)
	table.insert(TOTAL_INCLUDES, str)
	return _include(str)
end

include "include.lua"

yugh.ish "utils.lua"

local yughs_dir = "system/app/yugh/libraries/"
yugh.apps = yugh.apps or {
	sh = yughs_dir,
	sv = yughs_dir .. "server/",
	cl = yughs_dir .. "client/",
	exists = {},
	ran = {}
}

yugh.find(yugh.apps.sh, function(fn) local p = yugh.apps.sh .. fn .. ".lua" yugh.apps.exists[fn] = p AddCSLuaFile(p) end)
yugh.find(yugh.apps.cl, function(fn) local p = yugh.apps.cl .. fn .. ".lua" yugh.apps.exists[fn] = p AddCSLuaFile(p) end)
yugh.find(yugh.apps.sv, function(fn) local p = yugh.apps.sv .. fn .. ".lua" yugh.apps.exists[fn] = p end)

if (not _require) then _require = require end
function require(str)
	if (yugh.apps.exists[str] and not yugh.apps.ran[str]) then
		yugh.apps.ran[str] = true
		return include(yugh.apps.exists[str])
	else
		return _require(str)
	end
end

yugh.ish "includes/_init.lua"
yugh.ish(yughs_dir .. "cdn.lua")
yugh.i "/system/app/yugh/" {
	"extensions/",
	"modules/"
}