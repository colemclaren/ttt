yugh.i "app_mt.lua"

moat.apps = moat.apps or {
	path = "system/app/",
	paths = {}, included = {},
	include = function(p)
		p = p:match "/$" and p or p .. "/"

		yugh.i(moat.apps.path .. p)
	end
}

function moat.apps.load(fn)
	moat.apps.temp = fn
	yugh.ish(moat.apps.path .. fn .. "/app.lua")

	if (moat.apps[fn]) then return end
	moat.apps[fn] = setmetatable({fp = moat.apps.path .. "/" .. fn .. "/"}, {__call = function(s, p)
		return include(s.fp .. p)
	end})
end

local _, f = file.Find(moat.apps.path .. "*", "LUA")
for k, v in pairs(f) do
	if (v == "core") then
		continue
	end

	moat.apps.load(v)

	concommand.Add("reload_" .. v, function()
		moat.apps.load(v)
	end)
end