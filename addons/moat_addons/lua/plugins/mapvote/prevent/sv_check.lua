function MapPrevent.Check()
	if (not MapPrevent.Loaded) then return end
	moat.sql:q("SELECT active FROM moat_mapvote_prevent WHERE active = 1;", MapPrevent.CheckResults)
end

hook.Add("SQLConnected", "MapPrevent.Check", function()
	timer.Create("MapPrevent", MapPrevent.Timer, 0, MapPrevent.Check)
end)

function MapPrevent.CheckResults(r)
	local a = (r and r[1]) and true or false

	if (a == MapPrevent.Active) then
		return
	end

	MapPrevent.SwitchTo(a)
end

function MapPrevent.SwitchTo(active)
	if (not MapPrevent.Loaded) then return end

	MapPrevent.Switch(active)
	MapPrevent.Active = active
end