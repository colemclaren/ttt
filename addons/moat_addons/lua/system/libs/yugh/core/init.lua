AddCSLuaFile()

TOTAL_INCLUDES = {}
if (not _include) then _include = include end
function include(str)
	table.insert(TOTAL_INCLUDES, str)
	return _include(str)
end

include "include.lua"

yugh.ish "utils.lua"

local yughs_dir = "system/libs/yugh/libraries/"
yugh.libs = yugh.libs or {
	sh = yughs_dir,
	sv = yughs_dir .. "server/",
	cl = yughs_dir .. "client/",
	exists = {},
	ran = {}
}

yugh.find(yugh.libs.sh, function(fn) local p = yugh.libs.sh .. fn .. ".lua" yugh.libs.exists[fn] = p AddCSLuaFile(p) end)
yugh.find(yugh.libs.cl, function(fn) local p = yugh.libs.cl .. fn .. ".lua" yugh.libs.exists[fn] = p AddCSLuaFile(p) end)
yugh.find(yugh.libs.sv, function(fn) local p = yugh.libs.sv .. fn .. ".lua" yugh.libs.exists[fn] = p end)

if (not _require) then _require = require end
function require(str)
	if (yugh.libs.exists[str] and not yugh.libs.ran[str]) then
		yugh.libs.ran[str] = true
		return include(yugh.libs.exists[str])
	else
		return _require(str)
	end
end

yugh.ish "includes/_init.lua"

yugh.i "/system/libs/yugh/" {
	"extensions/",
	"modules/"
}