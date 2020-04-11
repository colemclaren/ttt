MSE.Config.Path = "plugins/mse/"
MSE.Config.Staff = {
	["trialstaff"] = true,
	["moderator"] = true,
	["admin"] = true,
	["senioradmin"] = true,
	["headadmin"] = true,
	["communitylead"] = true,
	["owner"] = true,
	["techartist"] = true,
	["audioengineer"] = true,
	["softwareengineer"] = true,
	["gamedesigner"] = true,
	["creativedirector"] = true
}

-- This is just the message table
MSE.Config.Messages = {
	Started = "{name} has started a {minigame}!",
	Permission = "You don't have permission to do that, sorry!",
	MPerision = "You don't have permission to start that minigame, sorry!",
	Cooldown = "Sorry, you must wait {time} before starting another minigame!",
	CooldownStarted = "You've used all of your minigame slots up, please wait {time} before starting another one!",
	Players = "There must be at least {amount} players alive to start that minigame, sorry!",
	Map = "You cannot start that minigame on this map, sorry!",
	SlotUsed = "You may start {num} more minigame(s) before your {time} cooldown starts!",
	RoundWait = "Please wait until the map change to start a minigame!",
	RoundEarly = "Please wait until the next round to start a minigame!",
	RoundPrep = "You may only start a minigame during the preparing phase!",
	Active = "There's a minigame already active!"
}

-- Chat Command for the menu
MSE.Config.ChatCommand = {
	["mse"] = true,
	["event"] = true,
	["events"] = true,
	["minigames"] = true,
	["minigame"] = true
}

-- mga is best admin mod
hook.Add("D3A_Initialize", "MSE.D3ACompatibility", function()
	for k, v in pairs(MSE.Config.ChatCommand) do
		table.insert(D3A.Config.IgnoreChatCommands, k)
	end
end)

-- Global minigame starting function
-- Return true to halt the minigame starting, followed by the error message
MSE.Config.CanStartMinigame = function(pl)
	local rounds_left = GetGlobal("ttt_rounds_left")

	if (cur_random_round) then
		return true, "Cannot start while there is a wacky round in progress!"
	end

	if (MSE.Events.CurAmount and MSE.Events.CurAmount >= 2) then
		return true, "There can only be 2 minigames per map! Wait until next map to start your event please!"
	end

	if (GetRoundState() ~= ROUND_PREP) then
		return true, MSE.Config.Messages.RoundPrep
	end

	if (GetConVar("ttt_round_limit"):GetInt() - 1 <= rounds_left) then
		return true, MSE.Config.Messages.RoundEarly
	end

	if (rounds_left <= 2) then
		return true, MSE.Config.Messages.RoundWait
	end

	if (MSE.Events.Active) then
		return true, MSE.Config.Messages.Active
	end
end