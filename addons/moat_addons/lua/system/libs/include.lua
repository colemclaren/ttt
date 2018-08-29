mlib.i "libs"

moat.libs = moat.libs or {
	path = "system/libs/",
	paths = {}, included = {},
	include = function(p)
		p = p:match "/$" and p or p .. "/"

		mlib.i(moat.libs.path .. p)
	end
}

function moat.libs.load(fn)
	moat.libs.temp = fn
	mlib.ish(moat.libs.path .. fn .. "/_.lua")

	if (moat.libs[fn]) then return end
	moat.libs[fn] = setmetatable({fp = moat.libs.path .. "/" .. fn .. "/"}, {__call = function(s, p)
		return include(s.fp .. p)
	end})
end

local _, f = file.Find(moat.libs.path .. "*", "LUA")
for k, v in pairs(f) do
	moat.libs.load(v)

	concommand.Add("lib_" .. v, function()
		moat.libs.load(v)
	end)
end