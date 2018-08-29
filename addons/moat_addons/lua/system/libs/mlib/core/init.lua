AddCSLuaFile()

TOTAL_INCLUDES = {}
if (not _include) then _include = include end
function include(str)
	table.insert(TOTAL_INCLUDES, str)
	return _include(str)
end

include "include.lua"

mlib.ish "utils.lua"

local mlibs_dir = "system/libs/mlib/libraries/"
mlib.libs = mlib.libs or {
	sh = mlibs_dir,
	sv = mlibs_dir .. "server/",
	cl = mlibs_dir .. "client/",
	exists = {},
	ran = {}
}

mlib.find(mlib.libs.sh, function(fn) local p = mlib.libs.sh .. fn .. ".lua" mlib.libs.exists[fn] = p AddCSLuaFile(p) end)
mlib.find(mlib.libs.cl, function(fn) local p = mlib.libs.cl .. fn .. ".lua" mlib.libs.exists[fn] = p AddCSLuaFile(p) end)
mlib.find(mlib.libs.sv, function(fn) local p = mlib.libs.sv .. fn .. ".lua" mlib.libs.exists[fn] = p end)

if (not _require) then _require = require end
function require(str)
	if (mlib.libs.exists[str] and not mlib.libs.ran[str]) then
		mlib.libs.ran[str] = true
		return include(mlib.libs.exists[str])
	else
		return _require(str)
	end
end

mlib.ish "includes/_init.lua"

mlib.i "/system/libs/mlib/" {
	"extensions/",
	"modules/"
}