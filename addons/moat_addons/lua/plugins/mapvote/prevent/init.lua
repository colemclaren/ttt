if (CLIENT) then return end

MapPrevent = MapPrevent or {
	Table = "moat_mapvote_prevent",
	Timer = 30,
	Active = false,
	Words1 = "The server has disabled map change while large updates are actively being uploaded. ",
	Words2 = "Regular map voting will resume when the update is fully uploaded.",
	SwitchMessage = function(active)
		if (active) then
			D3A.Chat.Broadcast2(Color(0, 255, 255), MapPrevent.Words1)
			D3A.Chat.Broadcast2(Color(255, 0, 255), MapPrevent.Words2)
			return
		end

		D3A.Chat.Broadcast2(Color(0, 255, 255), "The update is now fully uploaded to the server.")
		D3A.Chat.Broadcast2(Color(0, 255, 0), "Regular map voting will resume now.")

		hook.Add("TTTEndRound", "ChangeMap", function()
			MapVote.Start(nil, nil, nil, nil)
		end)
	end,
	Message = function(pl)
		if (not IsValid(pl)) then
			if (MapPrevent.mapmsg and MapPrevent.mapmsg > CurTime()) then return end
			MapPrevent.mapmsg = CurTime() + 120

			D3A.Chat.Broadcast2(Color(0, 255, 255), MapPrevent.Words1)
			D3A.Chat.Broadcast2(Color(255, 0, 255), MapPrevent.Words2)
			return
		end

		if (pl.mapmsg and pl.mapmsg > CurTime()) then return end
		pl.mapmsg = CurTime() + 5

		D3A.Chat.SendToPlayer2(pl, Color(0, 255, 255), MapPrevent.Words1)
		D3A.Chat.SendToPlayer2(pl, Color(255, 0, 255), MapPrevent.Words2)
	end,
	RoundsAlways = 10,
	TimeAlways = 420
}

function MapPrevent.SaveDefaults()
	if (MapPrevent.Defaults) then return end
	local tb = {}

	-- commands
	tb["cmd.boost"] = D3A.Commands.Stored["boost"].Run

	-- rtv
	tb["RTV.ShouldChange"] = RTV.ShouldChange
	tb["RTV.StartVote"] = RTV.StartVote
	tb["RTV.Start"] = RTV.Start

	-- gamemode
	tb["_CheckForMapSwitch"] = _CheckForMapSwitch or function() end
	tb["CheckForMapSwitch"] = CheckForMapSwitch or function() end

	MapPrevent.Defaults = tb
end

hook("InitPostEntity", function()
	MapPrevent.SaveDefaults()
	MapPrevent.Loaded = true
end)