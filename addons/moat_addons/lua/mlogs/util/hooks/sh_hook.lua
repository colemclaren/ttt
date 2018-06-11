if (SERVER) then
	include "sv_enums.lua"
	AddCSLuaFile "sh_events.lua"
end
include "sh_events.lua"



mlogs.hooks = mlogs.hooks or {}
function mlogs:hook(id, cb)
	self.hooks[id] = self.hooks[id] and self.hooks[id] + 1 or 1
	hook.Add(id, "mlogs." .. id .. "." .. self.hooks[id], cb)
	return self.hooks[id]
end

function mlogs:dehook(id, num)
	hook.Remove(id, "mlogs." .. id .. "." .. num)
end

mlogs.events = mlogs.events or {}
function mlogs.events.register(id, info)
	id = isstring(id) and mlogs.eventids[id] or id

	assert(id, "mlogs event1")
	assert(mlogs.events[id] ~= nil, "mlogs event2")

	local e = {}
	e.id = id
	e.name = info.name
	e.type = info.type
	e.color = info.color
	e.display = info.display
	e.keys = info.keys
	e.keytable = info.keytable
	e.logtype = info.log
	e.witness = info.witness

	mlogs.events.stored[id] = e
end

function mlogs.events.get(id)
	return mlogs.events.stored[id]
end

function mlogs:loadevents()
	local _, types = file.Find(mlogs.Folder .. "/events/", "LUA")
	for k, v in ipairs(types) do
		mlogs.mytype = v
		mlogs.IncludeFolder("events/" .. v .. "/")
	end

	mlogs.mytype = nil
end

mlogs:hook("mlogs.init", function(s)
	mlogs:PrintH "mlogs loading event files"
	mlogs:loadevents()
	mlogs:PrintH "mlogs loaded event files"
end)


mlogs.events = mlogs.events or {}
function mlogs.event(id, name, typ, display, tbl)
	assert(id and name and typ and display, "mlogs event1")

	id = mlogs.eventids[id]
	assert(id, "mlogs event2")
	assert(mlogs.events[id] ~= nil, "mlogs event3")
	assert(mlogs.events[name] ~= nil, "mlogs event4")

	local e = {}
	e.info = {id = id, n = name, t = typ, d = display, dt = tbl}
	mlogs.events[id] = e
	mlogs.events[name] = e
end