mlogs.events = mlogs.events or {
	stored = {}
}

function mlogs.events.hook(name, cb)
	hook.Remove(name, "mlogs.events")
	hook.Add(name, "mlogs.events", cb)
end

function mlogs.events.register(id, info)
	assert(id, "mlogs event1")

	local e = {}
	e.id = id
	e.name = info.name
	e.type = mlogs.curtype
	e.color = info.color
	e.display = info.display
	e.keys = info.keys
	e.keytable = info.keytable
	e.logtype = info.log
	e.witness = info.witness
	e.show = info.show

	mlogs.events.stored[id] = e
end

function mlogs:loadevents()
	mlogs.events.stored = mlogs.events.stored or {}

	-- mlogs.IncludeSH "/events/sh_events.lua"
	-- mlogs.IncludeFolderSV "events/hooks"

	/*
	local _, types = file.Find(mlogs.Folder .. "/events/*", "LUA")
	for k, v in ipairs(types) do
		mlogs.mytype = v
		mlogs.IncludeFolder("events/" .. v)
		mlogs.mytype = "nil"
	end
	*/
end

hook("mlogs.init", function(s)
	mlogs:PrintH "mlogs loading event files"
	mlogs:loadevents()
	mlogs:PrintH "mlogs loaded event files"
end)

concommand.Add("_reloadevents", function()
	mlogs:PrintH "mlogs loading event files"
	mlogs:loadevents()
	mlogs:PrintH "mlogs loaded event files"
end)

function mlogs.GetEvent(id)
	return mlogs.events.stored[id]
end

function mlogs.EventExists(id)
	return mlogs.events.stored[id] ~= nil
end



function mlogs.EventName(id)
	return mlogs.events.stored[id].name or "???"
end

function mlogs.EventType(id)
	return mlogs.events.stored[id].type or "???"
end

function mlogs.EventColor(id)
	return mlogs.events.stored[id].color or mlogs.Color.Black
end

function mlogs.EventDisplay(id)
	return mlogs.events.stored[id].display or "???"
end

function mlogs.EventDisplay(id)
	return mlogs.events.stored[id].display or "???"
end

function mlogs.EventDefault(t, f)
	if (t == nil) then
		return f
	else
		return t
	end
end

function mlogs.EventLogType(id)
	return mlogs.EventDefault(mlogs.events.stored[id].logtype, false)
end

function mlogs.EventWitness(id)
	return mlogs.EventDefault(mlogs.events.stored[id].witness, false)
end

function mlogs.EventShow(id)
	return mlogs.EventDefault(mlogs.events.stored[id].show, true)
end

function mlogs.EventKeys(id)
	return mlogs.EventDefault(mlogs.events.stored[id].keys, false), mlogs.events.stored[id].keytable
end