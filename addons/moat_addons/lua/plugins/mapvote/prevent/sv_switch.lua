function MapPrevent.Switch(active)
	MapPrevent.SwitchMessage(active)

	if (active) then
		MapPrevent.ReplaceDefaults()
	else
		MapPrevent.EnableDefaults()
	end
end

function MapPrevent.EnableDefaults()
	local tb = table.Copy(MapPrevent.Defaults)

	D3A.Commands.Stored["boost"].Run = tb["cmd.boost"]

	RTV.Start = tb["RTV.Start"]
	RTV.ShouldChange = tb["RTV.ShouldChange"]
	RTV.StartVote = tb["RTV.StartVote"]

	CheckForMapSwitch = tb["CheckForMapSwitch"]
	_CheckForMapSwitch = tb["_CheckForMapSwitch"]
end

function MapPrevent.ReplaceDefaults()
	D3A.Commands.Stored["boost"].Run = function(pl, args, supp)
		MapPrevent.Message(pl)
	end

	RTV.Start = function() end
	RTV.ShouldChange = function() return false end
	RTV.StartVote = function(pl)
		MapPrevent.Message(pl)
	end

	local function checkmap()
		MapPrevent.Message()

		GetConVar("ttt_rounds_left"):SetInt(MapPrevent.RoundsAlways)
		GetConVar("ttt_time_limit_minutes"):SetInt(MapPrevent.TimeAlways)

		local setg = SetGlobalInt
		setg("ttt_rounds_left", MapPrevent.RoundsAlways)
		setg("ttt_time_limit_minutes", MapPrevent.TimeAlways)
	end

	CheckForMapSwitch = checkmap
	_CheckForMapSwitch = checkmap
end